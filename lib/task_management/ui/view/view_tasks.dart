import 'package:flutter/material.dart';
import 'package:oaap/task_management/ui/widgets/task_tile.dart';

class ViewTasksPage extends StatelessWidget {
  const ViewTasksPage({super.key});

  @override
  Widget build(BuildContext context) {
    return  ListView.builder(
      itemCount: 10,
      itemBuilder: (context, index) {
        return const MyTaskTile();
      },
    );
  }
}