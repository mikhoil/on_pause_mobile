import '../../../entities/meditation/model/meditation.dart';

class HistoryItem {
  HistoryItem(
      {required this.id,
      required this.date,
      required this.userId,
      required this.meditations});

  int id, date, userId;
  List<Meditation> meditations;

  factory HistoryItem.fromJson(Map<String, dynamic> json) {
    if (json case {"id": int id, "date": int date, "userId": int userId}) {
      return HistoryItem(
          id: id,
          date: date,
          userId: userId,
          meditations: List<Meditation>.from((json['meditations'] ??
              []).map((meditation) =>
                  Meditation.fromJson(meditation as Map<String, dynamic>))));
    }
    throw const FormatException('invalid json');
  }
}
