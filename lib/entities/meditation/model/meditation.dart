class Meditation {
  Meditation(
      {required this.id,
      required this.title,
      required this.duration,
      required this.key,
      required this.practiceId});

  int id, duration, practiceId;
  String title;
  String? key;

  factory Meditation.fromJson(Map<String, dynamic> json) {
    if (json
        case {
          "id": int id,
          "title": String title,
          "duration": int duration,
          "practiceId": int practiceId
        }) {
      return Meditation(
          id: id,
          title: title,
          duration: duration,
          key: json['key'],
          practiceId: practiceId);
    }
    throw const FormatException("invalid json");
  }
}
