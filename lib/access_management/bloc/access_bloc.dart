import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oaap/access_management/data/client_cat_acc_model.dart';
import 'package:oaap/access_management/data/user_model.dart';
import 'package:oaap/authentication/data/curr_user.dart';

part 'access_event.dart';
part 'access_state.dart';

class AccessBloc extends Bloc<AccessEvent, AccessState> {
  final FirebaseFirestore store = FirebaseFirestore.instance;

  AccessBloc() : super(LoadingState()) {
    on<FetchAccessInformation>(_fetchAccessInformation);
    on<GrantAccess>(_grantAccess);
    on<RevokeAccess>(_revokeAccess);
    on<FetchEmployeesAndAccessInformation>(_fetchEmployees);
  }

  void _fetchAccessInformation(FetchAccessInformation event, Emitter<AccessState> emit) async {
    emit(LoadingState());
    try {
      List<ClientCategoryAccess> accessList = await _getList();
      emit(FetchedAccessInformation(accessList: accessList));
    } catch (e) {
      emit(AccessError(error: e.toString()));
    }
  }

  Future<List<ClientCategoryAccess>> _getList() async {
    User currentUser = await CurrentUser().getCurrentUser();
    
    List<ClientCategoryAccess> tempList = []; // creating another so that when method called again tou duplicates na hoin

    QuerySnapshot<Map<String, dynamic>> retrievedClientDocs = await store.collection('Clients').get(); // gets all client documents

    for (var clientDoc in retrievedClientDocs.docs) {
      QuerySnapshot categoriesForClient = await clientDoc.reference.collection('Categories').get(); //gets all categories for a client

      Map<String, dynamic> fetchedData = {};

      for (var category in categoriesForClient.docs) {
        QuerySnapshot access = await category.reference.collection('Access').get(); //gets all employees with access

        List<String> tempAccessList = access.docs.map((doc) => doc.id).toList(); //list of employees with access
        if(currentUser.role == 'employee'){
          if (tempAccessList.contains(currentUser.email)) {
            fetchedData[category.id] = tempAccessList;
          }
        }else{
          fetchedData[category.id] = tempAccessList;
        }
      }
      if (fetchedData.isNotEmpty) {
        tempList.add(ClientCategoryAccess.fromJson(clientDoc.id, fetchedData));
      }
    }
    return tempList;
  }

  void _grantAccess(GrantAccess event, Emitter<AccessState> emit) async {
    try{
      await store.collection('Clients').doc(event.client)
      .collection('Categories').doc(event.category)
      .collection('Access').doc(event.email).set({});

      add(const FetchEmployeesAndAccessInformation()); 
      emit(AccessPopUpMessage(message: 'Access granted.'));
    } catch (e){
      emit(AccessError(error: e.toString()));
    }
  }

  void _revokeAccess(RevokeAccess event, Emitter<AccessState> emit) async {
    try {
      await store.collection('Clients').doc(event.client).collection('Categories').doc(event.category).collection('Access').doc(event.email).delete();

      add(const FetchEmployeesAndAccessInformation()); 
      emit(AccessPopUpMessage(message: 'Access revoked.'));
    } catch (e) {
      emit(AccessError(error: e.toString()));
    }
  }

  void _fetchEmployees(FetchEmployeesAndAccessInformation event, Emitter<AccessState> emit) async {
    emit(LoadingState());
    List<User> tempListUsers = [];
    try{
      QuerySnapshot documents = await store.collection("users").get();

      for (var docRef in documents.docs){
        tempListUsers.add(User.fromJson(docRef.data() as Map<String, dynamic>));
      }
      List<ClientCategoryAccess> accessList = await _getList();
      emit(FetchedEmployeesAndAccessInformation(allUsers: tempListUsers, accessList: accessList));
    } catch (e) {
      emit(AccessError(error: e.toString()));
    }
  }
}
