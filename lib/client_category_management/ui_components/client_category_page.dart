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
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) { //executes after widget is built
      context.read<ClientCategoryNotifier>().getAllClients();
      context.read<ClientCategoryNotifier>().retrieveClientsCategories();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    
    Map<String,List<String>> clientsWithCategories = context.watch<ClientCategoryNotifier>().clientsWithCategories;
    List<String> allClients = context.watch<ClientCategoryNotifier>().allClients;

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
      (fetchedList && fetchedMap)?
        ListView.builder(
          itemCount: allClients.length + 1,
          itemBuilder: (context, index) {
            if(allClients.isNotEmpty){
              if(index < allClients.length){
                String client = allClients[index];
                List<String> categories = clientsWithCategories[client]?? [];


                return Column(
                  children: [
                    ClientCategoryTile(client: client, categories: categories),
                    const SizedBox(height: 5,)
                  ],
                );
              }else{
                return const SizedBox(height: 50);
              }
            }else{
              return null;
            }

          },
        )
        : const Center(child: CircularProgressIndicator(),)
        //   ListView(
        //   children: const [
        //     ClientCategoryTile(),
        //     ClientCategoryTile(),
        //     ClientCategoryTile(),
        //     ClientCategoryTile(),
        //     ClientCategoryTile(),
        //     ClientCategoryTile(),
        //     ClientCategoryTile(),
        //     ClientCategoryTile(),
        //     SizedBox(
        //       height: 50,
        //     )
        //   ],
        //  ),
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
            onTap: (){
              Navigator.pop(context);
            }
          ),
          MyElevatedButton(
            width: 80, 
            height: 40, 
            child: const Text('Ok'), 
            onTap: () async {
              final navigatorContext = context;
              // ignore: use_build_context_synchronously
              Navigator.pop(context);
              
              String message = await navigatorContext.read<ClientCategoryNotifier>().addClientToFirestore(companyController.text);
              
              // ignore: use_build_context_synchronously
              showSnackbar(navigatorContext, message);
              
            }
          )
        ],
      )
    ],
  );
}

void showSnackbar(BuildContext context, String message){
  SnackBar snackBar = SnackBar(
    behavior: SnackBarBehavior.floating,
    content: Text(message),
  );
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
