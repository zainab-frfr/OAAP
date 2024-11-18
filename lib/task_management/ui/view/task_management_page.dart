import 'package:flutter/material.dart';
import 'package:oaap/settings/bloc/theme_bloc.dart';
import 'package:oaap/task_management/ui/view/create_task.dart';
import 'package:oaap/task_management/ui/view/view_tasks.dart';
import 'package:provider/provider.dart';

class MyTaskPage extends StatefulWidget {
  const MyTaskPage({super.key});

  @override
  State<MyTaskPage> createState() => _MyTaskPageState();
}

class _MyTaskPageState extends State<MyTaskPage> {
  int currentPageIndex = 0;

   @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if(context.watch<ThemeBloc>().state.themeString == 'System Theme'){
      context.read<ThemeBloc>().add(ThemeChanged(theme: 'System Theme', context: context));
    }
  }

  @override
  Widget build(BuildContext context) {
    Brightness mode = context.select((ThemeBloc bloc) => bloc.state.brightness);

    return Scaffold(
      appBar: AppBar(
        title: const Padding(
          padding: EdgeInsets.symmetric(
            vertical: 20,
          ),
          child: Text(
            'Task Management',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
        ),
      ),
      body: <Widget>[
        // view access
        const ViewTasksPage(),
        // edit access
        const CreateTaskPage(),

      ][currentPageIndex],
      bottomNavigationBar: ClipRRect(
        borderRadius: BorderRadius.circular(15.0),
        child: NavigationBar(
          labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
          elevation: 2.0,
          onDestinationSelected: (int index) {
            setState(() {
              currentPageIndex = index;
            });
          },
          indicatorColor: (mode == Brightness.light)
              ? const Color.fromARGB(255, 140, 203, 255)
              : const Color.fromARGB(255, 65, 71, 77),
          selectedIndex: currentPageIndex,
          destinations: const <Widget>[
            NavigationDestination(
              selectedIcon: Icon(Icons.task_rounded),
              icon: Icon(Icons.task_outlined),
              label: 'View Tasks',
            ),
            NavigationDestination(
              selectedIcon: Icon(Icons.add_task_rounded),
              icon: Icon(Icons.add_task_outlined),
              label: 'Create Tasks',
            ),
          ],
        ),
      ),
    );
  }
}
