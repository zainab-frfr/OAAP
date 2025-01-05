import 'package:flutter/material.dart';

class MyCircle extends StatelessWidget {
  final Color colorbg;
  final Color colorText;
  final double diameter;
  final String text;
  const MyCircle({super.key, required this.colorbg, required this.text, required this.diameter, required this.colorText});

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: Stack(
        children: [
          Container(
            width: diameter,
            height: diameter,
            color: colorbg,
            child: Center(
              child: Text(text, style: TextStyle(color: colorText, fontWeight: FontWeight.bold),),
            ),
          ),
        ],
      ),
    );
  }
}