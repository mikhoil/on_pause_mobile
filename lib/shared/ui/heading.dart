import 'package:flutter/cupertino.dart';

class Heading extends StatelessWidget {
  const Heading({super.key, required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      SizedBox(height: 65),
      Text(
        text,
        style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14),
      )
    ]);
  }
}
