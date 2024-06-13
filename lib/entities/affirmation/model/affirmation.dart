class Affirmation {
  Affirmation({required this.id, required this.text, required this.image});

  int id;
  String text, image;

  factory Affirmation.fromJson(Map<String, dynamic> json) {
    if (json case {'id': int id, 'text': String text, 'image': String image}) {
      return Affirmation(id: id, text: text, image: image);
    }
    throw const FormatException('invalid json');
  }
}
