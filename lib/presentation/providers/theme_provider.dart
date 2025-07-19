import 'package:flutter/cupertino.dart';

/// Manages manual light/dark theme selection.
class ThemeProvider extends ChangeNotifier {
  bool isDark = false;

  void toggle() {
    isDark = !isDark;
    notifyListeners();
  }
}