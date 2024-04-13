import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class Close extends StatelessWidget {
  const Close({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
        top: 22,
        right: 16,
        width: 40,
        height: 40,
        child: ElevatedButton(
            style: const ButtonStyle(
                padding: MaterialStatePropertyAll(EdgeInsets.zero),
                iconColor: MaterialStatePropertyAll(
                    Color.fromRGBO(255, 255, 255, .19)),
                backgroundColor: MaterialStatePropertyAll(
                    Color.fromRGBO(255, 255, 255, .07)),
                fixedSize: MaterialStatePropertyAll(Size.fromRadius(18.5))),
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: SvgPicture.asset(
              "lib/app/assets/cross.svg",
              fit: BoxFit.fill,
            )));
  }
}
