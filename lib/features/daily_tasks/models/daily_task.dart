import 'package:flutter/material.dart';

class DailyTask {
  DailyTask({
    required this.title,
    required this.category,
    required this.time,
    required this.isCompleted,
    required this.icon,
  });

  final String title;
  final String category;
  final String time;
  final bool isCompleted;
  final IconData icon;

  DailyTask copyWith({
    String? title,
    String? category,
    String? time,
    bool? isCompleted,
    IconData? icon,
  }) {
    return DailyTask(
      title: title ?? this.title,
      category: category ?? this.category,
      time: time ?? this.time,
      isCompleted: isCompleted ?? this.isCompleted,
      icon: icon ?? this.icon,
    );
  }
}
