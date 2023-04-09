import 'package:flutter/material.dart';

import 'content.dart';

class PageWidget extends StatelessWidget {
  const PageWidget(
      {Key? key,
      required this.content,
      required this.keyString,
      required this.orientation})
      : super(key: key);

  final Content content;
  final String keyString;
  final Orientation orientation;

  @override
  Widget build(BuildContext context) {
    return Container(
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
        key: PageStorageKey(keyString),
        child: orientation == Orientation.portrait
            ? content
            : /*ListView(
              children: [
                content,
              ],
            ),*/
            content);
  }
}
