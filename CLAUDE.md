# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

This is a Flutter enterprise project template using **Feature-first architecture** combined with **Clean Architecture** principles, with **MVVM pattern** within each feature. The project uses **Provider** for state management and **Material 3** design system.

### Architecture Pattern

```
features/ (presentation layer)
    ↓ depends on
core/domain/ (domain abstraction layer)
    ↑ implemented by
data/ (data layer)
```

- **Feature-first**: Each business feature is self-contained in `features/[feature]/`
- **Clean Architecture**: Features depend only on `core` (including `core/domain` interfaces), never directly on `data` implementations
- **Feature MVVM**: Each feature has View, ViewModel, and optional Models

### Dependency Rules

- `features` → `core` (allowed, via Repository interfaces)
- `features` → `data` (forbidden - use `core/domain` interfaces instead)
- `data` → `core` (allowed, to implement Repository interfaces)
- `data` → `features` (forbidden)

## Directory Structure

```
lib/
├── main.dart              # App entry point
├── app.dart               # Root widget with MaterialApp, theme, routes, providers
├── core/
│   ├── constants/         # App & API constants
│   ├── theme/             # AppTheme, AppColors
│   ├── router/            # AppRouter, RouteNames
│   ├── utils/             # Extensions, validators
│   ├── widgets/           # Global reusable components (buttons, dialogs, loading)
│   ├── errors/            # AppException, error handling
│   ├── network/           # API client configuration
│   └── domain/            # Cross-feature domain abstractions (Repository interfaces)
├── data/
│   ├── datasources/       # Remote API and local storage implementations
│   ├── models/            # DTOs with JSON serialization
│   ├── repositories/      # Repository implementations (implement core/domain interfaces)
│   └── di/                # Data layer dependency injection (DataInjection class)
└── features/
    └── [feature]/
        ├── presentation/
        │   ├── view/      # Pages and feature-specific widgets
        │   └── viewmodel/ # ChangeNotifier ViewModels with business logic
        └── models/        # Feature-specific models (optional)
```

## Common Commands

### Version Management
This project uses FVM (Flutter Version Management) to lock Flutter version to 3.38.10.
```bash
fvm flutter pub get    # Install dependencies
fvm flutter run        # Run app
fvm flutter test       # Run tests
fvm flutter analyze    # Run static analysis
```

### Without FVM (if available in PATH)
```bash
flutter pub get
flutter run
flutter test
flutter analyze
```

## Key Patterns

### Adding a New Feature

1. Create feature directory: `features/[feature]/`
2. Define Repository interface in `core/domain/repositories/` if needed
3. Implement Repository in `data/repositories/`
4. Create ViewModel in `features/[feature]/presentation/viewmodel/`
5. Create View in `features/[feature]/presentation/view/`
6. Add route name to `core/router/route_names.dart`
7. Add route case to `core/router/app_router.dart`
8. Register Provider in `app.dart`

### State Management with Provider

- ViewModels extend `ChangeNotifier`
- Use `ListenableBuilder` with `context.watch<ViewModel>()` in views
- Access ViewModel methods with `context.read<ViewModel>()`
- Use `notifyListeners()` to trigger rebuilds

### Data Layer Pattern

```dart
// 1. Define interface in core/domain/repositories/
abstract class SomeRepository {
  Future<SomeModel> fetchData();
}

// 2. Implement in data/repositories/
class SomeRepositoryImpl implements SomeRepository {
  final SomeRemoteDataSource _remote;
  final SomeLocalDataSource _local;

  SomeRepositoryImpl(this._remote, this._local);

  @override
  Future<SomeModel> fetchData() async {
    final data = await _remote.fetchData();
    await _local.cacheData(data);
    return data;
  }
}

// 3. Register in data/di/data_injection.dart
class DataInjection {
  static SomeRepository provideSomeRepository(...) {
    return SomeRepositoryImpl(remote, local);
  }
}

// 4. Provide in app.dart
final someRepo = DataInjection.provideSomeRepository(...);
Provider<SomeRepository>.value(value: someRepo)
```

### Routing

Routes are defined using a centralized `AppRouter` with `onGenerateRoute`. Access routes using:

```dart
Navigator.of(context).pushNamed(RouteNames.routeName);
Navigator.of(context).pushReplacementNamed(RouteNames.routeName);
```

## Theme & Design

- Uses Material 3 (`useMaterial3: true`)
- Light and dark themes defined in `AppTheme`
- Centralized colors in `AppColors`
- Custom widgets in `core/widgets/` (e.g., `AppButton`, `AppLoading`, `AppDialog`)

## Error Handling

- Use `AppException` for application-specific errors
- Define in `core/errors/` with message, optional code, and original exception
- ViewModels catch errors, set error state, and call `notifyListeners()`
- Views display errors from ViewModel state

## Data Sources

- **Remote**: API calls (currently stub implementations with simulated delays)
- **Local**: In-memory storage (replace with SharedPreferences/flutter_secure_storage for production)

## Testing

Test files go in `test/` directory mirroring `lib/` structure. Run tests with `flutter test`.