import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

final showPageInfoProvider = StateProvider<bool>(
  (ref) {
    return false;
  },
);

final scrollOrNotProvider = StateProvider<bool>(
  (ref) {
    return true;
  },
);

//final imagesProvider = Provider.family<Image, int>((ref, index)

//final pageWidgetProvider = Provider.family<PageWidget, int>((ref, index) {

final hideWidgetAfterScrollProvider = ChangeNotifierProvider.autoDispose(
  (ref) => HideWidgetAfterScrollNotifier(),
);

class HideWidgetAfterScrollNotifier extends ChangeNotifier {
  bool _isVisible = true;
  Timer? _timer;

  bool get isVisible => _isVisible;

  void showAndHide(Duration duration) {
    _isVisible = true;
    _timer?.cancel();
    _timer = Timer(duration, () {
      _isVisible = false;
      notifyListeners();
    });
    notifyListeners();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}

final itemScrollControllerProvider = Provider<ItemScrollController>((ref) {
  return ItemScrollController();
});
