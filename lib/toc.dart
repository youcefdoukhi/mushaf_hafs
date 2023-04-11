import 'package:flutter/material.dart';
import 'content.dart';
import 'reader.dart';

class TOCItem {
  int page;
  String title;
  TOCItem(this.page, this.title);
}

class TOCWidget extends StatelessWidget {
  TOCWidget({Key? key}) : super(key: key);

  final List<TOCItem> entries = <TOCItem>[
    TOCItem(1, "مقدمة"),
    TOCItem(2, "يجب علينا تعلم أربع مسائل"),
    TOCItem(3, "المسألة الأولى : العلم"),
    TOCItem(4, "المسألة الثانية : العمل به"),
    TOCItem(5, "المسألة الثالثة : الدعوة إليه"),
    TOCItem(5, "المسألة الرابعة : الصبر على الأذى فيه"),
    TOCItem(6, "دليل تعلم المسائل الأربع"),
    TOCItem(7, "المُقدم من المسائل الأربع : العلم"),
    TOCItem(8, "يجب على كل مسلم و مسلمة تعلم ثلاث مسائل"),
    TOCItem(9, "المسألة الأولى : وجوب طاعة الرسول"),
    TOCItem(9, "المسألة الثانية : إبطال الشرك في العبادة"),
    TOCItem(10, "المسألة الثالثة : وجوب البراءة من المشركين"),
    TOCItem(11, "الحنيفية ملة إبراهيم"),
    TOCItem(12, "عبادة الله لها معنيان"),
    TOCItem(13, "الناس جميعا مأمورون بعبادة الله"),
    TOCItem(14, "أعظمية الأمر بالتوحيد و النهي عن الشرك"),
    TOCItem(16, "الأصول الثلاثة التي يجب على الإنسان معرفتها"),
    TOCItem(17, "الأصل الأول : معرفة العبد ربه"),
    TOCItem(19, "تفسير [الْعَالَمِينَ]"),
    TOCItem(20, "الدليل المرشد إلى معرفة الرب عزوجل"),
    TOCItem(22, "استحقاق الله للعبادة"),
    TOCItem(23, "حقيقة العبادة بالإرشاد إلى أنواعها"),
    TOCItem(26, "عبادة : الدعاء"),
    TOCItem(27, "الخوف, الرجاء, التوكل, الرغبة, الرهبة و الخشوع"),
    TOCItem(28, "الخشية, الإنابة, الاستعانة, الاستعاذة و الاستغاثة"),
    TOCItem(29, "عبادة : الذبح"),
    TOCItem(30, "عبادة : النذر"),
    TOCItem(31, "الأصل الثاني : معرفة دين الإسلام بالأدلة"),
    TOCItem(32, "مراتب الدين : الإسلام, الإيمان و الإحسان"),
    TOCItem(33, "الإسلام و أركانه"),
    TOCItem(36, "معنى الشهادتين"),
    TOCItem(37, "الإيمان و أركانه"),
    TOCItem(39, "القدر الواجب المجزئ من الإيمان بكل ركن"),
    TOCItem(41, "الإحسان و أركانه"),
    TOCItem(43, "القدر الواجب المجزئ من الإحسان"),
    TOCItem(44, "الأصل الثالث : معرفة العبد نبيه"),
    TOCItem(46, "المقصود من بعثة النبي"),
    TOCItem(47, "الهجرة من بلد الكفر إلى بلد الإسلام"),
    TOCItem(50, "بعثُه صلى الله عليه وسلم إلى الناس كافة"),
    TOCItem(52, "أرسل الله جميع الرسل مبشرين و منذرين"),
    TOCItem(53, "كل أمة بعث الله إليها رسولا"),
    TOCItem(55, "معنى الطاغوت"),
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
                  text: "محتويات الكتاب",
                  style: TextStyle(
                    fontSize: 16,
                    fontFamily: fontText,
                  ),
                ),
                textAlign: TextAlign.center,
                textDirection: TextDirection.rtl,
              ),
            ),
            Expanded(
              child: Container(
                color: Colors.white,
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
                      return ListTile(
                        leading: const Icon(
                          Icons.chevron_right,
                          color: Color.fromRGBO(84, 186, 185, 1),
                        ),
                        title: Text(
                          tocItem.title,
                          style: const TextStyle(
                            fontFamily: fontText,
                            fontSize: 14,
                          ),
                        ),
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ReaderWidget(
                              page: tocItem.page - 1,
                              ifGoto: true,
                            ),
                          ),
                        ),
                      );
                    },
                    separatorBuilder: (BuildContext context, int index) =>
                        const Divider(
                      indent: 50,
                      endIndent: 50,
                      color: Color.fromRGBO(233, 218, 193, 1),
                    ),
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
