import 'package:flutter/material.dart';

class MyInputField extends StatelessWidget {
  final String hintText;
  final bool obscureText;
  final TextEditingController controller;
  
  const MyInputField({super.key, required this.hintText, required this.obscureText, required this.controller});

  @override
  Widget build(BuildContext context) {
    return TextField(
        decoration: InputDecoration(hintText: hintText, hintStyle: const TextStyle(color: Colors.grey)),
        controller: controller,
        obscureText: obscureText,
      );
  }
}