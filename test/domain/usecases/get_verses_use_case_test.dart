import 'package:flutter_test/flutter_test.dart';
import 'package:bible/core/domain/entities/verse.dart';
import 'package:bible/core/domain/entities/version.dart';
import 'package:bible/core/domain/repositories/bible_repository.dart';
import 'package:bible/core/domain/usecases/get_verses_use_case.dart';
import 'package:bible/core/domain/entities/book.dart';

class FakeBibleRepository implements BibleRepository {
  @override
  Future<List<Verse>> getVerses(
    Version version,
    int bookId,
    int chapter,
  ) async {
    return [Verse(bookId: bookId, chapter: chapter, verse: 1, text: 'Test')];
  }

  @override
  Future<List<Book>> getBooks(Version version) async {
    throw UnimplementedError();
  }
}

void main() {
  late GetVersesUseCase useCase;
  late FakeBibleRepository repository;

  setUp(() {
    repository = FakeBibleRepository();
    useCase = GetVersesUseCase(repository);
  });

  test('should get verses from repository', () async {
    final result = await useCase(Version.KJF, 1, 1);
    expect(result, isA<List<Verse>>());
    expect(result.length, 1);
    expect(result.first.text, 'Test');
  });
}