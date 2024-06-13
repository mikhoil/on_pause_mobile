import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:onpause/shared/ui/notification_option.dart';

class NotificationsScreen extends HookWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(preferredSize: Size.fromHeight(0), child: AppBar()),
      body: Container(
          padding: EdgeInsets.only(left: 33, right: 33, top: 39, bottom: 65),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                      'УВЕДОМЛЕНИЯ',
                      style:
                          TextStyle(fontSize: 22, fontWeight: FontWeight.w400),
                    ),
                    SizedBox(
                      height: 68,
                    ),
                    Column(
                      children: [
                        NotificationOption(
                          initialValue: false,
                          text: 'Ежедневное напутствие',
                        ),
                        NotificationOption(
                          initialValue: true,
                          text: 'Запланированные паузы',
                        ),
                        NotificationOption(
                          initialValue: false,
                          text: 'Напоминания при отсутствии',
                        ),
                        NotificationOption(
                          initialValue: true,
                          text: 'Изменение статуса подписки',
                        ),
                        NotificationOption(
                          initialValue: true,
                          text: 'Новости, обновления',
                        ),
                      ],
                    )
                  ],
                ),
                GestureDetector(
                  child: Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.symmetric(vertical: 16),
                    decoration: BoxDecoration(
                        color: Color.fromRGBO(249, 242, 237, 1),
                        borderRadius: BorderRadius.circular(18)),
                    child: Text('Сохранить изменения'),
                  ),
                )
              ])),
    );
  }
}
