import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mushaf_hafs/models/chapters.dart';

// return a list of the chapter from surah JSON file
final chaptersProvider = FutureProvider<List<Chapters>>((ref) async {
  final jsonString = await rootBundle.loadString('data/surah.json');
  final jsonData = json.decode(jsonString);
  final objets =
      List<Chapters>.from(jsonData.map((json) => Chapters.fromJson(json)));
  return objets;
});
