import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'data.dart';
import 'providers/meta_data_coran_pages_provider.dart';
import 'providers/user_pref_provider.dart';

class VerticalPage extends ConsumerWidget {
  VerticalPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // item position listener of pages instance
    final ItemPositionsListener itemPositionsListener =
        ItemPositionsListener.create();

    // go to the user last visited page
    ref.listen<int>(
      pageIndexProvider,
      (int? previousCount, int newCount) {
        if (ref.read(scrollOrNotProvider) == false) {
          ref.read(itemScrollControllerProvider).jumpTo(
                index: newCount,
              );
          ref.read(scrollOrNotProvider.notifier).state = true;
        }
      },
    );

    // save the current page that the user is visiting
    Future<void> saveCurrentPage() async {
      final prefs = await SharedPreferences.getInstance();
      prefs.setInt('mushaf01_page', ref.read(pageIndexProvider));
    }

    // save the page whetever the user change the page
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

    return ScrollConfiguration(
      behavior: AppBehavior(),
      child: ScrollablePositionedList.builder(
        itemCount: 604,
        itemBuilder: (context, index) {
          // return coran pages into the list builder
          return ref.read(coranPagesProvider)[index];
        },
        initialScrollIndex: ref.read(pageIndexProvider),
        itemScrollController: ref.read(itemScrollControllerProvider),
        itemPositionsListener: itemPositionsListener,
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
