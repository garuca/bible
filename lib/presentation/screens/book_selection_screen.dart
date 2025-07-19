import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import '../../domain/entities/version.dart';
import '../providers/book_selection_provider.dart';
import '../providers/bible_reading_provider.dart';
import '../providers/theme_provider.dart';
import 'bible_reading_screen.dart';

class BookSelectionScreen extends StatelessWidget {
  const BookSelectionScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<BookSelectionProvider>();
    final readingProvider = context.read<BibleReadingProvider>();
    final books = provider.books;
    final selectedBook = provider.selectedBook;
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text('Seleção de Livro'),
      ),
      child: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Dark Mode'),
                  CupertinoSwitch(
                    value: context.watch<ThemeProvider>().isDark,
                    onChanged: (_) => context.read<ThemeProvider>().toggle(),
                  ),
                ],
              ),
            ),
            Expanded(
              child: CupertinoPicker(
                itemExtent: 32,
                onSelectedItemChanged: (i) => provider.selectBook(books[i]),
                children: books.map((b) => Text(b.name)).toList(),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: CupertinoTextField(
                placeholder: 'Capítulo',
                keyboardType: TextInputType.number,
                onChanged: provider.setChapter,
              ),
            ),
            CupertinoButton.filled(
              onPressed: selectedBook == null
                  ? null
                  : () {
                      readingProvider.loadVerses(
                        Version.KJA,
                        selectedBook.id,
                        provider.chapter,
                      );
                      Navigator.of(context).push(
                        CupertinoPageRoute(
                          builder: (_) => BibleReadingScreen(
                            book: selectedBook,
                            chapter: provider.chapter,
                          ),
                        ),
                      );
                    },
              child: const Text('Abrir capítulo'),
            ),
          ],
        ),
      ),
    );
  }
}