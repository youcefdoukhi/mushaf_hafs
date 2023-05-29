import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mushaf_hafs/reader.dart';
import 'data.dart';

/*
void main() {
  runApp(const Test());
}

class Test extends StatelessWidget {
  const Test({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      //showPerformanceOverlay: true,
      home: Scaffold(
        body: SafeArea(
          child: ListView.builder(
            shrinkWrap: false,
            itemCount: 150,
            itemBuilder: (context, index) {
              String pageNum = "";

              if ((index + 1) < 10) {
                pageNum = "00${index + 1}";
              } else if ((index + 1) < 100 && (index + 1) > 9) {
                pageNum = "0${index + 1}";
              } else {
                pageNum = "${index + 1}";
              }
              return TestWidget(
                index: pageNum,
              );
            },
          ),
        ),
      ),
    );
  }
}

class TestWidget extends ConsumerStatefulWidget {
  final String index;

  const TestWidget({super.key, required this.index});

  @override
  ConsumerState<TestWidget> createState() => PageWidgetState();
}

class PageWidgetState extends ConsumerState<TestWidget> {
  @override
  void initState() {
    super.initState();
    //------------
  }

  @override
  void dispose() {
    print("\nXXXXXXXXXx");
    PaintingBinding.instance.imageCache.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Image(
      image: AssetImage('images/img/page${widget.index}.png'),
      fit: BoxFit.fill,
    );
  }
}
*/

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);

  runApp(
    const ProviderScope(
      child: MainApp(),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({Key? key}) : super(key: key);

  static const String _title = 'القرآن الكريم';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const <Locale>[
        Locale('ar', ''),
      ],
      locale: const Locale('ar'),
      title: _title,
      home: Consumer(
        builder: (context, ref, child) {
          final pageIndex = ref.watch(pageIndexFromSharedPref);
          return pageIndex.when(
            data: (objets2) {
              return Consumer(
                builder: (context, ref, child) {
                  final rub = ref.watch(rubProvider);
                  return rub.when(
                    data: (objets3) {
                      return Consumer(
                        builder: (context, ref, child) {
                          final listSurah = ref.watch(chaptersProvider);
                          return listSurah.when(
                            data: (objets4) {
                              return const ReaderWidget();
                            },
                            loading: () => const Center(
                                child: CircularProgressIndicator()),
                            error: (error, _) => Text('Error: $error'),
                          );
                        },
                      );
                    },
                    loading: () =>
                        const Center(child: CircularProgressIndicator()),
                    error: (error, _) => Text('Error: $error'),
                  );
                },
              );
            },
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (error, _) => Text('Error: $error'),
          );
        },
      ),
    );
  }
}
