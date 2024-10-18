import 'package:flutter/material.dart';
import 'package:oaap/theme/UI%20components/theme_toggle_tile.dart';

class MySettingsPage extends StatelessWidget {
  const MySettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings', style: TextStyle(fontWeight: FontWeight.bold),),
      ),
      body: const Column(
        children: [
          MyThemeTile()
        ],
      ),
    );
  }
}