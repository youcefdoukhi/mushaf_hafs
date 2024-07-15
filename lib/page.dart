import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mushaf_hafs/providers/meta_data_coran_pages_provider.dart';
import 'package:mushaf_hafs/providers/user_pref_provider.dart';

//PaintingBinding.instance.imageCache.clear();
// PaintingBinding.instance.imageCache.clearLiveImages();

class PageWidget extends ConsumerWidget {
  const PageWidget({
    Key? key,
    required this.index,
  }) : super(key: key);

  // index of the coran page in images the list
  final int index;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Stack(
      fit: MediaQuery.of(context).orientation == Orientation.portrait
          ? StackFit.expand
          : StackFit.loose,
      children: <Widget>[
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            border: MediaQuery.of(context).orientation == Orientation.portrait
                ? const Border(
                    left: BorderSide(
                      width: 0.7,
                      color: Colors.black,
                    ),
                    right: BorderSide(
                      width: 0.7,
                      color: Colors.black,
                    ),
                  )
                : const Border(
                    top: BorderSide(
                      width: 1,
                      color: Colors.black,
                    ),
                    bottom: BorderSide(
                      width: 1,
                      color: Colors.black,
                    ),
                  ),
          ),
          // child: ref.read(imagesProvider(index)),
          child: ref.read(imagesProvider).elementAt(index),
        ),
        Visibility(
          visible: ref.watch(savedBookmarkProvider) == index ? true : false,
          child: const Align(
            alignment: Alignment.topLeft,
            child: SizedBox(
              height: 118,
              width: 118,
              child: Align(
                alignment: Alignment.topCenter,
                child: Image(
                  image: AssetImage('images/bookmark.png'),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
