import 'package:flutter/material.dart';
import 'content.dart';
import 'reader.dart';

class TOCItem {
  int num;
  String title;
  String type;
  int ayatNumber;
  int page;
  TOCItem(this.num, this.title, this.type, this.ayatNumber, this.page);
}

class TOCWidget extends StatelessWidget {
  TOCWidget({Key? key}) : super(key: key);

  final List<TOCItem> entries = <TOCItem>[
    TOCItem(1, "الفاتحة", "مكية", 7, 1),
    TOCItem(2, "البقرة", "مدنية", 286, 2),
    TOCItem(3, "آل عمران", "مدنية", 200, 50),
    TOCItem(4, "النساء", "مدنية", 176, 77),
    TOCItem(5, "المائدة", "مدنية", 120, 106),
    TOCItem(6, "الأنعام", "مكية", 165, 128),
    TOCItem(7, "الأعراف", "مكية", 206, 151),
    //TOCItem(8, "", "", , ),
    //TOCItem(9, "", "", , ),
    //TOCItem(10, "", "", , ),
    //TOCItem(11, "", "", , ),
    //TOCItem(12, "", "", , ),
    //TOCItem(13, "", "", , ),
    //TOCItem(14, "", "", , ),
    //TOCItem(15, "", "", , ),
    //TOCItem(16, "", "", , ),
    //TOCItem(17, "", "", , ),
    //TOCItem(18, "", "", , ),
    //TOCItem(19, "", "", , ),
    //TOCItem(20, "", "", , ),
    //TOCItem(21, "", "", , ),
    //TOCItem(22, "", "", , ),

    //TOCItem(, "", "", , ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              decoration: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    width: 2,
                    color: Color.fromRGBO(233, 218, 193, 1),
                  ),
                ),
              ),
              padding: const EdgeInsets.all(15),
              child: const Text.rich(
                TextSpan(
                  text: "فهرس القرآن الكريم",
                  style: TextStyle(
                    fontSize: 16,
                    fontFamily: fontText,
                  ),
                ),
                textAlign: TextAlign.center,
                textDirection: TextDirection.rtl,
              ),
            ),
            const Divider(
              //indent: 50,
              //endIndent: 50,
              color: Color.fromRGBO(233, 218, 193, 1),
            ),
            Expanded(
              child: NotificationListener<OverscrollIndicatorNotification>(
                onNotification: (overScroll) {
                  overScroll.disallowIndicator();
                  return false;
                },
                child: ListView.separated(
                  padding: const EdgeInsets.all(8),
                  itemCount: entries.length,
                  itemBuilder: (BuildContext context, int index) {
                    TOCItem tocItem = entries[index];
                    return GestureDetector(
                      onTap: () => {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ReaderWidget(
                              page: tocItem.page - 1,
                              ifGoto: true,
                            ),
                          ),
                        ),
                      },
                      child: Container(
                        color: Colors.transparent,
                        height: 40.0,
                        child: Row(
                          children: [
                            Expanded(
                              flex: 2,
                              child: Container(
                                //color: Colors.black,
                                alignment: Alignment.center,
                                child: Text(
                                  "${tocItem.num}",
                                  style: const TextStyle(
                                      //color: Colors.white,
                                      ),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 4,
                              child: Container(
                                padding: const EdgeInsets.only(
                                  right: 10,
                                ),
                                alignment: Alignment.centerRight,
                                child: Text(tocItem.title),
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: Column(
                                children: [
                                  const Flexible(
                                    child: FractionallySizedBox(
                                      heightFactor: 1,
                                      child: Text(
                                        "آياتها",
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 13,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Flexible(
                                    child: FractionallySizedBox(
                                      heightFactor: 1,
                                      child: Text("${tocItem.ayatNumber}"),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: Container(
                                alignment: Alignment.center,
                                child: tocItem.type == "مكية"
                                    ? const Image(
                                        image: AssetImage('images/mecca.png'),
                                        fit: BoxFit.contain)
                                    : const Image(
                                        image: AssetImage('images/medina.png'),
                                        fit: BoxFit.contain),
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: Container(
                                alignment: Alignment.center,
                                child: Text("${tocItem.page}"),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) =>
                      const Divider(
                    //indent: 50,
                    //endIndent: 50,
                    color: Color.fromRGBO(233, 218, 193, 1),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
