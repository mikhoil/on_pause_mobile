import 'package:flutter/material.dart';

class MenuButton extends StatelessWidget {
  const MenuButton(
      {super.key,
      required this.text,
      required this.onPressed,
      required this.leftIcon,
      required this.rightIcon});

  final Widget leftIcon, rightIcon;
  final String text;
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: onPressed,
        child: Container(
          decoration: BoxDecoration(
              color: Color.fromRGBO(148, 115, 92, .06),
              borderRadius: BorderRadius.circular(12)),
          padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(children: [
                leftIcon,
                SizedBox(
                  width: 19,
                ),
                Text(
                  text,
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                      color: Color.fromRGBO(61, 41, 26, 1)),
                ),
              ]),
              rightIcon
            ],
          ),
        ));
  }
}
