import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:onpause/app/layouts/main_layout.dart';

class PlayerScreen extends HookWidget {
  const PlayerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final paused = useState(false);
    final double darkness = paused.value ? -50 : 1;

    return Scaffold(
        appBar: PreferredSize(
            preferredSize: const Size.fromHeight(0), child: AppBar()),
        body: Stack(children: [
          Opacity(
              opacity: paused.value ? .9 : 1,
              child: SvgPicture.asset(
                'lib/app/assets/meditation_bg_image.svg',
                fit: BoxFit.cover,
                width: MediaQuery.of(context).size.width,
                colorFilter: ColorFilter.matrix([
                  1,
                  0,
                  0,
                  0,
                  darkness,
                  0,
                  1,
                  0,
                  0,
                  darkness,
                  0,
                  0,
                  1,
                  0,
                  darkness,
                  0,
                  0,
                  0,
                  1,
                  0
                ]),
              )),
          Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.only(
                  top: 51, bottom: 34, left: 33, right: 33),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      const Text("ДЫХАТЕЛЬНАЯ ПРАКТИКА",
                          style: TextStyle(
                              fontSize: 19,
                              color: Colors.white,
                              fontWeight: FontWeight.w500)),
                      const SizedBox(height: 10),
                      const Text("ПРОГУЛКА В ЛЕСУ",
                          style: TextStyle(
                              fontSize: 15,
                              color: Colors.white,
                              fontWeight: FontWeight.w500)),
                      const SizedBox(height: 10),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => const MainLayout()));
                        },
                        style: const ButtonStyle(
                            backgroundColor: MaterialStatePropertyAll(
                                Color.fromRGBO(255, 255, 255, .05))),
                        child: const Text(
                          "Завершить сеанс",
                          style: TextStyle(
                              color: Color.fromRGBO(185, 202, 215, .73),
                              fontSize: 15,
                              fontWeight: FontWeight.w400),
                        ),
                      )
                    ],
                  ),
                  Column(
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          paused.value = !paused.value;
                        },
                        style: const ButtonStyle(
                            fixedSize:
                                MaterialStatePropertyAll(Size.fromRadius(41.5)),
                            padding: MaterialStatePropertyAll(EdgeInsets.zero)),
                        child: SvgPicture.asset(
                          'lib/app/assets/${paused.value ? 'play' : 'pause'}.svg',
                          width: 26,
                          height: 28,
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      LinearProgressIndicator(
                        minHeight: 2,
                        value: .3,
                        color: paused.value ? Colors.white : Colors.black,
                        backgroundColor: Colors.black.withOpacity(.2),
                      ),
                      const SizedBox(
                        height: 14,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "1:30",
                            style: TextStyle(
                                color:
                                    paused.value ? Colors.white : Colors.black,
                                fontWeight: FontWeight.w400,
                                fontSize: 15),
                          ),
                          Text(" / 5:00",
                              style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 15,
                                  color: Colors.black.withOpacity(.3)))
                        ],
                      )
                    ],
                  ),
                ],
              )),
        ]));
  }
}
