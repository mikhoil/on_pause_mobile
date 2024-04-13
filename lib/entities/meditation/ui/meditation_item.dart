import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class MeditationItem extends HookWidget {
  const MeditationItem(
      {super.key,
      required this.duration,
      required this.outlined,
      required this.onPressed});

  final int duration;
  final bool outlined;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: onPressed,
        style: ButtonStyle(
            fixedSize: const MaterialStatePropertyAll(Size.fromHeight(80)),
            backgroundColor: const MaterialStatePropertyAll(
                Color.fromRGBO(141, 151, 151, 0.2)),
            shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                side: BorderSide(color: Colors.black, width: outlined ? 2 : 0),
                borderRadius: const BorderRadius.all(Radius.circular(10)))),
            padding: const MaterialStatePropertyAll(
                EdgeInsets.symmetric(vertical: 15, horizontal: 13))),
        child: Column(children: [
          Text(duration.toString(),
              style: const TextStyle(
                  color: Colors.black,
                  overflow: TextOverflow.ellipsis,
                  fontSize: 14,
                  fontWeight: FontWeight.w500)),
          const Text("МИН",
              style: TextStyle(
                  color: Colors.black,
                  overflow: TextOverflow.ellipsis,
                  fontSize: 14,
                  fontWeight: FontWeight.w500)),
        ]));
  }
}
