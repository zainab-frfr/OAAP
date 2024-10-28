import 'package:flutter/material.dart';
import 'package:oaap/client_category_management/ui_components/client_category_tile.dart';
import 'package:oaap/client_category_management/ui_components/my_elevated_button.dart';
import 'package:oaap/client_category_management/client_category_notifier.dart';
import 'package:provider/provider.dart';

class MyClientCategoryPage extends StatefulWidget {
  const MyClientCategoryPage({super.key});

  @override
  State<MyClientCategoryPage> createState() => _MyClientCategoryPageState();
}

class _MyClientCategoryPageState extends State<MyClientCategoryPage> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      //executes after widget is built
      context.read<ClientCategoryNotifier>().getAllClients();
      context.read<ClientCategoryNotifier>().retrieveClientsCategories();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Map<String, List<String>> clientsWithCategories =
        context.watch<ClientCategoryNotifier>().clientsWithCategories;
    List<String> allClients =
        context.watch<ClientCategoryNotifier>().allClients;

    bool fetchedMap = context.watch<ClientCategoryNotifier>().fetchedMap;
    bool fetchedList = context.watch<ClientCategoryNotifier>().fetchedList;

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
            PopupMenuButton<String>(
              onSelected: (String value) {
                showDialog(
                  context: context,
                  builder: (context) {
                    if (value == 'Add Client') {
                      return _manageClient(context, 'add');
                    } else {
                      return _manageClient(context, 'delete');
                    }
                  },
                );
              },
              itemBuilder: (BuildContext context) => [
                const PopupMenuItem<String>(
                  height: 40,
                  value: 'Add Client',
                  child: Text(
                    'Add Client',
                    style: TextStyle(fontSize: 10),
                  ),
                ),
                const PopupMenuDivider(),
                const PopupMenuItem<String>(
                  height: 40,
                  value: 'Delete Client',
                  child: Text(
                    'Delete Client',
                    style: TextStyle(fontSize: 10),
                  ),
                ),
              ],
              shape: const RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.vertical(bottom: Radius.circular(2))),
            ),
          ],
        ),
        body: (fetchedList && fetchedMap)
            ? ListView.builder(
                itemCount: allClients.length + 1,
                itemBuilder: (context, index) {
                  if (allClients.isNotEmpty) {
                    if (index < allClients.length) {
                      String client = allClients[index];
                      List<String> categories =
                          clientsWithCategories[client] ?? [];

                      return Column(
                        children: [
                          ClientCategoryTile(
                            client: client,
                            categories: categories,
                            onTap: (String value) {
                              WidgetsBinding.instance.addPostFrameCallback((_){
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return _manageCategory(context, client, value);
                                  },
                                );
                              });
                            },
                          ),
                          const SizedBox(
                            height: 5,
                          )
                        ],
                      );
                    } else {
                      return const SizedBox(height: 50);
                    }
                  } else {
                    return null;
                  }
                },
              )
            : const Center(
                child: CircularProgressIndicator(),
              ));
  }
}

AlertDialog _manageClient(BuildContext context, String toDo) {
  final TextEditingController companyController = TextEditingController();

  return AlertDialog(
    title: (toDo == 'add')? const Text('Add Client') :const Text('Delete Client'),
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
              onTap: () {
                Navigator.pop(context);
              }),
          MyElevatedButton(
              width: 80,
              height: 40,
              child: const Text('Ok'),
              onTap: () async {
                String message = (toDo =='add')
                // ignore: use_build_context_synchronously
                ? await context
                    .read<ClientCategoryNotifier>()
                    .addClientToFirestore(companyController.text)
                // ignore: use_build_context_synchronously
                : await context
                  .read<ClientCategoryNotifier>()
                  .deleteClientFromFirestore(companyController.text);
                // ignore: use_build_context_synchronously
                showSnackbar(context, message);

                // ignore: use_build_context_synchronously
                Navigator.pop(context);
              })
        ],
      )
    ],
  );
}

AlertDialog _manageCategory(BuildContext context, String client, String toDo) {
  final TextEditingController categoryController = TextEditingController();

  return AlertDialog(
    title: (toDo == 'add')? Text('Add Category to $client') : Text('Remove Category from $client'),
    content: TextField(
      controller: categoryController,
      decoration: const InputDecoration(
          hintText: 'Category',
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
              onTap: () {
                Navigator.pop(context);
              }),
          MyElevatedButton(
              width: 80,
              height: 40,
              child: const Text('Ok'),
              onTap: () async {
                final navigatorContext = context;
                String message = (toDo == 'add')
                // ignore: use_build_context_synchronously
                ? await navigatorContext
                    .read<ClientCategoryNotifier>()
                    .addCategoryForAClientToFirestore(categoryController.text, client)
                // ignore: use_build_context_synchronously
                : await navigatorContext
                    .read<ClientCategoryNotifier>()
                    .deleteCategoryFromFirestore(categoryController.text, client);
                // ignore: use_build_context_synchronously
                showSnackbar(navigatorContext, message);
                // ignore: use_build_context_synchronously
                Navigator.pop(context);
              })
        ],
      )
    ],
  );
}

void showSnackbar(BuildContext context, String message) {
  SnackBar snackBar = SnackBar(
    behavior: SnackBarBehavior.floating,
    content: Text(message),
  );
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
