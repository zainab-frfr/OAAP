import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:oaap/client_category_management/data/client_category_model.dart';

part 'cc_event.dart';
part 'cc_state.dart';

class ClientCategoryBloc extends Bloc<ClientCategoryEvent, ClientCategoryState>{
  
  final FirebaseFirestore store = FirebaseFirestore.instance;

  ClientCategoryBloc():super(LoadingClientCategory()){
    on<FetchClientCategory>(_fetchData);
    on<AddClient>(_addClient);
    on<AddCategoryToClient>(_addCategoryToClient);
    on<RemoveClient>(_removeClient);
    on<RemoveCategoryFromClient>(_removeCategoryFromClient);
  }

  void _fetchData(FetchClientCategory event, Emitter<ClientCategoryState> emit) async{
    emit(LoadingClientCategory());
    try {
      List<ClientCategoryModel> clientsAndCategories = await _getList();
      emit(FetchedClientCategory(clientsAndCategories: clientsAndCategories));
    } catch (e) {
      emit(ClientCategoryError(error: e.toString()));
    }
  }

  Future<List<ClientCategoryModel>> _getList() async {
    List<ClientCategoryModel> clientsAndCategories = [];
    
    try {
      QuerySnapshot clientSnapshot =
          await store.collection("Clients").get(); //gets saray clients

      for (var clientDoc in clientSnapshot.docs) {
        //for every client
        List<String> categories = [];

        QuerySnapshot categoriesForClient = await store
            .collection("Clients")
            .doc(clientDoc.id)
            .collection("Categories")
            .get(); //gets categories for a client

        for (var categoryDoc in categoriesForClient.docs) {
          categories.add(categoryDoc.id);
        }

        clientsAndCategories.add(ClientCategoryModel.fromJson(clientDoc.id, categories));
      }
    } catch (e) {
      rethrow;
    }
    return clientsAndCategories;
  }

  void _addClient(AddClient event, Emitter<ClientCategoryState> emit) async{
    
    final currentState = state;
      if(currentState is FetchedClientCategory){
        List<ClientCategoryModel> clientsAndCategories = currentState.clientsAndCategories;
        bool containsClient = _checkIfClientExists(clientsAndCategories, event.client);

        try {
          if (!containsClient) {
            emit(LoadingClientCategory());
            await store.collection("Clients").doc(event.client).set({});
            add(FetchClientCategory()); //fetch clients and categories after adding client
            emit(ClientCategoryPopUpMessage(message: 'Client added.'));
          } else{
            //client already exists;
            emit(ClientCategoryPopUpMessage(message: 'Client already exists.'));
          }
        } catch (e) {
          //emit error state
          emit(ClientCategoryError(error: e.toString() ));
        }
      }
    
  }

  bool _checkIfClientExists(List<ClientCategoryModel> clientsAndCategories, String client){
    for (var clientCat in clientsAndCategories){
      if (clientCat.client.toLowerCase() == client.toLowerCase()) return true;
    }
    return false;
  }

  void _addCategoryToClient(AddCategoryToClient event, Emitter<ClientCategoryState> emit) async{
    String category = event.category.trim();
    final currentState = state;
    if(currentState is FetchedClientCategory){
        List<ClientCategoryModel> clientsAndCategories = currentState.clientsAndCategories;
        bool contains = _checkIfClientHasCategory(clientsAndCategories,event.client, event.category);

        try {
          if (!contains) {
            emit(LoadingClientCategory());
            await store.collection("Clients").doc(event.client).collection("Categories").doc(category).set({});
            add(FetchClientCategory()); //fetch clients and categories after adding category
            emit(ClientCategoryPopUpMessage(message: 'Category added.'));
          } else{
            //client already exists;
            emit(ClientCategoryPopUpMessage(message: 'Category already exists.'));
          }
        } catch (e) {
          //emit error state
          emit(ClientCategoryError(error: e.toString() ));
        }
      }
  }

  bool _checkIfClientHasCategory(List<ClientCategoryModel> clientsAndCategories, String client, String category){
    for (var clientCat in clientsAndCategories){
      if (clientCat.client == client){
        if(clientCat.categories.any((c) => c.toLowerCase() == category.toLowerCase())) return true;
        return false;
      }
    }
    return false;
  }

  void _removeClient(RemoveClient event, Emitter<ClientCategoryState> emit) async{
    final currentState = state;
    if(currentState is FetchedClientCategory){
      List<ClientCategoryModel> clientsAndCategories = currentState.clientsAndCategories;
      bool containsClient = _checkIfClientExists(clientsAndCategories, event.client);
      if (!containsClient){
        emit(ClientCategoryPopUpMessage(message: 'Client does not exist.'));
      }
      else{
        try {
          emit(LoadingClientCategory());
          var categoriesSnapshot = await store.collection("Clients").doc(event.client).collection("Categories").get();
          
          for (var categoryDoc in categoriesSnapshot.docs) { // for each category
            var categoryRef = categoryDoc.reference;
            var accessSnapshot = await categoryRef.collection("Access").get(); //get all those who have access
            for (var accessDoc in accessSnapshot.docs) {
              await accessDoc.reference.delete(); // deleting everybody who has access
            }
            await categoryRef.delete(); // deleting category 
          }
          await store.collection("Clients").doc(event.client).delete(); // deleting the client 
          add(FetchClientCategory()); //fetch clients and categories after removing client
          emit(ClientCategoryPopUpMessage(message: 'Client removed.')); 

        } catch (e) {
          emit(ClientCategoryPopUpMessage(message: e.toString())); 
        }
      }
    }
  }

  void _removeCategoryFromClient(RemoveCategoryFromClient event, Emitter<ClientCategoryState> emit)async{
    final currentState = state;
    if(currentState is FetchedClientCategory){
      List<ClientCategoryModel> clientsAndCategories = currentState.clientsAndCategories;
      bool containsCategory = _checkIfClientHasCategory(clientsAndCategories, event.client, event.category);
      if (!containsCategory){
        emit(ClientCategoryPopUpMessage(message: 'Client does not exist.'));
      }
      else{
        try {
          emit(LoadingClientCategory());
          var categoryRef = store.collection("Clients").doc(event.client).collection("Categories").doc(event.category);
          var accessSnapshot = await categoryRef.collection("Access").get(); // get everybody who has access to that category
          for (var accessDoc in accessSnapshot.docs) { 
            await accessDoc.reference.delete(); // deleting the access list
          }
          await categoryRef.delete(); // deleting the category
          add(FetchClientCategory()); //fetch clients and categories after removing category
          emit(ClientCategoryPopUpMessage(message: 'Category removed.')); 
        } catch (e) {
          emit(ClientCategoryPopUpMessage(message: e.toString())); 
        }
      }
    }
  }


}