import 'package:bible/core/domain/entities/book.dart';
import 'package:bible/core/domain/entities/version.dart';
import 'package:bible/core/domain/repositories/bible_repository.dart';

class GetBooksUseCase {
  final BibleRepository repository;

  GetBooksUseCase(this.repository);

  Future<List<Book>> call(Version version) {
    return repository.getBooks(version);
  }
}