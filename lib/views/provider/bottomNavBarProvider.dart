import 'package:flutter/material.dart';

class BottomNavigationBarProvider with ChangeNotifier {
  int _currentIndex = 0;
 
  int get currentIndex {
    return _currentIndex;
  } 

  set currentIndex(int index) {
    _currentIndex = index;
    notifyListeners();
  }
}