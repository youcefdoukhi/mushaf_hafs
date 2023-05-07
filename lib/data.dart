import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

final chaptersProvider = FutureProvider<List<Chapters>>((ref) async {
  final jsonString = await rootBundle.loadString('data/surah.json');
  final jsonData = json.decode(jsonString);
  final objets =
      List<Chapters>.from(jsonData.map((json) => Chapters.fromJson(json)));
  return objets;
});

class PageRubHizbJuz {
  final int rub;
  final String pageInfo;
  final int hizb;
  final int juz;
  PageRubHizbJuz(
      {required this.rub,
      required this.pageInfo,
      required this.hizb,
      required this.juz});
}

final rubProvider = FutureProvider<List<PageRubHizbJuz>>((ref) async {
  final jsonString = await rootBundle.loadString('data/rubinfo.json');
  final jsonData = json.decode(jsonString);
  final rubObjets =
      List<RubObjet>.from(jsonData.map((json) => RubObjet.fromJson(json)));
  List<PageRubHizbJuz> newRubList = List<PageRubHizbJuz>.filled(
      604, PageRubHizbJuz(rub: 74, pageInfo: "", hizb: 60, juz: 30),
      growable: false);
  int step = 1;
  for (var i = 0; i < 73; i++) {
    RubObjet currentRub = rubObjets.elementAt(i);
    RubObjet nextRub = rubObjets.elementAt(i + 1);
    int pageNumOfCurrentRub = currentRub.pagenum - 1;
    int pageNumOfNextRub = nextRub.pagenum - 1;
    int hizb = ((currentRub.rub - 1) ~/ 4) + 1;
    int juz = ((hizb - 1) ~/ 2) + 1;
    String pageInfo = "-";
    if (step == 1) {
      if ((hizb % 2) == 0) {
        pageInfo = "الحزب $hizb";
      } else {
        pageInfo = "الجزء $juz\n" "الحزب $hizb";
      }

      step++;
    } else if (step == 2) {
      pageInfo = "ربع الحزب $hizb";
      step++;
    } else if (step == 3) {
      pageInfo = "نصف الحزب $hizb";
      step++;
    } else if (step == 4) {
      pageInfo = "ثلاثة أرباع الحزب $hizb";
      step = 1;
    }
    for (var j = pageNumOfCurrentRub; j < pageNumOfNextRub; j++) {
      newRubList[j] = PageRubHizbJuz(
        rub: currentRub.rub,
        pageInfo: pageInfo,
        hizb: hizb,
        juz: juz,
      );
      pageInfo = "-";
    }
  }
  newRubList.asMap().forEach((index, value) {
    // print(
    //     "Page = ${index + 1} / pageInfo = ${value.pageInfo} / Hizb = ${value.hizb} / Juz = ${value.juz} }");
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
