import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../../../entities/meditation/ui/meditation_item.dart';
import '../../../shared/ui/bbb.dart';

class ChooseMeditation extends HookWidget {
  const ChooseMeditation({super.key});

  @override
  Widget build(BuildContext context) {
    final List<int> meditations = [
      5,
      10,
      15,
      20,
      30,
    ];
    final currentIndex = useState(0);

    return Container(
        alignment: Alignment.topCenter,
        height: 195,
        padding:
            const EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 28),
        decoration: const BoxDecoration(
            color: Colors.white,
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(12), topRight: Radius.circular(12))),
        child: Column(children: [
          SizedBox(
              height: 80,
              child: ListView.separated(
                separatorBuilder: (context, index) {
                  return const SizedBox(width: 17);
                },
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return MeditationItem(
                    duration: meditations[index],
                    outlined: index == currentIndex.value,
                    onPressed: () {
                      currentIndex.value = index;
                    },
                  );
                },
                itemCount: meditations.length,
              )),
          const SizedBox(height: 15),
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 23),
              child: BBB(label: "Выбрать", onPressed: () {}))
        ]));
  }
}
