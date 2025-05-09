# 🩺 Flutter Test Task — Medical Menu App

Кроссплатформенное Flutter-приложение с динамическим боковым меню и адаптацией под Web и Mobile. Выполнено по принципам **чистой архитектуры**.

## 📦 Стек технологий

- Flutter (Mobile + Web)
- Dart
- Clean Architecture (Presentation / Domain / Data)
- Material Design 3
- Адаптивная верстка (responsive)

## 🧱 Архитектура проекта

lib/
├── core/ # Вспомогательные утилиты (иконки и т.п.)
├── data/ # Работа с источниками данных (JSON)
├── domain/ # Бизнес-логика и интерфейсы репозиториев
├── presentation/ # UI: экраны, виджеты, навигация
├── app.dart # Обертка приложения
└── main.dart # Точка входа


📁 JSON-меню находится в: `assets/menu.json`

---

## 📱 Особенности

✅ Боковое меню с анимацией (Web/Десктоп)  
✅ BottomNavigationBar для мобильных  
✅ Страницы-заглушки по каждой команде  
✅ Меню загружается из локального JSON  
✅ Плавные анимации, читаемый код  
✅ Комментарии к основным модулям

## 🚀 Как запустить

> Убедитесь, что установлен Flutter: [https://docs.flutter.dev/get-started/install](https://docs.flutter.dev/get-started/install)

``bash
# 1. Клонируйте репозиторий
git clone https://github.com/anmllixx/test.git
cd test

# 2. Установите зависимости
flutter pub get

# (Опционально — очистка кеша, если что-то не работает)
# flutter clean
# flutter pub get

# 3. Запустите приложение
flutter run

👩‍💻 Автор
Anastasia Petrova
GitHub @anmllixx
