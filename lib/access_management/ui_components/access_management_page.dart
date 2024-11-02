import 'package:flutter/material.dart';
import 'package:oaap/access_management/ui_components/edit_access_page.dart';
import 'package:oaap/access_management/ui_components/view_access_page.dart';
import 'package:oaap/settings/theme_notifier.dart';
import 'package:provider/provider.dart';

class MyAccessPage extends StatefulWidget {
  const MyAccessPage({super.key});

  @override
  State<MyAccessPage> createState() => _MyAccessPageState();
}

class _MyAccessPageState extends State<MyAccessPage> {
  int currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    Brightness mode = context.watch<ThemeNotifier>().getBrightness(context);

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
        // ListView(
        //   children: [
        //     ExpansionPanelList(
        //       animationDuration: const Duration(milliseconds: 500),
        //       expansionCallback: (int index, bool isExpanded) {
        //         setState(() {
        //           _isExpanded[index] = isExpanded;
        //         });
        //       },
        //       children: [
        //         ExpansionPanel(
        //           headerBuilder: (BuildContext context, bool isExpanded) {
        //             return ListTile(
        //               title: Text(
        //                 'Client 1',
        //                 style: TextStyle(
        //                     fontWeight: (_isExpanded[0])
        //                         ? FontWeight.bold
        //                         : FontWeight.normal),
        //               ),
        //             );
        //           },
        //           body: const Padding(
        //             padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        //             child: Align(
        //                 alignment: Alignment.topLeft,
        //                 child: Column(
        //                   crossAxisAlignment: CrossAxisAlignment.start,
        //                   children: [
        //                     Text('category 1'),
        //                     MyChips(
        //                       items: [
        //                         'ambar@gmail.com',
        //                         'aun@gmail.com',
        //                         'zainab@gmail.com'
        //                       ],
        //                     ),
        //                     SizedBox(
        //                       height: 10,
        //                     ),
        //                     Text('category 2'),
        //                     MyChips(
        //                       items: [
        //                         'ambar@gmail.com',
        //                         'aun@gmail.com',
        //                         'ambar@gmail.com',
        //                         'aun@gmail.com'
        //                       ],
        //                     ),
        //                     SizedBox(
        //                       height: 10,
        //                     ),
        //                     Text('category 3'),
        //                     MyChips(
        //                       items: [
        //                         'ambar@gmail.com',
        //                         'aun@gmail.com',
        //                         'ambar@gmail.com',
        //                         'aun@gmail.com',
        //                         'ambar@gmail.com',
        //                         'aun@gmail.com'
        //                       ],
        //                     ),
        //                   ],
        //                 )),
        //           ),
        //           isExpanded: _isExpanded[0],
        //         ),
        //         ExpansionPanel(
        //           headerBuilder: (BuildContext context, bool isExpanded) {
        //             return ListTile(
        //               title: Text(
        //                 'Client 2',
        //                 style: TextStyle(
        //                     fontWeight: (_isExpanded[1])
        //                         ? FontWeight.bold
        //                         : FontWeight.normal),
        //               ),
        //             );
        //           },
        //           body: const Padding(
        //             padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        //             child: Align(
        //                 alignment: Alignment.topLeft,
        //                 child: Column(
        //                   crossAxisAlignment: CrossAxisAlignment.start,
        //                   children: [
        //                     Text('category 1'),
        //                     MyChips(
        //                       items: [
        //                         'ambar@gmail.com',
        //                         'aun@gmail.com',
        //                         'zainab@gmail.com'
        //                       ],
        //                     ),
        //                     SizedBox(
        //                       height: 10,
        //                     ),
        //                     Text('category 2'),
        //                     MyChips(
        //                       items: ['ambar@gmail.com', 'aun@gmail.com'],
        //                     ),
        //                   ],
        //                 )),
        //           ),
        //           isExpanded: _isExpanded[1],
        //         ),
        //         ExpansionPanel(
        //           headerBuilder: (BuildContext context, bool isExpanded) {
        //             return ListTile(
        //               title: Text(
        //                 'Client 3',
        //                 style: TextStyle(
        //                     fontWeight: (_isExpanded[2])
        //                         ? FontWeight.bold
        //                         : FontWeight.normal),
        //               ),
        //             );
        //           },
        //           body: const Padding(
        //             padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        //             child: Align(
        //                 alignment: Alignment.topLeft,
        //                 child: Column(
        //                   crossAxisAlignment: CrossAxisAlignment.start,
        //                   children: [
        //                     Text('category 1'),
        //                     MyChips(
        //                       items: [
        //                         'ambar@gmail.com',
        //                         'aun@gmail.com',
        //                         'ambar@gmail.com',
        //                         'aun@gmail.com',
        //                         'ambar@gmail.com',
        //                         'aun@gmail.com'
        //                       ],
        //                     ),
        //                     SizedBox(
        //                       height: 10,
        //                     ),
        //                     Text('category 2'),
        //                     MyChips(
        //                       items: [
        //                         'ambar@gmail.com',
        //                         'aun@gmail.com',
        //                         'ambar@gmail.com',
        //                         'aun@gmail.com'
        //                       ],
        //                     ),
        //                   ],
        //                 )),
        //           ),
        //           isExpanded: _isExpanded[2],
        //         ),
        //       ],
        //     ),
        //   ],
        // ),

        // edit access
        const EditAccessPage(),

      ][currentPageIndex],
      bottomNavigationBar: ClipRRect(
        borderRadius: BorderRadius.circular(15.0),
        child: NavigationBar(
          labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
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
