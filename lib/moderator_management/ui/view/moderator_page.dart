import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oaap/access_management/data/user_model.dart';
import 'package:oaap/authentication/ui_components/widgets/sign_in_up_button.dart';
import 'package:oaap/moderator_management/ui/widgets/moderator_tile.dart';
import 'package:oaap/performance_reports/bloc/user%20bloc/user_bloc.dart';

class ModeratorManagementPage extends StatefulWidget {
  const ModeratorManagementPage({super.key});

  @override
  State<ModeratorManagementPage> createState() => _ModeratorManagementPageState();
}

class _ModeratorManagementPageState extends State<ModeratorManagementPage> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      context.read<UserBloc>().add(const FetchUsers());
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Padding(
          padding: EdgeInsets.symmetric(
            vertical: 20,
          ),
          child: Text(
            'Moderator Management',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
        ),
      ),
      body:Padding(
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
        child: BlocBuilder<UserBloc,UserState>(
          builder: (context, state) {
            switch(state){
              case UserLoadingState():
                return const Center(child: CircularProgressIndicator(),);
              case UserErrorState():
                return Center(child: Text(state.error),);
              case FetchedUsers():
                List<User> moderators = state.users.where((user) => user.role == 'moderator').toList();
                List<User> employees = state.users.where((user) => user.role == 'employee').toList();
                return Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        MySignInUpButton(
                          onTap: (){
                            showDialog(
                              context: context, 
                              builder: (context) {
                                return AlertDialog(
                                  title: const Text('Add Moderator'),
                                  content: SizedBox(
                                    width: double.maxFinite,
                                    child: ListView.builder(
                                      itemCount: employees.length,
                                      shrinkWrap: true,
                                      itemBuilder: (context, index) {
                                        return ListTile(
                                          title: Text(employees[index].username),
                                          onTap: () {
                                            context.read<UserBloc>().add( MakeModerator(userEmail: employees[index].email));
                                            Navigator.pop(context); 
                                          },
                                        );
                                      },
                                    ),
                                  ),
                                );
                              },
                            );
                          }, 
                          text: ' Add  Moderator '
                        ),
                        const SizedBox(width: 10,), 
                        MySignInUpButton(
                          onTap: (){
                            showDialog(
                              context: context, 
                              builder: (context) {
                                return AlertDialog(
                                  title: const Text('Remove Moderator'),
                                  content: SizedBox(
                                    width: double.maxFinite,
                                    child: ListView.builder(
                                      itemCount: moderators.length,
                                      shrinkWrap: true,
                                      itemBuilder: (context, index) {
                                        return ListTile(
                                          title: Text(moderators[index].username),
                                          onTap: () {
                                            context.read<UserBloc>().add( RemoveModerator(userEmail: moderators[index].email));
                                            Navigator.pop(context); 
                                          },
                                        );
                                      },
                                    ),
                                  ),
                                );
                              },
                            );
                          }, 
                          text: 'Remove Moderator'), 
                      ],
                    ), 
                    const SizedBox(height: 30,), 
                    Expanded(
                      child: ListView.builder(
                        itemCount: moderators.length,
                        itemBuilder: (context, index) {
                           
                          return MyModeratorTile(user: moderators[index]);
                               
                        },
                      ),
                    )

                  ],
                );
            }
          },
        )
      ),
    );
  }
}