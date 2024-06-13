import 'dart:ui';
import 'package:fl_query/fl_query.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../shared/utils/get_day_of_week.dart';
import '../../../shared/utils/get_month.dart';
import '../queries/use_affirmation.dart';

class TodayAffirmation extends HookWidget {
  const TodayAffirmation({super.key});

  @override
  Widget build(BuildContext context) {
    final Query(data: affirmation) = useAffirmation();
    final showed = useState(false);

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(0),
        child: AppBar(),
      ),
      body: affirmation != null
          ? Container(
              padding: EdgeInsets.only(top: 90),
              decoration: BoxDecoration(
                  image: DecorationImage(
                      filterQuality: !showed.value
                          ? FilterQuality.none
                          : FilterQuality.high,
                      fit: BoxFit.fill,
                      image: NetworkImage(
                          'https://storage.yandexcloud.net/on-pause-affirmations/${affirmation.image}'))),
              child: BackdropFilter(
                filter: ImageFilter.blur(
                    sigmaY: showed.value ? 10 : 0,
                    sigmaX: showed.value ? 10 : 0),
                child: showed.value
                    ? GestureDetector(
                        onTap: () => showed.value = false,
                        child: Align(
                            alignment: Alignment.center,
                            child: Container(
                                margin: EdgeInsets.symmetric(horizontal: 20),
                                padding: EdgeInsets.symmetric(
                                    horizontal: 18, vertical: 8),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: Color.fromRGBO(56, 30, 13, .7)),
                                child: Text(
                                  affirmation.text.toUpperCase(),
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 19,
                                      fontWeight: FontWeight.w500),
                                ))))
                    : Column(
                        verticalDirection: VerticalDirection.up,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          ElevatedButton(
                            onPressed: () => showed.value = true,
                            style: ButtonStyle(
                                padding: MaterialStatePropertyAll(
                                    EdgeInsets.symmetric(
                                        horizontal: 40, vertical: 33)),
                                backgroundColor: MaterialStatePropertyAll(
                                    Color.fromRGBO(69, 89, 103, .13)),
                                shape: MaterialStatePropertyAll(
                                    RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(63)))),
                            child: SvgPicture.asset(
                                'lib/app/assets/affirmation.svg'),
                          ),
                          SizedBox(height: 96),
                          Column(children: [
                            Container(
                                decoration: BoxDecoration(
                                    color: Color.fromRGBO(255, 251, 249, 0.85),
                                    borderRadius: BorderRadius.circular(14)),
                                padding: EdgeInsets.symmetric(
                                    vertical: 8, horizontal: 30),
                                child: Text('ВДОХНОВЕНИЕ',
                                    style: TextStyle(
                                        color: Color.fromRGBO(61, 41, 26, 1),
                                        fontSize: 19))),
                            SizedBox(height: 8),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 8, horizontal: 18),
                                  decoration: BoxDecoration(
                                      color: Color.fromRGBO(56, 30, 13, .7),
                                      borderRadius: BorderRadius.circular(9)),
                                  child: Text(
                                    getDayOfWeek(DateTime.now().weekday),
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 15,
                                        fontWeight: FontWeight.w400),
                                  ),
                                ),
                                SizedBox(width: 8),
                                Container(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 8, horizontal: 18),
                                  decoration: BoxDecoration(
                                      color: Color.fromRGBO(56, 30, 13, .7),
                                      borderRadius: BorderRadius.circular(9)),
                                  child: Text(
                                    '${DateTime.now().day} ${getMonth(DateTime.now().month)}',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 15,
                                        fontWeight: FontWeight.w400),
                                  ),
                                ),
                              ],
                            ),
                          ]),
                        ],
                      ),
              ))
          : CircularProgressIndicator(),
    );
  }
}
