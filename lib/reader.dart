import 'package:flutter/material.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'page.dart';
import 'pageinfo.dart';
import 'content.dart';

class ReaderWidget extends StatefulWidget {
  const ReaderWidget({Key? key, required this.page, required this.ifGoto})
      : super(key: key);
  final int page;
  final bool ifGoto;

  @override
  State<ReaderWidget> createState() => _ReaderWidgetState();
}

class _ReaderWidgetState extends State<ReaderWidget> {
  late int _page;
  int nbrPages = 604;

  bool _showPageInfo = false;
  PageController? _controller;

  late int _bookmark;

  final ItemScrollController itemScrollController = ItemScrollController();
  final ItemPositionsListener itemPositionsListener =
      ItemPositionsListener.create();

  @override
  void initState() {
    super.initState();

    _page = widget.page;
    _saveCurrentPage();

    _loadSavedBookmark();
    itemPositionsListener.itemPositions.addListener(
      () {
        int? min;
        int? max;
        if (itemPositionsListener.itemPositions.value.isNotEmpty) {
          min = itemPositionsListener.itemPositions.value
              .where((ItemPosition position) => position.itemTrailingEdge > 0)
              .reduce((ItemPosition min, ItemPosition position) =>
                  position.itemTrailingEdge < min.itemTrailingEdge
                      ? position
                      : min)
              .index;
          max = itemPositionsListener.itemPositions.value
              .where((ItemPosition position) => position.itemLeadingEdge < 1)
              .reduce((ItemPosition max, ItemPosition position) =>
                  position.itemLeadingEdge > max.itemLeadingEdge
                      ? position
                      : max)
              .index;

          if (max != min && max > _page) {
            setState(() {
              _page = max!;
            });
            _saveCurrentPage();
            print("Page === $_page");
          }
          if (min < _page && max < _page) {
            setState(() {
              _page = min!;
            });
            _saveCurrentPage();
            print("Page 2 === $_page");
          }
        }
      },
    );
  }

  Future<void> _saveBookmark() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setInt('mushaf01_bookmark', _page);
    setState(() {
      _showPageInfo = false;
      _bookmark = _page;
    });
  }

  Future<void> _loadSavedBookmark() async {
    final prefs = await SharedPreferences.getInstance();
    int? bookmark = prefs.getInt('mushaf01_bookmark');
    setState(() {
      if (bookmark != null) {
        _bookmark = bookmark;
      } else {
        _bookmark = 0;
      }
    });
  }

  Future<void> _saveCurrentPage() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setInt('mushaf01_page', _page);
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
                  _saveBookmark();
                  Navigator.pop(context);
                  showStatus(context);
                },
              ),
            ],
          );
        });
  }

  _goToSavedBookmark() {
    MediaQuery.of(context).orientation == Orientation.portrait
        ? Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => ReaderWidget(
                page: _bookmark,
                ifGoto: true,
              ),
            ),
          )
        : itemScrollController.jumpTo(index: _bookmark);
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
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        body: SafeArea(
          child: Stack(
            children: <Widget>[
              GestureDetector(
                onTap: () => {
                  setState(() {
                    _showPageInfo
                        ? _showPageInfo = false
                        : _showPageInfo = true;
                  })
                },
                child: OrientationBuilder(
                  builder: (context, orientation) {
                    return orientation == Orientation.portrait
                        ? PageView.builder(
                            pageSnapping: orientation == Orientation.portrait
                                ? true
                                : false,
                            scrollDirection: orientation == Orientation.portrait
                                ? Axis.horizontal
                                : Axis.vertical,
                            controller: PageController(
                              initialPage: _page,
                            ),
                            onPageChanged: (int page) => {
                              setState(() {
                                _page = page;
                              }),
                              _saveCurrentPage()
                            },
                            itemBuilder: (context, index) {
                              return PageWidget(
                                content: Content(
                                  index: index,
                                ),
                                orientation: orientation,
                                isBookmarked: _bookmark == index ? true : false,
                              );
                            },
                            itemCount: nbrPages,
                          )
                        : ScrollablePositionedList.builder(
                            itemCount: nbrPages,
                            itemBuilder: (context, index) {
                              return PageWidget(
                                content: Content(
                                  index: index,
                                ),
                                orientation: orientation,
                                isBookmarked: _bookmark == index ? true : false,
                              );
                            },
                            initialScrollIndex: _page,
                            itemScrollController: itemScrollController,
                            itemPositionsListener: itemPositionsListener,
                          );
                  },
                ),
              ),
              Visibility(
                visible: _showPageInfo,
                child: MyPageInfo(
                  nbrOfPages: nbrPages,
                  pageNum: _page,
                  displaySaveBookmarkDialog: _displaySaveBookmarkDialog,
                  goToSavedBookmark: _goToSavedBookmark,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
