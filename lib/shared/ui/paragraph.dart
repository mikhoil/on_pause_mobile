import 'package:flutter/cupertino.dart';

class Paragraph extends StatelessWidget {
  const Paragraph({super.key, required this.text, required this.mt});

  final String text;
  final double mt;

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      SizedBox(height: mt),
      Text(
        text,
        style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
      )
    ]);
  }
}
