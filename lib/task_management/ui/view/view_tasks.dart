import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oaap/task_management/bloc/task_bloc.dart';
import 'package:oaap/task_management/ui/widgets/task_tile.dart';

class ViewTasksPage extends StatefulWidget {
  const ViewTasksPage({super.key});

  @override
  State<ViewTasksPage> createState() => _ViewTasksPageState();
}

class _ViewTasksPageState extends State<ViewTasksPage> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      context.read<TaskBloc>().add(const RetrieveTasks());
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TaskBloc, TaskState>(
      builder: (context, state) {
        switch(state){
          case FetchedTasks():
            return ListView.builder(
              itemCount: state.tasks.length,
              itemBuilder: (context, index) {
                return MyTaskTile(task: state.tasks[index],);
              },
            );
          case TaskLoadingState():
            return const Center(child: CircularProgressIndicator(),);
          default:
            return Container();
        }
      },
    );
  }
}
