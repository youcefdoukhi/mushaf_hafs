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

class SizeFont extends StateNotifier<double> {
  SizeFont() : super(1);
/*
  void increment() {
    state = state + 5;
  }*/
}

final textSizeProvider =
    StateNotifierProvider<SizeFont, double>((ref) => SizeFont());

enum Filter {
  none,
  pair,
  impair,
}

final filterProvider = StateProvider((ref) => Filter.none);

final filteredFontSizeProvider = Provider<double>((ref) {
  final numberType = ref.watch(filterProvider);
  final fontSize = ref.watch(textSizeProvider);

  switch (numberType) {
    case Filter.none:
      return 16 * fontSize;
    case Filter.pair:
      return 100 * fontSize;
    case Filter.impair:
      return 45 * fontSize;
  }
});
