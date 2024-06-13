import 'package:fl_query/fl_query.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_solidart/flutter_solidart.dart';
import '../../../screens/home_screen/queries/use_user.dart';
import '../../../entities/practice/model/practice.dart';
import '../../../screens/player_screen/ui/player_screen.dart';
import '../../../entities/meditation/ui/meditation_item.dart';
import '../../../shared/ui/bbb.dart';

class ChooseMeditation extends HookWidget {
  const ChooseMeditation({super.key, required this.practice});

  final Practice practice;

  @override
  Widget build(BuildContext context) {
    final currentIndex = context.get<Signal<int>>(1);

    final Query(data: data) = useUser();

    return SizedBox(
        height: 217,
        child: Container(
            padding: const EdgeInsets.only(left: 16, right: 16, top: 24),
            decoration: const BoxDecoration(
                color: Color.fromRGBO(255, 247, 242, 1),
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(12),
                    topRight: Radius.circular(12))),
            child: Column(children: [
              SizedBox(
                  height: 85,
                  child: ListView.separated(
                    separatorBuilder: (context, index) =>
                        const SizedBox(width: 12),
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) => MeditationItem(
                      duration: practice.meditations[index].duration,
                      title: practice.meditations[index].title,
                      colors: practice.colors,
                      outlined: index == currentIndex.value,
                      onPressed: () => currentIndex.set(index),
                    ),
                    itemCount: practice.meditations.length,
                  )),
              const SizedBox(height: 24),
              (data != null &&
                      !data.hasSubscribe &&
                      practice.meditations[currentIndex.value].forSubs)
                  ? BBB(
                      label: "Для подписчиков",
                      onPressed: () {},
                      colors: practice.colors,
                    )
                  : BBB(
                      label: "Выбрать",
                      colors: practice.colors,
                      onPressed: () =>
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => PlayerScreen(
                                    meditation: practice
                                        .meditations[currentIndex.value],
                                  )))),
            ])));
  }
}
