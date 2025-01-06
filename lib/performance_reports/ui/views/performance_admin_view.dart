import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oaap/access_management/data/user_model.dart';
import 'package:oaap/performance_reports/bloc/user%20bloc/user_bloc.dart';
import 'package:oaap/performance_reports/ui/widgets/user_tile.dart';

class AdminPerformanceView extends StatefulWidget {
  const AdminPerformanceView({super.key});

  @override
  State<AdminPerformanceView> createState() => _AdminPerformanceViewState();
}

class _AdminPerformanceViewState extends State<AdminPerformanceView> {

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async{
      context.read<UserBloc>().add( const FetchUsers());
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
            'Select Employee',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
        ),
      ),
      body: BlocBuilder<UserBloc,UserState>(
        builder: (context, state) {
          switch(state){
            case UserLoadingState():
              return const Center(child: CircularProgressIndicator(),);
            case UserErrorState():
              return Center(child: Text('Error Loading Report: ${state.error}'),);
            case FetchedUsers():
              return ListView.builder(
                itemCount: state.users.length,
                itemBuilder: (context, index) {
                  User currUser = state.users[index];

                  return UserTile(userName: currUser.username, userEmail: currUser.email);
                },
              );
          }
        },
      )
    );
  }
}