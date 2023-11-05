import 'package:flutter/material.dart';

class ReusableWidgets extends StatelessWidget {
  final String time;
  final String temperature;
  final IconData iconData;
  const ReusableWidgets({super.key,
  required this.time,
  required this.temperature,
  required this.iconData,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      child: Container(
        padding: const EdgeInsets.all(8.0),
        width: 120,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(18)),
        child:  Column(
          children: [
            Text(
              time,
              style:const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
         const   SizedBox(
              height: 10,
            ),
            Icon(
              iconData,
              size: 32,
            ),
          const  SizedBox(
              height: 10,
            ),
            Text(
              temperature,
            ),
          ],
        ),
      ),
    );
  }
}
