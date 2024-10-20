import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService{

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _store = FirebaseFirestore.instance;

  Future<User?> signInWithGoogle() async { 

    final googleAccount = await GoogleSignIn().signIn(); //initiates the sign in process. returns a GoogleSignInAccount object if successful, and null if not.

    final googleAuth = await googleAccount?.authentication; //contains tokens needed to authenticate the user with firebase. 

    bool accountAlrExists = await _accountExists(googleAccount!.email); 

    if(!accountAlrExists){ //if account does not exist its not going to let you sign in
      GoogleSignIn().signOut();
      return null;
    }

    final credential = GoogleAuthProvider.credential( //created a credential here that will be used to login to firebase. 
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken
    );

    final userCredential =  await _auth.signInWithCredential(credential);

    return userCredential.user;

  }

  Future<User?> signUpWithGoogle() async { 

    final googleAccount = await GoogleSignIn().signIn(); 

    final googleAuth = await googleAccount?.authentication; 

    bool accountAlrExists = await _accountExists(googleAccount!.email); 

    if(accountAlrExists){ // if account does exist its not going to let you sign up
      GoogleSignIn().signOut();
      return null;
    }

    final credential = GoogleAuthProvider.credential( //created a credential here that will be used to login to firebase. 
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken
    );

    final userCredential =  await _auth.signInWithCredential(credential);

    await _storeUser(userCredential.user, 'google');

    return userCredential.user;

  }

  Future<void> signOut() async{
    await GoogleSignIn().signOut(); //signout from the google package
    await _auth.signOut();
  }

  Future<bool> _accountExists(String email) async{
    
     QuerySnapshot snapshot = await _store.collection('users').where("email", isEqualTo: email).get(); //returns all documents where email matches

     if(snapshot.docs.isEmpty){
      return false;
     }
     return true;

  }

  Future<void> _storeUser(User? user, String signInType) async{
    await _store.collection('users').add({
      "email": user?.email,
      "sign_in_type": signInType,
    });
  }


}