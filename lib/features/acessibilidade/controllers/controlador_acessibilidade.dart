import 'package:flutter/material.dart';

class ControladorAcessibilidade extends ChangeNotifier {
  ControladorAcessibilidade._();

  static final ControladorAcessibilidade instance = ControladorAcessibilidade._();

  double _escalaTexto = 1.0;

  double get escalaTexto => _escalaTexto;

  void definirEscalaTexto(double value) {
    if (_escalaTexto == value) return;
    _escalaTexto = value;
    notifyListeners();
  }
}