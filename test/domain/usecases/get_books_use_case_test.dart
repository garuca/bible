import 'package:flutter_test/flutter_test.dart';
import 'package:bible/domain/entities/book.dart';
import 'package:bible/domain/entities/version.dart';
import 'package:bible/domain/repositories/bible_repository.dart';
import 'package:bible/domain/usecases/get_books_use_case.dart';
import 'package:bible/domain/entities/verse.dart';

class FakeBibleRepository implements BibleRepository {
  @override
  Future<List<Book>> getBooks(Version version) async {
    return [Book(id: 1, name: 'Test', number: 1)];
  }

  @override
  Future<List<Verse>> getVerses(
    Version version,
    int bookId,
    int chapter,
  ) async {
    throw UnimplementedError();
  }
}

void main() {
  late GetBooksUseCase useCase;
  late FakeBibleRepository repository;

  setUp(() {
    repository = FakeBibleRepository();
    useCase = GetBooksUseCase(repository);
  });

  test('should get books from repository', () async {
    final result = await useCase(Version.KJA);
    expect(result, isA<List<Book>>());
    expect(result.length, 1);
    expect(result.first.name, 'Test');
  });
}