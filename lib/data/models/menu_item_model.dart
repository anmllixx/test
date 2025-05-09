import '../../domain/entities/menu_item.dart';

// Модель для десериализации JSON и конвертации в доменную сущность MenuItem
class MenuItemModel extends MenuItem {
  MenuItemModel({String? icon, String? text, String? page, String? section})
      : super(icon: icon, text: text, page: page, section: section);

  factory MenuItemModel.fromJson(Map<String, dynamic> json) {
    return MenuItemModel(
      icon: json['icon'],
      text: json['text'],
      page: json['page'],
      section: json['section'],
    );
  }
}