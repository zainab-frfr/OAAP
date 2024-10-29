import 'package:flutter/material.dart';
import 'package:oaap/dashboards/admin_dashboard.dart';
//import 'package:oaap/client_category_management/ui_components/client_category_page.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return AdminDashboard();  //const MyClientCategoryPage(); 
  }
}
