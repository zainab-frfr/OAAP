import 'package:flutter/material.dart';

class MySignInUpButton extends StatelessWidget {
  final Function onTap; 
  final String text; 
  
  const MySignInUpButton({super.key, required this.onTap, required this.text});

  @override
  Widget build(BuildContext context) {
    return Material(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      elevation: 2,
      child: InkWell(
        borderRadius: BorderRadius.circular(15),
        onTap: (){
          onTap();
        },
        child: Ink(
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.secondaryContainer,
            borderRadius: BorderRadius.circular(15),
            // border: Border.all(
            //   color: Theme.of(context).primaryColor
            // )
          ),
          padding: const EdgeInsets.all(25),
          child: Center(child: Text(text, style:  const TextStyle(fontWeight: FontWeight.bold),)),
        ),
      ),
    );
  }
}