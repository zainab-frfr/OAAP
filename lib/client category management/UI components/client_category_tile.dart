import 'package:flutter/material.dart';
import 'package:oaap/client%20category%20management/UI%20components/category_chip.dart';

class ClientCategoryTile extends StatefulWidget {

  const ClientCategoryTile({super.key});

  @override
  State<ClientCategoryTile> createState() => _ClientCategoryTileState();
}

class _ClientCategoryTileState extends State<ClientCategoryTile> {

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
                const Text(
                  'Loreal',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Categories'),
                    ElevatedButton(
                      onPressed: (){}, 
                      style: ButtonStyle(
                        foregroundColor: MaterialStatePropertyAll<Color>(Theme.of(context).colorScheme.inverseSurface),
                        backgroundColor: MaterialStatePropertyAll<Color>(Theme.of(context).colorScheme.background)
                      ),
                      child: const Icon(Icons.edit, applyTextScaling: true,),
                    )
                  ],
                ),
                Flexible(
                  child: Container(
                      width: MediaQuery.of(context).size.width * 0.75,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: const CategoryChip(categories: ['shampoo','hair care','beverages','toothpaste'],)),
                ),
              ],
            ),
          ),
      ),
    );
  }
}