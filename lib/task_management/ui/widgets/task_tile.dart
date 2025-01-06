import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:oaap/access_management/data/user_model.dart';
import 'package:oaap/authentication/data/curr_user.dart';
import 'package:oaap/global/global%20widgets/input_field.dart';
import 'package:oaap/global/global%20widgets/my_elevated_button.dart';
import 'package:oaap/global/global%20widgets/text_button.dart';
import 'package:oaap/task_management/bloc/task_bloc.dart';
import 'package:oaap/task_management/data/note.dart';
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
                      Text(task.dateDue, style: const TextStyle(color: Colors.grey), overflow: TextOverflow.ellipsis,)
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Responsibility:'),
                      Text(task.responsibleUser.split('@')[0], style: const TextStyle(color: Colors.grey), overflow: TextOverflow.ellipsis,)
                    ],
                  ), 
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void showDetails(BuildContext context) async{
    User currUser = await CurrentUser().getCurrentUser();
    bool isCurrentUser = (task.responsibleUser == currUser.email);

    showModalBottomSheet(
      enableDrag: true,
      isScrollControlled: true,
      //scrollControlDisabledMaxHeightRatio: MediaQuery.sizeOf(context).height *0.75,
      // ignore: use_build_context_synchronously
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
                        const Text('Initiated on:'),
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
                    if(isCurrentUser)
                      const SizedBox(height: 40,),
                    if(isCurrentUser)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          MyTextButton(
                            text: 'Mark Complete', 
                            onTap: (){
                              markComplete(context, task);
                            }
                          )
                        ],
                      ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Notes:', style: TextStyle(fontWeight: FontWeight.bold),),
                        IconButton(
                          onPressed: (){
                            addNote(context, task, currUser);
                          }, 
                          icon:const Icon(Icons.add, size: 20,)
                        )
                      ],
                    ), 
                    const SizedBox(height: 10),
                    if (task.notes.isEmpty)
                      const Text(
                        'No notes added yet.',
                        style: TextStyle(color: Colors.grey),
                      )
                    else
                      ListView.separated(
                         separatorBuilder: (context, index) => const Divider(
                            thickness: 0.5,
                            color: Colors.grey,
                          ),
                        shrinkWrap: true, 
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: task.notes.length,
                        itemBuilder: (context, index) {
                          final note = task.notes[index];
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 5.0),
                            child: ListTile(
                              title: Text(note.comment),
                              leading: CircleAvatar(
                                backgroundColor: const Color.fromARGB(255, 110, 137, 151),
                                child: Text(
                                  '${index + 1}',
                                  style: const TextStyle(color: Colors.white, fontSize: 15),
                                ),
                              ),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'By: ${note.username}',
                                    style: const TextStyle(fontSize: 12, color: Colors.grey),
                                  ),
                                  Text(
                                    'On: ${note.date}',
                                    style: const TextStyle(fontSize: 12, color: Colors.grey),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
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

void addNote(BuildContext context, Task task, User currUser){
  TextEditingController controller = TextEditingController();

  showDialog(
    context: context, 
    builder: (context) {
      return AlertDialog(
        content: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              MyInputField(hintText: 'Add Comment', obscureText: false, controller: controller)
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
                  },
                ),
                MyElevatedButton(
                  width: 80,
                  height: 40,
                  child: const Text('OK'),
                  onTap: () {
                    DateTime todaysDate = DateTime.now();
                    String todaysDateString = DateFormat.yMMMMd('en_US').format(todaysDate);
                    Note note = Note(comment: controller.text, username: currUser.username, date: todaysDateString);
                    context.read<TaskBloc>().add(AddNote(note: note, task: task));
                    Navigator.pop(context); //popping dialog box
                    Navigator.pop(context); //popping modal sheet
                  },
                )
              ],
            )
          ],
      );
    },
  );
}

void markComplete(BuildContext context, Task task){
  showDialog(
    context: context, 
    builder: (context) {
      return AlertDialog(
        content: const Padding(
          padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Are you sure you want to'),
              Text('mark this task completed?')
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
                  },
                ),
                MyElevatedButton(
                  width: 80,
                  height: 40,
                  child: const Text('OK'),
                  onTap: () {
                    context.read<TaskBloc>().add(MarkTaskComplete(task: task));
                    Navigator.pop(context); //popping dialog box
                    Navigator.pop(context); //popping modal sheet
                  },
                )
              ],
            )
          ],
      );
    },
  );
}



// void delete(BuildContext context, Task task){
//   showDialog(
//     context: context, 
//     barrierDismissible: false,
//     builder: (context) {
//       return AlertDialog(
//         content: const Padding(
//           padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               Text('Are you sure you want'),
//               Text('to delete this task?')
//             ],
//             ),
//         ),
//         actions: [
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 MyElevatedButton(
//                   width: 80,
//                   height: 40,
//                   child: const Text('Cancel'),
//                   onTap: () {
//                     Navigator.pop(context);
//                   },
//                 ),
//                 MyElevatedButton(
//                   width: 80,
//                   height: 40,
//                   child: const Text('OK'),
//                   onTap: () {
//                     context.read<TaskBloc>().add(EditTask(task: task));
//                     Navigator.pop(context);
//                   },
//                 )
//               ],
//             )
//           ],
//       );
//     },
//   );
// }