import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'page.dart';
import 'pageinfo.dart';
import 'content.dart';

class ReaderWidget extends StatefulWidget {
  const ReaderWidget({Key? key, required this.page}) : super(key: key);
  final int page;

  @override
  State<ReaderWidget> createState() => _ReaderWidgetState();
}

class _ReaderWidgetState extends State<ReaderWidget> {
  int? _page;
  int nbrPages = 604;
  bool _showPageInfo = false;
  PageController? _controller;

  int _bookmark = 0;

  @override
  void initState() {
    super.initState();

    _controller = PageController(initialPage: widget.page);
    _page = widget.page;
    _loadSavedBookmark();
  }

  Future<void> _loadSavedBookmark() async {
    final prefs = await SharedPreferences.getInstance();
    int? bookmark = prefs.getInt('mushaf01_bookmark');
    setState(() {
      if (bookmark != null) {
        _bookmark = bookmark;
      }
    });
  }

  Future<void> _saveBookmark() async {
    final prefs = await SharedPreferences.getInstance();

    prefs.setInt('mushaf01_bookmark', _bookmark);
  }

  _displaySaveBookmarkDialog(BuildContext context) async {
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
                  setState(() {
                    Navigator.pop(context);
                  });
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
                  setState(() {
                    _saveBookmark();
                    Navigator.pop(context);
                    showStatus(context);
                  });
                },
              ),
            ],
          );
        });
  }

  showStatus(ctext) {
    return ScaffoldMessenger.of(ctext).showSnackBar(
      const SnackBar(
        content: Text(
          'حفظ',
          textAlign: TextAlign.center,
        ),
        margin: EdgeInsets.only(bottom: 150),
        elevation: 10,
        behavior: SnackBarBehavior.floating,
        duration: Duration(milliseconds: 1000),
        backgroundColor: Color.fromRGBO(233, 218, 193, 0.9),
        shape: CircleBorder(),
      ),
    );
  }

  @override
  void dispose() {
    _controller?.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: <Widget>[
            GestureDetector(
              onTap: () => {
                setState(() {
                  _showPageInfo ? _showPageInfo = false : _showPageInfo = true;
                })
              },
              child: PageView.builder(
                //physics: const CustomPageViewScrollPhysics(),
                controller: _controller,
                onPageChanged: (int page) => {
                  setState(() {
                    _page = page;
                  }),
                },
                itemBuilder: (context, index) {
                  return PageWidget(
                    content: Content(
                      index: index,
                    ),
                    keyString: index.toString(),
                  );
                },
                itemCount: nbrPages,
              ),
            ),
            Visibility(
              visible: _showPageInfo,
              child: MyPageInfo(
                nbrOfPages: nbrPages,
                pageNum: _page!,
                displaySaveBookmarkDialog: _displaySaveBookmarkDialog,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/*
class CustomPageViewScrollPhysics extends ScrollPhysics {
  const CustomPageViewScrollPhysics({ScrollPhysics? parent})
      : super(parent: parent);

  @override
  CustomPageViewScrollPhysics applyTo(ScrollPhysics? ancestor) {
    return CustomPageViewScrollPhysics(parent: buildParent(ancestor));
  }

  @override
  SpringDescription get spring => const SpringDescription(
        mass: 80,
        stiffness: 100,
        damping: 1,
      );
}
*/