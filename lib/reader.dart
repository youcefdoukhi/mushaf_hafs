import 'package:flutter/material.dart';
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
  ScrollController? _lstviewController;
  double _lstviewOffset = 0.0;
  int _bookmark = 0;

  @override
  void initState() {
    super.initState();
    _page = widget.page;
    if (widget.ifGoto) {
      _saveCurrentPage();
    }
    _lstviewController = ScrollController(initialScrollOffset: _lstviewOffset);
    _lstviewController?.addListener(() {
      setState(() {
        _lstviewOffset = _lstviewController!.offset;
      });
    });

    _loadSavedBookmark();
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
      }
    });
  }

  Future<void> _saveCurrentPage() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setInt('mushaf01_page', _page);
  }

  Future<int> _loadSavedCurrentPage() async {
    final prefs = await SharedPreferences.getInstance();
    int? currentPage = prefs.getInt('mushaf01_page');
    if (currentPage != null) {
      setState(() {
        _page = currentPage;
        //_showPageInfo = false;
      });
      return currentPage;
    } else {
      return 0;
    }
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
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => ReaderWidget(
          page: _bookmark,
          ifGoto: true,
        ),
      ),
    );
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
                child: widget.ifGoto == false
                    ? FutureBuilder<int>(
                        future: _loadSavedCurrentPage(),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return OrientationBuilder(
                              builder: (context, orientation) {
                                return orientation == Orientation.portrait
                                    ? PageView.builder(
                                        pageSnapping:
                                            orientation == Orientation.portrait
                                                ? true
                                                : false,
                                        scrollDirection:
                                            orientation == Orientation.portrait
                                                ? Axis.horizontal
                                                : Axis.vertical,
                                        controller: PageController(
                                          initialPage: snapshot.data as int,
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
                                          );
                                        },
                                        itemCount: nbrPages,
                                      )
                                    : Column(
                                        children: [
                                          Expanded(
                                            child: ListView.builder(
                                              controller: _lstviewController,
                                              itemCount: nbrPages,
                                              itemBuilder: (context, index) {
                                                return PageWidget(
                                                  content: Content(
                                                    index: index,
                                                  ),
                                                  orientation: orientation,
                                                );
                                              },
                                            ),
                                          ),
                                        ],
                                      );
                              },
                            );
                          }
                          return Container();
                        },
                      )
                    : OrientationBuilder(
                        builder: (context, orientation) {
                          return orientation == Orientation.portrait
                              ? PageView.builder(
                                  pageSnapping:
                                      orientation == Orientation.portrait
                                          ? true
                                          : false,
                                  scrollDirection:
                                      orientation == Orientation.portrait
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
                                    );
                                  },
                                  itemCount: nbrPages,
                                )
                              : Column(
                                  children: [
                                    Expanded(
                                      child: ListView.builder(
                                        controller: _lstviewController,
                                        itemCount: nbrPages,
                                        itemBuilder: (context, index) {
                                          return PageWidget(
                                            content: Content(
                                              index: index,
                                            ),
                                            orientation: orientation,
                                          );
                                        },
                                      ),
                                    ),
                                  ],
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