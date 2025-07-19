import 'package:flutter/cupertino.dart';

import 'package:bible/core/domain/entities/book.dart';
import 'package:bible/core/domain/entities/version.dart';
import 'package:bible/core/domain/usecases/get_books_use_case.dart';

class BookSelectionProvider extends ChangeNotifier {
  final GetBooksUseCase getBooksUseCase;
  List<Book> books = [];
  Book? selectedBook;
  int chapter = 1;

  BookSelectionProvider(this.getBooksUseCase) {
    loadBooks();
  }

  Future<void> loadBooks() async {
    books = await getBooksUseCase(Version.KJA);
    if (books.isNotEmpty) selectedBook = books.first;
    notifyListeners();
  }

  void selectBook(Book book) {
    selectedBook = book;
    notifyListeners();
  }

  void setChapter(String text) {
    final value = int.tryParse(text);
    if (value != null && value > 0) {
      chapter = value;
      notifyListeners();
    }
  }
}