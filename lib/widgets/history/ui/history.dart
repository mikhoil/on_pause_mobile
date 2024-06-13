import 'package:flutter/cupertino.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import '../../../entities/history_item/ui/history_for_date.dart';
import '../../../entities/history_item/model/history_item.dart';

class History extends HookWidget {
  const History({super.key, required this.history});

  final List<HistoryItem> history;

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(
        'История',
        textAlign: TextAlign.start,
        style: TextStyle(fontSize: 19),
      ),
      SizedBox(height: 14),
      history.length > 0
          ? Expanded(
              child: ListView.separated(
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              itemCount: history.length,
              separatorBuilder: (context, index) => SizedBox(height: 14),
              itemBuilder: (context, index) =>
                  HistoryForDate(historyItem: history[index]),
            ))
          : Text('Здесь пока ничего нет'),
      // SizedBox(height: MediaQuery.of(context).size.height/852*96,)
    ]));
  }
}
