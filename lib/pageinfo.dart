import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:screen_brightness/screen_brightness.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'data.dart';
import 'toc.dart';

import 'num_pad.dart';

const fontText = "ScheherazadeNew";
const fontTitre = "Lateef";
const fontTitle = "ScheherazadeNew";

class MyPageInfo extends ConsumerWidget {
  const MyPageInfo({
    Key? key,
  }) : super(key: key);

  Future<void> setBrightness(double brightness) async {
    try {
      await ScreenBrightness().setScreenBrightness(brightness);
    } catch (e) {
      debugPrint(e.toString());
      throw 'Failed to set brightness';
    }
  }

  Future<void> resetBrightness() async {
    try {
      await ScreenBrightness().resetScreenBrightness();
    } catch (e) {
      debugPrint(e.toString());
      throw 'Failed to reset brightness';
    }
  }

  Future<void> _saveBookmark(ref) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setInt('mushaf01_bookmark', ref.read(pageIndexProvider));
    ref.read(savedBookmarkProvider.notifier).state =
        ref.read(pageIndexProvider);
    ref.read(showPageInfoProvider.notifier).state = false;
  }

  displaySaveBookmarkDialog(BuildContext context, WidgetRef ref) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: const Text("حفظ المرجعية؟"),
            actions: <Widget>[
              TextButton(
                style: TextButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: const Color.fromRGBO(233, 218, 193, 1),
                ),
                child: const Text(
                  'إلغاء',
                  style: TextStyle(
                    fontFamily: fontText,
                    fontSize: 14,
                  ),
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              TextButton(
                style: TextButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: const Color.fromRGBO(84, 186, 185, 1),
                ),
                child: const Text(
                  'حفظ',
                  style: TextStyle(
                    fontFamily: fontText,
                    fontSize: 14,
                  ),
                ),
                onPressed: () {
                  _saveBookmark(ref);
                  Navigator.pop(context);
                },
              ),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    int page = ref.watch(pageIndexProvider);
    Future(() {
      ref
          .read(hideWidgetAfterScrollProvider)
          .showAndHide(const Duration(milliseconds: 1300));
    });

    String getSurahFromPage(int page) {
      final listChaperts = ref.read(chaptersProvider).value!;
      String surah = "";
      for (var i = 1; i < 114; i++) {
        Chapters currentChapter = listChaperts[i - 1];
        Chapters nextChapter = listChaperts[i];

        if (page < nextChapter.start || (page == currentChapter.start)) {
          surah = currentChapter.name;
          break;
        }
      }
      return surah;
    }

    goToSavedBookmark() {
      MediaQuery.of(context).orientation == Orientation.portrait
          ? {
              ref.read(scrollOrNotProvider.notifier).state = false,
              ref.read(pageIndexProvider.notifier).state =
                  ref.read(savedBookmarkProvider),
              ref.read(showPageInfoProvider.notifier).state = false,
            }
          : {
              ref.read(pageIndexProvider.notifier).state =
                  ref.read(savedBookmarkProvider),
              ref.read(showPageInfoProvider.notifier).state = false,
              ref.read(itemScrollControllerProvider).jumpTo(
                    index: ref.read(savedBookmarkProvider),
                  ),
            };
    }

    return Stack(
      children: <Widget>[
        Visibility(
          visible: ref.watch(showPageInfoProvider),
          child: OrientationBuilder(
            builder: (context, orientation) {
              //return orientation == Orientation.portrait
              return 1 == 1
                  ? Column(
                      children: <Widget>[
                        Stack(
                          children: [
                            Container(
                              margin: const EdgeInsets.all(10),
                              padding:
                                  const EdgeInsets.only(left: 10, right: 10),
                              height: 44,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: const Color.fromARGB(220, 54, 56, 89),
                                border: Border.all(
                                  color:
                                      const Color.fromARGB(255, 212, 180, 124),
                                  width: 0.5,
                                ),
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: Row(
                                children: [
                                  Expanded(
                                    flex: 4,
                                    child: Align(
                                      alignment: Alignment.centerRight,
                                      child: Text(
                                        "الجزء ${ref.read(rubProvider).value![page].juz}",
                                        textDirection: TextDirection.rtl,
                                        textAlign: TextAlign.justify,
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontFamily: fontText,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 2,
                                    child: Center(
                                      child: Text(
                                        "${page + 1}",
                                        textDirection: TextDirection.rtl,
                                        textAlign: TextAlign.justify,
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontFamily: fontText,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 4,
                                    child: Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        getSurahFromPage(page + 1),
                                        textDirection: TextDirection.rtl,
                                        textAlign: TextAlign.justify,
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontFamily: fontText,
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.only(
                                left: 12,
                                right: 12,
                              ),
                              child: FutureBuilder<double>(
                                future: ScreenBrightness().current,
                                builder: (context, snapshot) {
                                  double currentBrightness = 0;
                                  if (snapshot.hasData) {
                                    currentBrightness = snapshot.data!;
                                  }

                                  return StreamBuilder<double>(
                                    stream: ScreenBrightness()
                                        .onCurrentBrightnessChanged,
                                    builder: (context, snapshot) {
                                      double changedBrightness =
                                          currentBrightness;
                                      if (snapshot.hasData) {
                                        changedBrightness = snapshot.data!;
                                      }

                                      return SliderTheme(
                                        data: SliderTheme.of(context).copyWith(
                                          trackHeight: 40.0,
                                          trackShape: CustomTrackShape(),
                                          activeTrackColor:
                                              const Color.fromARGB(
                                                  179, 54, 56, 89),
                                          inactiveTrackColor:
                                              Colors.transparent,
                                          thumbShape:
                                              const RoundSliderThumbShape(
                                            enabledThumbRadius: 0.0,
                                            pressedElevation: 0.0,
                                          ),
                                          thumbColor: Colors.transparent,
                                          overlayColor: Colors.transparent,
                                          overlayShape:
                                              const RoundSliderOverlayShape(
                                                  overlayRadius: 32.0),
                                        ),
                                        child: Slider.adaptive(
                                          value: changedBrightness,
                                          onChanged: (value) {
                                            setBrightness(value);
                                          },
                                        ),

                                        /*ElevatedButton(
                      onPressed: () {
                        resetBrightness();
                      },
                      child: const Text('reset brightness'),
                    ),*/
                                      );
                                    },
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                        Expanded(
                          child: Container(),
                        ),
                        Container(
                          height: 70,
                          width: double.infinity,
                          decoration: const BoxDecoration(
                            color: Color.fromARGB(220, 54, 56, 89),
                          ),
                          child: Column(
                            children: [
                              Flexible(
                                child: FractionallySizedBox(
                                  widthFactor: 1,
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Flexible(
                                        child: FractionallySizedBox(
                                          widthFactor: 1,
                                          child: Container(
                                            decoration: const BoxDecoration(
                                              border: Border(
                                                top: BorderSide(
                                                  width: 0.5,
                                                  color: Color.fromARGB(
                                                      255, 212, 180, 124),
                                                ),
                                              ),
                                            ),
                                            child: InkWell(
                                              onTap: () {},
                                              child: const Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: <Widget>[
                                                  Icon(
                                                    Icons.search_outlined,
                                                    color: Color.fromARGB(
                                                        255, 212, 180, 124),
                                                  ),
                                                  Text(
                                                    "بحث",
                                                    textDirection:
                                                        TextDirection.rtl,
                                                    textAlign:
                                                        TextAlign.justify,
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontFamily: fontTitre,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Flexible(
                                        child: FractionallySizedBox(
                                          widthFactor: 1,
                                          child: Container(
                                            decoration: const BoxDecoration(
                                              border: Border(
                                                top: BorderSide(
                                                  width: 0.5,
                                                  color: Color.fromARGB(
                                                      255, 212, 180, 124),
                                                ),
                                                right: BorderSide(
                                                  width: 0.5,
                                                  color: Color.fromARGB(
                                                      255, 212, 180, 124),
                                                ),
                                              ),
                                            ),
                                            child: InkWell(
                                              onTap: () {
                                                displaySaveBookmarkDialog(
                                                    context, ref);
                                              }, // button pressed
                                              child: const Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: <Widget>[
                                                  Icon(
                                                    Icons.bookmark_add_outlined,
                                                    color: Color.fromARGB(
                                                        255, 212, 180, 124),
                                                  ),
                                                  Text(
                                                    "حفظ العلامة",
                                                    textDirection:
                                                        TextDirection.rtl,
                                                    textAlign:
                                                        TextAlign.justify,
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontFamily: fontTitre,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Flexible(
                                        child: FractionallySizedBox(
                                          widthFactor: 1,
                                          child: Container(
                                            decoration: const BoxDecoration(
                                              border: Border(
                                                top: BorderSide(
                                                  width: 0.5,
                                                  color: Color.fromARGB(
                                                      255, 212, 180, 124),
                                                ),
                                                right: BorderSide(
                                                  width: 0.5,
                                                  color: Color.fromARGB(
                                                      255, 212, 180, 124),
                                                ),
                                              ),
                                            ),
                                            child: InkWell(
                                              onTap: () {
                                                goToSavedBookmark();
                                              },
                                              child: const Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: <Widget>[
                                                  Icon(
                                                    Icons.book_outlined,
                                                    color: Color.fromARGB(
                                                        255, 212, 180, 124),
                                                  ),
                                                  Text(
                                                    "إلى العلامة",
                                                    textDirection:
                                                        TextDirection.rtl,
                                                    textAlign:
                                                        TextAlign.justify,
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontFamily: fontTitre,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Flexible(
                                        child: FractionallySizedBox(
                                          widthFactor: 1,
                                          child: Container(
                                            decoration: const BoxDecoration(
                                              border: Border(
                                                top: BorderSide(
                                                  width: 0.5,
                                                  color: Color.fromARGB(
                                                      255, 212, 180, 124),
                                                ),
                                                right: BorderSide(
                                                  width: 0.5,
                                                  color: Color.fromARGB(
                                                      255, 212, 180, 124),
                                                ),
                                              ),
                                            ),
                                            child: const MyTocBottomSheet(),
                                          ),
                                        ),
                                      ),
                                      Flexible(
                                        child: FractionallySizedBox(
                                          widthFactor: 1,
                                          child: Container(
                                            decoration: const BoxDecoration(
                                              border: Border(
                                                top: BorderSide(
                                                  width: 0.5,
                                                  color: Color.fromARGB(
                                                      255, 212, 180, 124),
                                                ),
                                                right: BorderSide(
                                                  width: 0.5,
                                                  color: Color.fromARGB(
                                                      255, 212, 180, 124),
                                                ),
                                              ),
                                            ),
                                            child: InkWell(
                                              onTap: () {
                                                showModalBottomSheet(
                                                  elevation: 10,
                                                  barrierColor:
                                                      Colors.transparent,
                                                  backgroundColor:
                                                      Colors.transparent,
                                                  context: context,
                                                  enableDrag: true,
                                                  builder: (ctx) => Container(
                                                    width: double.infinity,
                                                    height: double.infinity,
                                                    color: Colors.transparent,
                                                    alignment: Alignment.center,
                                                    child: MyNumPad(),
                                                  ),
                                                );
                                              },
                                              child: const Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: <Widget>[
                                                  Icon(
                                                    Icons
                                                        .switch_access_shortcut_outlined,
                                                    color: Color.fromARGB(
                                                        255, 212, 180, 124),
                                                  ),
                                                  Text(
                                                    "إلى الصفحة",
                                                    textDirection:
                                                        TextDirection.rtl,
                                                    textAlign:
                                                        TextAlign.justify,
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontFamily: fontTitre,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    )
                  : Container();
            },
          ),
        ),
        Visibility(
          visible: (ref.read(rubProvider).value![page].pageInfo != "-") &&
              ref.watch(showPageInfoProvider),
          child: Center(
            child: Container(
              decoration: BoxDecoration(
                color: const Color.fromARGB(220, 54, 56, 89),
                borderRadius: BorderRadius.circular(5),
              ),
              padding: const EdgeInsets.all(10),
              child: Text(
                textAlign: TextAlign.center,
                ref
                    .read(rubProvider)
                    .value![ref.watch(pageIndexProvider)]
                    .pageInfo,
                style: const TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
        (ref.read(showPageInfoProvider) == false) &&
                (ref.read(rubProvider).value![page].pageInfo != "-")
            ? const MonWidgetMasque()
            : Container(),
      ],
    );
  }
}

class MyTocBottomSheet extends StatelessWidget {
  const MyTocBottomSheet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        /*
        Scaffold.of(context).showBottomSheet<void>(
          (BuildContext context) {
            return Container(
              padding: EdgeInsets.only(
                top: window.viewPadding.top / window.devicePixelRatio,
              ),
              child: const TOCWidget(),
            );
          },
        );*/

        showModalBottomSheet(
          isScrollControlled: true,
          context: context,
          enableDrag: true,
          builder: (ctx) => const TOCWidget(),
        );
      },
      child: const Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(
            Icons.menu_book_outlined,
            color: Color.fromARGB(255, 212, 180, 124),
          ),
          Text(
            "الفهرس",
            textDirection: TextDirection.rtl,
            textAlign: TextAlign.justify,
            style: TextStyle(
              color: Colors.white,
              fontFamily: fontTitre,
            ),
          ),
        ],
      ),
    );
  }
}

class CustomTrackShape extends RectangularSliderTrackShape {
  @override
  Rect getPreferredRect({
    required RenderBox parentBox,
    Offset offset = Offset.zero,
    required SliderThemeData sliderTheme,
    bool isEnabled = false,
    bool isDiscrete = false,
  }) {
    final trackHeight = sliderTheme.trackHeight;
    final trackLeft = offset.dx;
    final trackTop = offset.dy + (parentBox.size.height - trackHeight!) / 2;
    final trackWidth = parentBox.size.width;
    return Rect.fromLTWH(trackLeft, trackTop, trackWidth, trackHeight);
  }
}

class MonWidgetMasque extends ConsumerWidget {
  const MonWidgetMasque({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final hideNotifier = ref.watch(hideWidgetAfterScrollProvider);
    return Visibility(
      visible: hideNotifier.isVisible,
      child: Center(
        child: Container(
          decoration: BoxDecoration(
            color: const Color.fromARGB(220, 54, 56, 89),
            borderRadius: BorderRadius.circular(5),
          ),
          padding: const EdgeInsets.all(10),
          child: Text(
            textAlign: TextAlign.center,
            ref.read(rubProvider).value![ref.watch(pageIndexProvider)].pageInfo,
            style: const TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
