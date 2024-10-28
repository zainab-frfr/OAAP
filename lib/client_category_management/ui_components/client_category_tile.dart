import 'package:flutter/material.dart';
import 'package:oaap/client_category_management/ui_components/category_chips.dart';
import 'package:oaap/client_category_management/ui_components/my_elevated_button.dart';

class ClientCategoryTile extends StatelessWidget {
  final String client;
  final List<String> categories;
  
  const ClientCategoryTile({super.key, required this.client, required this.categories});

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
                    MyElevatedButton(
                      width: 40, 
                      height: 40, 
                      child: const Icon(Icons.edit, applyTextScaling: true, size: 20,), 
                      onTap: (){}
                    )
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