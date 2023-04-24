import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'package:hooks_riverpod/hooks_riverpod.dart';

class MonObjet {
  final int index;
  final String name;
  final String type;
  final int verses;
  final int start;

  MonObjet(
      {required this.index,
      required this.name,
      required this.type,
      required this.verses,
      required this.start});

  factory MonObjet.fromJson(Map<String, dynamic> json) {
    return MonObjet(
      index: json['index'],
      name: json['name'],
      type: json['type'],
      verses: json['verses'],
      start: json['start'],
    );
  }
}

final objetsProvider = FutureProvider<List<MonObjet>>((ref) async {
  final jsonString = await rootBundle.loadString('data/surah.json');
  final jsonData = json.decode(jsonString);
  final objets =
      List<MonObjet>.from(jsonData.map((json) => MonObjet.fromJson(json)));
  return objets;
});

final textSizeProvider = Provider((_) => 50.0);

final myAutoDisposeProvider = StateProvider.autoDispose<int>((ref) => 0);
final myFamilyProvider = Provider.family<String, int>((ref, id) => '$id');
