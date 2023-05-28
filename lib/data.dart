import 'dart:async';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mushaf_hafs/page.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
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
  newRubList.asMap().forEach((index, value) {});
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

final scrollOrNotProvider = StateProvider<bool>(
  (ref) {
    return true;
  },
);

final imagesProvider = Provider.family<Image, int>((ref, index) {
//final imagesProvider = Provider<List<Image>>((ref) {
  print("\n XXXXXX");
/*
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
        Image.asset(
          'images/img/page$pageNum.png',
          fit: BoxFit.fill,
        ));
  }
  */

  final imagesList = List<Image>.filled(
    604,
    const Image(
      image: AssetImage('images/img/page001.png'),
      fit: BoxFit.fill,
    ),
  );
//---------------------------------------------------

  imagesList[0] = const Image(
    image: AssetImage('images/img/page001.png'),
    fit: BoxFit.fill,
  );

  imagesList[1] = const Image(
    image: AssetImage('images/img/page002.png'),
    fit: BoxFit.fill,
  );
  imagesList[2] = const Image(
    image: AssetImage('images/img/page003.png'),
    fit: BoxFit.fill,
  );
  imagesList[3] = const Image(
    image: AssetImage('images/img/page004.png'),
    fit: BoxFit.fill,
  );
  imagesList[4] = const Image(
    image: AssetImage('images/img/page005.png'),
    fit: BoxFit.fill,
  );
  imagesList[5] = const Image(
    image: AssetImage('images/img/page006.png'),
    fit: BoxFit.fill,
  );
  imagesList[6] = const Image(
    image: AssetImage('images/img/page007.png'),
    fit: BoxFit.fill,
  );
  imagesList[7] = const Image(
    image: AssetImage('images/img/page008.png'),
    fit: BoxFit.fill,
  );
  imagesList[8] = const Image(
    image: AssetImage('images/img/page009.png'),
    fit: BoxFit.fill,
  );

  imagesList[9] = const Image(
    image: AssetImage('images/img/page010.png'),
    fit: BoxFit.fill,
  );
  imagesList[10] = const Image(
    image: AssetImage('images/img/page011.png'),
    fit: BoxFit.fill,
  );
  imagesList[11] = const Image(
    image: AssetImage('images/img/page012.png'),
    fit: BoxFit.fill,
  );
  imagesList[12] = const Image(
    image: AssetImage('images/img/page013.png'),
    fit: BoxFit.fill,
  );
  imagesList[13] = const Image(
    image: AssetImage('images/img/page014.png'),
    fit: BoxFit.fill,
  );
  imagesList[14] = const Image(
    image: AssetImage('images/img/page015.png'),
    fit: BoxFit.fill,
  );
  imagesList[15] = const Image(
    image: AssetImage('images/img/page016.png'),
    fit: BoxFit.fill,
  );
  imagesList[16] = const Image(
    image: AssetImage('images/img/page017.png'),
    fit: BoxFit.fill,
  );
  imagesList[17] = const Image(
    image: AssetImage('images/img/page018.png'),
    fit: BoxFit.fill,
  );
  imagesList[18] = const Image(
    image: AssetImage('images/img/page019.png'),
    fit: BoxFit.fill,
  );

  imagesList[19] = const Image(
    image: AssetImage('images/img/page020.png'),
    fit: BoxFit.fill,
  );
  imagesList[20] = const Image(
    image: AssetImage('images/img/page021.png'),
    fit: BoxFit.fill,
  );
  imagesList[21] = const Image(
    image: AssetImage('images/img/page022.png'),
    fit: BoxFit.fill,
  );
  imagesList[22] = const Image(
    image: AssetImage('images/img/page023.png'),
    fit: BoxFit.fill,
  );
  imagesList[23] = const Image(
    image: AssetImage('images/img/page024.png'),
    fit: BoxFit.fill,
  );
  imagesList[24] = const Image(
    image: AssetImage('images/img/page025.png'),
    fit: BoxFit.fill,
  );
  imagesList[25] = const Image(
    image: AssetImage('images/img/page026.png'),
    fit: BoxFit.fill,
  );
  imagesList[26] = const Image(
    image: AssetImage('images/img/page027.png'),
    fit: BoxFit.fill,
  );
  imagesList[27] = const Image(
    image: AssetImage('images/img/page028.png'),
    fit: BoxFit.fill,
  );
  imagesList[28] = const Image(
    image: AssetImage('images/img/page029.png'),
    fit: BoxFit.fill,
  );

  imagesList[29] = const Image(
    image: AssetImage('images/img/page030.png'),
    fit: BoxFit.fill,
  );
  imagesList[30] = const Image(
    image: AssetImage('images/img/page031.png'),
    fit: BoxFit.fill,
  );
  imagesList[31] = const Image(
    image: AssetImage('images/img/page032.png'),
    fit: BoxFit.fill,
  );
  imagesList[32] = const Image(
    image: AssetImage('images/img/page033.png'),
    fit: BoxFit.fill,
  );
  imagesList[33] = const Image(
    image: AssetImage('images/img/page034.png'),
    fit: BoxFit.fill,
  );
  imagesList[34] = const Image(
    image: AssetImage('images/img/page035.png'),
    fit: BoxFit.fill,
  );
  imagesList[35] = const Image(
    image: AssetImage('images/img/page036.png'),
    fit: BoxFit.fill,
  );
  imagesList[36] = const Image(
    image: AssetImage('images/img/page037.png'),
    fit: BoxFit.fill,
  );
  imagesList[37] = const Image(
    image: AssetImage('images/img/page038.png'),
    fit: BoxFit.fill,
  );
  imagesList[38] = const Image(
    image: AssetImage('images/img/page039.png'),
    fit: BoxFit.fill,
  );

  imagesList[39] = const Image(
    image: AssetImage('images/img/page040.png'),
    fit: BoxFit.fill,
  );
  imagesList[40] = const Image(
    image: AssetImage('images/img/page041.png'),
    fit: BoxFit.fill,
  );
  imagesList[41] = const Image(
    image: AssetImage('images/img/page042.png'),
    fit: BoxFit.fill,
  );
  imagesList[42] = const Image(
    image: AssetImage('images/img/page043.png'),
    fit: BoxFit.fill,
  );
  imagesList[43] = const Image(
    image: AssetImage('images/img/page044.png'),
    fit: BoxFit.fill,
  );
  imagesList[44] = const Image(
    image: AssetImage('images/img/page045.png'),
    fit: BoxFit.fill,
  );
  imagesList[45] = const Image(
    image: AssetImage('images/img/page046.png'),
    fit: BoxFit.fill,
  );
  imagesList[46] = const Image(
    image: AssetImage('images/img/page047.png'),
    fit: BoxFit.fill,
  );
  imagesList[47] = const Image(
    image: AssetImage('images/img/page048.png'),
    fit: BoxFit.fill,
  );
  imagesList[48] = const Image(
    image: AssetImage('images/img/page049.png'),
    fit: BoxFit.fill,
  );

  imagesList[49] = const Image(
    image: AssetImage('images/img/page050.png'),
    fit: BoxFit.fill,
  );
  imagesList[50] = const Image(
    image: AssetImage('images/img/page051.png'),
    fit: BoxFit.fill,
  );
  imagesList[51] = const Image(
    image: AssetImage('images/img/page052.png'),
    fit: BoxFit.fill,
  );
  imagesList[52] = const Image(
    image: AssetImage('images/img/page053.png'),
    fit: BoxFit.fill,
  );
  imagesList[53] = const Image(
    image: AssetImage('images/img/page054.png'),
    fit: BoxFit.fill,
  );
  imagesList[54] = const Image(
    image: AssetImage('images/img/page055.png'),
    fit: BoxFit.fill,
  );
  imagesList[55] = const Image(
    image: AssetImage('images/img/page056.png'),
    fit: BoxFit.fill,
  );
  imagesList[56] = const Image(
    image: AssetImage('images/img/page057.png'),
    fit: BoxFit.fill,
  );
  imagesList[57] = const Image(
    image: AssetImage('images/img/page058.png'),
    fit: BoxFit.fill,
  );
  imagesList[58] = const Image(
    image: AssetImage('images/img/page059.png'),
    fit: BoxFit.fill,
  );

  imagesList[59] = const Image(
    image: AssetImage('images/img/page060.png'),
    fit: BoxFit.fill,
  );
  imagesList[60] = const Image(
    image: AssetImage('images/img/page061.png'),
    fit: BoxFit.fill,
  );
  imagesList[61] = const Image(
    image: AssetImage('images/img/page062.png'),
    fit: BoxFit.fill,
  );
  imagesList[62] = const Image(
    image: AssetImage('images/img/page063.png'),
    fit: BoxFit.fill,
  );
  imagesList[63] = const Image(
    image: AssetImage('images/img/page064.png'),
    fit: BoxFit.fill,
  );
  imagesList[64] = const Image(
    image: AssetImage('images/img/page065.png'),
    fit: BoxFit.fill,
  );
  imagesList[65] = const Image(
    image: AssetImage('images/img/page066.png'),
    fit: BoxFit.fill,
  );
  imagesList[66] = const Image(
    image: AssetImage('images/img/page067.png'),
    fit: BoxFit.fill,
  );
  imagesList[67] = const Image(
    image: AssetImage('images/img/page068.png'),
    fit: BoxFit.fill,
  );
  imagesList[68] = const Image(
    image: AssetImage('images/img/page069.png'),
    fit: BoxFit.fill,
  );

  imagesList[69] = const Image(
    image: AssetImage('images/img/page070.png'),
    fit: BoxFit.fill,
  );
  imagesList[70] = const Image(
    image: AssetImage('images/img/page071.png'),
    fit: BoxFit.fill,
  );
  imagesList[71] = const Image(
    image: AssetImage('images/img/page072.png'),
    fit: BoxFit.fill,
  );
  imagesList[72] = const Image(
    image: AssetImage('images/img/page073.png'),
    fit: BoxFit.fill,
  );
  imagesList[73] = const Image(
    image: AssetImage('images/img/page074.png'),
    fit: BoxFit.fill,
  );
  imagesList[74] = const Image(
    image: AssetImage('images/img/page075.png'),
    fit: BoxFit.fill,
  );
  imagesList[75] = const Image(
    image: AssetImage('images/img/page076.png'),
    fit: BoxFit.fill,
  );
  imagesList[76] = const Image(
    image: AssetImage('images/img/page077.png'),
    fit: BoxFit.fill,
  );
  imagesList[77] = const Image(
    image: AssetImage('images/img/page078.png'),
    fit: BoxFit.fill,
  );
  imagesList[78] = const Image(
    image: AssetImage('images/img/page079.png'),
    fit: BoxFit.fill,
  );

  imagesList[79] = const Image(
    image: AssetImage('images/img/page080.png'),
    fit: BoxFit.fill,
  );
  imagesList[80] = const Image(
    image: AssetImage('images/img/page081.png'),
    fit: BoxFit.fill,
  );
  imagesList[81] = const Image(
    image: AssetImage('images/img/page082.png'),
    fit: BoxFit.fill,
  );
  imagesList[82] = const Image(
    image: AssetImage('images/img/page083.png'),
    fit: BoxFit.fill,
  );
  imagesList[83] = const Image(
    image: AssetImage('images/img/page084.png'),
    fit: BoxFit.fill,
  );
  imagesList[84] = const Image(
    image: AssetImage('images/img/page085.png'),
    fit: BoxFit.fill,
  );
  imagesList[85] = const Image(
    image: AssetImage('images/img/page086.png'),
    fit: BoxFit.fill,
  );
  imagesList[86] = const Image(
    image: AssetImage('images/img/page087.png'),
    fit: BoxFit.fill,
  );
  imagesList[87] = const Image(
    image: AssetImage('images/img/page088.png'),
    fit: BoxFit.fill,
  );
  imagesList[88] = const Image(
    image: AssetImage('images/img/page089.png'),
    fit: BoxFit.fill,
  );

  imagesList[89] = const Image(
    image: AssetImage('images/img/page090.png'),
    fit: BoxFit.fill,
  );
  imagesList[90] = const Image(
    image: AssetImage('images/img/page091.png'),
    fit: BoxFit.fill,
  );
  imagesList[91] = const Image(
    image: AssetImage('images/img/page092.png'),
    fit: BoxFit.fill,
  );
  imagesList[92] = const Image(
    image: AssetImage('images/img/page093.png'),
    fit: BoxFit.fill,
  );
  imagesList[93] = const Image(
    image: AssetImage('images/img/page094.png'),
    fit: BoxFit.fill,
  );
  imagesList[94] = const Image(
    image: AssetImage('images/img/page095.png'),
    fit: BoxFit.fill,
  );
  imagesList[95] = const Image(
    image: AssetImage('images/img/page096.png'),
    fit: BoxFit.fill,
  );
  imagesList[96] = const Image(
    image: AssetImage('images/img/page097.png'),
    fit: BoxFit.fill,
  );
  imagesList[97] = const Image(
    image: AssetImage('images/img/page098.png'),
    fit: BoxFit.fill,
  );
  imagesList[98] = const Image(
    image: AssetImage('images/img/page099.png'),
    fit: BoxFit.fill,
  );

  imagesList[99] = const Image(
    image: AssetImage('images/img/page100.png'),
    fit: BoxFit.fill,
  );
  imagesList[100] = const Image(
    image: AssetImage('images/img/page101.png'),
    fit: BoxFit.fill,
  );
  imagesList[101] = const Image(
    image: AssetImage('images/img/page102.png'),
    fit: BoxFit.fill,
  );
  imagesList[102] = const Image(
    image: AssetImage('images/img/page103.png'),
    fit: BoxFit.fill,
  );
  imagesList[103] = const Image(
    image: AssetImage('images/img/page104.png'),
    fit: BoxFit.fill,
  );
  imagesList[104] = const Image(
    image: AssetImage('images/img/page105.png'),
    fit: BoxFit.fill,
  );
  imagesList[105] = const Image(
    image: AssetImage('images/img/page106.png'),
    fit: BoxFit.fill,
  );
  imagesList[106] = const Image(
    image: AssetImage('images/img/page107.png'),
    fit: BoxFit.fill,
  );
  imagesList[107] = const Image(
    image: AssetImage('images/img/page108.png'),
    fit: BoxFit.fill,
  );
  imagesList[108] = const Image(
    image: AssetImage('images/img/page109.png'),
    fit: BoxFit.fill,
  );

  imagesList[109] = const Image(
    image: AssetImage('images/img/page110.png'),
    fit: BoxFit.fill,
  );
  imagesList[110] = const Image(
    image: AssetImage('images/img/page111.png'),
    fit: BoxFit.fill,
  );
  imagesList[111] = const Image(
    image: AssetImage('images/img/page112.png'),
    fit: BoxFit.fill,
  );
  imagesList[112] = const Image(
    image: AssetImage('images/img/page113.png'),
    fit: BoxFit.fill,
  );
  imagesList[113] = const Image(
    image: AssetImage('images/img/page114.png'),
    fit: BoxFit.fill,
  );
  imagesList[114] = const Image(
    image: AssetImage('images/img/page115.png'),
    fit: BoxFit.fill,
  );
  imagesList[115] = const Image(
    image: AssetImage('images/img/page116.png'),
    fit: BoxFit.fill,
  );
  imagesList[116] = const Image(
    image: AssetImage('images/img/page117.png'),
    fit: BoxFit.fill,
  );
  imagesList[117] = const Image(
    image: AssetImage('images/img/page118.png'),
    fit: BoxFit.fill,
  );
  imagesList[118] = const Image(
    image: AssetImage('images/img/page119.png'),
    fit: BoxFit.fill,
  );

  imagesList[119] = const Image(
    image: AssetImage('images/img/page120.png'),
    fit: BoxFit.fill,
  );
  imagesList[120] = const Image(
    image: AssetImage('images/img/page121.png'),
    fit: BoxFit.fill,
  );
  imagesList[121] = const Image(
    image: AssetImage('images/img/page122.png'),
    fit: BoxFit.fill,
  );
  imagesList[122] = const Image(
    image: AssetImage('images/img/page123.png'),
    fit: BoxFit.fill,
  );
  imagesList[123] = const Image(
    image: AssetImage('images/img/page124.png'),
    fit: BoxFit.fill,
  );
  imagesList[124] = const Image(
    image: AssetImage('images/img/page125.png'),
    fit: BoxFit.fill,
  );
  imagesList[125] = const Image(
    image: AssetImage('images/img/page126.png'),
    fit: BoxFit.fill,
  );
  imagesList[126] = const Image(
    image: AssetImage('images/img/page127.png'),
    fit: BoxFit.fill,
  );
  imagesList[127] = const Image(
    image: AssetImage('images/img/page128.png'),
    fit: BoxFit.fill,
  );
  imagesList[128] = const Image(
    image: AssetImage('images/img/page129.png'),
    fit: BoxFit.fill,
  );

  imagesList[129] = const Image(
    image: AssetImage('images/img/page130.png'),
    fit: BoxFit.fill,
  );
  imagesList[130] = const Image(
    image: AssetImage('images/img/page131.png'),
    fit: BoxFit.fill,
  );
  imagesList[131] = const Image(
    image: AssetImage('images/img/page132.png'),
    fit: BoxFit.fill,
  );
  imagesList[132] = const Image(
    image: AssetImage('images/img/page133.png'),
    fit: BoxFit.fill,
  );
  imagesList[133] = const Image(
    image: AssetImage('images/img/page134.png'),
    fit: BoxFit.fill,
  );
  imagesList[134] = const Image(
    image: AssetImage('images/img/page135.png'),
    fit: BoxFit.fill,
  );
  imagesList[135] = const Image(
    image: AssetImage('images/img/page136.png'),
    fit: BoxFit.fill,
  );
  imagesList[136] = const Image(
    image: AssetImage('images/img/page137.png'),
    fit: BoxFit.fill,
  );
  imagesList[137] = const Image(
    image: AssetImage('images/img/page138.png'),
    fit: BoxFit.fill,
  );
  imagesList[138] = const Image(
    image: AssetImage('images/img/page139.png'),
    fit: BoxFit.fill,
  );

  imagesList[139] = const Image(
    image: AssetImage('images/img/page140.png'),
    fit: BoxFit.fill,
  );
  imagesList[140] = const Image(
    image: AssetImage('images/img/page141.png'),
    fit: BoxFit.fill,
  );
  imagesList[141] = const Image(
    image: AssetImage('images/img/page142.png'),
    fit: BoxFit.fill,
  );
  imagesList[142] = const Image(
    image: AssetImage('images/img/page143.png'),
    fit: BoxFit.fill,
  );
  imagesList[143] = const Image(
    image: AssetImage('images/img/page144.png'),
    fit: BoxFit.fill,
  );
  imagesList[144] = const Image(
    image: AssetImage('images/img/page145.png'),
    fit: BoxFit.fill,
  );
  imagesList[145] = const Image(
    image: AssetImage('images/img/page146.png'),
    fit: BoxFit.fill,
  );
  imagesList[146] = const Image(
    image: AssetImage('images/img/page147.png'),
    fit: BoxFit.fill,
  );
  imagesList[147] = const Image(
    image: AssetImage('images/img/page148.png'),
    fit: BoxFit.fill,
  );
  imagesList[148] = const Image(
    image: AssetImage('images/img/page149.png'),
    fit: BoxFit.fill,
  );

  imagesList[149] = const Image(
    image: AssetImage('images/img/page150.png'),
    fit: BoxFit.fill,
  );
  imagesList[150] = const Image(
    image: AssetImage('images/img/page151.png'),
    fit: BoxFit.fill,
  );
  imagesList[151] = const Image(
    image: AssetImage('images/img/page152.png'),
    fit: BoxFit.fill,
  );
  imagesList[152] = const Image(
    image: AssetImage('images/img/page153.png'),
    fit: BoxFit.fill,
  );
  imagesList[153] = const Image(
    image: AssetImage('images/img/page154.png'),
    fit: BoxFit.fill,
  );
  imagesList[154] = const Image(
    image: AssetImage('images/img/page155.png'),
    fit: BoxFit.fill,
  );
  imagesList[155] = const Image(
    image: AssetImage('images/img/page156.png'),
    fit: BoxFit.fill,
  );
  imagesList[156] = const Image(
    image: AssetImage('images/img/page157.png'),
    fit: BoxFit.fill,
  );
  imagesList[157] = const Image(
    image: AssetImage('images/img/page158.png'),
    fit: BoxFit.fill,
  );
  imagesList[158] = const Image(
    image: AssetImage('images/img/page159.png'),
    fit: BoxFit.fill,
  );

  imagesList[159] = const Image(
    image: AssetImage('images/img/page160.png'),
    fit: BoxFit.fill,
  );
  imagesList[160] = const Image(
    image: AssetImage('images/img/page161.png'),
    fit: BoxFit.fill,
  );
  imagesList[161] = const Image(
    image: AssetImage('images/img/page162.png'),
    fit: BoxFit.fill,
  );
  imagesList[162] = const Image(
    image: AssetImage('images/img/page163.png'),
    fit: BoxFit.fill,
  );
  imagesList[163] = const Image(
    image: AssetImage('images/img/page164.png'),
    fit: BoxFit.fill,
  );
  imagesList[164] = const Image(
    image: AssetImage('images/img/page165.png'),
    fit: BoxFit.fill,
  );
  imagesList[165] = const Image(
    image: AssetImage('images/img/page166.png'),
    fit: BoxFit.fill,
  );
  imagesList[166] = const Image(
    image: AssetImage('images/img/page167.png'),
    fit: BoxFit.fill,
  );
  imagesList[167] = const Image(
    image: AssetImage('images/img/page168.png'),
    fit: BoxFit.fill,
  );
  imagesList[168] = const Image(
    image: AssetImage('images/img/page169.png'),
    fit: BoxFit.fill,
  );

  imagesList[169] = const Image(
    image: AssetImage('images/img/page170.png'),
    fit: BoxFit.fill,
  );
  imagesList[170] = const Image(
    image: AssetImage('images/img/page171.png'),
    fit: BoxFit.fill,
  );
  imagesList[171] = const Image(
    image: AssetImage('images/img/page172.png'),
    fit: BoxFit.fill,
  );
  imagesList[172] = const Image(
    image: AssetImage('images/img/page173.png'),
    fit: BoxFit.fill,
  );
  imagesList[173] = const Image(
    image: AssetImage('images/img/page174.png'),
    fit: BoxFit.fill,
  );
  imagesList[174] = const Image(
    image: AssetImage('images/img/page175.png'),
    fit: BoxFit.fill,
  );
  imagesList[175] = const Image(
    image: AssetImage('images/img/page176.png'),
    fit: BoxFit.fill,
  );
  imagesList[176] = const Image(
    image: AssetImage('images/img/page177.png'),
    fit: BoxFit.fill,
  );
  imagesList[177] = const Image(
    image: AssetImage('images/img/page178.png'),
    fit: BoxFit.fill,
  );
  imagesList[178] = const Image(
    image: AssetImage('images/img/page179.png'),
    fit: BoxFit.fill,
  );

  imagesList[179] = const Image(
    image: AssetImage('images/img/page180.png'),
    fit: BoxFit.fill,
  );
  imagesList[180] = const Image(
    image: AssetImage('images/img/page181.png'),
    fit: BoxFit.fill,
  );
  imagesList[181] = const Image(
    image: AssetImage('images/img/page182.png'),
    fit: BoxFit.fill,
  );
  imagesList[182] = const Image(
    image: AssetImage('images/img/page183.png'),
    fit: BoxFit.fill,
  );
  imagesList[183] = const Image(
    image: AssetImage('images/img/page184.png'),
    fit: BoxFit.fill,
  );
  imagesList[184] = const Image(
    image: AssetImage('images/img/page185.png'),
    fit: BoxFit.fill,
  );
  imagesList[185] = const Image(
    image: AssetImage('images/img/page186.png'),
    fit: BoxFit.fill,
  );
  imagesList[186] = const Image(
    image: AssetImage('images/img/page187.png'),
    fit: BoxFit.fill,
  );
  imagesList[187] = const Image(
    image: AssetImage('images/img/page188.png'),
    fit: BoxFit.fill,
  );
  imagesList[188] = const Image(
    image: AssetImage('images/img/page189.png'),
    fit: BoxFit.fill,
  );

  imagesList[189] = const Image(
    image: AssetImage('images/img/page190.png'),
    fit: BoxFit.fill,
  );
  imagesList[190] = const Image(
    image: AssetImage('images/img/page191.png'),
    fit: BoxFit.fill,
  );
  imagesList[191] = const Image(
    image: AssetImage('images/img/page192.png'),
    fit: BoxFit.fill,
  );
  imagesList[192] = const Image(
    image: AssetImage('images/img/page193.png'),
    fit: BoxFit.fill,
  );
  imagesList[193] = const Image(
    image: AssetImage('images/img/page194.png'),
    fit: BoxFit.fill,
  );
  imagesList[194] = const Image(
    image: AssetImage('images/img/page195.png'),
    fit: BoxFit.fill,
  );
  imagesList[195] = const Image(
    image: AssetImage('images/img/page196.png'),
    fit: BoxFit.fill,
  );
  imagesList[196] = const Image(
    image: AssetImage('images/img/page197.png'),
    fit: BoxFit.fill,
  );
  imagesList[197] = const Image(
    image: AssetImage('images/img/page198.png'),
    fit: BoxFit.fill,
  );
  imagesList[198] = const Image(
    image: AssetImage('images/img/page199.png'),
    fit: BoxFit.fill,
  );

  imagesList[199] = const Image(
    image: AssetImage('images/img/page200.png'),
    fit: BoxFit.fill,
  );
  imagesList[200] = const Image(
    image: AssetImage('images/img/page201.png'),
    fit: BoxFit.fill,
  );
  imagesList[201] = const Image(
    image: AssetImage('images/img/page202.png'),
    fit: BoxFit.fill,
  );
  imagesList[202] = const Image(
    image: AssetImage('images/img/page203.png'),
    fit: BoxFit.fill,
  );
  imagesList[203] = const Image(
    image: AssetImage('images/img/page204.png'),
    fit: BoxFit.fill,
  );
  imagesList[204] = const Image(
    image: AssetImage('images/img/page205.png'),
    fit: BoxFit.fill,
  );
  imagesList[205] = const Image(
    image: AssetImage('images/img/page206.png'),
    fit: BoxFit.fill,
  );
  imagesList[206] = const Image(
    image: AssetImage('images/img/page207.png'),
    fit: BoxFit.fill,
  );
  imagesList[207] = const Image(
    image: AssetImage('images/img/page208.png'),
    fit: BoxFit.fill,
  );
  imagesList[208] = const Image(
    image: AssetImage('images/img/page209.png'),
    fit: BoxFit.fill,
  );

  imagesList[209] = const Image(
    image: AssetImage('images/img/page210.png'),
    fit: BoxFit.fill,
  );
  imagesList[210] = const Image(
    image: AssetImage('images/img/page211.png'),
    fit: BoxFit.fill,
  );
  imagesList[211] = const Image(
    image: AssetImage('images/img/page212.png'),
    fit: BoxFit.fill,
  );
  imagesList[212] = const Image(
    image: AssetImage('images/img/page213.png'),
    fit: BoxFit.fill,
  );
  imagesList[213] = const Image(
    image: AssetImage('images/img/page214.png'),
    fit: BoxFit.fill,
  );
  imagesList[214] = const Image(
    image: AssetImage('images/img/page215.png'),
    fit: BoxFit.fill,
  );
  imagesList[215] = const Image(
    image: AssetImage('images/img/page216.png'),
    fit: BoxFit.fill,
  );
  imagesList[216] = const Image(
    image: AssetImage('images/img/page217.png'),
    fit: BoxFit.fill,
  );
  imagesList[217] = const Image(
    image: AssetImage('images/img/page218.png'),
    fit: BoxFit.fill,
  );
  imagesList[218] = const Image(
    image: AssetImage('images/img/page219.png'),
    fit: BoxFit.fill,
  );

  imagesList[219] = const Image(
    image: AssetImage('images/img/page220.png'),
    fit: BoxFit.fill,
  );
  imagesList[220] = const Image(
    image: AssetImage('images/img/page221.png'),
    fit: BoxFit.fill,
  );
  imagesList[221] = const Image(
    image: AssetImage('images/img/page222.png'),
    fit: BoxFit.fill,
  );
  imagesList[222] = const Image(
    image: AssetImage('images/img/page223.png'),
    fit: BoxFit.fill,
  );
  imagesList[223] = const Image(
    image: AssetImage('images/img/page224.png'),
    fit: BoxFit.fill,
  );
  imagesList[224] = const Image(
    image: AssetImage('images/img/page225.png'),
    fit: BoxFit.fill,
  );
  imagesList[225] = const Image(
    image: AssetImage('images/img/page226.png'),
    fit: BoxFit.fill,
  );
  imagesList[226] = const Image(
    image: AssetImage('images/img/page227.png'),
    fit: BoxFit.fill,
  );
  imagesList[227] = const Image(
    image: AssetImage('images/img/page228.png'),
    fit: BoxFit.fill,
  );
  imagesList[228] = const Image(
    image: AssetImage('images/img/page229.png'),
    fit: BoxFit.fill,
  );

  imagesList[229] = const Image(
    image: AssetImage('images/img/page230.png'),
    fit: BoxFit.fill,
  );
  imagesList[230] = const Image(
    image: AssetImage('images/img/page231.png'),
    fit: BoxFit.fill,
  );
  imagesList[231] = const Image(
    image: AssetImage('images/img/page232.png'),
    fit: BoxFit.fill,
  );
  imagesList[232] = const Image(
    image: AssetImage('images/img/page233.png'),
    fit: BoxFit.fill,
  );
  imagesList[233] = const Image(
    image: AssetImage('images/img/page234.png'),
    fit: BoxFit.fill,
  );
  imagesList[234] = const Image(
    image: AssetImage('images/img/page235.png'),
    fit: BoxFit.fill,
  );
  imagesList[235] = const Image(
    image: AssetImage('images/img/page236.png'),
    fit: BoxFit.fill,
  );
  imagesList[236] = const Image(
    image: AssetImage('images/img/page237.png'),
    fit: BoxFit.fill,
  );
  imagesList[237] = const Image(
    image: AssetImage('images/img/page238.png'),
    fit: BoxFit.fill,
  );
  imagesList[238] = const Image(
    image: AssetImage('images/img/page239.png'),
    fit: BoxFit.fill,
  );

  imagesList[239] = const Image(
    image: AssetImage('images/img/page240.png'),
    fit: BoxFit.fill,
  );
  imagesList[240] = const Image(
    image: AssetImage('images/img/page241.png'),
    fit: BoxFit.fill,
  );
  imagesList[241] = const Image(
    image: AssetImage('images/img/page242.png'),
    fit: BoxFit.fill,
  );
  imagesList[242] = const Image(
    image: AssetImage('images/img/page243.png'),
    fit: BoxFit.fill,
  );
  imagesList[243] = const Image(
    image: AssetImage('images/img/page244.png'),
    fit: BoxFit.fill,
  );
  imagesList[244] = const Image(
    image: AssetImage('images/img/page245.png'),
    fit: BoxFit.fill,
  );
  imagesList[245] = const Image(
    image: AssetImage('images/img/page246.png'),
    fit: BoxFit.fill,
  );
  imagesList[246] = const Image(
    image: AssetImage('images/img/page247.png'),
    fit: BoxFit.fill,
  );
  imagesList[247] = const Image(
    image: AssetImage('images/img/page248.png'),
    fit: BoxFit.fill,
  );
  imagesList[248] = const Image(
    image: AssetImage('images/img/page249.png'),
    fit: BoxFit.fill,
  );

  imagesList[249] = const Image(
    image: AssetImage('images/img/page250.png'),
    fit: BoxFit.fill,
  );
  imagesList[250] = const Image(
    image: AssetImage('images/img/page251.png'),
    fit: BoxFit.fill,
  );
  imagesList[251] = const Image(
    image: AssetImage('images/img/page252.png'),
    fit: BoxFit.fill,
  );
  imagesList[252] = const Image(
    image: AssetImage('images/img/page253.png'),
    fit: BoxFit.fill,
  );
  imagesList[253] = const Image(
    image: AssetImage('images/img/page254.png'),
    fit: BoxFit.fill,
  );
  imagesList[254] = const Image(
    image: AssetImage('images/img/page255.png'),
    fit: BoxFit.fill,
  );
  imagesList[255] = const Image(
    image: AssetImage('images/img/page256.png'),
    fit: BoxFit.fill,
  );
  imagesList[256] = const Image(
    image: AssetImage('images/img/page257.png'),
    fit: BoxFit.fill,
  );
  imagesList[257] = const Image(
    image: AssetImage('images/img/page258.png'),
    fit: BoxFit.fill,
  );
  imagesList[258] = const Image(
    image: AssetImage('images/img/page259.png'),
    fit: BoxFit.fill,
  );

  imagesList[259] = const Image(
    image: AssetImage('images/img/page260.png'),
    fit: BoxFit.fill,
  );
  imagesList[260] = const Image(
    image: AssetImage('images/img/page261.png'),
    fit: BoxFit.fill,
  );
  imagesList[261] = const Image(
    image: AssetImage('images/img/page262.png'),
    fit: BoxFit.fill,
  );
  imagesList[262] = const Image(
    image: AssetImage('images/img/page263.png'),
    fit: BoxFit.fill,
  );
  imagesList[263] = const Image(
    image: AssetImage('images/img/page264.png'),
    fit: BoxFit.fill,
  );
  imagesList[264] = const Image(
    image: AssetImage('images/img/page265.png'),
    fit: BoxFit.fill,
  );
  imagesList[265] = const Image(
    image: AssetImage('images/img/page266.png'),
    fit: BoxFit.fill,
  );
  imagesList[266] = const Image(
    image: AssetImage('images/img/page267.png'),
    fit: BoxFit.fill,
  );
  imagesList[267] = const Image(
    image: AssetImage('images/img/page268.png'),
    fit: BoxFit.fill,
  );
  imagesList[268] = const Image(
    image: AssetImage('images/img/page269.png'),
    fit: BoxFit.fill,
  );

  imagesList[269] = const Image(
    image: AssetImage('images/img/page270.png'),
    fit: BoxFit.fill,
  );
  imagesList[270] = const Image(
    image: AssetImage('images/img/page271.png'),
    fit: BoxFit.fill,
  );
  imagesList[271] = const Image(
    image: AssetImage('images/img/page272.png'),
    fit: BoxFit.fill,
  );
  imagesList[272] = const Image(
    image: AssetImage('images/img/page273.png'),
    fit: BoxFit.fill,
  );
  imagesList[273] = const Image(
    image: AssetImage('images/img/page274.png'),
    fit: BoxFit.fill,
  );
  imagesList[274] = const Image(
    image: AssetImage('images/img/page275.png'),
    fit: BoxFit.fill,
  );
  imagesList[275] = const Image(
    image: AssetImage('images/img/page276.png'),
    fit: BoxFit.fill,
  );
  imagesList[276] = const Image(
    image: AssetImage('images/img/page277.png'),
    fit: BoxFit.fill,
  );
  imagesList[277] = const Image(
    image: AssetImage('images/img/page278.png'),
    fit: BoxFit.fill,
  );
  imagesList[278] = const Image(
    image: AssetImage('images/img/page279.png'),
    fit: BoxFit.fill,
  );

  imagesList[279] = const Image(
    image: AssetImage('images/img/page280.png'),
    fit: BoxFit.fill,
  );
  imagesList[280] = const Image(
    image: AssetImage('images/img/page281.png'),
    fit: BoxFit.fill,
  );
  imagesList[281] = const Image(
    image: AssetImage('images/img/page282.png'),
    fit: BoxFit.fill,
  );
  imagesList[282] = const Image(
    image: AssetImage('images/img/page283.png'),
    fit: BoxFit.fill,
  );
  imagesList[283] = const Image(
    image: AssetImage('images/img/page284.png'),
    fit: BoxFit.fill,
  );
  imagesList[284] = const Image(
    image: AssetImage('images/img/page285.png'),
    fit: BoxFit.fill,
  );
  imagesList[285] = const Image(
    image: AssetImage('images/img/page286.png'),
    fit: BoxFit.fill,
  );
  imagesList[286] = const Image(
    image: AssetImage('images/img/page287.png'),
    fit: BoxFit.fill,
  );
  imagesList[287] = const Image(
    image: AssetImage('images/img/page288.png'),
    fit: BoxFit.fill,
  );
  imagesList[288] = const Image(
    image: AssetImage('images/img/page289.png'),
    fit: BoxFit.fill,
  );

  imagesList[289] = const Image(
    image: AssetImage('images/img/page290.png'),
    fit: BoxFit.fill,
  );
  imagesList[290] = const Image(
    image: AssetImage('images/img/page291.png'),
    fit: BoxFit.fill,
  );
  imagesList[291] = const Image(
    image: AssetImage('images/img/page292.png'),
    fit: BoxFit.fill,
  );
  imagesList[292] = const Image(
    image: AssetImage('images/img/page293.png'),
    fit: BoxFit.fill,
  );
  imagesList[293] = const Image(
    image: AssetImage('images/img/page294.png'),
    fit: BoxFit.fill,
  );
  imagesList[294] = const Image(
    image: AssetImage('images/img/page295.png'),
    fit: BoxFit.fill,
  );
  imagesList[295] = const Image(
    image: AssetImage('images/img/page296.png'),
    fit: BoxFit.fill,
  );
  imagesList[296] = const Image(
    image: AssetImage('images/img/page297.png'),
    fit: BoxFit.fill,
  );
  imagesList[297] = const Image(
    image: AssetImage('images/img/page298.png'),
    fit: BoxFit.fill,
  );
  imagesList[298] = const Image(
    image: AssetImage('images/img/page299.png'),
    fit: BoxFit.fill,
  );

  imagesList[299] = const Image(
    image: AssetImage('images/img/page300.png'),
    fit: BoxFit.fill,
  );
  imagesList[300] = const Image(
    image: AssetImage('images/img/page301.png'),
    fit: BoxFit.fill,
  );
  imagesList[301] = const Image(
    image: AssetImage('images/img/page302.png'),
    fit: BoxFit.fill,
  );
  imagesList[302] = const Image(
    image: AssetImage('images/img/page303.png'),
    fit: BoxFit.fill,
  );
  imagesList[303] = const Image(
    image: AssetImage('images/img/page304.png'),
    fit: BoxFit.fill,
  );
  imagesList[304] = const Image(
    image: AssetImage('images/img/page305.png'),
    fit: BoxFit.fill,
  );
  imagesList[305] = const Image(
    image: AssetImage('images/img/page306.png'),
    fit: BoxFit.fill,
  );
  imagesList[306] = const Image(
    image: AssetImage('images/img/page307.png'),
    fit: BoxFit.fill,
  );
  imagesList[307] = const Image(
    image: AssetImage('images/img/page308.png'),
    fit: BoxFit.fill,
  );
  imagesList[308] = const Image(
    image: AssetImage('images/img/page309.png'),
    fit: BoxFit.fill,
  );

  imagesList[309] = const Image(
    image: AssetImage('images/img/page310.png'),
    fit: BoxFit.fill,
  );
  imagesList[310] = const Image(
    image: AssetImage('images/img/page311.png'),
    fit: BoxFit.fill,
  );
  imagesList[311] = const Image(
    image: AssetImage('images/img/page312.png'),
    fit: BoxFit.fill,
  );
  imagesList[312] = const Image(
    image: AssetImage('images/img/page313.png'),
    fit: BoxFit.fill,
  );
  imagesList[313] = const Image(
    image: AssetImage('images/img/page314.png'),
    fit: BoxFit.fill,
  );
  imagesList[314] = const Image(
    image: AssetImage('images/img/page315.png'),
    fit: BoxFit.fill,
  );
  imagesList[315] = const Image(
    image: AssetImage('images/img/page316.png'),
    fit: BoxFit.fill,
  );
  imagesList[316] = const Image(
    image: AssetImage('images/img/page317.png'),
    fit: BoxFit.fill,
  );
  imagesList[317] = const Image(
    image: AssetImage('images/img/page318.png'),
    fit: BoxFit.fill,
  );
  imagesList[318] = const Image(
    image: AssetImage('images/img/page319.png'),
    fit: BoxFit.fill,
  );

  imagesList[319] = const Image(
    image: AssetImage('images/img/page320.png'),
    fit: BoxFit.fill,
  );
  imagesList[320] = const Image(
    image: AssetImage('images/img/page321.png'),
    fit: BoxFit.fill,
  );
  imagesList[321] = const Image(
    image: AssetImage('images/img/page322.png'),
    fit: BoxFit.fill,
  );
  imagesList[322] = const Image(
    image: AssetImage('images/img/page323.png'),
    fit: BoxFit.fill,
  );
  imagesList[323] = const Image(
    image: AssetImage('images/img/page324.png'),
    fit: BoxFit.fill,
  );
  imagesList[324] = const Image(
    image: AssetImage('images/img/page325.png'),
    fit: BoxFit.fill,
  );
  imagesList[325] = const Image(
    image: AssetImage('images/img/page326.png'),
    fit: BoxFit.fill,
  );
  imagesList[326] = const Image(
    image: AssetImage('images/img/page327.png'),
    fit: BoxFit.fill,
  );
  imagesList[327] = const Image(
    image: AssetImage('images/img/page328.png'),
    fit: BoxFit.fill,
  );
  imagesList[328] = const Image(
    image: AssetImage('images/img/page329.png'),
    fit: BoxFit.fill,
  );

  imagesList[329] = const Image(
    image: AssetImage('images/img/page330.png'),
    fit: BoxFit.fill,
  );
  imagesList[330] = const Image(
    image: AssetImage('images/img/page331.png'),
    fit: BoxFit.fill,
  );
  imagesList[331] = const Image(
    image: AssetImage('images/img/page332.png'),
    fit: BoxFit.fill,
  );
  imagesList[332] = const Image(
    image: AssetImage('images/img/page333.png'),
    fit: BoxFit.fill,
  );
  imagesList[333] = const Image(
    image: AssetImage('images/img/page334.png'),
    fit: BoxFit.fill,
  );
  imagesList[334] = const Image(
    image: AssetImage('images/img/page335.png'),
    fit: BoxFit.fill,
  );
  imagesList[335] = const Image(
    image: AssetImage('images/img/page336.png'),
    fit: BoxFit.fill,
  );
  imagesList[336] = const Image(
    image: AssetImage('images/img/page337.png'),
    fit: BoxFit.fill,
  );
  imagesList[337] = const Image(
    image: AssetImage('images/img/page338.png'),
    fit: BoxFit.fill,
  );
  imagesList[338] = const Image(
    image: AssetImage('images/img/page339.png'),
    fit: BoxFit.fill,
  );

  imagesList[339] = const Image(
    image: AssetImage('images/img/page340.png'),
    fit: BoxFit.fill,
  );
  imagesList[340] = const Image(
    image: AssetImage('images/img/page341.png'),
    fit: BoxFit.fill,
  );
  imagesList[341] = const Image(
    image: AssetImage('images/img/page342.png'),
    fit: BoxFit.fill,
  );
  imagesList[342] = const Image(
    image: AssetImage('images/img/page343.png'),
    fit: BoxFit.fill,
  );
  imagesList[343] = const Image(
    image: AssetImage('images/img/page344.png'),
    fit: BoxFit.fill,
  );
  imagesList[344] = const Image(
    image: AssetImage('images/img/page345.png'),
    fit: BoxFit.fill,
  );
  imagesList[345] = const Image(
    image: AssetImage('images/img/page346.png'),
    fit: BoxFit.fill,
  );
  imagesList[346] = const Image(
    image: AssetImage('images/img/page347.png'),
    fit: BoxFit.fill,
  );
  imagesList[347] = const Image(
    image: AssetImage('images/img/page348.png'),
    fit: BoxFit.fill,
  );
  imagesList[348] = const Image(
    image: AssetImage('images/img/page349.png'),
    fit: BoxFit.fill,
  );

  imagesList[349] = const Image(
    image: AssetImage('images/img/page350.png'),
    fit: BoxFit.fill,
  );
  imagesList[350] = const Image(
    image: AssetImage('images/img/page351.png'),
    fit: BoxFit.fill,
  );
  imagesList[351] = const Image(
    image: AssetImage('images/img/page352.png'),
    fit: BoxFit.fill,
  );
  imagesList[352] = const Image(
    image: AssetImage('images/img/page353.png'),
    fit: BoxFit.fill,
  );
  imagesList[353] = const Image(
    image: AssetImage('images/img/page354.png'),
    fit: BoxFit.fill,
  );
  imagesList[354] = const Image(
    image: AssetImage('images/img/page355.png'),
    fit: BoxFit.fill,
  );
  imagesList[355] = const Image(
    image: AssetImage('images/img/page356.png'),
    fit: BoxFit.fill,
  );
  imagesList[356] = const Image(
    image: AssetImage('images/img/page357.png'),
    fit: BoxFit.fill,
  );
  imagesList[357] = const Image(
    image: AssetImage('images/img/page358.png'),
    fit: BoxFit.fill,
  );
  imagesList[358] = const Image(
    image: AssetImage('images/img/page359.png'),
    fit: BoxFit.fill,
  );

  imagesList[359] = const Image(
    image: AssetImage('images/img/page360.png'),
    fit: BoxFit.fill,
  );
  imagesList[360] = const Image(
    image: AssetImage('images/img/page361.png'),
    fit: BoxFit.fill,
  );
  imagesList[361] = const Image(
    image: AssetImage('images/img/page362.png'),
    fit: BoxFit.fill,
  );
  imagesList[362] = const Image(
    image: AssetImage('images/img/page363.png'),
    fit: BoxFit.fill,
  );
  imagesList[363] = const Image(
    image: AssetImage('images/img/page364.png'),
    fit: BoxFit.fill,
  );
  imagesList[364] = const Image(
    image: AssetImage('images/img/page365.png'),
    fit: BoxFit.fill,
  );
  imagesList[365] = const Image(
    image: AssetImage('images/img/page366.png'),
    fit: BoxFit.fill,
  );
  imagesList[366] = const Image(
    image: AssetImage('images/img/page367.png'),
    fit: BoxFit.fill,
  );
  imagesList[367] = const Image(
    image: AssetImage('images/img/page368.png'),
    fit: BoxFit.fill,
  );
  imagesList[368] = const Image(
    image: AssetImage('images/img/page369.png'),
    fit: BoxFit.fill,
  );

  imagesList[369] = const Image(
    image: AssetImage('images/img/page370.png'),
    fit: BoxFit.fill,
  );
  imagesList[370] = const Image(
    image: AssetImage('images/img/page371.png'),
    fit: BoxFit.fill,
  );
  imagesList[371] = const Image(
    image: AssetImage('images/img/page372.png'),
    fit: BoxFit.fill,
  );
  imagesList[372] = const Image(
    image: AssetImage('images/img/page373.png'),
    fit: BoxFit.fill,
  );
  imagesList[373] = const Image(
    image: AssetImage('images/img/page374.png'),
    fit: BoxFit.fill,
  );
  imagesList[374] = const Image(
    image: AssetImage('images/img/page375.png'),
    fit: BoxFit.fill,
  );
  imagesList[375] = const Image(
    image: AssetImage('images/img/page376.png'),
    fit: BoxFit.fill,
  );
  imagesList[376] = const Image(
    image: AssetImage('images/img/page377.png'),
    fit: BoxFit.fill,
  );
  imagesList[377] = const Image(
    image: AssetImage('images/img/page378.png'),
    fit: BoxFit.fill,
  );
  imagesList[378] = const Image(
    image: AssetImage('images/img/page379.png'),
    fit: BoxFit.fill,
  );

  imagesList[379] = const Image(
    image: AssetImage('images/img/page380.png'),
    fit: BoxFit.fill,
  );
  imagesList[380] = const Image(
    image: AssetImage('images/img/page381.png'),
    fit: BoxFit.fill,
  );
  imagesList[381] = const Image(
    image: AssetImage('images/img/page382.png'),
    fit: BoxFit.fill,
  );
  imagesList[382] = const Image(
    image: AssetImage('images/img/page383.png'),
    fit: BoxFit.fill,
  );
  imagesList[383] = const Image(
    image: AssetImage('images/img/page384.png'),
    fit: BoxFit.fill,
  );
  imagesList[384] = const Image(
    image: AssetImage('images/img/page385.png'),
    fit: BoxFit.fill,
  );
  imagesList[385] = const Image(
    image: AssetImage('images/img/page386.png'),
    fit: BoxFit.fill,
  );
  imagesList[386] = const Image(
    image: AssetImage('images/img/page387.png'),
    fit: BoxFit.fill,
  );
  imagesList[387] = const Image(
    image: AssetImage('images/img/page388.png'),
    fit: BoxFit.fill,
  );
  imagesList[388] = const Image(
    image: AssetImage('images/img/page389.png'),
    fit: BoxFit.fill,
  );

  imagesList[389] = const Image(
    image: AssetImage('images/img/page390.png'),
    fit: BoxFit.fill,
  );
  imagesList[390] = const Image(
    image: AssetImage('images/img/page391.png'),
    fit: BoxFit.fill,
  );
  imagesList[391] = const Image(
    image: AssetImage('images/img/page392.png'),
    fit: BoxFit.fill,
  );
  imagesList[392] = const Image(
    image: AssetImage('images/img/page393.png'),
    fit: BoxFit.fill,
  );
  imagesList[393] = const Image(
    image: AssetImage('images/img/page394.png'),
    fit: BoxFit.fill,
  );
  imagesList[394] = const Image(
    image: AssetImage('images/img/page395.png'),
    fit: BoxFit.fill,
  );
  imagesList[395] = const Image(
    image: AssetImage('images/img/page396.png'),
    fit: BoxFit.fill,
  );
  imagesList[396] = const Image(
    image: AssetImage('images/img/page397.png'),
    fit: BoxFit.fill,
  );
  imagesList[397] = const Image(
    image: AssetImage('images/img/page398.png'),
    fit: BoxFit.fill,
  );
  imagesList[398] = const Image(
    image: AssetImage('images/img/page399.png'),
    fit: BoxFit.fill,
  );

  imagesList[399] = const Image(
    image: AssetImage('images/img/page400.png'),
    fit: BoxFit.fill,
  );
  imagesList[400] = const Image(
    image: AssetImage('images/img/page401.png'),
    fit: BoxFit.fill,
  );
  imagesList[401] = const Image(
    image: AssetImage('images/img/page402.png'),
    fit: BoxFit.fill,
  );
  imagesList[402] = const Image(
    image: AssetImage('images/img/page403.png'),
    fit: BoxFit.fill,
  );
  imagesList[403] = const Image(
    image: AssetImage('images/img/page404.png'),
    fit: BoxFit.fill,
  );
  imagesList[404] = const Image(
    image: AssetImage('images/img/page405.png'),
    fit: BoxFit.fill,
  );
  imagesList[405] = const Image(
    image: AssetImage('images/img/page406.png'),
    fit: BoxFit.fill,
  );
  imagesList[406] = const Image(
    image: AssetImage('images/img/page407.png'),
    fit: BoxFit.fill,
  );
  imagesList[407] = const Image(
    image: AssetImage('images/img/page408.png'),
    fit: BoxFit.fill,
  );
  imagesList[408] = const Image(
    image: AssetImage('images/img/page409.png'),
    fit: BoxFit.fill,
  );

  imagesList[409] = const Image(
    image: AssetImage('images/img/page410.png'),
    fit: BoxFit.fill,
  );
  imagesList[410] = const Image(
    image: AssetImage('images/img/page411.png'),
    fit: BoxFit.fill,
  );
  imagesList[411] = const Image(
    image: AssetImage('images/img/page412.png'),
    fit: BoxFit.fill,
  );
  imagesList[412] = const Image(
    image: AssetImage('images/img/page413.png'),
    fit: BoxFit.fill,
  );
  imagesList[413] = const Image(
    image: AssetImage('images/img/page414.png'),
    fit: BoxFit.fill,
  );
  imagesList[414] = const Image(
    image: AssetImage('images/img/page415.png'),
    fit: BoxFit.fill,
  );
  imagesList[415] = const Image(
    image: AssetImage('images/img/page416.png'),
    fit: BoxFit.fill,
  );
  imagesList[416] = const Image(
    image: AssetImage('images/img/page417.png'),
    fit: BoxFit.fill,
  );
  imagesList[417] = const Image(
    image: AssetImage('images/img/page418.png'),
    fit: BoxFit.fill,
  );
  imagesList[418] = const Image(
    image: AssetImage('images/img/page419.png'),
    fit: BoxFit.fill,
  );

  imagesList[419] = const Image(
    image: AssetImage('images/img/page420.png'),
    fit: BoxFit.fill,
  );
  imagesList[420] = const Image(
    image: AssetImage('images/img/page421.png'),
    fit: BoxFit.fill,
  );
  imagesList[421] = const Image(
    image: AssetImage('images/img/page422.png'),
    fit: BoxFit.fill,
  );
  imagesList[422] = const Image(
    image: AssetImage('images/img/page423.png'),
    fit: BoxFit.fill,
  );
  imagesList[423] = const Image(
    image: AssetImage('images/img/page424.png'),
    fit: BoxFit.fill,
  );
  imagesList[424] = const Image(
    image: AssetImage('images/img/page425.png'),
    fit: BoxFit.fill,
  );
  imagesList[425] = const Image(
    image: AssetImage('images/img/page426.png'),
    fit: BoxFit.fill,
  );
  imagesList[426] = const Image(
    image: AssetImage('images/img/page427.png'),
    fit: BoxFit.fill,
  );
  imagesList[427] = const Image(
    image: AssetImage('images/img/page428.png'),
    fit: BoxFit.fill,
  );
  imagesList[428] = const Image(
    image: AssetImage('images/img/page429.png'),
    fit: BoxFit.fill,
  );

  imagesList[429] = const Image(
    image: AssetImage('images/img/page430.png'),
    fit: BoxFit.fill,
  );
  imagesList[430] = const Image(
    image: AssetImage('images/img/page431.png'),
    fit: BoxFit.fill,
  );
  imagesList[431] = const Image(
    image: AssetImage('images/img/page432.png'),
    fit: BoxFit.fill,
  );
  imagesList[432] = const Image(
    image: AssetImage('images/img/page433.png'),
    fit: BoxFit.fill,
  );
  imagesList[433] = const Image(
    image: AssetImage('images/img/page434.png'),
    fit: BoxFit.fill,
  );
  imagesList[434] = const Image(
    image: AssetImage('images/img/page435.png'),
    fit: BoxFit.fill,
  );
  imagesList[435] = const Image(
    image: AssetImage('images/img/page436.png'),
    fit: BoxFit.fill,
  );
  imagesList[436] = const Image(
    image: AssetImage('images/img/page437.png'),
    fit: BoxFit.fill,
  );
  imagesList[437] = const Image(
    image: AssetImage('images/img/page438.png'),
    fit: BoxFit.fill,
  );
  imagesList[438] = const Image(
    image: AssetImage('images/img/page439.png'),
    fit: BoxFit.fill,
  );

  imagesList[439] = const Image(
    image: AssetImage('images/img/page440.png'),
    fit: BoxFit.fill,
  );
  imagesList[440] = const Image(
    image: AssetImage('images/img/page441.png'),
    fit: BoxFit.fill,
  );
  imagesList[441] = const Image(
    image: AssetImage('images/img/page442.png'),
    fit: BoxFit.fill,
  );
  imagesList[442] = const Image(
    image: AssetImage('images/img/page443.png'),
    fit: BoxFit.fill,
  );
  imagesList[443] = const Image(
    image: AssetImage('images/img/page444.png'),
    fit: BoxFit.fill,
  );
  imagesList[444] = const Image(
    image: AssetImage('images/img/page445.png'),
    fit: BoxFit.fill,
  );
  imagesList[445] = const Image(
    image: AssetImage('images/img/page446.png'),
    fit: BoxFit.fill,
  );
  imagesList[446] = const Image(
    image: AssetImage('images/img/page447.png'),
    fit: BoxFit.fill,
  );
  imagesList[447] = const Image(
    image: AssetImage('images/img/page448.png'),
    fit: BoxFit.fill,
  );
  imagesList[448] = const Image(
    image: AssetImage('images/img/page449.png'),
    fit: BoxFit.fill,
  );

  imagesList[449] = const Image(
    image: AssetImage('images/img/page450.png'),
    fit: BoxFit.fill,
  );
  imagesList[450] = const Image(
    image: AssetImage('images/img/page451.png'),
    fit: BoxFit.fill,
  );
  imagesList[451] = const Image(
    image: AssetImage('images/img/page452.png'),
    fit: BoxFit.fill,
  );
  imagesList[452] = const Image(
    image: AssetImage('images/img/page453.png'),
    fit: BoxFit.fill,
  );
  imagesList[453] = const Image(
    image: AssetImage('images/img/page454.png'),
    fit: BoxFit.fill,
  );
  imagesList[454] = const Image(
    image: AssetImage('images/img/page455.png'),
    fit: BoxFit.fill,
  );
  imagesList[455] = const Image(
    image: AssetImage('images/img/page456.png'),
    fit: BoxFit.fill,
  );
  imagesList[456] = const Image(
    image: AssetImage('images/img/page457.png'),
    fit: BoxFit.fill,
  );
  imagesList[457] = const Image(
    image: AssetImage('images/img/page458.png'),
    fit: BoxFit.fill,
  );
  imagesList[458] = const Image(
    image: AssetImage('images/img/page459.png'),
    fit: BoxFit.fill,
  );

  imagesList[459] = const Image(
    image: AssetImage('images/img/page460.png'),
    fit: BoxFit.fill,
  );
  imagesList[460] = const Image(
    image: AssetImage('images/img/page461.png'),
    fit: BoxFit.fill,
  );
  imagesList[461] = const Image(
    image: AssetImage('images/img/page462.png'),
    fit: BoxFit.fill,
  );
  imagesList[462] = const Image(
    image: AssetImage('images/img/page463.png'),
    fit: BoxFit.fill,
  );
  imagesList[463] = const Image(
    image: AssetImage('images/img/page464.png'),
    fit: BoxFit.fill,
  );
  imagesList[464] = const Image(
    image: AssetImage('images/img/page465.png'),
    fit: BoxFit.fill,
  );
  imagesList[465] = const Image(
    image: AssetImage('images/img/page466.png'),
    fit: BoxFit.fill,
  );
  imagesList[466] = const Image(
    image: AssetImage('images/img/page467.png'),
    fit: BoxFit.fill,
  );
  imagesList[467] = const Image(
    image: AssetImage('images/img/page468.png'),
    fit: BoxFit.fill,
  );
  imagesList[468] = const Image(
    image: AssetImage('images/img/page469.png'),
    fit: BoxFit.fill,
  );

  imagesList[469] = const Image(
    image: AssetImage('images/img/page470.png'),
    fit: BoxFit.fill,
  );
  imagesList[470] = const Image(
    image: AssetImage('images/img/page471.png'),
    fit: BoxFit.fill,
  );
  imagesList[471] = const Image(
    image: AssetImage('images/img/page472.png'),
    fit: BoxFit.fill,
  );
  imagesList[472] = const Image(
    image: AssetImage('images/img/page473.png'),
    fit: BoxFit.fill,
  );
  imagesList[473] = const Image(
    image: AssetImage('images/img/page474.png'),
    fit: BoxFit.fill,
  );
  imagesList[474] = const Image(
    image: AssetImage('images/img/page475.png'),
    fit: BoxFit.fill,
  );
  imagesList[475] = const Image(
    image: AssetImage('images/img/page476.png'),
    fit: BoxFit.fill,
  );
  imagesList[476] = const Image(
    image: AssetImage('images/img/page477.png'),
    fit: BoxFit.fill,
  );
  imagesList[477] = const Image(
    image: AssetImage('images/img/page478.png'),
    fit: BoxFit.fill,
  );
  imagesList[478] = const Image(
    image: AssetImage('images/img/page479.png'),
    fit: BoxFit.fill,
  );

  imagesList[479] = const Image(
    image: AssetImage('images/img/page480.png'),
    fit: BoxFit.fill,
  );
  imagesList[480] = const Image(
    image: AssetImage('images/img/page481.png'),
    fit: BoxFit.fill,
  );
  imagesList[481] = const Image(
    image: AssetImage('images/img/page482.png'),
    fit: BoxFit.fill,
  );
  imagesList[482] = const Image(
    image: AssetImage('images/img/page483.png'),
    fit: BoxFit.fill,
  );
  imagesList[483] = const Image(
    image: AssetImage('images/img/page484.png'),
    fit: BoxFit.fill,
  );
  imagesList[484] = const Image(
    image: AssetImage('images/img/page485.png'),
    fit: BoxFit.fill,
  );
  imagesList[485] = const Image(
    image: AssetImage('images/img/page486.png'),
    fit: BoxFit.fill,
  );
  imagesList[486] = const Image(
    image: AssetImage('images/img/page487.png'),
    fit: BoxFit.fill,
  );
  imagesList[487] = const Image(
    image: AssetImage('images/img/page488.png'),
    fit: BoxFit.fill,
  );
  imagesList[488] = const Image(
    image: AssetImage('images/img/page489.png'),
    fit: BoxFit.fill,
  );

  imagesList[489] = const Image(
    image: AssetImage('images/img/page490.png'),
    fit: BoxFit.fill,
  );
  imagesList[490] = const Image(
    image: AssetImage('images/img/page491.png'),
    fit: BoxFit.fill,
  );
  imagesList[491] = const Image(
    image: AssetImage('images/img/page492.png'),
    fit: BoxFit.fill,
  );
  imagesList[492] = const Image(
    image: AssetImage('images/img/page493.png'),
    fit: BoxFit.fill,
  );
  imagesList[493] = const Image(
    image: AssetImage('images/img/page494.png'),
    fit: BoxFit.fill,
  );
  imagesList[494] = const Image(
    image: AssetImage('images/img/page495.png'),
    fit: BoxFit.fill,
  );
  imagesList[495] = const Image(
    image: AssetImage('images/img/page496.png'),
    fit: BoxFit.fill,
  );
  imagesList[496] = const Image(
    image: AssetImage('images/img/page497.png'),
    fit: BoxFit.fill,
  );
  imagesList[497] = const Image(
    image: AssetImage('images/img/page498.png'),
    fit: BoxFit.fill,
  );
  imagesList[498] = const Image(
    image: AssetImage('images/img/page499.png'),
    fit: BoxFit.fill,
  );

  imagesList[499] = const Image(
    image: AssetImage('images/img/page500.png'),
    fit: BoxFit.fill,
  );
  imagesList[500] = const Image(
    image: AssetImage('images/img/page501.png'),
    fit: BoxFit.fill,
  );
  imagesList[501] = const Image(
    image: AssetImage('images/img/page502.png'),
    fit: BoxFit.fill,
  );
  imagesList[502] = const Image(
    image: AssetImage('images/img/page503.png'),
    fit: BoxFit.fill,
  );
  imagesList[503] = const Image(
    image: AssetImage('images/img/page504.png'),
    fit: BoxFit.fill,
  );
  imagesList[504] = const Image(
    image: AssetImage('images/img/page505.png'),
    fit: BoxFit.fill,
  );
  imagesList[505] = const Image(
    image: AssetImage('images/img/page506.png'),
    fit: BoxFit.fill,
  );
  imagesList[506] = const Image(
    image: AssetImage('images/img/page507.png'),
    fit: BoxFit.fill,
  );
  imagesList[507] = const Image(
    image: AssetImage('images/img/page508.png'),
    fit: BoxFit.fill,
  );
  imagesList[508] = const Image(
    image: AssetImage('images/img/page509.png'),
    fit: BoxFit.fill,
  );

  imagesList[509] = const Image(
    image: AssetImage('images/img/page510.png'),
    fit: BoxFit.fill,
  );
  imagesList[510] = const Image(
    image: AssetImage('images/img/page511.png'),
    fit: BoxFit.fill,
  );
  imagesList[511] = const Image(
    image: AssetImage('images/img/page512.png'),
    fit: BoxFit.fill,
  );
  imagesList[512] = const Image(
    image: AssetImage('images/img/page513.png'),
    fit: BoxFit.fill,
  );
  imagesList[513] = const Image(
    image: AssetImage('images/img/page514.png'),
    fit: BoxFit.fill,
  );
  imagesList[514] = const Image(
    image: AssetImage('images/img/page515.png'),
    fit: BoxFit.fill,
  );
  imagesList[515] = const Image(
    image: AssetImage('images/img/page516.png'),
    fit: BoxFit.fill,
  );
  imagesList[516] = const Image(
    image: AssetImage('images/img/page517.png'),
    fit: BoxFit.fill,
  );
  imagesList[517] = const Image(
    image: AssetImage('images/img/page518.png'),
    fit: BoxFit.fill,
  );
  imagesList[518] = const Image(
    image: AssetImage('images/img/page519.png'),
    fit: BoxFit.fill,
  );

  imagesList[519] = const Image(
    image: AssetImage('images/img/page520.png'),
    fit: BoxFit.fill,
  );
  imagesList[520] = const Image(
    image: AssetImage('images/img/page521.png'),
    fit: BoxFit.fill,
  );
  imagesList[521] = const Image(
    image: AssetImage('images/img/page522.png'),
    fit: BoxFit.fill,
  );
  imagesList[522] = const Image(
    image: AssetImage('images/img/page523.png'),
    fit: BoxFit.fill,
  );
  imagesList[523] = const Image(
    image: AssetImage('images/img/page524.png'),
    fit: BoxFit.fill,
  );
  imagesList[524] = const Image(
    image: AssetImage('images/img/page525.png'),
    fit: BoxFit.fill,
  );
  imagesList[525] = const Image(
    image: AssetImage('images/img/page526.png'),
    fit: BoxFit.fill,
  );
  imagesList[526] = const Image(
    image: AssetImage('images/img/page527.png'),
    fit: BoxFit.fill,
  );
  imagesList[527] = const Image(
    image: AssetImage('images/img/page528.png'),
    fit: BoxFit.fill,
  );
  imagesList[528] = const Image(
    image: AssetImage('images/img/page529.png'),
    fit: BoxFit.fill,
  );

  imagesList[529] = const Image(
    image: AssetImage('images/img/page530.png'),
    fit: BoxFit.fill,
  );
  imagesList[530] = const Image(
    image: AssetImage('images/img/page531.png'),
    fit: BoxFit.fill,
  );
  imagesList[531] = const Image(
    image: AssetImage('images/img/page532.png'),
    fit: BoxFit.fill,
  );
  imagesList[532] = const Image(
    image: AssetImage('images/img/page533.png'),
    fit: BoxFit.fill,
  );
  imagesList[533] = const Image(
    image: AssetImage('images/img/page534.png'),
    fit: BoxFit.fill,
  );
  imagesList[534] = const Image(
    image: AssetImage('images/img/page535.png'),
    fit: BoxFit.fill,
  );
  imagesList[535] = const Image(
    image: AssetImage('images/img/page536.png'),
    fit: BoxFit.fill,
  );
  imagesList[536] = const Image(
    image: AssetImage('images/img/page537.png'),
    fit: BoxFit.fill,
  );
  imagesList[537] = const Image(
    image: AssetImage('images/img/page538.png'),
    fit: BoxFit.fill,
  );
  imagesList[538] = const Image(
    image: AssetImage('images/img/page539.png'),
    fit: BoxFit.fill,
  );

  imagesList[539] = const Image(
    image: AssetImage('images/img/page540.png'),
    fit: BoxFit.fill,
  );
  imagesList[540] = const Image(
    image: AssetImage('images/img/page541.png'),
    fit: BoxFit.fill,
  );
  imagesList[541] = const Image(
    image: AssetImage('images/img/page542.png'),
    fit: BoxFit.fill,
  );
  imagesList[542] = const Image(
    image: AssetImage('images/img/page543.png'),
    fit: BoxFit.fill,
  );
  imagesList[543] = const Image(
    image: AssetImage('images/img/page544.png'),
    fit: BoxFit.fill,
  );
  imagesList[544] = const Image(
    image: AssetImage('images/img/page545.png'),
    fit: BoxFit.fill,
  );
  imagesList[545] = const Image(
    image: AssetImage('images/img/page546.png'),
    fit: BoxFit.fill,
  );
  imagesList[546] = const Image(
    image: AssetImage('images/img/page547.png'),
    fit: BoxFit.fill,
  );
  imagesList[547] = const Image(
    image: AssetImage('images/img/page548.png'),
    fit: BoxFit.fill,
  );
  imagesList[548] = const Image(
    image: AssetImage('images/img/page549.png'),
    fit: BoxFit.fill,
  );

  imagesList[549] = const Image(
    image: AssetImage('images/img/page550.png'),
    fit: BoxFit.fill,
  );
  imagesList[550] = const Image(
    image: AssetImage('images/img/page551.png'),
    fit: BoxFit.fill,
  );
  imagesList[551] = const Image(
    image: AssetImage('images/img/page552.png'),
    fit: BoxFit.fill,
  );
  imagesList[552] = const Image(
    image: AssetImage('images/img/page553.png'),
    fit: BoxFit.fill,
  );
  imagesList[553] = const Image(
    image: AssetImage('images/img/page554.png'),
    fit: BoxFit.fill,
  );
  imagesList[554] = const Image(
    image: AssetImage('images/img/page555.png'),
    fit: BoxFit.fill,
  );
  imagesList[555] = const Image(
    image: AssetImage('images/img/page556.png'),
    fit: BoxFit.fill,
  );
  imagesList[556] = const Image(
    image: AssetImage('images/img/page557.png'),
    fit: BoxFit.fill,
  );
  imagesList[557] = const Image(
    image: AssetImage('images/img/page558.png'),
    fit: BoxFit.fill,
  );
  imagesList[558] = const Image(
    image: AssetImage('images/img/page559.png'),
    fit: BoxFit.fill,
  );

  imagesList[559] = const Image(
    image: AssetImage('images/img/page560.png'),
    fit: BoxFit.fill,
  );
  imagesList[560] = const Image(
    image: AssetImage('images/img/page561.png'),
    fit: BoxFit.fill,
  );
  imagesList[561] = const Image(
    image: AssetImage('images/img/page562.png'),
    fit: BoxFit.fill,
  );
  imagesList[562] = const Image(
    image: AssetImage('images/img/page563.png'),
    fit: BoxFit.fill,
  );
  imagesList[563] = const Image(
    image: AssetImage('images/img/page564.png'),
    fit: BoxFit.fill,
  );
  imagesList[564] = const Image(
    image: AssetImage('images/img/page565.png'),
    fit: BoxFit.fill,
  );
  imagesList[565] = const Image(
    image: AssetImage('images/img/page566.png'),
    fit: BoxFit.fill,
  );
  imagesList[566] = const Image(
    image: AssetImage('images/img/page567.png'),
    fit: BoxFit.fill,
  );
  imagesList[567] = const Image(
    image: AssetImage('images/img/page568.png'),
    fit: BoxFit.fill,
  );
  imagesList[568] = const Image(
    image: AssetImage('images/img/page569.png'),
    fit: BoxFit.fill,
  );

  imagesList[569] = const Image(
    image: AssetImage('images/img/page570.png'),
    fit: BoxFit.fill,
  );
  imagesList[570] = const Image(
    image: AssetImage('images/img/page571.png'),
    fit: BoxFit.fill,
  );
  imagesList[571] = const Image(
    image: AssetImage('images/img/page572.png'),
    fit: BoxFit.fill,
  );
  imagesList[572] = const Image(
    image: AssetImage('images/img/page573.png'),
    fit: BoxFit.fill,
  );
  imagesList[573] = const Image(
    image: AssetImage('images/img/page574.png'),
    fit: BoxFit.fill,
  );
  imagesList[574] = const Image(
    image: AssetImage('images/img/page575.png'),
    fit: BoxFit.fill,
  );
  imagesList[575] = const Image(
    image: AssetImage('images/img/page576.png'),
    fit: BoxFit.fill,
  );
  imagesList[576] = const Image(
    image: AssetImage('images/img/page577.png'),
    fit: BoxFit.fill,
  );
  imagesList[577] = const Image(
    image: AssetImage('images/img/page578.png'),
    fit: BoxFit.fill,
  );
  imagesList[578] = const Image(
    image: AssetImage('images/img/page579.png'),
    fit: BoxFit.fill,
  );

  imagesList[579] = const Image(
    image: AssetImage('images/img/page580.png'),
    fit: BoxFit.fill,
  );
  imagesList[580] = const Image(
    image: AssetImage('images/img/page581.png'),
    fit: BoxFit.fill,
  );
  imagesList[581] = const Image(
    image: AssetImage('images/img/page582.png'),
    fit: BoxFit.fill,
  );
  imagesList[582] = const Image(
    image: AssetImage('images/img/page583.png'),
    fit: BoxFit.fill,
  );
  imagesList[583] = const Image(
    image: AssetImage('images/img/page584.png'),
    fit: BoxFit.fill,
  );
  imagesList[584] = const Image(
    image: AssetImage('images/img/page585.png'),
    fit: BoxFit.fill,
  );
  imagesList[585] = const Image(
    image: AssetImage('images/img/page586.png'),
    fit: BoxFit.fill,
  );
  imagesList[586] = const Image(
    image: AssetImage('images/img/page587.png'),
    fit: BoxFit.fill,
  );
  imagesList[587] = const Image(
    image: AssetImage('images/img/page588.png'),
    fit: BoxFit.fill,
  );
  imagesList[588] = const Image(
    image: AssetImage('images/img/page589.png'),
    fit: BoxFit.fill,
  );

  imagesList[589] = const Image(
    image: AssetImage('images/img/page590.png'),
    fit: BoxFit.fill,
  );
  imagesList[590] = const Image(
    image: AssetImage('images/img/page591.png'),
    fit: BoxFit.fill,
  );
  imagesList[591] = const Image(
    image: AssetImage('images/img/page592.png'),
    fit: BoxFit.fill,
  );
  imagesList[592] = const Image(
    image: AssetImage('images/img/page593.png'),
    fit: BoxFit.fill,
  );
  imagesList[593] = const Image(
    image: AssetImage('images/img/page594.png'),
    fit: BoxFit.fill,
  );
  imagesList[594] = const Image(
    image: AssetImage('images/img/page595.png'),
    fit: BoxFit.fill,
  );
  imagesList[595] = const Image(
    image: AssetImage('images/img/page596.png'),
    fit: BoxFit.fill,
  );
  imagesList[596] = const Image(
    image: AssetImage('images/img/page597.png'),
    fit: BoxFit.fill,
  );
  imagesList[597] = const Image(
    image: AssetImage('images/img/page598.png'),
    fit: BoxFit.fill,
  );
  imagesList[598] = const Image(
    image: AssetImage('images/img/page599.png'),
    fit: BoxFit.fill,
  );

  imagesList[599] = const Image(
    image: AssetImage('images/img/page600.png'),
    fit: BoxFit.fill,
  );
  imagesList[600] = const Image(
    image: AssetImage('images/img/page601.png'),
    fit: BoxFit.fill,
  );
  imagesList[601] = const Image(
    image: AssetImage('images/img/page602.png'),
    fit: BoxFit.fill,
  );
  imagesList[602] = const Image(
    image: AssetImage('images/img/page603.png'),
    fit: BoxFit.fill,
  );
  imagesList[603] = const Image(
    image: AssetImage('images/img/page604.png'),
    fit: BoxFit.fill,
  );

  return imagesList[index];
  //return imagesList;
});

final pageWidgetProvider = Provider.family<PageWidget, int>((ref, index) {
//final pageWidgetProvider = Provider<List<PageWidget>>((ref) {
  final objets = List<PageWidget>.filled(604, const PageWidget(index: 0));

  objets[0] = const PageWidget(index: 0);
  objets[1] = const PageWidget(index: 1);
  objets[2] = const PageWidget(index: 2);
  objets[3] = const PageWidget(index: 3);
  objets[4] = const PageWidget(index: 4);
  objets[5] = const PageWidget(index: 5);
  objets[6] = const PageWidget(index: 6);
  objets[7] = const PageWidget(index: 7);
  objets[8] = const PageWidget(index: 8);
  objets[9] = const PageWidget(index: 9);
  objets[10] = const PageWidget(index: 10);
  objets[11] = const PageWidget(index: 11);
  objets[12] = const PageWidget(index: 12);
  objets[13] = const PageWidget(index: 13);
  objets[14] = const PageWidget(index: 14);
  objets[15] = const PageWidget(index: 15);
  objets[16] = const PageWidget(index: 16);
  objets[17] = const PageWidget(index: 17);
  objets[18] = const PageWidget(index: 18);
  objets[19] = const PageWidget(index: 19);
  objets[20] = const PageWidget(index: 20);
  objets[21] = const PageWidget(index: 21);
  objets[22] = const PageWidget(index: 22);
  objets[23] = const PageWidget(index: 23);
  objets[24] = const PageWidget(index: 24);
  objets[25] = const PageWidget(index: 25);
  objets[26] = const PageWidget(index: 26);
  objets[27] = const PageWidget(index: 27);
  objets[28] = const PageWidget(index: 28);
  objets[29] = const PageWidget(index: 29);
  objets[30] = const PageWidget(index: 30);
  objets[31] = const PageWidget(index: 31);
  objets[32] = const PageWidget(index: 32);
  objets[33] = const PageWidget(index: 33);
  objets[34] = const PageWidget(index: 34);
  objets[35] = const PageWidget(index: 35);
  objets[36] = const PageWidget(index: 36);
  objets[37] = const PageWidget(index: 37);
  objets[38] = const PageWidget(index: 38);
  objets[39] = const PageWidget(index: 39);
  objets[40] = const PageWidget(index: 40);
  objets[41] = const PageWidget(index: 41);
  objets[42] = const PageWidget(index: 42);
  objets[43] = const PageWidget(index: 43);
  objets[44] = const PageWidget(index: 44);
  objets[45] = const PageWidget(index: 45);
  objets[46] = const PageWidget(index: 46);
  objets[47] = const PageWidget(index: 47);
  objets[48] = const PageWidget(index: 48);
  objets[49] = const PageWidget(index: 49);
  objets[50] = const PageWidget(index: 50);
  objets[51] = const PageWidget(index: 51);
  objets[52] = const PageWidget(index: 52);
  objets[53] = const PageWidget(index: 53);
  objets[54] = const PageWidget(index: 54);
  objets[55] = const PageWidget(index: 55);
  objets[56] = const PageWidget(index: 56);
  objets[57] = const PageWidget(index: 57);
  objets[58] = const PageWidget(index: 58);
  objets[59] = const PageWidget(index: 59);
  objets[60] = const PageWidget(index: 60);
  objets[61] = const PageWidget(index: 61);
  objets[62] = const PageWidget(index: 62);
  objets[63] = const PageWidget(index: 63);
  objets[64] = const PageWidget(index: 64);
  objets[65] = const PageWidget(index: 65);
  objets[66] = const PageWidget(index: 66);
  objets[67] = const PageWidget(index: 67);
  objets[68] = const PageWidget(index: 68);
  objets[69] = const PageWidget(index: 69);
  objets[70] = const PageWidget(index: 70);
  objets[71] = const PageWidget(index: 71);
  objets[72] = const PageWidget(index: 72);
  objets[73] = const PageWidget(index: 73);
  objets[74] = const PageWidget(index: 74);
  objets[75] = const PageWidget(index: 75);
  objets[76] = const PageWidget(index: 76);
  objets[77] = const PageWidget(index: 77);
  objets[78] = const PageWidget(index: 78);
  objets[79] = const PageWidget(index: 79);
  objets[80] = const PageWidget(index: 80);
  objets[81] = const PageWidget(index: 81);
  objets[82] = const PageWidget(index: 82);
  objets[83] = const PageWidget(index: 83);
  objets[84] = const PageWidget(index: 84);
  objets[85] = const PageWidget(index: 85);
  objets[86] = const PageWidget(index: 86);
  objets[87] = const PageWidget(index: 87);
  objets[88] = const PageWidget(index: 88);
  objets[89] = const PageWidget(index: 89);
  objets[90] = const PageWidget(index: 90);
  objets[91] = const PageWidget(index: 91);
  objets[92] = const PageWidget(index: 92);
  objets[93] = const PageWidget(index: 93);
  objets[94] = const PageWidget(index: 94);
  objets[95] = const PageWidget(index: 95);
  objets[96] = const PageWidget(index: 96);
  objets[97] = const PageWidget(index: 97);
  objets[98] = const PageWidget(index: 98);
  objets[99] = const PageWidget(index: 99);

  objets[100] = const PageWidget(index: 100);
  objets[101] = const PageWidget(index: 101);
  objets[102] = const PageWidget(index: 102);
  objets[103] = const PageWidget(index: 103);
  objets[104] = const PageWidget(index: 104);
  objets[105] = const PageWidget(index: 105);
  objets[106] = const PageWidget(index: 106);
  objets[107] = const PageWidget(index: 107);
  objets[108] = const PageWidget(index: 108);
  objets[109] = const PageWidget(index: 109);
  objets[110] = const PageWidget(index: 110);
  objets[111] = const PageWidget(index: 111);
  objets[112] = const PageWidget(index: 112);
  objets[113] = const PageWidget(index: 113);
  objets[114] = const PageWidget(index: 114);
  objets[115] = const PageWidget(index: 115);
  objets[116] = const PageWidget(index: 116);
  objets[117] = const PageWidget(index: 117);
  objets[118] = const PageWidget(index: 118);
  objets[119] = const PageWidget(index: 119);
  objets[120] = const PageWidget(index: 120);
  objets[121] = const PageWidget(index: 121);
  objets[122] = const PageWidget(index: 122);
  objets[123] = const PageWidget(index: 123);
  objets[124] = const PageWidget(index: 124);
  objets[125] = const PageWidget(index: 125);
  objets[126] = const PageWidget(index: 126);
  objets[127] = const PageWidget(index: 127);
  objets[128] = const PageWidget(index: 128);
  objets[129] = const PageWidget(index: 129);
  objets[130] = const PageWidget(index: 130);
  objets[131] = const PageWidget(index: 131);
  objets[132] = const PageWidget(index: 132);
  objets[133] = const PageWidget(index: 133);
  objets[134] = const PageWidget(index: 134);
  objets[135] = const PageWidget(index: 135);
  objets[136] = const PageWidget(index: 136);
  objets[137] = const PageWidget(index: 137);
  objets[138] = const PageWidget(index: 138);
  objets[139] = const PageWidget(index: 139);
  objets[140] = const PageWidget(index: 140);
  objets[141] = const PageWidget(index: 141);
  objets[142] = const PageWidget(index: 142);
  objets[143] = const PageWidget(index: 143);
  objets[144] = const PageWidget(index: 144);
  objets[145] = const PageWidget(index: 145);
  objets[146] = const PageWidget(index: 146);
  objets[147] = const PageWidget(index: 147);
  objets[148] = const PageWidget(index: 148);
  objets[149] = const PageWidget(index: 149);
  objets[150] = const PageWidget(index: 150);
  objets[151] = const PageWidget(index: 151);
  objets[152] = const PageWidget(index: 152);
  objets[153] = const PageWidget(index: 153);
  objets[154] = const PageWidget(index: 154);
  objets[155] = const PageWidget(index: 155);
  objets[156] = const PageWidget(index: 156);
  objets[157] = const PageWidget(index: 157);
  objets[158] = const PageWidget(index: 158);
  objets[159] = const PageWidget(index: 159);
  objets[160] = const PageWidget(index: 160);
  objets[161] = const PageWidget(index: 161);
  objets[162] = const PageWidget(index: 162);
  objets[163] = const PageWidget(index: 163);
  objets[164] = const PageWidget(index: 164);
  objets[165] = const PageWidget(index: 165);
  objets[166] = const PageWidget(index: 166);
  objets[167] = const PageWidget(index: 167);
  objets[168] = const PageWidget(index: 168);
  objets[169] = const PageWidget(index: 169);
  objets[170] = const PageWidget(index: 170);
  objets[171] = const PageWidget(index: 171);
  objets[172] = const PageWidget(index: 172);
  objets[173] = const PageWidget(index: 173);
  objets[174] = const PageWidget(index: 174);
  objets[175] = const PageWidget(index: 175);
  objets[176] = const PageWidget(index: 176);
  objets[177] = const PageWidget(index: 177);
  objets[178] = const PageWidget(index: 178);
  objets[179] = const PageWidget(index: 179);
  objets[180] = const PageWidget(index: 180);
  objets[181] = const PageWidget(index: 181);
  objets[182] = const PageWidget(index: 182);
  objets[183] = const PageWidget(index: 183);
  objets[184] = const PageWidget(index: 184);
  objets[185] = const PageWidget(index: 185);
  objets[186] = const PageWidget(index: 186);
  objets[187] = const PageWidget(index: 187);
  objets[188] = const PageWidget(index: 188);
  objets[189] = const PageWidget(index: 189);
  objets[190] = const PageWidget(index: 190);
  objets[191] = const PageWidget(index: 191);
  objets[192] = const PageWidget(index: 192);
  objets[193] = const PageWidget(index: 193);
  objets[194] = const PageWidget(index: 194);
  objets[195] = const PageWidget(index: 195);
  objets[196] = const PageWidget(index: 196);
  objets[197] = const PageWidget(index: 197);
  objets[198] = const PageWidget(index: 198);
  objets[199] = const PageWidget(index: 199);

  objets[200] = const PageWidget(index: 200);
  objets[201] = const PageWidget(index: 201);
  objets[202] = const PageWidget(index: 202);
  objets[203] = const PageWidget(index: 203);
  objets[204] = const PageWidget(index: 204);
  objets[205] = const PageWidget(index: 205);
  objets[206] = const PageWidget(index: 206);
  objets[207] = const PageWidget(index: 207);
  objets[208] = const PageWidget(index: 208);
  objets[209] = const PageWidget(index: 209);
  objets[210] = const PageWidget(index: 210);
  objets[211] = const PageWidget(index: 211);
  objets[212] = const PageWidget(index: 212);
  objets[213] = const PageWidget(index: 213);
  objets[214] = const PageWidget(index: 214);
  objets[215] = const PageWidget(index: 215);
  objets[216] = const PageWidget(index: 216);
  objets[217] = const PageWidget(index: 217);
  objets[218] = const PageWidget(index: 218);
  objets[219] = const PageWidget(index: 219);
  objets[220] = const PageWidget(index: 220);
  objets[221] = const PageWidget(index: 221);
  objets[222] = const PageWidget(index: 222);
  objets[223] = const PageWidget(index: 223);
  objets[224] = const PageWidget(index: 224);
  objets[225] = const PageWidget(index: 225);
  objets[226] = const PageWidget(index: 226);
  objets[227] = const PageWidget(index: 227);
  objets[228] = const PageWidget(index: 228);
  objets[229] = const PageWidget(index: 229);
  objets[230] = const PageWidget(index: 230);
  objets[231] = const PageWidget(index: 231);
  objets[232] = const PageWidget(index: 232);
  objets[233] = const PageWidget(index: 233);
  objets[234] = const PageWidget(index: 234);
  objets[235] = const PageWidget(index: 235);
  objets[236] = const PageWidget(index: 236);
  objets[237] = const PageWidget(index: 237);
  objets[238] = const PageWidget(index: 238);
  objets[239] = const PageWidget(index: 239);
  objets[240] = const PageWidget(index: 240);
  objets[241] = const PageWidget(index: 241);
  objets[242] = const PageWidget(index: 242);
  objets[243] = const PageWidget(index: 243);
  objets[244] = const PageWidget(index: 244);
  objets[245] = const PageWidget(index: 245);
  objets[246] = const PageWidget(index: 246);
  objets[247] = const PageWidget(index: 247);
  objets[248] = const PageWidget(index: 248);
  objets[249] = const PageWidget(index: 249);
  objets[250] = const PageWidget(index: 250);
  objets[251] = const PageWidget(index: 251);
  objets[252] = const PageWidget(index: 252);
  objets[253] = const PageWidget(index: 253);
  objets[254] = const PageWidget(index: 254);
  objets[255] = const PageWidget(index: 255);
  objets[256] = const PageWidget(index: 256);
  objets[257] = const PageWidget(index: 257);
  objets[258] = const PageWidget(index: 258);
  objets[259] = const PageWidget(index: 259);
  objets[260] = const PageWidget(index: 260);
  objets[261] = const PageWidget(index: 261);
  objets[262] = const PageWidget(index: 262);
  objets[263] = const PageWidget(index: 263);
  objets[264] = const PageWidget(index: 264);
  objets[265] = const PageWidget(index: 265);
  objets[266] = const PageWidget(index: 266);
  objets[267] = const PageWidget(index: 267);
  objets[268] = const PageWidget(index: 268);
  objets[269] = const PageWidget(index: 269);
  objets[270] = const PageWidget(index: 270);
  objets[271] = const PageWidget(index: 271);
  objets[272] = const PageWidget(index: 272);
  objets[273] = const PageWidget(index: 273);
  objets[274] = const PageWidget(index: 274);
  objets[275] = const PageWidget(index: 275);
  objets[276] = const PageWidget(index: 276);
  objets[277] = const PageWidget(index: 277);
  objets[278] = const PageWidget(index: 278);
  objets[279] = const PageWidget(index: 279);
  objets[280] = const PageWidget(index: 280);
  objets[281] = const PageWidget(index: 281);
  objets[282] = const PageWidget(index: 282);
  objets[283] = const PageWidget(index: 283);
  objets[284] = const PageWidget(index: 284);
  objets[285] = const PageWidget(index: 285);
  objets[286] = const PageWidget(index: 286);
  objets[287] = const PageWidget(index: 287);
  objets[288] = const PageWidget(index: 288);
  objets[289] = const PageWidget(index: 289);
  objets[290] = const PageWidget(index: 290);
  objets[291] = const PageWidget(index: 291);
  objets[292] = const PageWidget(index: 292);
  objets[293] = const PageWidget(index: 293);
  objets[294] = const PageWidget(index: 294);
  objets[295] = const PageWidget(index: 295);
  objets[296] = const PageWidget(index: 296);
  objets[297] = const PageWidget(index: 297);
  objets[298] = const PageWidget(index: 298);
  objets[299] = const PageWidget(index: 299);

  objets[300] = const PageWidget(index: 300);
  objets[301] = const PageWidget(index: 301);
  objets[302] = const PageWidget(index: 302);
  objets[303] = const PageWidget(index: 303);
  objets[304] = const PageWidget(index: 304);
  objets[305] = const PageWidget(index: 305);
  objets[306] = const PageWidget(index: 306);
  objets[307] = const PageWidget(index: 307);
  objets[308] = const PageWidget(index: 308);
  objets[309] = const PageWidget(index: 309);
  objets[310] = const PageWidget(index: 310);
  objets[311] = const PageWidget(index: 311);
  objets[312] = const PageWidget(index: 312);
  objets[313] = const PageWidget(index: 313);
  objets[314] = const PageWidget(index: 314);
  objets[315] = const PageWidget(index: 315);
  objets[316] = const PageWidget(index: 316);
  objets[317] = const PageWidget(index: 317);
  objets[318] = const PageWidget(index: 318);
  objets[319] = const PageWidget(index: 319);
  objets[320] = const PageWidget(index: 320);
  objets[321] = const PageWidget(index: 321);
  objets[322] = const PageWidget(index: 322);
  objets[323] = const PageWidget(index: 323);
  objets[324] = const PageWidget(index: 324);
  objets[325] = const PageWidget(index: 325);
  objets[326] = const PageWidget(index: 326);
  objets[327] = const PageWidget(index: 327);
  objets[328] = const PageWidget(index: 328);
  objets[329] = const PageWidget(index: 329);
  objets[330] = const PageWidget(index: 330);
  objets[331] = const PageWidget(index: 331);
  objets[332] = const PageWidget(index: 332);
  objets[333] = const PageWidget(index: 333);
  objets[334] = const PageWidget(index: 334);
  objets[335] = const PageWidget(index: 335);
  objets[336] = const PageWidget(index: 336);
  objets[337] = const PageWidget(index: 337);
  objets[338] = const PageWidget(index: 338);
  objets[339] = const PageWidget(index: 339);
  objets[340] = const PageWidget(index: 340);
  objets[341] = const PageWidget(index: 341);
  objets[342] = const PageWidget(index: 342);
  objets[343] = const PageWidget(index: 343);
  objets[344] = const PageWidget(index: 344);
  objets[345] = const PageWidget(index: 345);
  objets[346] = const PageWidget(index: 346);
  objets[347] = const PageWidget(index: 347);
  objets[348] = const PageWidget(index: 348);
  objets[349] = const PageWidget(index: 349);
  objets[350] = const PageWidget(index: 350);
  objets[351] = const PageWidget(index: 351);
  objets[352] = const PageWidget(index: 352);
  objets[353] = const PageWidget(index: 353);
  objets[354] = const PageWidget(index: 354);
  objets[355] = const PageWidget(index: 355);
  objets[356] = const PageWidget(index: 356);
  objets[357] = const PageWidget(index: 357);
  objets[358] = const PageWidget(index: 358);
  objets[359] = const PageWidget(index: 359);
  objets[360] = const PageWidget(index: 360);
  objets[361] = const PageWidget(index: 361);
  objets[362] = const PageWidget(index: 362);
  objets[363] = const PageWidget(index: 363);
  objets[364] = const PageWidget(index: 364);
  objets[365] = const PageWidget(index: 365);
  objets[366] = const PageWidget(index: 366);
  objets[367] = const PageWidget(index: 367);
  objets[368] = const PageWidget(index: 368);
  objets[369] = const PageWidget(index: 369);
  objets[370] = const PageWidget(index: 370);
  objets[371] = const PageWidget(index: 371);
  objets[372] = const PageWidget(index: 372);
  objets[373] = const PageWidget(index: 373);
  objets[374] = const PageWidget(index: 374);
  objets[375] = const PageWidget(index: 375);
  objets[376] = const PageWidget(index: 376);
  objets[377] = const PageWidget(index: 377);
  objets[378] = const PageWidget(index: 378);
  objets[379] = const PageWidget(index: 379);
  objets[380] = const PageWidget(index: 380);
  objets[381] = const PageWidget(index: 381);
  objets[382] = const PageWidget(index: 382);
  objets[383] = const PageWidget(index: 383);
  objets[384] = const PageWidget(index: 384);
  objets[385] = const PageWidget(index: 385);
  objets[386] = const PageWidget(index: 386);
  objets[387] = const PageWidget(index: 387);
  objets[388] = const PageWidget(index: 388);
  objets[389] = const PageWidget(index: 389);
  objets[390] = const PageWidget(index: 390);
  objets[391] = const PageWidget(index: 391);
  objets[392] = const PageWidget(index: 392);
  objets[393] = const PageWidget(index: 393);
  objets[394] = const PageWidget(index: 394);
  objets[395] = const PageWidget(index: 395);
  objets[396] = const PageWidget(index: 396);
  objets[397] = const PageWidget(index: 397);
  objets[398] = const PageWidget(index: 398);
  objets[399] = const PageWidget(index: 399);

  objets[400] = const PageWidget(index: 400);
  objets[401] = const PageWidget(index: 401);
  objets[402] = const PageWidget(index: 402);
  objets[403] = const PageWidget(index: 403);
  objets[404] = const PageWidget(index: 404);
  objets[405] = const PageWidget(index: 405);
  objets[406] = const PageWidget(index: 406);
  objets[407] = const PageWidget(index: 407);
  objets[408] = const PageWidget(index: 408);
  objets[409] = const PageWidget(index: 409);
  objets[410] = const PageWidget(index: 410);
  objets[411] = const PageWidget(index: 411);
  objets[412] = const PageWidget(index: 412);
  objets[413] = const PageWidget(index: 413);
  objets[414] = const PageWidget(index: 414);
  objets[415] = const PageWidget(index: 415);
  objets[416] = const PageWidget(index: 416);
  objets[417] = const PageWidget(index: 417);
  objets[418] = const PageWidget(index: 418);
  objets[419] = const PageWidget(index: 419);
  objets[420] = const PageWidget(index: 420);
  objets[421] = const PageWidget(index: 421);
  objets[422] = const PageWidget(index: 422);
  objets[423] = const PageWidget(index: 423);
  objets[424] = const PageWidget(index: 424);
  objets[425] = const PageWidget(index: 425);
  objets[426] = const PageWidget(index: 426);
  objets[427] = const PageWidget(index: 427);
  objets[428] = const PageWidget(index: 428);
  objets[429] = const PageWidget(index: 429);
  objets[430] = const PageWidget(index: 430);
  objets[431] = const PageWidget(index: 431);
  objets[432] = const PageWidget(index: 432);
  objets[433] = const PageWidget(index: 433);
  objets[434] = const PageWidget(index: 434);
  objets[435] = const PageWidget(index: 435);
  objets[436] = const PageWidget(index: 436);
  objets[437] = const PageWidget(index: 437);
  objets[438] = const PageWidget(index: 438);
  objets[439] = const PageWidget(index: 439);
  objets[440] = const PageWidget(index: 440);
  objets[441] = const PageWidget(index: 441);
  objets[442] = const PageWidget(index: 442);
  objets[443] = const PageWidget(index: 443);
  objets[444] = const PageWidget(index: 444);
  objets[445] = const PageWidget(index: 445);
  objets[446] = const PageWidget(index: 446);
  objets[447] = const PageWidget(index: 447);
  objets[448] = const PageWidget(index: 448);
  objets[449] = const PageWidget(index: 449);
  objets[450] = const PageWidget(index: 450);
  objets[451] = const PageWidget(index: 451);
  objets[452] = const PageWidget(index: 452);
  objets[453] = const PageWidget(index: 453);
  objets[454] = const PageWidget(index: 454);
  objets[455] = const PageWidget(index: 455);
  objets[456] = const PageWidget(index: 456);
  objets[457] = const PageWidget(index: 457);
  objets[458] = const PageWidget(index: 458);
  objets[459] = const PageWidget(index: 459);
  objets[460] = const PageWidget(index: 460);
  objets[461] = const PageWidget(index: 461);
  objets[462] = const PageWidget(index: 462);
  objets[463] = const PageWidget(index: 463);
  objets[464] = const PageWidget(index: 464);
  objets[465] = const PageWidget(index: 465);
  objets[466] = const PageWidget(index: 466);
  objets[467] = const PageWidget(index: 467);
  objets[468] = const PageWidget(index: 468);
  objets[469] = const PageWidget(index: 469);
  objets[470] = const PageWidget(index: 470);
  objets[471] = const PageWidget(index: 471);
  objets[472] = const PageWidget(index: 472);
  objets[473] = const PageWidget(index: 473);
  objets[474] = const PageWidget(index: 474);
  objets[475] = const PageWidget(index: 475);
  objets[476] = const PageWidget(index: 476);
  objets[477] = const PageWidget(index: 477);
  objets[478] = const PageWidget(index: 478);
  objets[479] = const PageWidget(index: 479);
  objets[480] = const PageWidget(index: 480);
  objets[481] = const PageWidget(index: 481);
  objets[482] = const PageWidget(index: 482);
  objets[483] = const PageWidget(index: 483);
  objets[484] = const PageWidget(index: 484);
  objets[485] = const PageWidget(index: 485);
  objets[486] = const PageWidget(index: 486);
  objets[487] = const PageWidget(index: 487);
  objets[488] = const PageWidget(index: 488);
  objets[489] = const PageWidget(index: 489);
  objets[490] = const PageWidget(index: 490);
  objets[491] = const PageWidget(index: 491);
  objets[492] = const PageWidget(index: 492);
  objets[493] = const PageWidget(index: 493);
  objets[494] = const PageWidget(index: 494);
  objets[495] = const PageWidget(index: 495);
  objets[496] = const PageWidget(index: 496);
  objets[497] = const PageWidget(index: 497);
  objets[498] = const PageWidget(index: 498);
  objets[499] = const PageWidget(index: 499);

  objets[500] = const PageWidget(index: 500);
  objets[501] = const PageWidget(index: 501);
  objets[502] = const PageWidget(index: 502);
  objets[503] = const PageWidget(index: 503);
  objets[504] = const PageWidget(index: 504);
  objets[505] = const PageWidget(index: 505);
  objets[506] = const PageWidget(index: 506);
  objets[507] = const PageWidget(index: 507);
  objets[508] = const PageWidget(index: 508);
  objets[509] = const PageWidget(index: 509);
  objets[510] = const PageWidget(index: 510);
  objets[511] = const PageWidget(index: 511);
  objets[512] = const PageWidget(index: 512);
  objets[513] = const PageWidget(index: 513);
  objets[514] = const PageWidget(index: 514);
  objets[515] = const PageWidget(index: 515);
  objets[516] = const PageWidget(index: 516);
  objets[517] = const PageWidget(index: 517);
  objets[518] = const PageWidget(index: 518);
  objets[519] = const PageWidget(index: 519);
  objets[520] = const PageWidget(index: 520);
  objets[521] = const PageWidget(index: 521);
  objets[522] = const PageWidget(index: 522);
  objets[523] = const PageWidget(index: 523);
  objets[524] = const PageWidget(index: 524);
  objets[525] = const PageWidget(index: 525);
  objets[526] = const PageWidget(index: 526);
  objets[527] = const PageWidget(index: 527);
  objets[528] = const PageWidget(index: 528);
  objets[529] = const PageWidget(index: 529);
  objets[530] = const PageWidget(index: 530);
  objets[531] = const PageWidget(index: 531);
  objets[532] = const PageWidget(index: 532);
  objets[533] = const PageWidget(index: 533);
  objets[534] = const PageWidget(index: 534);
  objets[535] = const PageWidget(index: 535);
  objets[536] = const PageWidget(index: 536);
  objets[537] = const PageWidget(index: 537);
  objets[538] = const PageWidget(index: 538);
  objets[539] = const PageWidget(index: 539);
  objets[540] = const PageWidget(index: 540);
  objets[541] = const PageWidget(index: 541);
  objets[542] = const PageWidget(index: 542);
  objets[543] = const PageWidget(index: 543);
  objets[544] = const PageWidget(index: 544);
  objets[545] = const PageWidget(index: 545);
  objets[546] = const PageWidget(index: 546);
  objets[547] = const PageWidget(index: 547);
  objets[548] = const PageWidget(index: 548);
  objets[549] = const PageWidget(index: 549);
  objets[550] = const PageWidget(index: 550);
  objets[551] = const PageWidget(index: 551);
  objets[552] = const PageWidget(index: 552);
  objets[553] = const PageWidget(index: 553);
  objets[554] = const PageWidget(index: 554);
  objets[555] = const PageWidget(index: 555);
  objets[556] = const PageWidget(index: 556);
  objets[557] = const PageWidget(index: 557);
  objets[558] = const PageWidget(index: 558);
  objets[559] = const PageWidget(index: 559);
  objets[560] = const PageWidget(index: 560);
  objets[561] = const PageWidget(index: 561);
  objets[562] = const PageWidget(index: 562);
  objets[563] = const PageWidget(index: 563);
  objets[564] = const PageWidget(index: 564);
  objets[565] = const PageWidget(index: 565);
  objets[566] = const PageWidget(index: 566);
  objets[567] = const PageWidget(index: 567);
  objets[568] = const PageWidget(index: 568);
  objets[569] = const PageWidget(index: 569);
  objets[570] = const PageWidget(index: 570);
  objets[571] = const PageWidget(index: 571);
  objets[572] = const PageWidget(index: 572);
  objets[573] = const PageWidget(index: 573);
  objets[574] = const PageWidget(index: 574);
  objets[575] = const PageWidget(index: 575);
  objets[576] = const PageWidget(index: 576);
  objets[577] = const PageWidget(index: 577);
  objets[578] = const PageWidget(index: 578);
  objets[579] = const PageWidget(index: 579);
  objets[580] = const PageWidget(index: 580);
  objets[581] = const PageWidget(index: 581);
  objets[582] = const PageWidget(index: 582);
  objets[583] = const PageWidget(index: 583);
  objets[584] = const PageWidget(index: 584);
  objets[585] = const PageWidget(index: 585);
  objets[586] = const PageWidget(index: 586);
  objets[587] = const PageWidget(index: 587);
  objets[588] = const PageWidget(index: 588);
  objets[589] = const PageWidget(index: 589);
  objets[590] = const PageWidget(index: 590);
  objets[591] = const PageWidget(index: 591);
  objets[592] = const PageWidget(index: 592);
  objets[593] = const PageWidget(index: 593);
  objets[594] = const PageWidget(index: 594);
  objets[595] = const PageWidget(index: 595);
  objets[596] = const PageWidget(index: 596);
  objets[597] = const PageWidget(index: 597);
  objets[598] = const PageWidget(index: 598);
  objets[599] = const PageWidget(index: 599);

  objets[600] = const PageWidget(index: 600);
  objets[601] = const PageWidget(index: 601);
  objets[602] = const PageWidget(index: 602);
  objets[603] = const PageWidget(index: 603);
  return objets[index];
});

final hideWidgetAfterScrollProvider = ChangeNotifierProvider.autoDispose(
  (ref) => HideWidgetAfterScrollNotifier(),
);

class HideWidgetAfterScrollNotifier extends ChangeNotifier {
  bool _isVisible = true;
  Timer? _timer;

  bool get isVisible => _isVisible;

  void showAndHide(Duration duration) {
    _isVisible = true;
    _timer?.cancel();
    _timer = Timer(duration, () {
      _isVisible = false;
      notifyListeners();
    });
    notifyListeners();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}

final itemScrollControllerProvider = Provider<ItemScrollController>((ref) {
  final ItemScrollController itemScrollController = ItemScrollController();
  return itemScrollController;
});
