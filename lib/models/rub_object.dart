class RubObjet {
  final int rub;
  final int pagenum;
  final String ayah;

  RubObjet({required this.rub, required this.pagenum, required this.ayah});

  factory RubObjet.fromJson(Map<String, dynamic> json) {
    return RubObjet(
      rub: json['rub'],
      pagenum: json['pagenum'],
      ayah: json['ayah'],
    );
  }
}
