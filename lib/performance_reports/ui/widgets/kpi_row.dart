import 'package:flutter/material.dart';
import 'package:oaap/performance_reports/ui/widgets/circle.dart';

class MyKPIRow extends StatelessWidget {
  final Color colorOne;
  final Color colorTwo;
  final String kpiOne;
  final String kpiTwo;
  final String countOne;
  final String countTwo;
  const MyKPIRow({super.key, required this.colorOne, required this.colorTwo, required this.kpiOne, required this.kpiTwo, required this.countOne, required this.countTwo,});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [ 
            Row(
              children: [ 
                MyCircle(colorbg: colorOne, text: '', diameter: 10, colorText: colorOne), 
                const SizedBox(width: 10,), 
                Text(kpiOne, style: TextStyle(color: colorOne),)
              ],
            ), 
            Row(
              children: [
                const SizedBox(width: 20,),
                Text(countOne)
              ],
            )
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [ 
            Row(
              children: [ 
                MyCircle(colorbg: colorTwo, text: '', diameter: 10, colorText: colorTwo), 
                const SizedBox(width: 10,), 
                Text(kpiTwo, style: TextStyle(color: colorTwo),)
              ],
            ), 
            Row(
              children: [
                const SizedBox(width: 20,),
                Text(countTwo)
              ],
            )
          ],
        )
      ],
    );
  }
}