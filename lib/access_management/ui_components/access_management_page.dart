import 'package:flutter/material.dart';
import 'package:oaap/access_management/ui_components/edit_access_page.dart';
import 'package:oaap/access_management/ui_components/view_access_page.dart';
import 'package:oaap/settings/bloc/theme_bloc.dart';
import 'package:provider/provider.dart';

class MyAccessPage extends StatefulWidget {
  const MyAccessPage({super.key});

  @override
  State<MyAccessPage> createState() => _MyAccessPageState();
}

class _MyAccessPageState extends State<MyAccessPage> {
  int currentPageIndex = 0;

   @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if(context.watch<ThemeBloc>().state.themeString == 'System Theme'){
      context.read<ThemeBloc>().add(ThemeChanged(theme: 'System Theme', context: context));
    }
  }

  @override
  Widget build(BuildContext context) {
    Brightness mode = context.select((ThemeBloc bloc) => bloc.state.brightness);

    return Scaffold(
      appBar: AppBar(
        title: const Padding(
          padding: EdgeInsets.symmetric(
            vertical: 20,
          ),
          child: Text(
            'Access Management',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
        ),
      ),
      body: <Widget>[
        // view access
        const ViewAccessPage(),
        // edit access
        const EditAccessPage(),

      ][currentPageIndex],
      bottomNavigationBar: ClipRRect(
        borderRadius: BorderRadius.circular(15.0),
        child: NavigationBar(
          labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
          elevation: 2.0,
          onDestinationSelected: (int index) {
            setState(() {
              currentPageIndex = index;
            });
          },
          indicatorColor: (mode == Brightness.light)
              ? const Color.fromARGB(255, 140, 203, 255)
              : const Color.fromARGB(255, 65, 71, 77),
          selectedIndex: currentPageIndex,
          destinations: const <Widget>[
            NavigationDestination(
              selectedIcon: Icon(Icons.people_alt),
              icon: Icon(Icons.people_alt_outlined),
              label: 'View Access',
            ),
            NavigationDestination(
              selectedIcon: Icon(Icons.admin_panel_settings),
              icon: Icon(Icons.admin_panel_settings_outlined),
              label: 'Grant/Revoke',
            ),
          ],
        ),
      ),
    );
  }
}
