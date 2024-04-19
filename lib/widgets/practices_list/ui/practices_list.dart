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
          children: List<Widget>.from(practices.map((practice) => Container(
              padding: const EdgeInsets.only(top: 83),
              alignment: Alignment.topCenter,
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image:
                          AssetImage("lib/app/assets/meditation_bg_image.png"),
                      fit: BoxFit.fill,
                      alignment: Alignment.topCenter)),
              child: Column(children: [
                Text(practice.title,
                    style: const TextStyle(
                        fontSize: 19,
                        fontWeight: FontWeight.w500,
                        color: Colors.white)),
                SizedBox(height: 20),
                Text(
                    practices[practiceIdx.value]
                        .meditations[meditationIdx.value]
                        .title,
                    style: TextStyle(
                        fontSize: 19,
                        fontWeight: FontWeight.w500,
                        color: Colors.white)),
              ]))))),
      Positioned(
          bottom: 200,
          child: TabPageSelector(
            controller: tabController,
            color: const Color.fromRGBO(80, 89, 89, 0.36),
            selectedColor: const Color.fromRGBO(80, 89, 89, 1),
            borderStyle: BorderStyle.none,
          )),
    ]);
  }
}
