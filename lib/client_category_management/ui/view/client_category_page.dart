import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oaap/client_category_management/bloc/cc_bloc.dart';
import 'package:oaap/client_category_management/data/client_category_model.dart';
import 'package:oaap/client_category_management/ui/widgets/client_category_tile.dart';
import 'package:oaap/global/global%20widgets/my_elevated_button.dart';

class MyClientCategoryPage extends StatefulWidget {
  const MyClientCategoryPage({super.key});

  @override
  State<MyClientCategoryPage> createState() => _MyClientCategoryPageState();
}

class _MyClientCategoryPageState extends State<MyClientCategoryPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      context.read<ClientCategoryBloc>().add(FetchClientCategory());
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        key: _scaffoldKey,
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
                      return _manageClient(context, 'add', _scaffoldKey);
                    } else {
                      return _manageClient(context, 'delete', _scaffoldKey);
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
        body: BlocListener<ClientCategoryBloc, ClientCategoryState>(
            listener: (context, state) {
          if (state is ClientCategoryPopUpMessage) {
            // Show success snackbar when the data is fetched
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              behavior: SnackBarBehavior.floating,
              content: Text(state.message),
            ));
          }
        }, child: BlocBuilder<ClientCategoryBloc, ClientCategoryState>(
                builder: (context, state) {
          switch (state) {
            case LoadingClientCategory():
              return const Center(
                child: CircularProgressIndicator(),
              );
            case FetchedClientCategory():
              return (state.clientsAndCategories.isNotEmpty)
                  ? ListView.builder(
                      itemCount: state.clientsAndCategories.length + 1,
                      itemBuilder: (context, index) {
                        //if (state.clientsAndCategories.isNotEmpty) {
                        if (index < state.clientsAndCategories.length) {
                          ClientCategoryModel modelInstance =
                              state.clientsAndCategories[index];
                          List<String> categories = modelInstance.categories;

                          return Column(
                            children: [
                              ClientCategoryTile(
                                client: modelInstance.client,
                                categories: categories,
                                onTap: (String value) {
                                  WidgetsBinding.instance
                                      .addPostFrameCallback((_) {
                                    showDialog(
                                      context: context,
                                      builder: (context) {
                                        return _manageCategory(
                                            context,
                                            modelInstance.client,
                                            value,
                                            _scaffoldKey);
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
                          return null;
                        }
                      },
                    )
                  : const Center(
                      child: Text('No clients and categories found.'),
                    );

            case ClientCategoryError():
              return Center(
                child: Text(state.error),
              );
            case ClientCategoryPopUpMessage():
              context.read<ClientCategoryBloc>().add(FetchClientCategory());
              return Container();
            default:
              return const Center(
                child: Text('Error retrieving information'),
              );
          }
        })));
  }
}

AlertDialog _manageClient(
    BuildContext context, String toDo, GlobalKey<ScaffoldState> scaffoldKey) {
  final TextEditingController companyController = TextEditingController();

  return AlertDialog(
    title: (toDo == 'add')
        ? const Text('Add Client')
        : const Text('Delete Client'),
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
                Navigator.pop(context);
                (toDo == 'add')
                    ? context.read<ClientCategoryBloc>().add(AddClient(client: companyController.text))
                    : context.read<ClientCategoryBloc>().add(RemoveClient(client: companyController.text));
              })
        ],
      )
    ],
  );
}

AlertDialog _manageCategory(BuildContext context, String client, String toDo,
    GlobalKey<ScaffoldState> scaffoldKey) {
  final TextEditingController categoryController = TextEditingController();

  return AlertDialog(
    title: (toDo == 'add')
        ? Text('Add Category to $client')
        : Text('Remove Category from $client'),
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
                Navigator.pop(context);
                (toDo == 'add')
                    ? context.read<ClientCategoryBloc>().add(AddCategoryToClient(category: categoryController.text, client: client))
                    : context.read<ClientCategoryBloc>().add(RemoveCategoryFromClient(category: categoryController.text, client: client));
              })
        ],
      )
    ],
  );
}
