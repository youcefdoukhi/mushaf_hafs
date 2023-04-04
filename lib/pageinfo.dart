import 'dart:ui';
import 'package:flutter/material.dart';

import 'toc.dart';
import 'bookmarks.dart';
import 'content.dart';
import 'num_pad.dart';

class MyPageInfo extends StatelessWidget {
  const MyPageInfo({
    Key? key,
    //required this.saveMarksList,
    required this.displaySaveBookmarkDialog,
    required this.pageNum,
    required this.nbrOfPages,
  }) : super(key: key);

  final Function displaySaveBookmarkDialog;
  final int pageNum;
  final int nbrOfPages;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          margin: const EdgeInsets.all(10),
          height: 40,
          width: double.infinity,
          decoration: BoxDecoration(
            color: const Color.fromARGB(220, 54, 56, 89),
            border: Border.all(
              color: const Color.fromARGB(255, 54, 56, 89),
              width: 0.4,
            ),
            borderRadius: BorderRadius.circular(5),
          ),
          child: Center(
            child: Text(
              "الصفحة : $nbrOfPages/${pageNum + 1}",
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
          child: Container(),
        ),
        Container(
          height: 140,
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
                              onTap: () {
                                /*
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const MainWidget()),
                                );*/
                              }, // button pressed
                              child: Column(
                                //mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const <Widget>[
                                  Icon(
                                    //size: 20,
                                    Icons.home_outlined,
                                    color: Color.fromARGB(255, 212, 180, 124),
                                  ), // icon
                                  Text(" الواجهة الرئيسية",
                                      textDirection: TextDirection.rtl,
                                      textAlign: TextAlign.justify,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontFamily: fontTitre,
                                      )),
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
                                left: BorderSide(
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
                              },
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const <Widget>[
                                  Icon(
                                    Icons.bookmark_add_outlined,
                                    color: Color.fromARGB(255, 212, 180, 124),
                                  ), // icon
                                  Text(
                                    "إضافة علامة",
                                    textDirection: TextDirection.rtl,
                                    textAlign: TextAlign.justify,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: fontTitre,
                                    ),
                                  ), // text
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
                              ),
                            ),
                            child: const MyBookmarkBottomSheet(),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
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
                                    Icons.zoom_in_outlined,
                                    color: Color.fromARGB(255, 212, 180, 124),
                                  ),
                                  Text(
                                    "تكبير",
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
                              onTap: () {}, // button pressed
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const <Widget>[
                                  Icon(
                                    Icons.crop_free_outlined,
                                    color: Color.fromARGB(255, 212, 180, 124),
                                  ),
                                  Text(
                                    "100%",
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
                              onTap: () {}, // button pressed
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const <Widget>[
                                  Icon(
                                    Icons.zoom_out_outlined,
                                    color: Color.fromARGB(255, 212, 180, 124),
                                  ),
                                  Text(
                                    "تصغير",
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
                                    "إذهب إلى",
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

class MyBookmarkBottomSheet extends StatelessWidget {
  const MyBookmarkBottomSheet({Key? key}) : super(key: key);

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
              child: const BookmarksList(),
            );
          },
        );
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const <Widget>[
          Icon(
            Icons.bookmarks_outlined,
            color: Color.fromARGB(255, 212, 180, 124),
          ),
          Text(
            "العلامات الموجودة",
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
              child: TOCWidget(),
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
            "المحتوى",
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
