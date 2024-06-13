import 'package:flutter/material.dart';

class BBB extends StatelessWidget {
  const BBB(
      {super.key,
      required this.label,
      required this.onPressed,
      required this.colors});

  final String label;
  final VoidCallback onPressed;
  final List<String> colors;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
          elevation: 0,
          fixedSize: Size.fromWidth(MediaQuery.of(context).size.width),
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(52)),
          backgroundColor:
              Color(int.parse(colors[0].replaceAll('#', 'ff'), radix: 16))),
      child: Text(label,
          style: TextStyle(
              color:
                  Color(int.parse(colors[1].replaceAll('#', 'ff'), radix: 16)),
              fontSize: 15,
              fontWeight: FontWeight.w400)),
    );
  }
}
