import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import 'package:bible/core/domain/usecases/get_books_use_case.dart';
import 'package:bible/core/domain/usecases/get_verses_use_case.dart';
import 'package:bible/core/domain/usecases/compare_verses_use_case.dart';
import 'package:bible/core/presentation/providers/theme_provider.dart';
import 'package:bible/features/book_selection/presentation/book_selection_provider.dart';
import 'package:bible/features/bible_reading/presentation/bible_reading_provider.dart';
import 'package:bible/features/book_selection/presentation/book_selection_screen.dart';

class MyApp extends StatelessWidget {
  final GetBooksUseCase getBooksUseCase;
  final GetVersesUseCase getVersesUseCase;
  final CompareVersesUseCase compareVersesUseCase;

  const MyApp({
    super.key,
    required this.getBooksUseCase,
    required this.getVersesUseCase,
    required this.compareVersesUseCase,
  });

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