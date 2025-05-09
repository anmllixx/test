import '../entities/menu_item.dart';

// Абстракция репозитория для получения пунктов меню
abstract class MenuRepository {
  Future<List<MenuItem>> getMenuItems();
}