# Homii - Smart Home Cooking Assistant

<div align="center">
  <img src="assets/app_icon.png" alt="Homii Logo" width="120" height="120">

  [![Flutter](https://img.shields.io/badge/Flutter-3.0+-blue.svg)](https://flutter.dev/)
  [![Dart](https://img.shields.io/badge/Dart-3.0+-blue.svg)](https://dart.dev/)
  [![License](https://img.shields.io/badge/License-MIT-green.svg)](LICENSE)
</div>

## 📱 About

Homii is a comprehensive Flutter-based mobile application designed to revolutionize your home cooking experience. The app combines meal planning, recipe management, pantry tracking, and smart shopping features to help users create delicious meals while maintaining their health goals.

## ✨ Features

### 🏠 **Home Dashboard**
- Personalized greeting and daily meal overview
- Quick access to all app features
- Smart notifications for meal reminders

### 📋 **Meal Planning**
- Weekly meal planner with drag-and-drop functionality
- Customizable meal categories (Breakfast, Lunch, Dinner, Snacks)
- Meal completion tracking with visual progress indicators

### 💾 **Saved Recipes**
- Curated collection of favorite recipes
- Advanced search and filtering capabilities
- Recipe categorization and tagging system

### 🛒 **Smart Shopping**
- Integrated shopping cart with real-time updates
- Product catalog with detailed information
- Seamless checkout experience

### 🥫 **Pantry Management**
- Digital pantry inventory tracking
- Expiration date monitoring
- Smart suggestions based on available ingredients

### 🔔 **Notifications**
- Real-time notifications with smooth slide animations
- Meal reminders and cooking tips
- Shopping list updates

### ⚙️ **Settings & Preferences**
- Dark/Light theme support
- Personalized dietary preferences
- Health data integration
- Goal tracking and progress monitoring

## 🚀 Getting Started

### Prerequisites

- Flutter SDK (3.0 or higher)
- Dart SDK (3.0 or higher)
- Android Studio / VS Code
- iOS Simulator / Android Emulator

### Installation

1. **Clone the repository**
   ```bash
   git clone https://github.com/KennyTangg/homii.git
   cd homii
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Run the application**
   ```bash
   flutter run
   ```

### Development Setup

1. **Enable device preview (optional)**
   ```bash
   flutter run -d chrome --web-renderer html
   ```

2. **Generate app icons**
   ```bash
   flutter packages pub run flutter_launcher_icons:main
   ```

3. **Run tests**
   ```bash
   flutter test
   ```

## 🏗️ Architecture

### Project Structure
```
lib/
├── main.dart                 # Application entry point
├── models/                   # Data models
│   ├── meal_plan_model.dart
│   └── user_model.dart
├── screens/                  # UI screens
│   ├── authentication/
│   ├── home/
│   ├── notifications/
│   ├── settings/
│   └── user_preferences/
├── services/                 # Business logic
│   ├── cart_service.dart
│   └── notification_service.dart
├── widgets/                  # Reusable components
│   ├── custom_search_bar.dart
│   ├── custom_notification.dart
│   └── slide_page_route.dart
└── theme/                    # App theming
    └── theme_provider.dart
```

### Key Design Patterns

- **Provider Pattern**: State management using Provider package
- **Singleton Pattern**: Cart service for global state management
- **Observer Pattern**: Real-time UI updates with ChangeNotifier
- **Factory Pattern**: Theme configuration and routing

## 🎨 Design System

### Color Palette
- **Primary**: Custom orange theme for warmth and appetite appeal
- **Secondary**: Complementary green for health and freshness
- **Surface**: Adaptive colors for light/dark mode support

### Typography
- **Headers**: Bold, readable fonts for navigation
- **Body**: Clean, accessible text for content
- **Captions**: Subtle styling for metadata

### Animations
- **Page Transitions**: Smooth slide animations between screens
- **Notifications**: Right-to-center slide animations
- **Micro-interactions**: Subtle feedback for user actions

## 📦 Dependencies

### Core Dependencies
```yaml
flutter:
  sdk: flutter
provider: ^6.0.5           # State management
device_preview: ^1.1.0     # Multi-device testing
```

### Development Dependencies
```yaml
flutter_test:
  sdk: flutter
flutter_lints: ^3.0.0     # Code quality
flutter_launcher_icons: ^0.13.1  # Icon generation
```

## 🧪 Testing

### Running Tests
```bash
# Run all tests
flutter test

# Run tests with coverage
flutter test --coverage

# Run integration tests
flutter drive --target=test_driver/app.dart
```

### Test Structure
- **Unit Tests**: Business logic validation
- **Widget Tests**: UI component testing
- **Integration Tests**: End-to-end user flows

## 🚀 Deployment

### Android
```bash
flutter build apk --release
flutter build appbundle --release
```

### iOS
```bash
flutter build ios --release
```

### Web
```bash
flutter build web --release
```

## 🤝 Contributing

We welcome contributions! Please follow these steps:

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

### Code Style
- Follow [Dart Style Guide](https://dart.dev/guides/language/effective-dart/style)
- Use meaningful variable and function names
- Add comments for complex logic
- Maintain consistent formatting

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 👥 Team

- **Development Team**: BINUS Computer Science Students
- **UI/UX Design**: Custom design system
- **Project Management**: Agile methodology

## 📞 Support

For support and questions:
- 📧 Email: support@homii.app
- 🐛 Issues: [GitHub Issues](https://github.com/yourusername/homii/issues)
- 📖 Documentation: [Wiki](https://github.com/yourusername/homii/wiki)

## 🔄 Changelog

### Version 1.0.0
- Initial release with core features
- Meal planning and recipe management
- Shopping cart functionality
- Dark/Light theme support

---

<div align="center">
  Made with ❤️ by the Homii Team
</div>
