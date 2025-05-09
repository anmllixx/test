import '../../domain/entities/menu_item.dart';
import '../../domain/repositories/menu_repository.dart';
import '../datasources/menu_local_data_source.dart';

// Реализация MenuRepository, использующая локальный источник данных (JSON)
class MenuRepositoryImpl implements MenuRepository {
  final MenuLocalDataSource localDataSource;

  MenuRepositoryImpl(this.localDataSource);

  @override
  Future<List<MenuItem>> getMenuItems() async {
    return localDataSource.loadMenuItems();
  }
}