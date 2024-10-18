import 'package:flutter/material.dart';

class MyInputField extends StatelessWidget {
  final String hintText;
  final bool obscureText;
  final TextEditingController controller;
  
  const MyInputField({super.key, required this.hintText, required this.obscureText, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: TextField(
        controller: controller,
        obscureText: obscureText,
      ),
    );
  }
}