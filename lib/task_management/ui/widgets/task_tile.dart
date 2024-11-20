import 'package:flutter/material.dart';
import 'package:oaap/task_management/data/task.dart';

class MyTaskTile extends StatelessWidget {
  final Task task;

  const MyTaskTile({super.key, required this.task});

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
            child: ListTile(
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    task.title,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Due on:'),
                      Text(task.dateDue,
                          style: const TextStyle(color: Colors.grey))
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Responsibility of:'),
                      Text(task.responsibleUser.split('@')[0],
                          style: const TextStyle(color: Colors.grey))
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
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      task.title,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 30),
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Initited on:'),
                        Text(task.dateInitiated,
                            style: const TextStyle(color: Colors.grey))
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Due on:'),
                        Text(task.dateDue,
                            style: const TextStyle(color: Colors.grey))
                      ],
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Responsibility of:'),
                        Text(task.responsibleUser.split('@')[0],
                            style: const TextStyle(color: Colors.grey))
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Client:'),
                        Text(task.client,
                            style: const TextStyle(color: Colors.grey))
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Category:'),
                        Text(task.category,
                            style: const TextStyle(color: Colors.grey))
                      ],
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    const Text('Description:'),
                    Text(
                      task.description,
                      style: const TextStyle(fontSize: 15, color: Colors.grey),
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
}
