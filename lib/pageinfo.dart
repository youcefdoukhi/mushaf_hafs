import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:screen_brightness/screen_brightness.dart';

import 'toc.dart';
import 'content.dart';
import 'num_pad.dart';

class MyPageInfo extends StatelessWidget {
  const MyPageInfo({
    Key? key,
    required this.displaySaveBookmarkDialog,
    required this.goToSavedBookmark,
    required this.pageNum,
  }) : super(key: key);

  final Function displaySaveBookmarkDialog;
  final Function goToSavedBookmark;
  final int pageNum;

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

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Stack(
          children: [
            Container(
              margin: const EdgeInsets.all(10),
              height: 44,
              width: double.infinity,
              decoration: BoxDecoration(
                color: const Color.fromARGB(220, 54, 56, 89),
                border: Border.all(
                  color: const Color.fromARGB(255, 212, 180, 124),
                  width: 0.5,
                ),
                borderRadius: BorderRadius.circular(5),
              ),
              child: Center(
                child: Text(
                  "${pageNum + 1}",
                  textDirection: TextDirection.rtl,
                  textAlign: TextAlign.justify,
                  style: const TextStyle(
                    color: Colors.white,
                    fontFamily: fontText,
                  ),
                ),
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
                    stream: ScreenBrightness().onCurrentBrightnessChanged,
                    builder: (context, snapshot) {
                      double changedBrightness = currentBrightness;
                      if (snapshot.hasData) {
                        changedBrightness = snapshot.data!;
                      }

                      return SliderTheme(
                        data: SliderTheme.of(context).copyWith(
                          trackHeight: 40.0,
                          trackShape: CustomTrackShape(),
                          activeTrackColor:
                              const Color.fromARGB(179, 54, 56, 89),
                          inactiveTrackColor: Colors.transparent,
                          thumbShape: const RoundSliderThumbShape(
                            enabledThumbRadius: 0.0,
                            pressedElevation: 0.0,
                          ),
                          thumbColor: Colors.transparent,
                          overlayColor: Colors.transparent,
                          overlayShape: const RoundSliderOverlayShape(
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
                                  color: Color.fromARGB(255, 212, 180, 124),
                                ),
                              ),
                            ),
                            child: InkWell(
                              onTap: () {}, // button pressed
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const <Widget>[
                                  Icon(
                                    Icons.search_outlined,
                                    color: Color.fromARGB(255, 212, 180, 124),
                                  ),
                                  Text(
                                    "بحث",
                                    textDirection: TextDirection.rtl,
                                    textAlign: TextAlign.justify,
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
                                  color: Color.fromARGB(255, 212, 180, 124),
                                ),
                                right: BorderSide(
                                  width: 0.5,
                                  color: Color.fromARGB(255, 212, 180, 124),
                                ),
                              ),
                            ),
                            child: InkWell(
                              onTap: () {
                                displaySaveBookmarkDialog(context);
                              }, // button pressed
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const <Widget>[
                                  Icon(
                                    Icons.bookmark_add_outlined,
                                    color: Color.fromARGB(255, 212, 180, 124),
                                  ),
                                  Text(
                                    "حفظ العلامة",
                                    textDirection: TextDirection.rtl,
                                    textAlign: TextAlign.justify,
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
                                  color: Color.fromARGB(255, 212, 180, 124),
                                ),
                                right: BorderSide(
                                  width: 0.5,
                                  color: Color.fromARGB(255, 212, 180, 124),
                                ),
                              ),
                            ),
                            child: InkWell(
                              // splash color
                              onTap: () {
                                goToSavedBookmark();
                              }, // button pressed
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const <Widget>[
                                  Icon(
                                    Icons.book_outlined,
                                    color: Color.fromARGB(255, 212, 180, 124),
                                  ),
                                  Text(
                                    "إلى العلامة",
                                    textDirection: TextDirection.rtl,
                                    textAlign: TextAlign.justify,
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
                                  color: Color.fromARGB(255, 212, 180, 124),
                                ),
                                right: BorderSide(
                                  width: 0.5,
                                  color: Color.fromARGB(255, 212, 180, 124),
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
                                  color: Color.fromARGB(255, 212, 180, 124),
                                ),
                                right: BorderSide(
                                  width: 0.5,
                                  color: Color.fromARGB(255, 212, 180, 124),
                                ),
                              ),
                            ),
                            child: InkWell(
                              onTap: () {
                                showModalBottomSheet(
                                  elevation: 10,
                                  barrierColor: Colors.transparent,
                                  backgroundColor: Colors.transparent,
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
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const <Widget>[
                                  Icon(
                                    Icons.switch_access_shortcut_outlined,
                                    color: Color.fromARGB(255, 212, 180, 124),
                                  ),
                                  Text(
                                    "إلى الصفحة",
                                    textDirection: TextDirection.rtl,
                                    textAlign: TextAlign.justify,
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
    );
  }
}

class MyTocBottomSheet extends StatelessWidget {
  const MyTocBottomSheet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Scaffold.of(context).showBottomSheet<void>(
          (BuildContext context) {
            return Container(
              padding: EdgeInsets.only(
                top: window.viewPadding.top / window.devicePixelRatio,
              ),
              child: const TOCWidget(),
            );
          },
        );
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const <Widget>[
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
