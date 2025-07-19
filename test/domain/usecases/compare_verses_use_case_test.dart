import 'package:flutter_test/flutter_test.dart';
import 'package:bible/core/domain/entities/verse.dart';
import 'package:bible/core/domain/entities/version.dart';
import 'package:bible/core/domain/repositories/bible_repository.dart';
import 'package:bible/core/domain/usecases/compare_verses_use_case.dart';
import 'package:bible/core/domain/entities/book.dart';

class FakeBibleRepository implements BibleRepository {
  @override
  Future<List<Verse>> getVerses(
    Version version,
    int bookId,
    int chapter,
  ) async {
    return [Verse(bookId: bookId, chapter: chapter, verse: 1, text: version.name)];
  }

  @override
  Future<List<Book>> getBooks(Version version) async {
    throw UnimplementedError();
  }
}

void main() {
  late CompareVersesUseCase useCase;
  late FakeBibleRepository repository;

  setUp(() {
    repository = FakeBibleRepository();
    useCase = CompareVersesUseCase(repository);
  });

  test('should compare verses from both versions', () async {
    final result = await useCase(Version.KJA, Version.KJF, 1, 1);
    expect(result, contains(Version.KJA));
    expect(result, contains(Version.KJF));
    expect(result[Version.KJA]![0].text, 'KJA');
    expect(result[Version.KJF]![0].text, 'KJF');
  });
}