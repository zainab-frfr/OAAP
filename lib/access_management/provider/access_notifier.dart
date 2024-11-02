import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:oaap/access_management/models/client_cat_acc_model.dart';

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

  Future<String> grantAccess(String client, String category, String email) async{
    _fetchedAccess = false;
    notifyListeners();
    try{
      await _store.collection('Clients').doc(client)
      .collection('Categories').doc(category)
      .collection('Access').doc(email).set({});

      await getAccess();
      _fetchedAccess = true;
      notifyListeners();
      return '${email.split('@')[0]} granted access to $category under $client.';
    } catch (e){
      return 'Error granting access. Please try again later.';
    }
  }

  Future<String> revokeAccess(String client, String category, String email) async {
    _fetchedAccess = false;
    notifyListeners();
    try {
      await _store.collection('Clients').doc(client)
      .collection('Categories').doc(category)
      .collection('Access').doc(email).delete();

      await getAccess();
      _fetchedAccess = true;
      notifyListeners();

      return '${email.split('@')[0]} access to $category under $client has been revoked.';
    } catch (e) {
      return 'Error revoking access. Please try again later.';
    }
  }

}