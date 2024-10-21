import 'package:flutter/material.dart';
import 'dart:math' as math;

class CategoryChip extends StatelessWidget {
  final List<String> categories;

  const CategoryChip({super.key, required this.categories});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8.0, 
      runSpacing: 4.0,
      children: categories.map((category) => returnChip(category)).toList(),
    );
  }
}

Color randomBlueShade() {
  final random = math.Random();
  int blue = random.nextInt(256); // Random value for the blue component (0-255)
  return Color.fromARGB(
    0,             // Alpha (fully opaque)
    random.nextInt(30), // Low value for red (0-50 to keep it low)
    random.nextInt(30), // Low value for green (0-50 to keep it low)
    100 + blue,      // High value for blue (200-255 for stronger blue shades)
  );
}

Chip returnChip(String payID) {
  return Chip(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(20),
    ),
    side: const BorderSide(color: Colors.transparent),
    elevation: 2,
    padding: const EdgeInsets.all(8),
    backgroundColor:
        randomBlueShade().withOpacity(0.2),
    label: Text(
      payID,
      style: const TextStyle(fontSize: 10),
    ),
  );
}