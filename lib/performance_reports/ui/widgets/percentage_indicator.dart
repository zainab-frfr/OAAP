import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart'; 

class MyPercentageIndicator extends StatelessWidget {
  final double percentage; // needs to be between 0.0 and 1.0
  final String label;
  final bool late;

  // Function to determine the color based on the percentage
  Color _getColor(double percentage) {
    if (percentage <= 0.33) {
      return (late)?Colors.green:Colors.red; 
    } else if (percentage <= 0.66) {
      return Colors.orange; 
    } else {
      return (late)? Colors.red:Colors.green; 
    }
  }

  const MyPercentageIndicator({super.key, required this.percentage, required this.label, required this.late});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircularPercentIndicator(
          radius: 80.0,
          lineWidth: 15.0,
          percent: percentage, 
          center: Text(
            "${(percentage * 100).toStringAsFixed(1)}%",
            style: const TextStyle(fontSize: 20.0),
          ),
          progressColor: _getColor(percentage), 
          backgroundColor: Colors.grey,
          circularStrokeCap: CircularStrokeCap.round,
        ),
        const SizedBox(height: 5,), 
        Text(label, style: const TextStyle(color: Colors.grey, fontWeight: FontWeight.normal),)
      ],
    );
  }
}