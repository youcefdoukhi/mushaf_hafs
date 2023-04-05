import 'package:flutter/material.dart';

import 'content.dart';

class PageWidget extends StatelessWidget {
  const PageWidget({Key? key, required this.content, required this.keyString})
      : super(key: key);

  final Content content;
  final String keyString;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: const BoxDecoration(
          color: Color.fromRGBO(254, 251, 236, 0.6),
          border: Border(
            left: BorderSide(
              width: 0.7,
              color: Colors.black,
            ),
            right: BorderSide(
              width: 0.7,
              color: Colors.black,
            ),
          ),
        ),
        key: PageStorageKey(keyString),
        child: content,
      ),
    );
  }
}
