import 'package:flutter/material.dart';
import '../../../domain/entities/menu_item.dart';
import '../../../core/utils/icon_mapper.dart';

/// Нижняя навигационная панель для мобильной версии.
class BottomNavBar extends StatelessWidget {
  final List<MenuItem> items; // Список пунктов меню (макс. 4)
  final int currentIndex; // Текущий выбранный индекс
  final ValueChanged<int> onTap; // Обработчик нажатия по пункту меню

  const BottomNavBar({
    super.key,
    required this.items,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: onTap,
      items: items.take(4).map((item) {
        return BottomNavigationBarItem(
          icon: Icon(getIconData(item.icon)),
          label: item.text,
        );
      }).toList(),
      type: BottomNavigationBarType.fixed,
    );
  }
}