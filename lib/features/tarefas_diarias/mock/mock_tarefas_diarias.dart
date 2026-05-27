import 'package:flutter/material.dart';

import '../models/tarefa_diaria.dart';

class MockTarefasDiarias {
  static List<TarefaDiaria> initialTasks() {
    return [
      TarefaDiaria(
        title: 'Escovar os dentes',
        category: 'Cuidados pessoais',
        time: '07:00',
        isCompleted: true,
        icon: Icons.cleaning_services_outlined,
      ),
      TarefaDiaria(
        title: 'Tomar banho',
        category: 'Cuidados pessoais',
        time: '07:30',
        isCompleted: true,
        icon: Icons.shower_outlined,
      ),
      TarefaDiaria(
        title: 'Trocar de roupa',
        category: 'Cuidados pessoais',
        time: '08:00',
        isCompleted: true,
        icon: Icons.checkroom_outlined,
      ),
      TarefaDiaria(
        title: 'Pentear o cabelo',
        category: 'Cuidados pessoais',
        time: '08:10',
        isCompleted: false,
        icon: Icons.face_retouching_natural_outlined,
      ),
      TarefaDiaria(
        title: 'Tomar café da manhã',
        category: 'Alimentação',
        time: '08:30',
        isCompleted: true,
        icon: Icons.free_breakfast_outlined,
      ),
      TarefaDiaria(
        title: 'Almoçar',
        category: 'Alimentação',
        time: '12:00',
        isCompleted: true,
        icon: Icons.restaurant_outlined,
      ),
      TarefaDiaria(
        title: 'Jantar',
        category: 'Alimentação',
        time: '19:00',
        isCompleted: false,
        icon: Icons.dinner_dining_outlined,
      ),
      TarefaDiaria(
        title: 'Beber água',
        category: 'Alimentação',
        time: '10:00',
        isCompleted: true,
        icon: Icons.water_drop_outlined,
      ),
      TarefaDiaria(
        title: 'Fazer lanche',
        category: 'Alimentação',
        time: '15:30',
        isCompleted: false,
        icon: Icons.bakery_dining_outlined,
      ),
      TarefaDiaria(
        title: 'Tomar remédio da manhã',
        category: 'Medicamentos',
        time: '08:00',
        isCompleted: true,
        icon: Icons.medication_outlined,
      ),
      TarefaDiaria(
        title: 'Tomar remédio da tarde',
        category: 'Medicamentos',
        time: '14:00',
        isCompleted: true,
        icon: Icons.medication_liquid_outlined,
      ),
      TarefaDiaria(
        title: 'Tomar remédio da noite',
        category: 'Medicamentos',
        time: '21:00',
        isCompleted: false,
        icon: Icons.medical_services_outlined,
      ),
      TarefaDiaria(
        title: 'Verificar se a porta está trancada',
        category: 'Segurança',
        time: '20:30',
        isCompleted: false,
        icon: Icons.lock_outline,
      ),
      TarefaDiaria(
        title: 'Desligar o fogão',
        category: 'Segurança',
        time: '13:00',
        isCompleted: false,
        icon: Icons.local_fire_department_outlined,
      ),
      TarefaDiaria(
        title: 'Levar documento ou identificação',
        category: 'Segurança',
        time: '09:00',
        isCompleted: true,
        icon: Icons.badge_outlined,
      ),
      TarefaDiaria(
        title: 'Fazer exercício de memória',
        category: 'Atividades cognitivas',
        time: '10:30',
        isCompleted: false,
        icon: Icons.psychology_outlined,
      ),
      TarefaDiaria(
        title: 'Ouvir música',
        category: 'Atividades cognitivas',
        time: '16:00',
        isCompleted: true,
        icon: Icons.music_note_outlined,
      ),
      TarefaDiaria(
        title: 'Ler uma frase do dia',
        category: 'Atividades cognitivas',
        time: '09:30',
        isCompleted: false,
        icon: Icons.menu_book_outlined,
      ),
      TarefaDiaria(
        title: 'Ver fotos da família',
        category: 'Atividades cognitivas',
        time: '17:00',
        isCompleted: false,
        icon: Icons.photo_library_outlined,
      ),
      TarefaDiaria(
        title: 'Caminhar',
        category: 'Atividade física leve',
        time: '07:45',
        isCompleted: true,
        icon: Icons.directions_walk_outlined,
      ),
      TarefaDiaria(
        title: 'Alongar',
        category: 'Atividade física leve',
        time: '18:00',
        isCompleted: false,
        icon: Icons.accessibility_new_outlined,
      ),
      TarefaDiaria(
        title: 'Sentar no sol por alguns minutos',
        category: 'Atividade física leve',
        time: '08:45',
        isCompleted: false,
        icon: Icons.wb_sunny_outlined,
      ),
    ];
  }
}
