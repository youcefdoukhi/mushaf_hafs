import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mushaf_hafs/reader.dart';

import 'data.dart';

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
      home: HookConsumer(
        builder: (context, ref, child) {
          final objetsAsyncValue = ref.watch(imagesProvider);
          return objetsAsyncValue.when(
            data: (objets) {
              return const ReaderWidget();
            },
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (error, _) => Text('Error: $error'),
          );
        },
      ),
    );
  }
}
