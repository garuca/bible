import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';

import 'package:bible/domain/entities/verse.dart';
import 'package:bible/domain/entities/version.dart';
import 'package:bible/domain/repositories/bible_repository.dart';
import 'package:bible/domain/usecases/get_verses_use_case.dart';
import 'package:bible/domain/usecases/compare_verses_use_case.dart';
import 'package:bible/domain/entities/book.dart';
import 'package:bible/presentation/providers/bible_reading_provider.dart';
import 'package:bible/presentation/screens/bible_reading_screen.dart';

class FakeRepo implements BibleRepository {
  @override
  Future<List<Verse>> getVerses(Version version, int bookId, int chapter) async {
    return [Verse(bookId: bookId, chapter: chapter, verse: 1, text: 'TestVerse')];
  }

  @override
  Future<List<Book>> getBooks(Version version) async {
    return [];
  }
}

void main() {
  testWidgets('BibleReadingScreen displays verses', (tester) async {
    final fakeRepo = FakeRepo();
    final getVerses = GetVersesUseCase(fakeRepo);
    final compareVerses = CompareVersesUseCase(fakeRepo);

    final provider = BibleReadingProvider(
      getVersesUseCase: getVerses,
      compareVersesUseCase: compareVerses,
    );
    await provider.loadVerses(Version.KJA, 1, 1);

    await tester.pumpWidget(
      CupertinoApp(
        home: ChangeNotifierProvider.value(
          value: provider,
          child: BibleReadingScreen(
            book: Book(id: 1, name: 'TestBook', number: 1),
            chapter: 1,
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('1. TestVerse'), findsOneWidget);
  });
}