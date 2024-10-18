import 'package:flutter/material.dart';

class MyTextButton extends StatelessWidget {
  final String text;
  final Function()? onTap;
  
  const MyTextButton({super.key, required this.text, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Ink(
        child: Text(text, style: TextStyle(color: Theme.of(context).colorScheme.primary, fontWeight: FontWeight.bold),),
      ),
    );
  }
}