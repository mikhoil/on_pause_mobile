import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_solidart/flutter_solidart.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../entities/practice/model/practice.dart';
import '../../../screens/player_screen.dart';
import '../../../entities/meditation/ui/meditation_item.dart';
import '../../../shared/ui/bbb.dart';

class ChooseMeditation extends HookWidget {
  const ChooseMeditation({super.key, required this.practice});

  final Practice practice;

  @override
  Widget build(BuildContext context) {
    final currentIndex = context.get<Signal<int>>(1);

    Future<bool> hasSubscribtion() async {
      final prefs = await SharedPreferences.getInstance();
      return prefs.getBool("hasSubscription") ?? false;
    }

    final snapshot = useFuture(hasSubscribtion(), initialData: null);

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
                    duration: practice.meditations[index].duration,
                    outlined: index == currentIndex.value,
                    onPressed: () {
                      currentIndex.set(index);
                    },
                  );
                },
                itemCount: practice.meditations.length,
              )),
          const SizedBox(height: 15),
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 23),
              child: (!snapshot.data! && practice.forSubs)
                  ? BBB(label: "Для подписчиков", onPressed: () {})
                  : BBB(
                      label: "Выбрать",
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => PlayerScreen(
                                  meditation:
                                      practice.meditations[currentIndex.value],
                                  practiceTitle: practice.title,
                                )));
                      }))
        ]));
  }
}
