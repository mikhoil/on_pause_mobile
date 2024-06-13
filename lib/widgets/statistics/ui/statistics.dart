import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Statistics extends HookWidget {
  const Statistics(
      {super.key,
      required this.dailyStrick,
      required this.totalTime,
      required this.sessionsCount});

  final int dailyStrick, totalTime, sessionsCount;

  @override
  Widget build(BuildContext context) {
    final prefs = SharedPreferences.getInstance();
    final results = useMemoized(
        () async => (await prefs).getBool('show_stats') ?? true, [prefs]);
    final snapshot = useFuture(results);

    return snapshot.hasData
        ? Container(
            padding: EdgeInsets.only(bottom: 27),
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: [
                Column(children: [
                  snapshot.data!
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Stack(
                              alignment: Alignment.center,
                              children: [
                                Container(
                                    width: MediaQuery.of(context).size.width /
                                        393 *
                                        120,
                                    height: MediaQuery.of(context).size.height /
                                        852 *
                                        182,
                                    decoration: BoxDecoration(
                                        color: Color.fromRGBO(249, 238, 230, 1),
                                        borderRadius:
                                            BorderRadius.circular(10))),
                                Positioned(
                                    top: 8,
                                    child: SvgPicture.asset(
                                      'lib/app/assets/strick_bg.svg',
                                      fit: BoxFit.fitWidth,
                                    )),
                                Column(
                                  children: [
                                    Text(dailyStrick.toString(),
                                        style: TextStyle(fontSize: 35)),
                                    SizedBox(height: 21),
                                    Text(
                                      "Стрик",
                                      style: TextStyle(fontSize: 19),
                                    )
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(width: 8),
                            Stack(
                              alignment: Alignment.center,
                              children: [
                                Container(
                                    width: MediaQuery.of(context).size.width /
                                        393 *
                                        120,
                                    height: MediaQuery.of(context).size.height /
                                        852 *
                                        182,
                                    decoration: BoxDecoration(
                                        color: Color.fromRGBO(249, 238, 230, 1),
                                        borderRadius:
                                            BorderRadius.circular(10))),
                                Positioned(
                                    top: 0,
                                    child: SvgPicture.asset(
                                        'lib/app/assets/time_bg.svg')),
                                Column(
                                  children: [
                                    Text((totalTime ~/ 60).toString(),
                                        style: TextStyle(fontSize: 35)),
                                    SizedBox(height: 21),
                                    Text(
                                      "Минут",
                                      style: TextStyle(fontSize: 19),
                                    )
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(width: 8),
                            Stack(
                              alignment: Alignment.center,
                              children: [
                                Container(
                                    width: MediaQuery.of(context).size.width /
                                        393 *
                                        120,
                                    height: MediaQuery.of(context).size.height /
                                        852 *
                                        182,
                                    decoration: BoxDecoration(
                                        color: Color.fromRGBO(249, 238, 230, 1),
                                        borderRadius:
                                            BorderRadius.circular(10))),
                                Positioned(
                                    top: 24,
                                    child: SvgPicture.asset(
                                        'lib/app/assets/sessions_bg.svg')),
                                Column(
                                  children: [
                                    Text(sessionsCount.toString(),
                                        style: TextStyle(fontSize: 35)),
                                    SizedBox(height: 21),
                                    Text(
                                      "Сессий",
                                      style: TextStyle(fontSize: 19),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ],
                        )
                      : Align(
                          alignment: Alignment.topCenter,
                          child: Container(
                            padding: EdgeInsets.all(40),
                            decoration: BoxDecoration(
                                color: Color.fromRGBO(249, 238, 230, 1),
                                borderRadius: BorderRadius.circular(10)),
                            child: Text(
                                'Занимайтесь в своем комфортном темпе\nСтатистика больше не будет отвлекать',
                                style: TextStyle(
                                    color: Color.fromRGBO(100, 92, 89, 1),
                                    fontSize: 15)),
                          )),
                  SizedBox(height: 27)
                ]),
                Positioned(
                  child: IconButton(
                      style: IconButton.styleFrom(
                        shape: CircleBorder(),
                        alignment: Alignment.center,
                        fixedSize: Size.fromRadius(27),
                        backgroundColor: Color.fromRGBO(255, 247, 242, 1),
                      ),
                      icon: SvgPicture.asset(
                          'lib/app/assets/${!snapshot.data! ? "un" : ""}visible.svg'),
                      onPressed: () => SharedPreferences.getInstance().then(
                          (value) =>
                              value.setBool('show_stats', !snapshot.data!))),
                )
              ],
            ))
        : CircularProgressIndicator();
  }
}
