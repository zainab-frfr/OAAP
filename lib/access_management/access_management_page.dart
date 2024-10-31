import 'package:flutter/material.dart';



class MyAccessPage extends StatefulWidget {
  const MyAccessPage({super.key});

  @override
  State<MyAccessPage> createState() => _MyAccessPageState();
}

class _MyAccessPageState extends State<MyAccessPage> {
  List<bool> _isExpanded = [false, false, false];

  @override
  Widget build(BuildContext context) {
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
        body:ListView(
          children: [
            ExpansionPanelList(
            animationDuration: const Duration(milliseconds: 500),
            expansionCallback: (int index, bool isExpanded) {
              setState(() {
                _isExpanded[index] = isExpanded;
              });
            },
            children: [
              ExpansionPanel(
                headerBuilder: (BuildContext context, bool isExpanded) {
                  return const ListTile(
                    title: Text('Client 1'),
                  );
                },
                body: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Category 1'),
                    Text('Category 2'),
                  ],
                ),
                isExpanded: _isExpanded[0],
              ),
              ExpansionPanel(
                headerBuilder: (BuildContext context, bool isExpanded) {
                  return const ListTile(
                    title: Text('Client 2'),
                  );
                },
                body: const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Text('This is the content of Panel 2.'),
                ),
                isExpanded: _isExpanded[1],
              ),
              ExpansionPanel(
                headerBuilder: (BuildContext context, bool isExpanded) {
                  return const ListTile(
                    title: Text('Client 3'),
                  );
                },
                body: const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Text('This is the content of Panel 3.'),
                ),
                isExpanded: _isExpanded[2],
              ),
            ],
                  ),
          ],
        ),
      );
  }
}
