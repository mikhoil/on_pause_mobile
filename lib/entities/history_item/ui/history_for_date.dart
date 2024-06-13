import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import '../../../shared/utils/format_duration.dart';
import '../../../shared/utils/format_time.dart';
import '../model/history_item.dart';

class HistoryForDate extends HookWidget {
  const HistoryForDate({super.key, required this.historyItem});

  final HistoryItem historyItem;

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(
        FormatDate(historyItem.date),
        style: TextStyle(color: Colors.black.withOpacity(.5)),
      ),
      SizedBox(height: 6),
      Column(
        children: List<Widget>.from(
            historyItem.meditations.reversed.map((meditation) => Container(
                margin: EdgeInsets.only(bottom: 10),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      height: 63,
                      width: 63,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: NetworkImage(
                                  'https://storage.yandexcloud.net/on-pause-meditations/${meditation.image}'),
                              fit: BoxFit.cover),
                          borderRadius: BorderRadius.circular(6)),
                    ),
                    SizedBox(width: 13),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(meditation.title),
                        SizedBox(height: 6),
                        Container(
                            padding: EdgeInsets.symmetric(
                                vertical: 9, horizontal: 15),
                            decoration: BoxDecoration(
                                color: Colors.black.withOpacity(.04),
                                borderRadius: BorderRadius.circular(36)),
                            child: Text(
                              "${formatDuration(meditation.duration)} МИН",
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black.withOpacity(.47),
                                  fontSize: 11),
                            )),
                      ],
                    )
                  ],
                )))),
      )
    ]);
  }
}
