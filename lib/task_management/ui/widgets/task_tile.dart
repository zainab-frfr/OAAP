import 'package:flutter/material.dart';

class MyTaskTile extends StatelessWidget {
  const MyTaskTile({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
      child: Material(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        elevation: 5,
        child: InkWell(
          onTap: () {
            showDetails(context);
          },
          child: Ink(
            child: const ListTile(
              
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Send Data',
                    style:  TextStyle(fontWeight: FontWeight.bold, ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Due on:'),
                      Text('7th December 2024', style: TextStyle(color: Colors.grey))
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Responsibility of:'),
                      Text('Zainab Rehman', style: TextStyle(color: Colors.grey))
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

void showDetails(BuildContext context) {
    showModalBottomSheet(
      enableDrag: true,
      isScrollControlled: true,
      //scrollControlDisabledMaxHeightRatio: MediaQuery.sizeOf(context).height *0.75,
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(10.0)),
      ),
      builder: (context) {
        return DraggableScrollableSheet(
          initialChildSize: 0.60, // Start at 75% of screen height
          minChildSize: 0.3,
          maxChildSize: 0.95,
          expand: false,
          builder: (context, scrollController) {
            return Padding(
              padding: const EdgeInsets.all(20),
              child: ListView(controller: scrollController, children: [
                Center(
                  child: Container(
                    width: 50,
                    height: 4,
                    margin: const EdgeInsets.only(bottom: 20),
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 165, 164, 164),
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Task Title',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 30),
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Initited on:'),
                      Text('4th October 2024', style: TextStyle(color: Colors.grey))
                    ],
                  ),
                    Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Due on:'),
                      Text('7th December 2024', style: TextStyle(color: Colors.grey))
                    ],
                  ),
                  SizedBox(
                      height: 15,
                    ),
                    Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Responsibility of:'),
                      Text('Zainab Rehman', style: TextStyle(color: Colors.grey))
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Client:'),
                      Text('Loreal', style: TextStyle(color: Colors.grey))
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Category:'),
                      Text('Shampoo', style: TextStyle(color: Colors.grey))
                    ],
                  ),
                  
                    

                    SizedBox(
                      height: 15,
                    ),
                    Text('Description:'),
                    Text(
                      'Send Reports to Yahya By Friday. Include all the changes he mentioned in last meeting. Include links to all the demo videos.',
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.grey
                      ),
                    ),
                  ],
                ),
              ]),
            );
          },
        );
      },
    );
  }