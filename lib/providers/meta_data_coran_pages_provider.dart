import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mushaf_hafs/models/page_rub_hizb_juz.dart';
import 'package:mushaf_hafs/models/rub_object.dart';
import 'package:mushaf_hafs/page.dart';

// Coran Pages  metadata Initiallization
Future<List<PageRubHizbJuz>> fetchMetaData() async {
  // get the JSON file of rub info
  final jsonString = await rootBundle.loadString('data/rubinfo.json');
  final jsonData = json.decode(jsonString);

  // create List of rub Objects from the json file
  final rubObjets =
      List<RubObjet>.from(jsonData.map((json) => RubObjet.fromJson(json)));

  // return PageRubHizbJuz empty list of coran pages
  List<PageRubHizbJuz> newRubList = List<PageRubHizbJuz>.filled(
      604, PageRubHizbJuz(rub: 74, pageInfo: "", hizb: 60, juz: 30),
      growable: false);

  // step variable to divide RUB of every hizb : [ 1 ,2 ,3 ,4 ] ... start with 1
  int step = 1;

  // loop over rub ...
  for (var i = 0; i < 73; i++) {
    // get pages info about the RUB and next RUB
    RubObjet currentRub = rubObjets.elementAt(i);
    RubObjet nextRub = rubObjets.elementAt(i + 1);
    int pageNumOfCurrentRub = currentRub.pagenum - 1;
    int pageNumOfNextRub = nextRub.pagenum - 1;

    // find the hizb of the current Rub
    int hizb = ((currentRub.rub - 1) ~/ 4) + 1;

    // find the juz of the current Rub
    int juz = ((hizb - 1) ~/ 2) + 1;

    // informations of the RUB  << current hizb and juz >>
    String pageInfo = "-";
    if (step == 1) {
      if ((hizb % 2) == 0) {
        pageInfo = "الحزب $hizb";
      } else {
        // display juz only if the hizb is an odd
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
      // resete the step to 1 for the next hizb
      step = 1;
    }

    // add meta data to the current rub pags of the coran
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
  return newRubList;
}

// list of metadata coran Pages provider
final rubProvider = FutureProvider<List<PageRubHizbJuz>>((ref) async {
  final coranMetaData = await fetchMetaData();

  // Youcef Comment //
  // newRubList.asMap().forEach((index, value) {});

  return coranMetaData;
});

fetchCoranImages() {
  return List<Image>.generate(604, (i) {
    String coranPageImageIndex = (i + 1).toString().padLeft(3, '0');
    return Image.asset(
      'images/img/page$coranPageImageIndex.png',
      fit: BoxFit.fill,
    );
  });
}

// provide images of the coran
Provider<List<Image>> imagesProvider = Provider<List<Image>>((ref) {
  return fetchCoranImages();
});

// return the Coran pages
final coranPagesProvider = Provider<List<PageWidget>>((ref) {
  final coran = List<PageWidget>.filled(604, const PageWidget(index: 0));

  // fill the coran with pages
  for (int i = 0; i < 604; i++) {
    coran[i] = PageWidget(index: i);
  }

  return coran;
});
