import 'package:flutter/material.dart';

class ControladorTema {
  const ControladorTema._();

  static final ValueNotifier<bool> modoEscuroAtivo = ValueNotifier<bool>(false);

  static ThemeMode get modoTema =>
      modoEscuroAtivo.value ? ThemeMode.dark : ThemeMode.light;

  static void alternarTema(bool valor) {
    modoEscuroAtivo.value = valor;
  }
}