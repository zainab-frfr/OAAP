import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService{

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _store = FirebaseFirestore.instance;

  Future<String> signInWithGoogle() async { 

    try{

    final googleAccount = await GoogleSignIn().signIn(); //initiates the sign in process. returns a GoogleSignInAccount object if successful, and null if not.

    final googleAuth = await googleAccount?.authentication; //contains tokens needed to authenticate the user with firebase. 

    if(googleAccount == null){
      return 'user did not select account';
    }

    bool accountAlrExists = await _accountExists(googleAccount.email); 

    if(!accountAlrExists){ //if account does not exist its not going to let you sign in
      GoogleSignIn().signOut();
      return 'account doesnot exist';
    }

    final credential = GoogleAuthProvider.credential( //created a credential here that will be used to login to firebase. 
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken
    );

    await _auth.signInWithCredential(credential);

    return 'sign in successful';
    } 
    on Exception catch(_){
      return 'error';
    }

  }

  Future<String> signUpWithGoogle() async { 

    try {
    final googleAccount = await GoogleSignIn().signIn(); 

    final googleAuth = await googleAccount?.authentication; 

    if(googleAccount == null){
      return 'user did not select account';
    }

    bool accountAlrExists = await _accountExists(googleAccount.email); 

    if(accountAlrExists){ // if account does exist its not going to let you sign up
      GoogleSignIn().signOut();
      return 'account already exists';
    }

    final credential = GoogleAuthProvider.credential( //created a credential here that will be used to login to firebase. 
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken
    );

    final userCredential =  await _auth.signInWithCredential(credential);

    await _storeUser(userCredential.user, 'google');

    return 'sign up successful';
    }
    on Exception catch (_){
      return 'error';
    }

  }

  Future<void> signOut() async{
    await GoogleSignIn().signOut(); //signout from the google package
    await _auth.signOut();
  }

  Future<bool> _accountExists(String email) async{
    
     QuerySnapshot snapshot = await _store.collection('users').where("email", isEqualTo: email ).get(); //returns all documents where email matches

     if(snapshot.docs.isEmpty){
      return false;
     }
     return true;

  }

  Future<void> _storeUser(User? user, String signUpType) async{
    await _store.collection('users').add({
      "email": user?.email,
      "sign_in_type": signUpType,
    });
  }

  Future<User?> signInWithEmailAndPassword(String email, String password) async{

    bool accountAlrExists = await _accountExists(email); 
    if(!accountAlrExists){ //if account does not exist its not going to let you sign in
      return null;
    }

     try {
      final userCredential = await _auth.signInWithEmailAndPassword(email: email, password: password);
      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      throw Exception(e.code);
    }

  }

  Future<User?> signUpWithEmailAndPassword(String email, String password) async {
    bool accountAlrExists = await _accountExists(email); 
    if(accountAlrExists){ //if account already exists its not going to let you sign up
      return null;
    }

    try {
      final userCredential = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      await _storeUser(userCredential.user, 'emailpswd');
      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      throw Exception(e.code);
    }

  }
}