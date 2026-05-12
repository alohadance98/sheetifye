# Getting Started

Get a fully interactive spreadsheet viewer running in your Flutter app in under 2 minutes.

---

## Prerequisites

Before you begin, make sure you have:

- Flutter **3.10** or later
- Dart **3.0** or later
- An existing Flutter project (`flutter create` is fine)

---

## Step 1 — Add the dependency

```bash
flutter pub add sheetifye
```

Or add it manually to your `pubspec.yaml`:

```yaml
dependencies:
  sheetifye: ^1.0.0
```

Then run:

```bash
flutter pub get
```

---

## Step 2 — Wrap with ProviderScope

Sheetifye uses [Riverpod](https://riverpod.dev) for state management. Add `ProviderScope` once at the root of your app — if you already have one, you're done.

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

> [!NOTE]
> If your app already uses Riverpod, no additional setup is needed. Sheetifye will share the existing `ProviderScope`.

---

## Step 3 — Load a spreadsheet

Add an `.xlsx` file to your assets and declare it in `pubspec.yaml`:

```yaml
flutter:
  assets:
    - assets/data/inventory.xlsx
```

Then drop the widget into any screen:

```dart
import 'package:sheetifye/sheetifye.dart';

class SpreadsheetPage extends StatelessWidget {
  const SpreadsheetPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Sheetifye.asset(
        'assets/data/inventory.xlsx',
      ),
    );
  }
}
```

Run your app — that's all it takes.

---

## What's Next?

| Guide | Description |
|:---|:---|
| [Installation](installation.md) | Platform-specific setup, permissions, and advanced configuration |
| [Theming](theming.md) | Match Sheetifye's appearance to your app's design system |
| [XLSX Support](xlsx_support.md) | Supported Excel features, formulas, and known limitations |
| [Performance](performance.md) | How virtualized rendering works and how to tune it |

---

<sub>Stuck? <a href="https://github.com/vikaspoute/sheetifye/issues">Open an issue</a> and we'll help you get unblocked.</sub>