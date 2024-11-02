import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:oaap/access_management/model/client_cat_acc_model.dart';

class AccessNotifier extends ChangeNotifier{
  
  List<ClientCategoryAccess> _accessList = []; 
  bool _fetchedAccess = false;

  final FirebaseFirestore _store = FirebaseFirestore.instance;

  List<ClientCategoryAccess> get accessList => _accessList;
  bool get fetchedAccess => _fetchedAccess;

  Future<void> getAccess() async{
    _fetchedAccess = false;
    notifyListeners();
    try{
      List<ClientCategoryAccess> tempList = []; // creating another so that when method called again tou duplicates na hoin

      QuerySnapshot<Map<String,dynamic>> retrievedClientDocs = await _store.collection('Clients').get(); // gets all client documents

      for ( var clientDoc in retrievedClientDocs.docs){
        QuerySnapshot categoriesForClient = await clientDoc.reference.collection('Categories').get(); //gets all categories for a client

        Map<String, dynamic> fetchedData = {};

        for (var category in categoriesForClient.docs){
          QuerySnapshot access = await category.reference.collection('Access').get(); //gets all employees with access

          List<String> tempAccessList = access.docs.map((doc) => doc.id).toList(); //list of employees with access
          fetchedData[category.id] = tempAccessList;
        }

        tempList.add(ClientCategoryAccess.fromJson(clientDoc.id, fetchedData));

      }

      _accessList = tempList;
      
      _fetchedAccess = true;
      notifyListeners();
    } catch (e){
      throw Exception("Failed to fetch access data: $e");
    }
  }
}