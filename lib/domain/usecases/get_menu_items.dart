import '../entities/menu_item.dart';
import '../repositories/menu_repository.dart';

// UseCase для получения элементов меню из репозитория
class GetMenuItems {
  final MenuRepository repository;

  GetMenuItems(this.repository);

  Future<List<MenuItem>> call() async {
    return repository.getMenuItems();
  }
}