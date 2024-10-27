import 'package:flutter/material.dart';
import 'package:oaap/client%20category%20management/UI%20components/client_category_tile.dart';
import 'package:oaap/client%20category%20management/UI%20components/my_elevated_button.dart';

class MyClientCategoryPage extends StatelessWidget {
  const MyClientCategoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Padding(
          padding: EdgeInsets.symmetric(
            vertical: 20,
          ),
          child: Text(
            'Clients and Categories',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
        ),
        actions: [
          PopupMenuButton(
              itemBuilder: (context) => [
                    PopupMenuItem(
                      child: const Text(
                        'Add Client',
                        style: TextStyle(fontSize: 10),
                      ),
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return _addClient(context);
                          },
                        );
                      },
                    ),
                  ]),
        ],
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(2))),
      ),
      body:
          // ListWheelScrollView(
          //   itemExtent: 235,
          //   diameterRatio: 2,
          //   children: const[
          //     ClientCategoryTile(),
          //     ClientCategoryTile(),
          //     ClientCategoryTile(),
          //     ClientCategoryTile(),
          //     ClientCategoryTile(),
          //     ClientCategoryTile(),
          //     ClientCategoryTile(),
          //     ClientCategoryTile(),
          //   ]
          // ),
          ListView(
        children: const [
          ClientCategoryTile(),
          ClientCategoryTile(),
          ClientCategoryTile(),
          ClientCategoryTile(),
          ClientCategoryTile(),
          ClientCategoryTile(),
          ClientCategoryTile(),
          ClientCategoryTile(),
          SizedBox(
            height: 50,
          )
        ],
      ),
    );
  }
}

AlertDialog _addClient(BuildContext context) {
  final TextEditingController companyController = TextEditingController();

  return AlertDialog(
    title: const Text('Add Client'),
    content: TextField(
      controller: companyController,
      decoration: const InputDecoration(
          hintText: 'Client name',
          hintStyle: TextStyle(color: Colors.grey, fontSize: 12)),
    ),
    contentPadding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
    actions: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          MyElevatedButton(
            width: 80, 
            height: 40, 
            child: const Text('Cancel'), 
            onTap: (){}
          ),
          MyElevatedButton(
            width: 80, 
            height: 40, 
            child: const Text('Ok'), 
            onTap: (){}
          )
        ],
      )
    ],
  );
}
