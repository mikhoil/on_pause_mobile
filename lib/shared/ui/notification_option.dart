import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class NotificationOption extends HookWidget {
  const NotificationOption(
      {super.key, required this.initialValue, required this.text});

  final bool initialValue;
  final String text;

  @override
  Widget build(BuildContext context) {
    final toggled = useState(initialValue);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(text,
            style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w400,
                color: Color.fromRGBO(61, 41, 26, 1))),
        Switch(
            value: toggled.value,
            onChanged: (value) => toggled.value = value,
            activeColor: Color.fromRGBO(234, 126, 45, 1))
      ],
    );
  }
}
