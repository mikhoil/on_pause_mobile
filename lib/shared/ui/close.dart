import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class Close extends StatelessWidget {
  const Close({super.key, required this.colors});

  final List<String> colors;

  @override
  Widget build(BuildContext context) {
    return Positioned(
        top: 22,
        right: 16,
        width: 40,
        height: 40,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              elevation: 0,
              padding: EdgeInsets.zero,
              foregroundColor:
                  Color(int.parse(colors[0].replaceAll('#', 'ff'), radix: 16)),
              backgroundColor:
                  Color(int.parse(colors[1].replaceAll('#', 'ff'), radix: 16)),
              fixedSize: Size.fromRadius(18.5)),
          onPressed: () => Navigator.of(context).pop(),
          child: const Icon(Icons.close),
        ));
  }
}
