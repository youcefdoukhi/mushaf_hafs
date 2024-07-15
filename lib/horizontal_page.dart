import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'data.dart';
import 'providers/meta_data_coran_pages_provider.dart';
import 'providers/user_pref_provider.dart';

class HorizontalPage extends ConsumerWidget {
  const HorizontalPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pageIndex = ref.read(pageIndexProvider);
    final PageController pageController =
        PageController(initialPage: pageIndex);

    // go to the user last visited page
    ref.listen<int>(
      pageIndexProvider,
      (int? previousCount, int newCount) {
        if (ref.read(scrollOrNotProvider) == false) {
          pageController.jumpToPage(newCount);
          ref.read(scrollOrNotProvider.notifier).state = true;
        }
      },
    );

    // save the current page that the user is visiting
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
          // save the new visited page
          ref.read(pageIndexProvider.notifier).state = page,
          saveCurrentPage()
        },
        itemCount: 604,
        itemBuilder: (context, index) {
          return ref.read(coranPagesProvider)[index];
        },
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
