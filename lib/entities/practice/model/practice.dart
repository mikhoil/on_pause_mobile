import 'package:onpause/entities/meditation/model/meditation.dart';

class Practice {
  Practice(
      {required this.id,
      required this.title,
      required this.forSubs,
      required this.meditations});

  int id;
  String title;
  bool forSubs;
  List<Meditation> meditations;

  factory Practice.fromJson(Map<String, dynamic> json) {
    if (json
        case {"id": int id, "title": String title, "forSubs": bool forSubs}) {
      return Practice(
          id: id,
          title: title,
          forSubs: forSubs,
          meditations: List<Meditation>.from(json['meditations'].map(
              (meditation) =>
                  Meditation.fromJson(meditation as Map<String, dynamic>))));
    }
    throw const FormatException("invalid json");
  }
}
