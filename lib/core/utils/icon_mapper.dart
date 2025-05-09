import 'package:flutter/material.dart';

// Утилита для сопоставления строкового имени иконки с иконками Material
IconData getIconData(String? iconName) {
  switch (iconName) {
    case 'event':
      return Icons.event;
    case 'person':
      return Icons.person;
    case 'note':
      return Icons.note;
    case 'medical_services':
      return Icons.medical_services;
    case 'visibility':
      return Icons.visibility;
    case 'analytics':
      return Icons.analytics;
    case 'receipt':
      return Icons.receipt;
    case 'money':
      return Icons.money;
    case 'sell':
      return Icons.sell;
    case 'report':
      return Icons.insert_chart;
    default:
      return Icons.circle;
  }
}