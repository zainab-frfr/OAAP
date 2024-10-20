import 'package:flutter/material.dart';
import 'package:oaap/authentication/services/auth_service.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FloatingActionButton(
          child: const Text('Logout'),
          onPressed: () async{
            await AuthService().signOut();
          }
        ),
      ),
    );
  }
}