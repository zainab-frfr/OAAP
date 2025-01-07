import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:oaap/access_management/bloc/access_bloc.dart';
import 'package:oaap/access_management/ui/views/access_management_page.dart';
import 'package:oaap/authentication/services/auth_gate.dart';
import 'package:oaap/client_category_management/bloc/cc_bloc.dart';
import 'package:oaap/client_category_management/ui/view/client_category_page.dart';
import 'package:oaap/firebase_options.dart';
import 'package:oaap/moderator_management/ui/view/moderator_page.dart';
import 'package:oaap/performance_reports/bloc/performance%20bloc/performance_bloc.dart';
import 'package:oaap/performance_reports/bloc/user%20bloc/user_bloc.dart';
import 'package:oaap/performance_reports/ui/views/performance_admin_view.dart';
import 'package:oaap/settings/bloc/theme_bloc.dart';
import 'package:oaap/settings/data/current_theme.dart';
import 'package:oaap/settings/data/theme.dart';
import 'package:oaap/settings/ui/view/settings_page.dart';
import 'package:flutter/services.dart';
import 'package:oaap/task_management/bloc/task_bloc.dart';
import 'package:oaap/task_management/ui/view/task_management_page.dart';

/*
  1. add koi image ya gradient background in signup login screen. 

  3. during deletion  of client delete all fields within document also lolsies
  4. if i click on access management and foran click on grant/revoke access tou exception
  
  5. access mein ALL acesss
  6. access mein check if aready has access
  7. also view access page par poori email arahi hai boss (insert cri)

  8. view access screen par chips are changing color randomly
  9. System Theme option is not persisting across multiple app sessions plus when i change theme widgets ka color on da

  10. create task mein empty title and description pop up background mein ata hai :(
*/

  late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
  
  void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: DefaultFirebaseOptions
          .currentPlatform); //uses the firebase_options.dart in lib
  await _initializeLocalNotifications();

  await _requestNotificationPermissions();

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);  // to handle notifications

  SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
      overlays: [SystemUiOverlay.top]); //to hide navigation bar of phone.
  
  await CurrentTheme().getTheme(); //to load the previous theme into the variable inside CurrentTheme 
  runApp(const MainApp());
}

Future<void> _requestNotificationPermissions() async {
  FirebaseMessaging messaging = FirebaseMessaging.instance;

  NotificationSettings settings = await messaging.requestPermission(
    alert: true,
    badge: true,
    sound: true,
  );

  if (settings.authorizationStatus == AuthorizationStatus.authorized) {
    debugPrint('User granted notification permissions');
  } else if (settings.authorizationStatus == AuthorizationStatus.provisional) {
    debugPrint('User granted provisional notification permissions');
  } else {
    debugPrint('User denied notification permissions');
  }
}

Future<void> _initializeLocalNotifications() async {
  flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  const AndroidInitializationSettings initializationSettingsAndroid =
      AndroidInitializationSettings('@mipmap/ic_launcher');
        //'app_icon'); // Ensure you have an app_icon in your drawable

  const InitializationSettings initializationSettings = InitializationSettings(
    android: initializationSettingsAndroid,
  );

  await flutterLocalNotificationsPlugin.initialize(initializationSettings);
}

// Background message handler
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  debugPrint('Handling a background message: ${message.data}');
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await _initializeLocalNotifications();
  _showLocalNotification(message);
}

Future<void> _showLocalNotification(RemoteMessage message) async {
  const AndroidNotificationDetails androidPlatformChannelSpecifics =
      AndroidNotificationDetails(
    'task_reminders', // Channel ID
    'Task Reminders', // Channel name
    importance: Importance.max,
    priority: Priority.high,
    showWhen: false,
  );

  const NotificationDetails platformChannelSpecifics =
      NotificationDetails(android: androidPlatformChannelSpecifics);

  await flutterLocalNotificationsPlugin.show(
    0, // Notification ID (you can change this to show different notifications)
    message.notification?.title, // Notification title
    message.notification?.body, // Notification body
    platformChannelSpecifics,
    payload: message.data.toString(),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});
  
  @override
  Widget build(BuildContext context) {
    final String prevTheme = CurrentTheme().themeString;

    return MultiBlocProvider( 
        providers: [
          BlocProvider<ThemeBloc>(
            create: (_) => ThemeBloc(),
          ),
          BlocProvider<ClientCategoryBloc>(
            create: (_) => ClientCategoryBloc(),
          ),
          BlocProvider<AccessBloc>(
            create: (_) => AccessBloc(),
          ),
          BlocProvider<TaskBloc>(
            create: (_) => TaskBloc(),
          ),
          BlocProvider<PerformanceBloc>(
            create: (_) => PerformanceBloc(),
          ),
          BlocProvider<UserBloc>(
            create: (_) => UserBloc(),
          ),

        ],
        child: Builder(
          builder: (context) {
            final themeMode = context.select((ThemeBloc bloc) => bloc.state.themeMode);
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              theme: lightTheme,
              darkTheme: darkTheme,
              themeMode: themeMode,
              builder: (context, child) {
                debugPrint(prevTheme);
                if(prevTheme == 'System Theme'){
                  context.read<ThemeBloc>().add(ThemeChanged(theme: prevTheme, context: context));
                }
                return child!;
              },
              initialRoute: '/authGate',
              routes: {
                '/authGate': (context) => const AuthGate(), //in lib>authentication>services
                '/clientCategoryManagement': (context) => const MyClientCategoryPage(),
                '/accessManagement': (context) => const MyAccessPage(),
                '/settings': (context) => const MySettingsPage(),
                '/taskManagement': (context) => const MyTaskPage(),
                '/performanceReportAdmin': (context) => const AdminPerformanceView(),
                '/moderatorManagement': (context) => const ModeratorManagementPage(),
              },
            );
          }
        )
    );
  }
}
