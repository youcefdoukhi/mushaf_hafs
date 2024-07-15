class Chapters {
  final int index;
  final String name;
  final String type;
  final int verses;
  final int start;

  Chapters({
    required this.index,
    required this.name,
    required this.type,
    required this.verses,
    required this.start,
  });

  factory Chapters.fromJson(Map<String, dynamic> json) {
    return Chapters(
      index: json['index'],
      name: json['name'],
      type: json['type'],
      verses: json['verses'],
      start: json['start'],
    );
  }
}
