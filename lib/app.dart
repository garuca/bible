import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import 'domain/usecases/get_books_use_case.dart';
import 'domain/usecases/get_verses_use_case.dart';
import 'domain/usecases/compare_verses_use_case.dart';
import 'presentation/providers/book_selection_provider.dart';
import 'presentation/providers/bible_reading_provider.dart';
import 'presentation/providers/theme_provider.dart';
import 'presentation/screens/book_selection_screen.dart';

class MyApp extends StatelessWidget {
  final GetBooksUseCase getBooksUseCase;
  final GetVersesUseCase getVersesUseCase;
  final CompareVersesUseCase compareVersesUseCase;

  const MyApp({
    Key? key,
    required this.getBooksUseCase,
    required this.getVersesUseCase,
    required this.compareVersesUseCase,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(
          create: (_) => BookSelectionProvider(getBooksUseCase),
        ),
        ChangeNotifierProvider(
          create: (_) => BibleReadingProvider(
            getVersesUseCase: getVersesUseCase,
            compareVersesUseCase: compareVersesUseCase,
          ),
        ),
      ],
      child: Consumer<ThemeProvider>(
        builder: (context, theme, child) => CupertinoApp(
          title: 'Bible App',
          debugShowCheckedModeBanner: false,
          builder: (context, child) {
            final brightness = theme.isDark
                ? Brightness.dark
                : Brightness.light;
            return CupertinoTheme(
              data: CupertinoThemeData(brightness: brightness),
              child: child!,
            );
          },
          home: const BookSelectionScreen(),
        ),
      ),
    );
  }
}