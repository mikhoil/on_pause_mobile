import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class OAuthButton extends StatelessWidget {
  const OAuthButton({super.key, required this.iconPath});

  final String iconPath;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: 48,
        height: 48,
        child: ElevatedButton(
            onPressed: () {},
            style: ButtonStyle(
              padding: const MaterialStatePropertyAll(EdgeInsets.zero),
              backgroundColor: const MaterialStatePropertyAll<Color>(
                  Color.fromRGBO(232, 217, 206, 1)),
              shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6))),
            ),
            child: iconPath.split('.').last == 'svg'
                ? SvgPicture.asset(
                    iconPath,
                    colorFilter: const ColorFilter.mode(
                        Color.fromRGBO(131, 117, 107, 1), BlendMode.srcIn),
                  )
                : Image.asset(
                    iconPath,
                    color: const Color.fromRGBO(131, 117, 107, 1),
                  )));
  }
}
