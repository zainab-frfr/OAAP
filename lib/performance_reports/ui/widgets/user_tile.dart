import 'package:flutter/material.dart';
import 'package:oaap/performance_reports/ui/views/performance_employee_view.dart';

class UserTile extends StatelessWidget {
  final String userName; 
  final String userEmail;

  const UserTile({super.key, required this.userName, required this.userEmail});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 15, left: 20, right: 20),
      child: Material(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        elevation: 1.5,
        child: InkWell(
          borderRadius: BorderRadius.circular(10),
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => EmployeePerformanceReport(userEmail: userEmail, userName: userName,),));
          },
          child: Ink(
              width: MediaQuery.sizeOf(context).width,
              height: MediaQuery.sizeOf(context).height * 0.09,
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              child:  Align(
                  alignment: Alignment.centerLeft, child: Text(userName))),
        ),
      ),
    );
  }
}