import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'data.dart';

class HorizontalPage extends ConsumerWidget {
  const HorizontalPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pageIndex = ref.read(pageIndexProvider);
    final PageController pageController =
        PageController(initialPage: pageIndex);

    ref.listen<int>(
      pageIndexProvider,
      (int? previousCount, int newCount) {
        if (ref.read(scrollOrNotProvider) == false) {
          pageController.jumpToPage(newCount);
          ref.read(scrollOrNotProvider.notifier).state = true;
        }
      },
    );

    Future<void> saveCurrentPage() async {
      final prefs = await SharedPreferences.getInstance();
      prefs.setInt('mushaf01_page', ref.read(pageIndexProvider));
    }

    return ScrollConfiguration(
      behavior: AppBehavior(),
      child: PageView.builder(
        pageSnapping: true,
        scrollDirection: Axis.horizontal,
        controller: pageController,
        onPageChanged: (int page) => {
          ref.read(pageIndexProvider.notifier).state = page,
          saveCurrentPage()
        },
        itemBuilder: (context, index) {
          return ref.read(pageWidgetProvider(index));
        },
        itemCount: 604,
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
