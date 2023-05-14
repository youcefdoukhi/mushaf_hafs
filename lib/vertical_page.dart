import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'data.dart';

class VerticalPage extends ConsumerWidget {
  const VerticalPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ItemPositionsListener itemPositionsListener =
        ItemPositionsListener.create();

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

    Future<void> saveCurrentPage() async {
      final prefs = await SharedPreferences.getInstance();
      prefs.setInt('mushaf01_page', ref.read(pageIndexProvider));
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

    return ScrollConfiguration(
      behavior: AppBehavior(),
      child: ScrollablePositionedList.builder(
        shrinkWrap: true,
        itemCount: 604,
        itemBuilder: (context, index) {
          return ref.read(pageWidgetProvider(index));
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
