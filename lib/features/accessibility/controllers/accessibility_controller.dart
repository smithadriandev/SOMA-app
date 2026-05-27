import 'package:flutter/material.dart';

class AccessibilityController extends ChangeNotifier {
  AccessibilityController._();

  static final AccessibilityController instance = AccessibilityController._();

  double _textScale = 1.0;

  double get textScale => _textScale;

  void setTextScale(double value) {
    if (_textScale == value) return;
    _textScale = value;
    notifyListeners();
  }
}