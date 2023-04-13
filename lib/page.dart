import 'package:flutter/material.dart';

import 'content.dart';

class PageWidget extends StatelessWidget {
  const PageWidget(
      {Key? key,
      required this.content,
      required this.orientation,
      required this.isBookmarked})
      : super(key: key);

  final Content content;
  final Orientation orientation;
  final bool isBookmarked;

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: orientation == Orientation.portrait
          ? StackFit.expand
          : StackFit.loose,
      children: <Widget>[
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            border: orientation == Orientation.portrait
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
          child: content,
        ),
        Visibility(
          visible: isBookmarked,
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
