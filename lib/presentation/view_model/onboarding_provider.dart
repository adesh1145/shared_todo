import 'package:flutter/material.dart';

class OnboardingProvider extends ChangeNotifier {
  int currentPage = 0;
  updateCurrentPage(int page) {
    currentPage = page;
    notifyListeners();
  }
}
