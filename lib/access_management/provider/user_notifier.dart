import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:oaap/access_management/models/user_model.dart';

class UserNotifier extends ChangeNotifier{

  List<User> _allUsers = [];
  final FirebaseFirestore _store = FirebaseFirestore.instance;
  bool fetchedData = false;

  List<User> get allUsers => _allUsers; 

  Future<void> getUsers() async{
    _allUsers = [];
    fetchedData = false;
    notifyListeners();
    try{
      QuerySnapshot documents = await _store.collection("users").get();

      for (var docRef in documents.docs){
        _allUsers.add(User.fromJson(docRef.data() as Map<String, dynamic>));
      }
    } catch (e) {
      throw Exception('Cannot fetch users: $e');
    }
    fetchedData = true;
    notifyListeners();
  }
}