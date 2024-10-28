import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ClientCategoryNotifier extends ChangeNotifier{

  final FirebaseFirestore _store = FirebaseFirestore.instance;

  Map<String,List<String>> _clientsWithCategories = {} ;
  List<String> _allClients = [];

  Map<String,List<String>> get clientsWithCategories => _clientsWithCategories; 
  List<String> get allClients => _allClients;

  bool _fetchedMap = false;
  bool _fetchedList = false;

  bool get fetchedMap => _fetchedMap;
  bool get fetchedList => _fetchedList;

  Future<String> addCategoryForAClientToFirestore(String category, String client) async {
    List<String>? categories = _clientsWithCategories[client];
    
    if(categories!.contains(category)){
      return 'This category already exists for $client';
    }
    try {
      _store.collection("Clients").doc(client).collection("Categories").doc(category).set({});
      await retrieveClientsCategories();
      return 'Added';
    } catch (e) {
      return e.toString();
    }
  }


  Future<String> addClientToFirestore(String client) async {
    _fetchedMap = false;
    _fetchedList = false;
    notifyListeners();

    try {
      bool containsClient = _allClients.any((c) => c.toLowerCase() == client.toLowerCase());
      if (!containsClient){
        await _store.collection("Clients").doc(client).set({});
        await retrieveClientsCategories();
        await getAllClients();
        return 'Added';
      }

    _fetchedMap = true;
    _fetchedList = true;
    notifyListeners();
      return 'Client already exists';
    } catch (e) {
      return e.toString();
    }
  }

  Future<void> retrieveClientsCategories() async{
    _fetchedMap = false;
    _clientsWithCategories.clear();
    notifyListeners();

    try{
      QuerySnapshot clientSnapshot = await _store.collection("Clients").get(); //gets saray clients 

      for(var clientDoc in clientSnapshot.docs){ //for every client
        List<String> categories = [];

        QuerySnapshot categoriesForClient = await _store.collection("Clients").doc(clientDoc.id).collection("Categories").get(); //gets categories for a client

        for(var categoryDoc in categoriesForClient.docs){
          categories.add(categoryDoc.id);
        }

        _clientsWithCategories[clientDoc.id] = categories; //adds em {'client':[categories list]} to the map. 

      }
    } catch (e){
      _clientsWithCategories = {};
    }
    
    _fetchedMap = true;
    notifyListeners();
  }

  Future<void> getAllClients() async{
    _fetchedList = false;
    _allClients.clear();
    notifyListeners();

    try{
      QuerySnapshot clientSnapshot = await _store.collection("Clients").get(); //gets saray clients 

      for (var clientDoc in clientSnapshot.docs){
        _allClients.add(clientDoc.id);
      }

    } catch (e){
      _allClients = [];
    }

    _fetchedList = true;
    notifyListeners();
  }

}