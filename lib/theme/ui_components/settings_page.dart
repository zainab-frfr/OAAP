import 'package:flutter/material.dart';
import 'package:oaap/theme/ui_components/logout_button.dart';
import 'package:oaap/theme/ui_components/theme_toggle_tile.dart';

class MySettingsPage extends StatelessWidget {
  const MySettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    
    final GlobalKey<ScaffoldState> scaffoldState = GlobalKey<ScaffoldState>();

    return Scaffold(
      key: scaffoldState,
      appBar: AppBar(
        title: const Text('Settings', style: TextStyle(fontWeight: FontWeight.bold),),
      ),
      body: Column(
        children: [
          const MyThemeTile(),
          MyLogoutButton(scaffoldState: scaffoldState,)
        ],
      ),
    );
  }
}