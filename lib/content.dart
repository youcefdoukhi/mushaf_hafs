import 'package:flutter/material.dart';

const quranColor = Color(0xFFAA0A00);
const hadithColor = Color(0xFF008080);
const mousanifColor = Color.fromARGB(255, 110, 47, 68);
const charihColor = Colors.black;
const fontText = "ScheherazadeNew";
const fontTitre = "Lateef";
const fontTitle = "ScheherazadeNew";

class Content extends StatelessWidget {
  final int? index;

  static List<Image>? pages;

  Content({
    Key? key,
    required this.index,
  }) : super(key: key) {
    pages = <Image>[
      //01
      const Image(
        image: AssetImage('images/mushaf_photos/01.jpg'),
      ),
      //02
      const Image(
        image: AssetImage('images/mushaf_photos/02.jpg'),
      ),
      //03
      const Image(
        image: AssetImage('images/mushaf_photos/03.png'),
        fit: BoxFit.fill,
      ),
      //04
      const Image(
        image: AssetImage('images/mushaf_photos/04.png'),
        fit: BoxFit.fill,
      ),
      //05
      const Image(
        image: AssetImage('images/mushaf_photos/05.png'),
        fit: BoxFit.fill,
      ),
      //06
      const Image(
        image: AssetImage('images/mushaf_photos/06.png'),
        fit: BoxFit.fill,
      ),
      //07
      const Image(
        image: AssetImage('images/mushaf_photos/07.png'),
        fit: BoxFit.fill,
      ),
      //08
      const Image(
        image: AssetImage('images/mushaf_photos/08.png'),
        fit: BoxFit.fill,
      ),
      //09
      const Image(
        image: AssetImage('images/mushaf_photos/09.png'),
        fit: BoxFit.fill,
      ),
      //10
      const Image(
        image: AssetImage('images/mushaf_photos/10.png'),
        fit: BoxFit.fill,
      ),
      //11
      const Image(
        image: AssetImage('images/mushaf_photos/11.png'),
        fit: BoxFit.fill,
      ),
      //12
      const Image(
        image: AssetImage('images/mushaf_photos/12.png'),
        fit: BoxFit.fill,
      ),
      //13
      const Image(
        image: AssetImage('images/mushaf_photos/13.png'),
        fit: BoxFit.fill,
      ),
      //14
      const Image(
        image: AssetImage('images/mushaf_photos/14.png'),
        fit: BoxFit.fill,
      ),
      //15
      const Image(
        image: AssetImage('images/mushaf_photos/15.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/16.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/17.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/18.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/19.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/20.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/21.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/22.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/23.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/24.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/25.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/26.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/27.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/28.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/29.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/30.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/31.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/32.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/33.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/34.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/35.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/36.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/37.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/38.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/39.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/40.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/41.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/42.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/43.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/44.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/45.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/46.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/47.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/48.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/49.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/50.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/51.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/52.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/53.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/54.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/55.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/56.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/57.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/58.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/59.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/60.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/61.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/62.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/63.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/64.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/65.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/66.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/67.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/68.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/69.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/70.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/71.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/72.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/73.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/74.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/75.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/76.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/77.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/78.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/79.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/80.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/81.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/82.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/83.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/84.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/85.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/86.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/87.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/88.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/89.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/90.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/91.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/92.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/93.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/94.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/95.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/96.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/97.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/98.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/99.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/100.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/.png'),
        fit: BoxFit.fill,
      ),
      //
      const Image(
        image: AssetImage('images/mushaf_photos/.png'),
        fit: BoxFit.fill,
      ),
    ];
  }

  Image getPage() {
    //return pages![index!];

    String pageNum = "";

    if (index! < 10) {
      pageNum = "0${index! + 1}";
    } else {
      pageNum = "${index! + 1}";
    }

    return Image(
      image: AssetImage('images/mushaf_photos/$pageNum.png'),
      fit: index! > 1 ? BoxFit.fill : BoxFit.contain,
    );

/*
    String pageNum = "";

    if ((index! + 1) < 10) {
      pageNum = "00${index! + 1}";
    } else if ((index! + 1) < 100 && (index! + 1) > 9) {
      pageNum = "0${index! + 1}";
    } else {
      pageNum = "${index! + 1}";
    }

    return Image(
      image: AssetImage('images/mushaf_photos_2/page$pageNum.png'),
      fit: fit: index! > 1 ? BoxFit.fill : BoxFit.contain,
    );*/
  }

  @override
  Widget build(BuildContext context) {
    return getPage();
  }
}
