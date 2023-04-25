import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mushaf_hafs/data.dart';
import 'content.dart';
import 'reader.dart';

class TOCWidget extends HookConsumerWidget {
  const TOCWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
              child: Text.rich(
                TextSpan(
                  text: "فهرس القرآن الكريم",
                  style: TextStyle(
                    //fontSize: 16,
                    fontSize: ref.watch(
                        filteredFontSizeProvider.select((value) => value)),
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
            HookConsumer(
              builder: (context, ref, child) {
                final objetsAsyncValue = ref.watch(objetsProvider);
                return objetsAsyncValue.when(
                  data: (objets) {
                    return Expanded(
                      child:
                          NotificationListener<OverscrollIndicatorNotification>(
                        onNotification: (overScroll) {
                          overScroll.disallowIndicator();
                          return false;
                        },
                        child: ListView.separated(
                          padding: const EdgeInsets.all(8),
                          itemCount: objets.length,
                          itemBuilder: (BuildContext context, int index) {
                            final objet = objets[index];
                            return GestureDetector(
                              onTap: () => {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ReaderWidget(
                                      page: objet.start - 1,
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
                                          "${objet.index}",
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
                                        child: Text(objet.name),
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
                                              child: Text("${objet.verses}"),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                      flex: 2,
                                      child: Container(
                                        alignment: Alignment.center,
                                        child: objet.type == "مكية"
                                            ? const Image(
                                                image: AssetImage(
                                                    'images/mecca.png'),
                                                fit: BoxFit.contain)
                                            : const Image(
                                                image: AssetImage(
                                                    'images/medina.png'),
                                                fit: BoxFit.contain),
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
                                                "ص",
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
                                              child: Text("${objet.start}"),
                                            ),
                                          ),
                                        ],
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
                    );
                  },
                  loading: () =>
                      const Center(child: CircularProgressIndicator()),
                  error: (error, _) => Text('Error: $error'),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
