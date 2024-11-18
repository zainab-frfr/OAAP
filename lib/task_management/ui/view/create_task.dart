import 'package:flutter/material.dart';
import 'package:oaap/global/global%20widgets/input_field.dart';
import 'package:oaap/global/global%20widgets/my_elevated_button.dart';
import 'package:oaap/task_management/ui/widgets/drop_down_button.dart';

class CreateTaskPage extends StatelessWidget {

  const CreateTaskPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: MyElevatedButton(
        width: 200, 
        height: 80, 
        child: const Text('Create Task'), 
        onTap: (){
          selectClient(context);
        }
      ),
    );

  }

  void selectClient(BuildContext context){
    showDialog(
      context: context, 
      builder: (context) {
        return AlertDialog(
          title: const Text('Select Client'),
          content: const Padding(
            padding:  EdgeInsets.symmetric(vertical: 30),
            child: MyDropDownButton(
              valueOfFormField: 'Loreal', 
              dropDownMenuItems: ['Loreal', 'Colgate' , 'Unilever']
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
                  onTap: (){
                    Navigator.pop(context);
                  },
                ),
                MyElevatedButton(
                  width: 80, 
                  height: 40,
                  child: const Text('OK'),
                  onTap: (){
                    Navigator.pop(context);
                    selectCategory(context);
                  },
                )
              ],
            )
          ],
        );
      },
    ); 
  }

  void selectCategory(BuildContext context){
    showDialog(
      context: context, 
      builder: (context) {
        return AlertDialog(
          title: const Text('Select Category'),
          content: const Padding(
            padding: EdgeInsets.symmetric(vertical: 30),
            child: MyDropDownButton(
              valueOfFormField: 'Soap', 
              dropDownMenuItems: ['Soap', 'Shampoo' , 'Toothpaste']
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
                  onTap: (){
                    Navigator.pop(context);
                  },
                ),
                MyElevatedButton(
                  width: 80, 
                  height: 40,
                  child: const Text('OK'),
                  onTap: (){
                    Navigator.pop(context);
                    selectResponsibility(context);
                  },
                )
              ],
            )
          ],
        );
      },
    );
  }

  void selectResponsibility(BuildContext context){
    showDialog(
      context: context, 
      builder: (context) {
        return AlertDialog(
          title: const Text('Select Responsibility'),
          content:  const Padding(
            padding: EdgeInsets.symmetric(vertical: 30),
            child: MyDropDownButton(
              valueOfFormField: 'Yasir', 
              dropDownMenuItems: ['Yasir', 'Zainab' , 'Areeba']
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
                  onTap: (){
                    Navigator.pop(context);
                  },
                ),
                MyElevatedButton(
                  width: 80, 
                  height: 40,
                  child: const Text('OK'),
                  onTap: (){
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

  void enterTitleAndDescription(BuildContext context){
    TextEditingController titleController = TextEditingController();
    TextEditingController descriptionController = TextEditingController();

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
                MyInputField(hintText: 'Task Title', obscureText: false, controller: titleController),
                const SizedBox(height: 20,),
                MyInputField(hintText: 'Task Description', obscureText: false, controller: descriptionController)
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
                  onTap: (){
                    Navigator.pop(context);
                  },
                ),
                MyElevatedButton(
                  width: 80, 
                  height: 40,
                  child: const Text('OK'),
                  onTap: (){
                    Navigator.pop(context);
                    selectDueDate(context);
                  },
                )
              ],
            )
          ],
        );
      },
    );
  }

  void selectDueDate(BuildContext context){
  
    showDatePicker(
      context: context, 
      firstDate: DateTime.now(), 
      lastDate: DateTime(2050),
      initialDate: DateTime.now(),
    );
    
  }
}