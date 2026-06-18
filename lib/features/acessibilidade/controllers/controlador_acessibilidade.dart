import 'package:flutter/material.dart';

class ControladorAcessibilidade extends ChangeNotifier {
  ControladorAcessibilidade._();

  static final ControladorAcessibilidade instance =
      ControladorAcessibilidade._();

  double _escalaTexto = 1.0;
  bool _altoContraste = false;
  bool _botoesMaiores = false;

  double get escalaTexto => _escalaTexto;
  bool get altoContraste => _altoContraste;
  bool get botoesMaiores => _botoesMaiores;

  void definirEscalaTexto(double value) {
    if (_escalaTexto == value) return;
    _escalaTexto = value;
    notifyListeners();
  }

  void alternarAltoContraste(bool value) {
    if (_altoContraste == value) return;
    _altoContraste = value;
    notifyListeners();
  }

  void alternarBotoesMaiores(bool value) {
    if (_botoesMaiores == value) return;
    _botoesMaiores = value;
    notifyListeners();
  }
}
