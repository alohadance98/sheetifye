# Getting Started

Welcome to Sheetify! This guide will help you get a spreadsheet viewer running in your Flutter app in under 2 minutes.

## 1. Add Dependency

Add `sheetify` to your `pubspec.yaml`:

```bash
flutter pub add sheetify
```

## 2. Setup ProviderScope

Sheetify uses Riverpod for high-performance state management. Wrap your `runApp` with `ProviderScope`:

```dart
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}
```

## 3. Basic Usage

Load an XLSX file from your assets:

```dart
import 'package:sheetify/sheetify.dart';

class MySpreadsheetPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Sheetify.asset(
        'assets/data/inventory.xlsx',
      ),
    );
  }
}
```

## What's Next?

- [Installation Guide](installation.md) - For advanced setup.
- [Theming Guide](theming.md) - Match Sheetify to your app's design.
- [XLSX Support](xlsx_support.md) - Learn about supported Excel features.
- [Performance](performance.md) - Why Sheetify is fast.
