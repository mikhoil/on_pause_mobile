class Meditation {
  Meditation(
      {required this.id,
      required this.title,
      required this.duration,
      required this.audio,
      required this.practiceId,
      required this.forSubs,
      required this.image});

  int id, duration, practiceId;
  String title;
  String? audio;
  String image;
  bool forSubs;

  factory Meditation.fromJson(Map<String, dynamic> json) {
    if (json
        case {
          "id": int id,
          "title": String title,
          "duration": int duration,
          "practiceId": int practiceId,
          "forSubs": bool forSubs,
          "image": String image
        }) {
      return Meditation(
          id: id,
          title: title,
          duration: duration,
          forSubs: forSubs,
          image: image,
          audio: json['audio'],
          practiceId: practiceId);
    }
    throw const FormatException("invalid json");
  }
}
