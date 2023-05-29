import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mushaf_hafs/reader.dart';

import 'dart:ui' as ui;

import 'data.dart';

void main() {
  runApp(const Test());
  //setCustomImageCacheSize(); // Set the custom cache size
}

void setCustomImageCacheSize() {
  const int megabytes = 0; // Define the desired cache size in megabytes
  const int cacheSize = megabytes * 1024 * 1024;
  PaintingBinding.instance.imageCache.maximumSize = cacheSize;
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
              return Image(
                image: AssetImage('images/img/page$pageNum.png'),
                fit: BoxFit.fill,
              );
            },
          ),
        ),
      ),
    );
  }
}

/*
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

*/

