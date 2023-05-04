import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'data.dart';
import 'page.dart';
import 'pageinfo.dart';

class ReaderWidget extends ConsumerWidget {
  ReaderWidget({super.key});

  static const int nbrPages = 604;
  final ItemScrollController itemScrollController = ItemScrollController();
  final ItemPositionsListener itemPositionsListener =
      ItemPositionsListener.create();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    print("\nAAAAAAAAA ${ref.read(pageIndexProvider)} AAAAAAAAAAA");
    final pageIndex = ref.read(pageIndexProvider);
    final PageController pageController =
        PageController(initialPage: pageIndex);

    MediaQuery.of(context).orientation == Orientation.portrait
        ? {
            ref.listen<int>(
              pageIndexProvider,
              (int? previousCount, int newCount) {
                /*  if (ref.read(scroolOrNotProvider) == true) {
                  print("\n Scrooooooolll");
                  pageController.animateToPage(newCount,
                      duration: const Duration(milliseconds: 200),
                      curve: Curves.ease);
                }*/
                if (ref.read(scroolOrNotProvider) == false) {
                  pageController.jumpToPage(newCount);
                  ref.read(scroolOrNotProvider.notifier).state = true;
                }
              },
            ),
          }
        : {};

    Future<void> saveCurrentPage() async {
      final prefs = await SharedPreferences.getInstance();
      prefs.setInt('mushaf01_page', ref.read(pageIndexProvider));
    }

    goToSavedBookmark() {
      MediaQuery.of(context).orientation == Orientation.portrait
          ? {
              ref.read(scroolOrNotProvider.notifier).state = false,
              ref.read(pageIndexProvider.notifier).state =
                  ref.read(savedBookmarkProvider),
              ref.read(showPageInfoProvider.notifier).state = false,
              /* Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => ReaderWidget(),
                ),
              ),*/
            }
          : {
              ref.read(pageIndexProvider.notifier).state =
                  ref.read(savedBookmarkProvider),
              ref.read(showPageInfoProvider.notifier).state = false,
              itemScrollController.jumpTo(
                index: ref.read(savedBookmarkProvider),
              ),
            };
    }

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

            saveCurrentPage();
          }
          if (min < ref.read(pageIndexProvider) &&
              max < ref.read(pageIndexProvider)) {
            ref.read(pageIndexProvider.notifier).state = min;

            saveCurrentPage();
          }
        }
      },
    );

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
                  ref.read(showPageInfoProvider)
                      ? ref.read(showPageInfoProvider.notifier).state = false
                      : ref.read(showPageInfoProvider.notifier).state = true,
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
                              //controller: PageController(
                              // initialPage: ref.read(pageIndexProvider),
                              //   initialPage: ref.watch(pageIndexProvider),
                              // ),
                              controller: pageController,
                              onPageChanged: (int page) => {
                                ref.read(pageIndexProvider.notifier).state =
                                    page,
                                saveCurrentPage()
                              },
                              itemBuilder: (context, index) {
                                return PageWidget(
                                  content:
                                      ref.read(imagesProvider).value![index],
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
                              shrinkWrap: false,
                              itemCount: nbrPages,
                              itemBuilder: (context, index) {
                                return PageWidget(
                                  content:
                                      ref.read(imagesProvider).value![index],
                                  orientation: orientation,
                                  isBookmarked:
                                      ref.read(savedBookmarkProvider) == index
                                          ? true
                                          : false,
                                );
                              },
                              initialScrollIndex: ref.read(pageIndexProvider),
                              itemScrollController: itemScrollController,
                              itemPositionsListener: itemPositionsListener,
                              addAutomaticKeepAlives: false,
                              addRepaintBoundaries: false,
                            ),
                          );
                  },
                ),
              ),
              Visibility(
                visible: ref.watch(showPageInfoProvider),
                child: OrientationBuilder(
                  builder: (context, orientation) {
                    //return orientation == Orientation.portrait
                    return 1 == 1
                        ? MyPageInfo(
                            goToSavedBookmark: goToSavedBookmark,
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
