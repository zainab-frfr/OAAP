import 'package:flutter/material.dart';
import 'package:oaap/authentication/services/auth_service.dart';
import 'package:oaap/client%20category%20management/UI%20components/client_category_tile.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FloatingActionButton(
                  child: const Text('Logout'),
                  onPressed: () async {
                    await AuthService().signOut();
                  }),
              const SizedBox(
                height: 30,
              ),
              const ClientCategoryTile(),
            ],
        )
      ),
    );
  }
}
