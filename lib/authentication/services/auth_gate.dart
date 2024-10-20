import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:oaap/authentication/UI%20components/pages/toggle_page.dart';
import 'package:oaap/home.dart';

class AuthGate extends StatefulWidget {
  const AuthGate({super.key});

  @override
  AuthGateState createState() => AuthGateState();
}

class AuthGateState extends State<AuthGate> {

  void reload(){
    setState(() {
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          User? user = snapshot.data;

          if (user == null) {
            return const TogglePage();
          } else {

            return FutureBuilder(
              future: user.reload(),
              builder: (context, reloadSnapshot) {
                if (reloadSnapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else {
                  user = FirebaseAuth.instance.currentUser;

                  return const MyHomePage();
                }
              },
            );
          }
        },
      ),
    );
  }
}