import 'dart:convert';
import 'package:flutter/services.dart';
import '../models/menu_item_model.dart';

// Источник данных для загрузки пунктов меню из локального JSON-файла в assets
class MenuLocalDataSource {
  Future<List<MenuItemModel>> loadMenuItems() async {
    final jsonString = await rootBundle.loadString('assets/menu.json');
    final Map<String, dynamic> jsonMap = json.decode(jsonString);
    final List<dynamic> items = jsonMap['menuItems'];
    return items.map((e) => MenuItemModel.fromJson(e)).toList();
  }
}