import '../../../entities/meditation/model/meditation.dart';

class Practice {
  Practice(
      {required this.id,
      required this.title,
      required this.meditations,
      required this.colors});

  int id;
  String title;
  List<Meditation> meditations;
  List<String> colors;

  factory Practice.fromJson(Map<String, dynamic> json) {
    if (json case {"id": int id, "title": String title}) {
      return Practice(
          id: id,
          title: title,
          colors: List<String>.from(json['colors'].map((color) => color)),
          meditations: List<Meditation>.from(json['meditations'].map(
              (meditation) =>
                  Meditation.fromJson(meditation as Map<String, dynamic>))));
    }
    throw const FormatException("invalid json");
  }
}
