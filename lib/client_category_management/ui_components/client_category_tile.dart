import 'package:flutter/material.dart';
import 'package:oaap/client_category_management/ui_components/category_chips.dart';

class ClientCategoryTile extends StatelessWidget {
  final String client;
  final List<String> categories;
  final Function onTap;
  
  const ClientCategoryTile({super.key, required this.client, required this.categories, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10, left: 20, right: 20),
      child: Material(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        elevation: 4,
        child: Ink(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  client,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Categories', style: TextStyle(fontSize: 12),),
                    PopupMenuButton<String>(
                      icon: const Icon(Icons.edit, size: 20),
                      onSelected: (String value) {
                        onTap(value);
                      },
                      itemBuilder: (BuildContext context) => [
                        const PopupMenuItem<String>(
                          height: 40,
                          value: 'add',
                          child: Text(
                            'Add Category',
                            style: TextStyle(fontSize: 10),
                          ),
                        ),
                        const PopupMenuDivider(),
                        const PopupMenuItem<String>(
                          height: 40,
                          value: 'delete',
                          child: Text(
                            'Remove Category',
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
                Flexible(
                  child: Container(
                      width: MediaQuery.of(context).size.width * 0.75,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: CategoryChips(categories: categories,)),
                ),
              ],
            ),
          ),
      ),
    );
  }
}