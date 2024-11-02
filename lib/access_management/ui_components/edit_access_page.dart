import 'package:flutter/material.dart';
import 'package:oaap/access_management/models/client_cat_acc_model.dart';
import 'package:oaap/access_management/models/user_model.dart';
import 'package:oaap/access_management/provider/access_notifier.dart';
import 'package:oaap/access_management/provider/user_notifier.dart';
import 'package:oaap/global/global%20widgets/my_elevated_button.dart';
import 'package:provider/provider.dart';

class EditAccessPage extends StatefulWidget {
  const EditAccessPage({super.key});

  @override
  State<EditAccessPage> createState() => _EditAccessPageState();
}

class _EditAccessPageState extends State<EditAccessPage> {
  String? selectedClient;
  String? selectedCategory;
  String? selectedUser;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      final accessNotifier = Provider.of<AccessNotifier>(context, listen: false);

      await accessNotifier.getAccess();
      // ignore: use_build_context_synchronously
      await Provider.of<UserNotifier>(context, listen: false).getUsers();
      // Set the selected client after data is fetched
      setState(() {
        selectedClient = accessNotifier.accessList[0].client;
        selectedCategory = accessNotifier.accessList[0].categories[0];
        selectedUser = Provider.of<UserNotifier>(context, listen: false).allUsers[0].username;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    // each object contains string of client name, and a list of it's categories.
    List<ClientCategoryAccess> accessList = context.watch<AccessNotifier>().accessList;
    bool fetchedAccessList = context.watch<AccessNotifier>().fetchedAccess;
    List<User> usersList = context.watch<UserNotifier>().allUsers;
    bool fetchedUsersList = context.watch<UserNotifier>().fetchedData;

    return (fetchedAccessList && fetchedUsersList)
    ?Center(
      child: Card(
        elevation: 0.75,
        child: SizedBox(
          height: MediaQuery.sizeOf(context).height * 0.5,
          width: MediaQuery.sizeOf(context).width * 0.75,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 12),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    FittedBox(
                      fit: BoxFit.scaleDown,
                      child: SizedBox(
                        width: MediaQuery.sizeOf(context).width * 0.75,
                        child: DropdownButtonFormField(
                            isDense: true,
                            decoration: const InputDecoration(border: InputBorder.none),
                            enableFeedback: true,
                            value: accessList[0].client,
                            items: accessList.map((entry) {
                              return DropdownMenuItem(
                                  value: entry.client,
                                  child: Text(entry.client));
                            }).toList(),
                            onChanged: (value) {
                              setState(() {
                                selectedClient = value;
                              });
                            }),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    FittedBox(
                      fit: BoxFit.scaleDown,
                      child: SizedBox(
                        width: MediaQuery.sizeOf(context).width * 0.75,
                        child: DropdownButtonFormField(
                            isDense: true,
                            decoration:
                                const InputDecoration(border: InputBorder.none),
                            enableFeedback: true,
                            value: accessList
                                .firstWhere(
                                  (element) => element.client == selectedClient,
                                  orElse: () => ClientCategoryAccess(
                                      client: '',
                                      categoryAccess: {},
                                      categories: ['no categories']),
                                )
                                .categories[0],
                            items: accessList
                                .firstWhere(
                                  (element) => element.client == selectedClient,
                                  orElse: () => ClientCategoryAccess(
                                      client: '',
                                      categoryAccess: {},
                                      categories: ['no categories']),
                                )
                                .categories
                                .map((entry) {
                              return DropdownMenuItem(
                                  value: entry, child: Text(entry));
                            }).toList(),
                            onChanged: (value) {
                              selectedCategory = value;
                            }),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    FittedBox(
                      fit: BoxFit.scaleDown,
                      child: SizedBox(
                        width: MediaQuery.sizeOf(context).width * 0.75,
                        child: DropdownButtonFormField(
                            isDense: true,
                            decoration:
                                const InputDecoration(border: InputBorder.none),
                            enableFeedback: true,
                            value: usersList[0].username,
                            items: usersList.map((user) {
                              return DropdownMenuItem(
                                value: user.username,
                                child: Text(user.username, overflow: TextOverflow.ellipsis,),
                              );
                            }).toList(),
                            onChanged: (value) {
                              selectedUser = value;
                            }),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    MyElevatedButton(
                        width: 100,
                        height: 70,
                        child: const Text('Revoke\nAccess'),
                        onTap: () async {
                          String message = await context.read<AccessNotifier>().revokeAccess(selectedClient!, selectedCategory!,'${selectedUser!}@gmail.com');
                          // ignore: use_build_context_synchronously
                          showSnackbar(context, message);
                        }),
                    MyElevatedButton(
                        width: 100,
                        height: 70,
                        child: const Text(' Grant\nAccess'),
                        onTap: () async {
                          String message = await context.read<AccessNotifier>().grantAccess(selectedClient!, selectedCategory!,'${selectedUser!}@gmail.com');
                          // ignore: use_build_context_synchronously
                          showSnackbar(context, message);
                        })
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    )
    : const Center(child: CircularProgressIndicator(),);

  }
}

void showSnackbar(BuildContext context, String message) {
  SnackBar snackBar = SnackBar(
    behavior: SnackBarBehavior.floating,
    content: Text(message),
  );
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}