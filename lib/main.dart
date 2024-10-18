import 'package:flutter/material.dart';
import 'package:oaap/authentication/UI%20components/toggle_page.dart';
import 'package:oaap/theme/theme_model.dart';
import 'package:oaap/theme/theme_notifier.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
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
          home:  const TogglePage()
      );
      },
    );
  }
}
