import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:oaap/authentication/services/auth_gate.dart';
import 'package:oaap/firebase_options.dart';
import 'package:oaap/theme/theme_model.dart';
import 'package:oaap/theme/theme_notifier.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform); //uses the firebase_options.dart in lib
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []); //to hide status bar and navigation bar of phone.
  runApp(
    ChangeNotifierProvider(
      create: (_)=> ThemeNotifier(), //underscore is used as a placeholder for unused/ignored parameters (BuildContext in this case)
      child: const MainApp(),
    )
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeNotifier>(
      builder: (context, themeNotifier, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: lightTheme,
          darkTheme: darkTheme,
          themeMode: themeNotifier.themeMode,
          home: const AuthGate() //in lib>authentication>services
      );
      },
    );
  }
}
