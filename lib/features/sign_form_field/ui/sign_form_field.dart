import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';

class SignTextField extends StatelessWidget {
  const SignTextField(
      {super.key,
      required this.name,
      required this.label,
      this.obscureText = false});

  final String name, label;
  final bool obscureText;

  @override
  Widget build(BuildContext context) {
    return ReactiveTextField(
        key: Key(name),
        obscureText: obscureText,
        formControlName: name,
        style: const TextStyle(
          fontSize: 15,
        ),
        decoration: InputDecoration(
            contentPadding:
                const EdgeInsets.only(left: 17, top: 13, bottom: 12),
            filled: true,
            fillColor: const Color.fromRGBO(244, 238, 233, 1),
            floatingLabelBehavior: FloatingLabelBehavior.never,
            label: Text(label,
                style: TextStyle(
                    fontWeight: FontWeight.w400,
                    color: Colors.black.withOpacity(0.39))),
            border: const OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.all(Radius.circular(9)))));
  }
}
