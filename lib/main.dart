import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:oaap/authentication/services/auth_gate.dart';
import 'package:oaap/client_category_management/client_category_notifier.dart';
import 'package:oaap/client_category_management/ui_components/client_category_page.dart';
import 'package:oaap/firebase_options.dart';
import 'package:oaap/theme/theme_model.dart';
import 'package:oaap/theme/theme_notifier.dart';
import 'package:oaap/theme/ui_components/settings_page.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform); //uses the firebase_options.dart in lib
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: [SystemUiOverlay.top]); //to hide navigation bar of phone.
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeNotifier()),//underscore is used as a placeholder for unused/ignored parameters (BuildContext in this case)
        ChangeNotifierProvider(create: (_) => ClientCategoryNotifier())
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
            '/settings':(context) => const MySettingsPage(),
          },
      );
      },
    );
  }
}

/*
stuff left

resolved:   
1. when category or client added tou you can't see circular progress indicator kion ke context popping issue. 

remaining:
2. add koi image ya gradient background in signup login screen. 

*/