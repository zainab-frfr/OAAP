import 'package:flutter/material.dart';
import 'package:oaap/authentication/services/auth_service.dart';
import 'package:oaap/dashboards/admin_dashboard.dart';
import 'package:oaap/dashboards/employee_dashboard.dart';
//import 'package:oaap/client_category_management/ui_components/client_category_page.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String? role = "";
  @override
  void initState() {
    getRole();
    super.initState();
  }

  Future<void> getRole() async{
    String? getRole = await AuthService().getCurrentUserRole();
    setState(() {
      role = getRole;
    });
  }
  @override
  Widget build(BuildContext context) {
    if(role == 'admin'){
      return const AdminDashboard();  //const MyClientCategoryPage(); 
    }
    else if (role == 'subadmin'){
      return const Center(
        child: Text('subadmin page'),
      );
    }else if (role == 'employee'){
      return const EmployeeDashboard(); 
    }else{
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
  }
}
