import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:oaap/access_management/bloc/access_bloc.dart';
import 'package:oaap/global/global%20widgets/input_field.dart';
import 'package:oaap/global/global%20widgets/my_elevated_button.dart';
import 'package:oaap/task_management/bloc/task_bloc.dart';
import 'package:oaap/task_management/data/task.dart';
import 'package:oaap/task_management/ui/widgets/drop_down_button.dart';

/*
    MUSLAY 

    1. agr i dont select a value and try to proceed tou error ata
    2. agr the list that goes into dropdown khali tou phir kia hona chahiyay?
*/
class CreateTaskPage extends StatefulWidget {
  const CreateTaskPage({super.key});

  @override
  State<CreateTaskPage> createState() => _CreateTaskPageState();
}

//USE CLIENT CATEGORY ACCESS BLOC AND MODEL
class _CreateTaskPageState extends State<CreateTaskPage> {
  String selectedClient = '';
  String selectedCategory = '';
  String selectedResponsibility = '';
  DateTime? dateDue;
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      context.read<AccessBloc>().add(const FetchAccessInformation());
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<TaskBloc, TaskState>(
      listener: (context, state) {
        if (state is PopUpMessageState) {
          SnackBar snackBar = SnackBar(
            behavior: SnackBarBehavior.floating,
            content: Text(state.message),
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }
      },
      child: BlocBuilder<AccessBloc, AccessState>(
        builder: (context, state) {
          switch (state) {
            case LoadingState():
              return const Center(
                child: CircularProgressIndicator(),
              );
            case AccessError():
              return Center(child: Text(state.error));
            case FetchedAccessInformation():
              return Center(
                child: MyElevatedButton(
                    width: 200,
                    height: 80,
                    child: const Text('Create Task'),
                    onTap: () {
                      selectClient(context, state);
                    }),
              );
            default:
              return Container();
          }
        },
      ),
    );
  }

  void selectClient(BuildContext context, FetchedAccessInformation state) {
    List<String> clients =
        state.accessList.map((model) => model.client).toList();
    selectedClient = clients[0];
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Select Client'),
          content: Padding(
            padding: const EdgeInsets.symmetric(vertical: 30),
            child: MyDropDownButton(
              valueOfFormField: clients[0],
              dropDownMenuItems: clients,
              onValueChanged: (value) {
                setState(() {
                  selectedClient = value;
                });
              },
            ),
          ),
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
                  },
                ),
                MyElevatedButton(
                  width: 80,
                  height: 40,
                  child: const Text('OK'),
                  onTap: () {
                    Navigator.pop(context);
                    selectCategory(context, state);
                  },
                )
              ],
            )
          ],
        );
      },
    );
  }

  void selectCategory(BuildContext context, FetchedAccessInformation state) {
    List<String> categories = state.accessList
        .firstWhere((model) => model.client == selectedClient)
        .categories;
    selectedCategory = categories[0];

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Select Category'),
          content: Padding(
            padding: const EdgeInsets.symmetric(vertical: 30),
            child: MyDropDownButton(
              valueOfFormField: categories[0],
              dropDownMenuItems: categories,
              onValueChanged: (value) {
                selectedCategory = value;
              },
            ),
          ),
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
                  },
                ),
                MyElevatedButton(
                  width: 80,
                  height: 40,
                  child: const Text('OK'),
                  onTap: () {
                    Navigator.pop(context);
                    selectResponsibility(context, state);
                  },
                )
              ],
            )
          ],
        );
      },
    );
  }

  void selectResponsibility(
      BuildContext context, FetchedAccessInformation state) {
    List<String> peopleWithAccess = state.accessList
        .firstWhere(
          (clientCategory) => clientCategory.client == selectedClient,
        )
        .categoryAccess[selectedCategory]!;

    if(peopleWithAccess.isNotEmpty) selectedResponsibility = peopleWithAccess[0];

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Select Responsibility'),
          content:
          (peopleWithAccess.isNotEmpty)
           ? Padding(
            padding: const EdgeInsets.symmetric(vertical: 30),
            child: MyDropDownButton(
              valueOfFormField: peopleWithAccess[0],
              dropDownMenuItems: peopleWithAccess,
              onValueChanged: (value) {
                selectedResponsibility = value;
              },
            ),
          )
          : const Column(
            mainAxisSize: MainAxisSize.min,
            children: [
             Center(child: Padding(
               padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
               child: Text('No employee has access.\n Please grant access before assigning task', textAlign: TextAlign.center,),
             ),),
            ],
          ),
          actions: [
            Row(
              mainAxisAlignment:(peopleWithAccess.isNotEmpty)? MainAxisAlignment.spaceBetween: MainAxisAlignment.center,
              children: [
                MyElevatedButton(
                  width: 80,
                  height: 40,
                  child: const Text('Cancel'),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
                if(peopleWithAccess.isNotEmpty)
                  MyElevatedButton(
                    width: 80,
                    height: 40,
                    child: const Text('OK'),
                    onTap: () {
                      Navigator.pop(context);
                      enterTitleAndDescription(context);
                    },
                )
              ],
            )
          ],
        );
      },
    );
  }

  void enterTitleAndDescription(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Task Details'),
          content: Padding(
            padding: const EdgeInsets.symmetric(vertical: 30),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                MyInputField(
                    hintText: 'Task Title',
                    obscureText: false,
                    controller: titleController
                ),
                const SizedBox(
                  height: 20,
                ),
                MyInputField(
                    hintText: 'Task Description',
                    obscureText: false,
                    controller: descriptionController)
              ],
            ),
          ),
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
                    setState(() {
                      titleController.clear();
                      descriptionController.clear();
                    });
                  },
                ),
                MyElevatedButton(
                  width: 80,
                  height: 40,
                  child: const Text('OK'),
                  onTap: () {
                    if(titleController.text.isEmpty || descriptionController.text.isEmpty){
                      SnackBar snackBar = const SnackBar(
                        behavior: SnackBarBehavior.floating,
                        content: Text('Title and Description can not be empty. \n Please cancel if you wish to discard task.'),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    }else{
                      Navigator.pop(context);
                      selectDueDate(context);
                    }
                  },
                )
              ],
            )
          ],
        );
      },
    );
  }

  void selectDueDate(BuildContext context) async {
    dateDue = await showDatePicker(
      context: context,
      firstDate: DateTime.now(),
      lastDate: DateTime(2050),
      initialDate: DateTime.now(),
    );
    if (dateDue != null){
      addTask();
    }
  }

  void addTask() {
    DateTime dateInitiated = DateTime.now();
    String dateInitiatedString =
        DateFormat.yMMMMd('en_US').format(dateInitiated);

    String dateDueString = DateFormat.yMMMMd('en_US').format(dateDue!);

    Task newTask = Task.fromJson({
      'title': titleController.text,
      'description': descriptionController.text,
      'client': selectedClient,
      'category': selectedCategory,
      'dateInitiated': dateInitiatedString,
      'dateDue': dateDueString,
      'responsibleUser': selectedResponsibility
    });
    context.read<TaskBloc>().add(AddTask(task: newTask));

    setState(() {
      titleController.clear();
      descriptionController.clear();
    });

  }
}
