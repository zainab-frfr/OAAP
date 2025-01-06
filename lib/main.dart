import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oaap/access_management/bloc/access_bloc.dart';
import 'package:oaap/access_management/ui/views/access_management_page.dart';
import 'package:oaap/authentication/services/auth_gate.dart';
import 'package:oaap/client_category_management/bloc/cc_bloc.dart';
import 'package:oaap/client_category_management/ui/view/client_category_page.dart';
import 'package:oaap/firebase_options.dart';
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

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: DefaultFirebaseOptions
          .currentPlatform); //uses the firebase_options.dart in lib
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
      overlays: [SystemUiOverlay.top]); //to hide navigation bar of phone.
  await CurrentTheme().getTheme(); //to load the previous theme into the variable inside CurrentTheme 
  runApp(const MainApp());
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
              },
            );
          }
        )
    );
  }
}
