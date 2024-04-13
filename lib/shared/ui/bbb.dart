import 'package:flutter/material.dart';

class BBB extends StatelessWidget {
  const BBB({super.key, required this.label, required this.onPressed});

  final String label;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ButtonStyle(
          fixedSize: MaterialStatePropertyAll(
              Size.fromWidth(MediaQuery.of(context).size.width)),
          padding: const MaterialStatePropertyAll(
              EdgeInsets.symmetric(vertical: 20)),
          shape: MaterialStatePropertyAll(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(18))),
          backgroundColor: const MaterialStatePropertyAll<Color>(
              Color.fromRGBO(52, 77, 106, 1))),
      child: Text(label,
          style: const TextStyle(
              color: Colors.white, fontSize: 15, fontWeight: FontWeight.w400)),
    );
  }
}
