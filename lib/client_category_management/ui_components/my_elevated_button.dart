import 'package:flutter/material.dart';

class MyElevatedButton extends StatelessWidget {
  final double width;
  final double height;
  final Widget child;
  final Function onTap;

  const MyElevatedButton(
      {super.key,
      required this.width,
      required this.height,
      required this.child,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        onTap();
      },
      style: ButtonStyle(
          padding: MaterialStateProperty.all<EdgeInsets>(const EdgeInsets.all(2)),
          minimumSize: MaterialStateProperty.all<Size>( Size(width, height)),
          foregroundColor: MaterialStatePropertyAll<Color>(Theme.of(context).colorScheme.inverseSurface),
          backgroundColor: MaterialStatePropertyAll<Color>(Theme.of(context).colorScheme.background)),
      child: child,
    );
  }
}
