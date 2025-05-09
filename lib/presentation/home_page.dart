import 'package:flutter/material.dart';

// Импортируем страницы-заглушки
import 'pages/calendar_page.dart';
import 'pages/patients_page.dart';
import 'pages/records_page.dart';
import 'pages/events_page.dart';
import 'pages/appointments_page.dart';
import 'pages/checkups_page.dart';
import 'pages/tests_page.dart';
import 'pages/prescriptions_page.dart';
import 'pages/cash_registers_page.dart';
import 'pages/sales_page.dart';
import 'pages/reports_page.dart';
import 'pages/empty_page.dart';

// Импортируем бизнес-логику и доступ к данным
import '../../domain/entities/menu_item.dart';
import '../../domain/usecases/get_menu_items.dart';
import '../../data/datasources/menu_local_data_source.dart';
import '../../data/repositories/menu_repository_impl.dart';

// Импортируем виджеты интерфейса
import 'widgets/sidebar_menu.dart';
import 'widgets/bottom_nav_bar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin {
  // Асинхронная загрузка пунктов меню
  late Future<List<MenuItem>> menuItems;

  // UseCase для получения меню
  late GetMenuItems getMenuItemsUseCase;

  // Название текущей выбранной страницы
  String currentPage = 'Календарь';

  // Индекс текущей вкладки для мобильной версии
  int _currentIndex = 0;

  // Состояние: свернуто ли меню (веб)
  bool isCollapsed = false;

  // Контроллер анимации сворачивания меню (веб)
  late AnimationController _animationController;
  late Animation<double> _widthAnimation;

  // Список основных страниц для мобильного меню
  final List<String> _mobilePages = ['Календарь', 'Пациенты', 'Записи', 'События'];

  @override
  void initState() {
    super.initState();

    // Инициализация репозитория, use case и загрузка меню
    final repository = MenuRepositoryImpl(MenuLocalDataSource());
    getMenuItemsUseCase = GetMenuItems(repository);
    menuItems = getMenuItemsUseCase();

    // Инициализация анимации бокового меню
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _widthAnimation = Tween<double>(begin: 250, end: 72).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  // Переключение состояния бокового меню (веб)
  void _toggleMenu() {
    setState(() {
      isCollapsed = !isCollapsed;
      isCollapsed ? _animationController.forward() : _animationController.reverse();
    });
  }

  // Получаем только 4 пункта меню для нижней навигации на мобильных
  List<MenuItem> _getMobileMenuItems(List<MenuItem> allItems) {
    return allItems.where((item) => item.text != null && _mobilePages.contains(item.text)).toList();
  }

  @override
  Widget build(BuildContext context) {
    final bool isMobile = MediaQuery.of(context).size.width < 600;

    return FutureBuilder<List<MenuItem>>(
      future: menuItems,
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Scaffold(body: Center(child: CircularProgressIndicator()));
        }

        final items = snapshot.data!;
        final mobileItems = _getMobileMenuItems(items);

        // Мобильная версия интерфейса с нижней навигацией
        if (isMobile) {
          return Scaffold(
            appBar: AppBar(title: Text(_mobilePages[_currentIndex])),
            body: _buildPage(_mobilePages[_currentIndex]),
            bottomNavigationBar: BottomNavBar(
              items: mobileItems,
              currentIndex: _currentIndex,
              onTap: (index) {
                setState(() {
                  _currentIndex = index;
                  currentPage = _mobilePages[index];
                });
              },
            ),
          );
        }

        // Веб-десктоп версия с боковым меню и анимацией
        return Scaffold(
          appBar: AppBar(
            title: AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              child: Text(currentPage, key: ValueKey<String>(currentPage)),
            ),
            leading: IconButton(
              icon: Icon(isCollapsed ? Icons.menu : Icons.close),
              onPressed: _toggleMenu,
            ),
          ),
          body: Row(
            children: [
              SidebarMenu(
                items: items,
                isCollapsed: isCollapsed,
                animationController: _animationController,
                widthAnimation: _widthAnimation,
                onItemSelected: (item) => setState(() => currentPage = item.text ?? ''),
                selectedText: currentPage,
              ),
              Expanded(
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 300),
                  child: _buildPage(currentPage),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  // Возвращает соответствующую страницу по названию
  Widget _buildPage(String page) {
    switch (page) {
      case 'Календарь':
        return const CalendarPage();
      case 'Пациенты':
        return const PatientsPage();
      case 'Записи':
        return const RecordsPage();
      case 'События':
        return const EventsPage();
      case 'Приёмы врача':
        return const AppointmentsPage();
      case 'Медицинские осмотры':
        return const CheckupsPage();
      case 'Анализы':
        return const TestsPage();
      case 'Рецепты':
        return const PrescriptionsPage();
      case 'Кассы':
        return const CashRegistersPage();
      case 'Продажи':
        return const SalesPage();
      case 'Отчёты':
        return const ReportsPage();
      default:
        return EmptyPage(title: page);
    }
  }
}