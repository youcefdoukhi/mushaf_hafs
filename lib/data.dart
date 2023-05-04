import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

final objetsProvider = FutureProvider<List<MonObjet>>((ref) async {
  final jsonString = await rootBundle.loadString('data/surah.json');
  final jsonData = json.decode(jsonString);
  final objets =
      List<MonObjet>.from(jsonData.map((json) => MonObjet.fromJson(json)));
  return objets;
});

class PageRubHizbJuz {
  final int rub;
  final int hizb;
  final int juz;
  final bool show;
  PageRubHizbJuz(
      {required this.rub,
      required this.hizb,
      required this.juz,
      required this.show});
}

final rubProvider = FutureProvider<List<PageRubHizbJuz>>((ref) async {
  final jsonString = await rootBundle.loadString('data/rubinfo.json');
  final jsonData = json.decode(jsonString);
  final rubObjets =
      List<RubObjet>.from(jsonData.map((json) => RubObjet.fromJson(json)));
  List<PageRubHizbJuz> newRubList = List<PageRubHizbJuz>.filled(
      604, PageRubHizbJuz(rub: 74, hizb: 60, juz: 30, show: false),
      growable: false);

  for (var i = 0; i < 73; i++) {
    RubObjet currentRub = rubObjets.elementAt(i);
    RubObjet nextRub = rubObjets.elementAt(i + 1);
    int pageNumOfCurrentRub = currentRub.pagenum - 1;
    int pageNumOfNextRub = nextRub.pagenum - 1;
    for (var j = pageNumOfCurrentRub; j < pageNumOfNextRub; j++) {
      newRubList[j] =
          PageRubHizbJuz(rub: currentRub.rub, hizb: 0, juz: 0, show: false);
    }
  }
  newRubList.asMap().forEach((index, value) {
    print(
        "Page = $index / Rub = ${value.rub} / Hizb = ${(value.rub ~/ 4) + 1} / Juz = ${value.juz} / Show = ${value.show}");
  });
  return newRubList;
});

final pageIndexFromSharedPref = FutureProvider<int>((ref) async {
  final prefs = await SharedPreferences.getInstance();
  int? currentPage = prefs.getInt('mushaf01_page');
  if (currentPage != null) {
    return currentPage;
  } else {
    return 0;
  }
});

final pageIndexProvider = StateProvider<int>(
  (ref) {
    final futureValue = ref.watch(pageIndexFromSharedPref);
    return futureValue.asData?.value ?? 0;
  },
);

final savedBookmarkFromSharedPref = FutureProvider<int>((ref) async {
  final prefs = await SharedPreferences.getInstance();
  int? bookmark = prefs.getInt('mushaf01_bookmark');

  if (bookmark != null) {
    return bookmark;
  } else {
    return 0;
  }
});

final savedBookmarkProvider = StateProvider<int>(
  (ref) {
    final futureValue = ref.watch(savedBookmarkFromSharedPref);
    return futureValue.asData?.value ?? 0;
  },
);

final showPageInfoProvider = StateProvider<bool>(
  (ref) {
    return false;
  },
);

final scroolOrNotProvider = StateProvider<bool>(
  (ref) {
    return true;
  },
);

final imagesProvider = FutureProvider<List<Image>>((ref) async {
  final List<Image> imagesList = [];

  for (var index = 0; index < 604; index++) {
    String pageNum = "";

    if ((index + 1) < 10) {
      pageNum = "00${index + 1}";
    } else if ((index + 1) < 100 && (index + 1) > 9) {
      pageNum = "0${index + 1}";
    } else {
      pageNum = "${index + 1}";
    }
    imagesList.insert(
        index,
        Image(
          image: AssetImage('images/mushaf_photos_2/page$pageNum.png'),
          fit: BoxFit.fill,
        ));
  }
  return imagesList;
});
