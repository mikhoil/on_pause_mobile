import 'package:fl_query/fl_query.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../home_screen/queries/use_user.dart';
import '../queries/use_subscription_off.dart';
import '../queries/use_subscription_on.dart';

class SubscriptionScreen extends HookWidget {
  const SubscriptionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Query(data: user) = useUser();
    final on = useSubscriptionOn();
    final off = useSubscriptionOff();

    return Scaffold(
      appBar: PreferredSize(preferredSize: Size.fromHeight(0), child: AppBar()),
      body: Container(
        padding: EdgeInsets.only(left: 33, right: 33, top: 39, bottom: 65),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                GestureDetector(
                  onTap: () => Navigator.of(context).pop(),
                  child: Row(
                    children: [
                      Icon(Icons.chevron_left),
                      Text(
                        'Настройки',
                        style: TextStyle(
                            color: Color.fromRGBO(61, 41, 26, 1),
                            fontSize: 15,
                            fontWeight: FontWeight.w400),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 42,
                ),
                Text(
                  'ПОДПИСКА',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.w400),
                ),
                SizedBox(
                  height: 58,
                ),
                user != null
                    ? Container(
                        padding: EdgeInsets.all(6),
                        decoration: BoxDecoration(
                            color: Color.fromRGBO(148, 115, 92, 0.06),
                            borderRadius: BorderRadius.circular(18)),
                        child: user.hasSubscribe
                            ? Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                          vertical: 9, horizontal: 14),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(12),
                                          color:
                                              Color.fromRGBO(234, 126, 45, 1)),
                                      child: Text(
                                        'Подписка активна',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 15,
                                            fontWeight: FontWeight.w400),
                                      ),
                                    ),
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                          vertical: 9, horizontal: 14),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(12),
                                          color:
                                              Color.fromRGBO(237, 227, 219, 1)),
                                      child: Text('До 24.09.2024',
                                          style: TextStyle(
                                              color: Color.fromRGBO(
                                                  140, 121, 108, 1),
                                              fontSize: 15,
                                              fontWeight: FontWeight.w400)),
                                    )
                                  ])
                            : Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                        vertical: 9, horizontal: 14),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(12),
                                        color:
                                            Color.fromRGBO(237, 227, 219, 1)),
                                    child: Text('Неактивна',
                                        style: TextStyle(
                                            color: Color.fromRGBO(
                                                140, 121, 108, 1),
                                            fontSize: 15,
                                            fontWeight: FontWeight.w400)),
                                  ),
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                        vertical: 9, horizontal: 14),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(12),
                                        color:
                                            Color.fromRGBO(237, 227, 219, 1)),
                                    child: Text('Ввести промокод',
                                        style: TextStyle(
                                            color: Color.fromRGBO(
                                                140, 121, 108, 1),
                                            fontSize: 15,
                                            fontWeight: FontWeight.w400)),
                                  ),
                                ],
                              ))
                    : CircularProgressIndicator(),
                SizedBox(height: 31),
                user != null
                    ? Text(
                        user.hasSubscribe
                            ? 'Вам доступно все и даже'
                            : 'В подписке много хорошего',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w500),
                      )
                    : Text('loading'),
                SizedBox(height: 25),
                Row(children: [
                  Icon(
                    Icons.video_collection_outlined,
                    color: Color.fromRGBO(234, 126, 45, 1),
                  ),
                  SizedBox(
                    width: 17,
                  ),
                  Text(
                    'Доступ ко всем программам',
                    style: TextStyle(
                        fontSize: 15, color: Color.fromRGBO(73, 66, 60, 1)),
                  )
                ]),
                SizedBox(height: 25),
                Row(children: [
                  SvgPicture.asset('lib/app/assets/schedule.svg'),
                  SizedBox(
                    width: 17,
                  ),
                  Text(
                    'Возможность планировать сессии',
                    style: TextStyle(
                        fontSize: 15, color: Color.fromRGBO(73, 66, 60, 1)),
                  )
                ]),
                SizedBox(height: 25),
                Row(children: [
                  SvgPicture.asset('lib/app/assets/download.svg'),
                  SizedBox(
                    width: 17,
                  ),
                  Text(
                    'Загрузка медитаций, оффлайн режим',
                    style: TextStyle(
                        fontSize: 15, color: Color.fromRGBO(73, 66, 60, 1)),
                  )
                ]),
                SizedBox(height: 25),
                Row(children: [
                  SvgPicture.asset('lib/app/assets/cancel.svg', width: 23),
                  SizedBox(
                    width: 17,
                  ),
                  Text(
                    'Отмена подписки в любой момент',
                    style: TextStyle(
                        fontSize: 15, color: Color.fromRGBO(73, 66, 60, 1)),
                  )
                ]),
              ],
            ),
            user != null
                ? GestureDetector(
                    onTap: () => user.hasSubscribe
                        ? off.mutate((), scheduleToQueue: true)
                        : on.mutate((), scheduleToQueue: true),
                    child: Container(
                        alignment: Alignment.center,
                        padding: EdgeInsets.symmetric(vertical: 16),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(18),
                            color: user.hasSubscribe
                                ? Color.fromRGBO(249, 242, 237, 1)
                                : Color.fromRGBO(234, 126, 45, 1)),
                        child: user.hasSubscribe
                            ? Text(
                                'Отменить подписку',
                                style: TextStyle(
                                    color: Color.fromRGBO(61, 41, 26, 1),
                                    fontSize: 15),
                              )
                            : Text(
                                'Активировать подписку',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 15),
                              )),
                  )
                : Text('loading')
          ],
        ),
      ),
    );
  }
}
