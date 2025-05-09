import 'package:flutter/material.dart';
import '../../../domain/entities/menu_item.dart';
import '../../../core/utils/icon_mapper.dart';

/// Боковое меню для десктоп/веб версии приложения.
class SidebarMenu extends StatelessWidget {
  final List<MenuItem> items; // Список всех пунктов меню
  final bool isCollapsed; // Состояние свёрнутости меню
  final AnimationController animationController; // Контроллер анимации
  final Animation<double> widthAnimation; // Анимация ширины
  final Function(MenuItem) onItemSelected; // Колбэк при выборе пункта меню
  final String selectedText; // Текущий выбранный пункт

  const SidebarMenu({
    super.key,
    required this.items,
    required this.isCollapsed,
    required this.animationController,
    required this.widthAnimation,
    required this.onItemSelected,
    required this.selectedText,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animationController,
      builder: (context, child) {
        return Container(
          width: widthAnimation.value,
          decoration: BoxDecoration(
            color: Colors.grey[200],
            boxShadow: [
              BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 4, offset: const Offset(2, 0)),
            ],
          ),
          child: ListView(
            padding: EdgeInsets.zero,
            children: items.map((item) {
              if (item.section != null) {
                // Раздел меню (заголовок)
                return AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  height: isCollapsed ? 24 : 48,
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: AnimatedOpacity(
                    duration: const Duration(milliseconds: 150),
                    opacity: isCollapsed ? 0 : 1,
                    child: Text(item.section!, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                  ),
                );
              }
              // Элемент меню
              return ListTile(
                leading: Icon(getIconData(item.icon)),
                title: AnimatedOpacity(
                  duration: const Duration(milliseconds: 200),
                  opacity: isCollapsed ? 0 : 1,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8),
                    child: Text(item.text ?? '', overflow: TextOverflow.ellipsis),
                  ),
                ),
                onTap: () => onItemSelected(item),
                selected: selectedText == item.text,
                dense: true,
              );
            }).toList(),
          ),
        );
      },
    );
  }
}