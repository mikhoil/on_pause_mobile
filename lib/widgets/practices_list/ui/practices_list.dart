import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_solidart/flutter_solidart.dart';
import '../../../entities/practice/model/practice.dart';

class PracticesList extends HookWidget {
  const PracticesList({super.key, required this.practices});

  final List<Practice> practices;

  @override
  Widget build(BuildContext context) {
    final practiceIdx = context.get<Signal<int>>(0);
    final meditationIdx = context.get<Signal<int>>(1);

    final pageController = usePageController();

    final tabController = useTabController(initialLength: practices.length);

    return Stack(alignment: Alignment.bottomCenter, children: [
      PageView(
          controller: pageController,
          onPageChanged: (index) {
            pageController.animateToPage(index,
                duration: const Duration(microseconds: 500),
                curve: Curves.easeInOut);
            tabController.index = index;
            practiceIdx.set(index);
            meditationIdx.set(0);
          },
          children: List<Widget>.from(practices.map((practice) {
            print(practice.meditations.length);
            return Container(
                padding: const EdgeInsets.only(top: 83),
                alignment: Alignment.bottomCenter,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: NetworkImage(
                            'https://storage.yandexcloud.net/on-pause-meditations/${practice.meditations[meditationIdx.value < practice.meditations.length ? meditationIdx.value : 0].image}'),
                        fit: BoxFit.contain,
                        alignment: Alignment.topCenter)),
                child: Column(children: [
                  Text(practice.title.toUpperCase(),
                      style: TextStyle(
                          fontSize: 19,
                          fontWeight: FontWeight.w500,
                          color: Color(int.parse(
                              practice.colors[0].replaceAll('#', 'FF'),
                              radix: 16)))),
                  SizedBox(height: 7),
                  Container(
                      decoration: BoxDecoration(
                          color: Color(int.parse(
                              practice.colors[1].replaceAll('#', 'FF'),
                              radix: 16)),
                          borderRadius: BorderRadius.circular(21)),
                      padding:
                          EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                      child: Text(
                          practices[practiceIdx.value]
                              .meditations[meditationIdx.value]
                              .title,
                          style: TextStyle(
                              fontSize: 15,
                              color: Color(int.parse(
                                  radix: 16,
                                  practice.colors[2].replaceAll('#', 'FF')))))),
                ]));
          }))),
      Positioned(
          bottom: 220,
          child: TabPageSelector(
            controller: tabController,
            color: const Color.fromRGBO(80, 89, 89, 0.36),
            selectedColor: const Color.fromRGBO(80, 89, 89, 1),
            borderStyle: BorderStyle.none,
          )),
    ]);
  }
}
