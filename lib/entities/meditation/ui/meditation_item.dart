import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:onpause/shared/utils/format_duration.dart';

class MeditationItem extends HookWidget {
  const MeditationItem(
      {super.key,
      required this.duration,
      required this.outlined,
      required this.onPressed,
      required this.title,
      required this.colors});

  final int duration;
  final String title;
  final bool outlined;
  final VoidCallback onPressed;
  final List<String> colors;

  @override
  Widget build(BuildContext context) {
    return Wrap(children: [
      ElevatedButton(
          onPressed: onPressed,
          style: ButtonStyle(
              backgroundColor: MaterialStatePropertyAll(
                  Color(int.parse(colors[1].replaceAll('#', 'ff'), radix: 16))),
              shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                  side: BorderSide(
                      color: outlined
                          ? Color(int.parse(colors[0].replaceAll('#', 'ff'),
                              radix: 16))
                          : Color(int.parse(colors[1].replaceAll('#', 'ff'),
                              radix: 16)),
                      width: outlined ? 3 : 0),
                  borderRadius: const BorderRadius.all(Radius.circular(16)))),
              padding: const MaterialStatePropertyAll(EdgeInsets.all(15))),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(title,
                style: TextStyle(
                    color: Color(
                        int.parse(colors[2].replaceAll('#', 'ff'), radix: 16)),
                    fontSize: 15)),
            const SizedBox(height: 10),
            Text(formatDuration(duration),
                style: TextStyle(
                    color: Color(
                        int.parse(colors[2].replaceAll('#', 'ff'), radix: 16)),
                    overflow: TextOverflow.ellipsis,
                    fontSize: 15)),
          ]))
    ]);
  }
}
