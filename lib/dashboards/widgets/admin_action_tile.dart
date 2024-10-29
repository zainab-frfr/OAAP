import 'package:flutter/material.dart';

class AdminActionTile extends StatelessWidget {
  final List<Color> colors;
  final String text;

  const AdminActionTile({super.key, required this.colors, required this.text});

  @override
  Widget build(BuildContext context) {
    return Material(
              elevation: 1.5,
              borderRadius: BorderRadius.circular(20),
              color: Colors.transparent,
              child: InkWell(
                onTap: () {},
                borderRadius: BorderRadius.circular(20),
                child: Ink(
                  height: 120,
                  width: 120,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: colors,
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(20)),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Expanded(
                        child: Center(
                      child: Text(
                        text,
                        textAlign: TextAlign.center,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    )),
                  ),
                ),
              ),
            );
  }
}