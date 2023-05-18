import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mushaf_hafs/data.dart';

class PageWidget extends ConsumerWidget {
  final int index;

  const PageWidget({
    Key? key,
    required this.index,
  }) : super(key: key);

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
          child: ref.read(imagesProvider(index)),
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
