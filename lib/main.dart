import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:oaap/access_management/network/access_notifier.dart';
import 'package:oaap/access_management/ui_components/access_management_page.dart';
import 'package:oaap/authentication/services/auth_gate.dart';
import 'package:oaap/global/global%20notifiers/client_category_notifier.dart';
import 'package:oaap/client_category_management/ui_components/client_category_page.dart';
import 'package:oaap/firebase_options.dart';
import 'package:oaap/settings/theme_model.dart';
import 'package:oaap/settings/theme_notifier.dart';
import 'package:oaap/settings/ui_components/settings_page.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';
/*
  1. add koi image ya gradient background in signup login screen. 
  2. need to create client ka model

  3. during deletion  of client delete all fields within document also lolsies
*/
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform); //uses the firebase_options.dart in lib
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: [SystemUiOverlay.top]); //to hide navigation bar of phone.
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeNotifier()),//underscore is used as a placeholder for unused/ignored parameters (BuildContext in this case)
        ChangeNotifierProvider(create: (_) => ClientCategoryNotifier()),
        ChangeNotifierProvider(create: (_) => AccessNotifier())
      ],
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
          initialRoute: '/authGate',
          routes: {
            '/authGate' : (context) => const AuthGate(), //in lib>authentication>services
            '/clientCategoryManagement': (context) => const MyClientCategoryPage(),
            '/accessManagement': (context) => const MyAccessPage(),
            '/settings':(context) => const MySettingsPage(),
          },
      );
      },
    );
  }
}