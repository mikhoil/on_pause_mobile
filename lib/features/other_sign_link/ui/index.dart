import 'package:flutter/material.dart';

class OtherSignLink extends StatelessWidget {
  const OtherSignLink(
      {super.key, required this.label, required this.onPressed});

  final String label;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: ButtonStyle(
          padding: const MaterialStatePropertyAll(
              EdgeInsets.symmetric(vertical: 13, horizontal: 77)),
          shape: MaterialStatePropertyAll(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)))),
      child: Text(label,
          style: const TextStyle(
              color: Color.fromRGBO(131, 117, 107, 1),
              fontSize: 15,
              fontWeight: FontWeight.w400)),
    );
  }
}
