import 'package:flutter/cupertino.dart';

import '../../domain/entities/verse.dart';
import '../../domain/entities/version.dart';
import '../../domain/usecases/get_verses_use_case.dart';
import '../../domain/usecases/compare_verses_use_case.dart';

class BibleReadingProvider extends ChangeNotifier {
  final GetVersesUseCase getVersesUseCase;
  final CompareVersesUseCase compareVersesUseCase;

  List<Verse> verses = [];
  List<Verse> versesLeft = [];
  List<Verse> versesRight = [];
  bool isComparing = false;
  Version version = Version.KJA;
  Version compareVersion = Version.KJF;
  double fontSize = 16.0;

  BibleReadingProvider({
    required this.getVersesUseCase,
    required this.compareVersesUseCase,
  });

  Future<void> loadVerses(
    Version version,
    int bookId,
    int chapter,
  ) async {
    isComparing = false;
    this.version = version;
    verses = await getVersesUseCase(version, bookId, chapter);
    notifyListeners();
  }

  void increaseFont() {
    fontSize += 2;
    notifyListeners();
  }

  Future<void> compareVerses(
    Version left,
    Version right,
    int bookId,
    int chapter,
  ) async {
    isComparing = true;
    version = left;
    compareVersion = right;
    final result = await compareVersesUseCase(left, right, bookId, chapter);
    versesLeft = result[left] ?? [];
    versesRight = result[right] ?? [];
    notifyListeners();
  }
}