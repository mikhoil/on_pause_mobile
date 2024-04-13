import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class PracticesList extends HookWidget {
  const PracticesList({super.key});

  @override
  Widget build(BuildContext context) {
    final pageController = usePageController();
    final tabController = useTabController(initialLength: 2);

    return Stack(alignment: Alignment.bottomCenter, children: [
      PageView(
          controller: pageController,
          onPageChanged: (index) {
            pageController.animateToPage(index,
                duration: const Duration(microseconds: 500),
                curve: Curves.easeInOut);
            tabController.index = index;
          },
          children: [
            Container(
                padding: const EdgeInsets.only(top: 83),
                alignment: Alignment.topCenter,
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(
                            "lib/app/assets/meditation_bg_image.png"),
                        fit: BoxFit.fill,
                        alignment: Alignment.topCenter)),
                child: const Column(children: [
                  Text("ДЫХАТЕЛЬНАЯ ПРАКТИКА",
                      style: TextStyle(
                          fontSize: 19,
                          fontWeight: FontWeight.w500,
                          color: Colors.white)),
                  SizedBox(height: 20),
                  Text("Прогулка по лесу",
                      style: TextStyle(
                          fontSize: 19,
                          fontWeight: FontWeight.w500,
                          color: Colors.white)),
                ])),
            Container(
                padding: const EdgeInsets.only(top: 83),
                alignment: Alignment.topCenter,
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(
                            "lib/app/assets/meditation_bg_image.png"),
                        fit: BoxFit.fill,
                        alignment: Alignment.topCenter)),
                child: const Column(children: [
                  Text("ДЫХАТЕЛЬНАЯ ПРАКТИКА",
                      style: TextStyle(
                          fontSize: 19,
                          fontWeight: FontWeight.w500,
                          color: Colors.white)),
                  SizedBox(height: 20),
                  Text("Прогулка по лесу",
                      style: TextStyle(
                          fontSize: 19,
                          fontWeight: FontWeight.w500,
                          color: Colors.white)),
                ])),
          ]),
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
