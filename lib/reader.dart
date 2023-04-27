import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'data.dart';
import 'page.dart';
import 'pageinfo.dart';
import 'content.dart';

class ReaderWidget extends StatefulHookConsumerWidget {
  const ReaderWidget({Key? key}) : super(key: key);

  @override
  ConsumerState<ReaderWidget> createState() => _ReaderWidgetState();
}

class _ReaderWidgetState extends ConsumerState<ReaderWidget> {
  static const int nbrPages = 604;

  PageController? _controller;

  final ItemScrollController itemScrollController = ItemScrollController();
  final ItemPositionsListener itemPositionsListener =
      ItemPositionsListener.create();

  @override
  void initState() {
    super.initState();

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

          if (max != min && max > ref.read(pageIndexProvider)) {
            ref.read(pageIndexProvider.notifier).state = max;

            _saveCurrentPage();
          }
          if (min < ref.read(pageIndexProvider) &&
              max < ref.read(pageIndexProvider)) {
            ref.read(pageIndexProvider.notifier).state = min;

            _saveCurrentPage();
          }
        }
      },
    );
  }

  Future<void> _saveCurrentPage() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setInt('mushaf01_page', ref.read(pageIndexProvider));
  }

  _goToSavedBookmark() {
    MediaQuery.of(context).orientation == Orientation.portrait
        ? {
            ref.read(pageIndexProvider.notifier).state =
                ref.read(savedBookmarkProvider),
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const ReaderWidget(),
              ),
            ),
          }
        : itemScrollController.jumpTo(index: ref.read(savedBookmarkProvider));
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
                    ref.read(showPageInfoProvider)
                        ? ref.read(showPageInfoProvider.notifier).state = false
                        : ref.read(showPageInfoProvider.notifier).state = true;
                  })
                },
                child: OrientationBuilder(
                  builder: (context, orientation) {
                    return orientation == Orientation.portrait
                        ? ScrollConfiguration(
                            behavior: AppBehavior(),
                            child: PageView.builder(
                              pageSnapping: orientation == Orientation.portrait
                                  ? true
                                  : false,
                              scrollDirection:
                                  orientation == Orientation.portrait
                                      ? Axis.horizontal
                                      : Axis.vertical,
                              controller: PageController(
                                initialPage: ref.watch(pageIndexProvider),
                              ),
                              onPageChanged: (int page) => {
                                ref.read(pageIndexProvider.notifier).state =
                                    page,
                                _saveCurrentPage()
                              },
                              itemBuilder: (context, index) {
                                return PageWidget(
                                  content: Content(
                                    index: index,
                                  ),
                                  orientation: orientation,
                                  isBookmarked:
                                      ref.read(savedBookmarkProvider) == index
                                          ? true
                                          : false,
                                );
                              },
                              itemCount: nbrPages,
                            ),
                          )
                        : ScrollConfiguration(
                            behavior: AppBehavior(),
                            child: ScrollablePositionedList.builder(
                              itemCount: nbrPages,
                              itemBuilder: (context, index) {
                                return PageWidget(
                                  content: Content(
                                    index: index,
                                  ),
                                  orientation: orientation,
                                  isBookmarked:
                                      ref.read(savedBookmarkProvider) == index
                                          ? true
                                          : false,
                                );
                              },
                              initialScrollIndex: ref.watch(pageIndexProvider),
                              itemScrollController: itemScrollController,
                              itemPositionsListener: itemPositionsListener,
                            ),
                          );
                  },
                ),
              ),
              Visibility(
                visible: ref.watch(showPageInfoProvider),
                child: OrientationBuilder(
                  builder: (context, orientation) {
                    return orientation == Orientation.portrait
                        ? MyPageInfo(
                            goToSavedBookmark: _goToSavedBookmark,
                          )
                        : Container();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class AppBehavior extends ScrollBehavior {
  @override
  Widget buildOverscrollIndicator(
      BuildContext context, Widget child, ScrollableDetails details) {
    return child;
  }
}
