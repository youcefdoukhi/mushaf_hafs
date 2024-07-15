import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

// get the user last visited page
final pageIndexFromSharedPref = FutureProvider<int>((ref) async {
  final prefs = await SharedPreferences.getInstance();
  int? currentPage = prefs.getInt('mushaf01_page');
  if (currentPage != null) {
    // if the user visited a page before, return it
    return currentPage;
  } else {
    // otherwise return the first page
    return 0;
  }
});

// return the user last visited page
StateProvider<int> pageIndexProvider = StateProvider<int>(
  (ref) {
    final futureValue = ref.watch(pageIndexFromSharedPref);
    return futureValue.asData?.value ?? 0;
  },
);

// get the booKmarked of the user
final savedBookmarkFromSharedPref = FutureProvider<int>((ref) async {
  final prefs = await SharedPreferences.getInstance();
  int? bookmark = prefs.getInt('mushaf01_bookmark');

  if (bookmark != null) {
    // return the bookmark of the user if exist
    return bookmark;
  } else {
    // otherwise return 0
    return 0;
  }
});

// return the saved bookMark
final savedBookmarkProvider = StateProvider<int>(
  (ref) {
    final savedBookmark = ref.watch(savedBookmarkFromSharedPref);
    return savedBookmark.asData?.value ?? 0;
  },
);
