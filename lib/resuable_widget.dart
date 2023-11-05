import 'package:flutter/material.dart';
class AnotherReusable extends StatelessWidget {
const  AnotherReusable(
      {super.key,
      required this.title,
      required this.title2,
      required this.iconData
      });
final String title;
final String title2;
final IconData iconData;
 

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(
          iconData,
          size: 32,
        ),
      
        Text(
          title,
          style: const TextStyle(fontSize: 16),
        ),
     
        Text(
          title2,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
      ],
    );
  }
}