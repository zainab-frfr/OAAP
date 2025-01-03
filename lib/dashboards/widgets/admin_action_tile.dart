import 'package:flutter/material.dart';

class ActionTile extends StatelessWidget {
  final List<Color> colors;
  final String text;
  final Function onTap;

  const ActionTile({super.key, required this.colors, required this.text, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 1.0,
      borderRadius: BorderRadius.circular(20),
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          onTap();
        },
        borderRadius: BorderRadius.circular(20),
        child: Ink(
          height: 120,
          width: 120,
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: colors,
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
              borderRadius: BorderRadius.circular(20)),
          child: Center(
            child: Flex( // expanded needs to be placed inside column, row, or flex widget
              direction: Axis.horizontal,
              children: [
                Expanded(
                  child: Text(
                    text,
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 10),
                  ),
                ),
              ],
            )
          ),
        ),
      ),
    );
  }
}
