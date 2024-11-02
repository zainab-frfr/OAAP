import 'package:flutter/material.dart';
import 'package:oaap/global%20widgets/my_elevated_button.dart';

class EditAccessPage extends StatelessWidget {
  const EditAccessPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
          child: Card(
            elevation: 0.75,
            child: SizedBox(
              height: MediaQuery.sizeOf(context).height *0.5,
              width: MediaQuery.sizeOf(context).width *0.75,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 12),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        FittedBox(
                      fit:  BoxFit.scaleDown,
                      child: SizedBox(
                        width: MediaQuery.sizeOf(context).width *0.75,
                        child: DropdownButtonFormField(
                          isDense: true,
                          decoration: const InputDecoration(
                            border: InputBorder.none
                          ),
                          enableFeedback: true,
                          value: 'Client 1',
                          items: const [
                            DropdownMenuItem(value: 'Client 1' , child: Text('Client 1', overflow: TextOverflow.ellipsis,)),
                            DropdownMenuItem(value: 'Client 2' , child: Text('Client 2', overflow: TextOverflow.ellipsis,)),
                            DropdownMenuItem(value: 'Client 3' , child: Text('Client 3', overflow: TextOverflow.ellipsis,)),
                          ], 
                          onChanged: (value) {
                
                          }
                        ),
                      ),
                    ),
                    const SizedBox(height: 20,),
                    FittedBox(
                      fit:  BoxFit.scaleDown,
                      child: SizedBox(
                        width: MediaQuery.sizeOf(context).width *0.75,
                        child: DropdownButtonFormField(
                          isDense: true,
                          decoration: const InputDecoration(
                            border: InputBorder.none
                          ),
                          enableFeedback: true,
                          value: 'Category 1',
                          items: const [
                            DropdownMenuItem(value: 'Category 1' , child: Text('Category 1', overflow: TextOverflow.ellipsis,)),
                            DropdownMenuItem(value: 'Category 2' , child: Text('Category 2', overflow: TextOverflow.ellipsis,)),
                            DropdownMenuItem(value: 'Category 3' , child: Text('Category 3', overflow: TextOverflow.ellipsis,)),
                          ], 
                          onChanged: (value) {
                
                          }
                        ),
                      ),
                    ),
                    const SizedBox(height: 20,),
                     FittedBox(
                      fit:  BoxFit.scaleDown,
                      child: SizedBox(
                        width: MediaQuery.sizeOf(context).width *0.75,
                        child: DropdownButtonFormField(
                          isDense: true,
                          decoration: const InputDecoration(
                            border: InputBorder.none
                          ),
                          enableFeedback: true,
                          value: 'Employee 1',
                          items: const [
                            DropdownMenuItem(value: 'Employee 1' , child: Text('Employee 1', overflow: TextOverflow.ellipsis,)),
                            DropdownMenuItem(value: 'Employee 2' , child: Text('Employee 2', overflow: TextOverflow.ellipsis,)),
                            DropdownMenuItem(value: 'Employee 3' , child: Text('Employee 3', overflow: TextOverflow.ellipsis,)),
                          ], 
                          onChanged: (value) {
                
                          }
                        ),
                      ),
                    ),
                      ],
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        MyElevatedButton(
                              width: 100,
                              height: 70,
                              child: const Text('Revoke\nAccess'),
                              onTap: () async {
                              }),
                         MyElevatedButton(
                              width: 100,
                              height: 70,
                              child: const Text(' Grant\nAccess'),
                              onTap: () async {
                              })
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        );
  }
}