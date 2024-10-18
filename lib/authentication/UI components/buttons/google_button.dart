import 'package:flutter/material.dart';

class GoogleButton extends StatelessWidget {
  const GoogleButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
      elevation: 2,
      child: InkWell(
        onTap: (){},
        child: Ink(
          height: 50,
          width: 50,
          child: Center(child: Image.asset('assets/images/google.png')),
        )
      ),
    );
  }
}