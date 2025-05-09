// Представляет пункт меню, загружаемый из JSON-файла.
class MenuItem {
  final String? icon;
  final String? text;
  final String? page;
  final String? section;

  const MenuItem({this.icon, this.text, this.page, this.section});
}