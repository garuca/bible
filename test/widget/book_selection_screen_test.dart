import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';

import 'package:bible/domain/entities/book.dart';
import 'package:bible/domain/entities/version.dart';
import 'package:bible/domain/repositories/bible_repository.dart';
import 'package:bible/domain/usecases/get_books_use_case.dart';
import 'package:bible/domain/usecases/get_verses_use_case.dart';
import 'package:bible/domain/entities/verse.dart';
import 'package:bible/domain/usecases/compare_verses_use_case.dart';
import 'package:bible/presentation/providers/book_selection_provider.dart';
import 'package:bible/presentation/providers/bible_reading_provider.dart';
import 'package:bible/presentation/screens/book_selection_screen.dart';

class FakeRepo implements BibleRepository {
  @override
  Future<List<Book>> getBooks(Version version) async {
    return [Book(id: 1, name: 'TestBook', number: 1)];
  }

  @override
  Future<List<Verse>> getVerses(
    Version version,
    int bookId,
    int chapter,
  ) async {
    return [];
  }
}

void main() {
  testWidgets('BookSelectionScreen displays picker and button', (tester) async {
    final fakeRepo = FakeRepo();
    final getBooks = GetBooksUseCase(fakeRepo);
    final getVerses = GetVersesUseCase(fakeRepo);
    final compareVerses = CompareVersesUseCase(fakeRepo);

    await tester.pumpWidget(
      CupertinoApp(
        home: MultiProvider(
          providers: [
            ChangeNotifierProvider(
                create: (_) => BookSelectionProvider(getBooks)),
            ChangeNotifierProvider(
                create: (_) => BibleReadingProvider(
                      getVersesUseCase: getVerses,
                      compareVersesUseCase: compareVerses,
                    )),
          ],
          child: const BookSelectionScreen(),
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.byType(CupertinoPicker), findsOneWidget);
    expect(find.byType(CupertinoTextField), findsOneWidget);
    expect(find.byType(CupertinoButton), findsWidgets);
    expect(find.text('TestBook'), findsOneWidget);
  });
}