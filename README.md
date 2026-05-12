<p align="center">
  <img src="https://raw.githubusercontent.com/vikaspoute/sheetify/main/assets/logo.png" width="150" alt="Sheetify Logo" />
</p>

# Sheetify

### A lightweight, virtualized Flutter spreadsheet viewer with native XLSX support.

[![Pub Version](https://img.shields.io/pub/v/sheetify?logo=dart&color=blue)](https://pub.dev/packages/sheetify)
[![License](https://img.shields.io/badge/license-MIT-green)](LICENSE)
[![Flutter Compatibility](https://img.shields.io/badge/Flutter-3.10+-blue?logo=flutter)](https://flutter.dev)

---

**Sheetify** is a high-performance spreadsheet engine for Flutter. It’s designed to render large workbooks with millions of cells smoothly, providing a native experience for viewing and interacting with `.xlsx` data across Mobile, Desktop, and Web.

[**Explore the Docs**](docs/getting_started.md) • [**View Examples**](example/) • [**Report a Bug**](https://github.com/vikaspoute/sheetify/issues)

---

## ✨ Key Features

- 🚀 **Virtualized Rendering**: Handles millions of cells at 60+ FPS.
- 📦 **Native XLSX Support**: No external dependencies or Excel installations required.
- 🎨 **Theme Aware**: Automatically adapts to your app's light/dark mode and color scheme.
- 🖱️ **Selection System**: Support for single cell and range selection.
- ⌨️ **Formula Bar**: Integrated viewer for cell values and formulas.
- 📐 **Merged Cells**: Proper rendering and interaction with merged regions.
- 🌐 **Platform Native**: Optimized for Touch (Mobile) and Mouse/Keyboard (Desktop/Web).

## 📸 Screenshots

| Light Mode | Dark Mode |
|------------|-----------|
| ![Light Mode Placeholder](https://raw.githubusercontent.com/vikaspoute/sheetify/main/screenshots/light_mode.png) | ![Dark Mode Placeholder](https://raw.githubusercontent.com/vikaspoute/sheetify/main/screenshots/dark_mode.png) |

## 🚀 Quick Start

### 1. Add dependency

```bash
flutter pub add sheetify
```

### 2. Wrap with ProviderScope

Sheetify uses Riverpod for state management. Ensure your app is wrapped in a `ProviderScope`:

```dart
void main() {
  runApp(const ProviderScope(child: MyApp()));
}
```

### 3. Load a spreadsheet

```dart
import 'package:sheetify/sheetify.dart';

class MyView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Sheetify.asset(
        'assets/reports/annual_sales.xlsx',
        readOnly: true, // Default is true (v1 focus)
      ),
    );
  }
}
```

## 📂 Data Sources

Sheetify makes it easy to load data from anywhere:

```dart
// From Assets
Sheetify.asset('assets/data.xlsx')

// From Web
Sheetify.network('https://example.com/report.xlsx')

// From File
Sheetify.file(myFile)

// From Memory
Sheetify.memory(bytes)
```

## 🎨 Professional Theming

Match your brand perfectly with `SheetifyThemeData`:

```dart
Sheetify.asset(
  'data.xlsx',
  theme: SheetifyThemeData(
    primary: Colors.indigo,
    accent: Colors.amber,
    headerBackground: Colors.grey[100]!,
    fontFamily: 'Inter',
  ),
)
```

## 🛠 Roadmap

- [x] **v1.0.0**: High-performance read-only viewer, XLSX support, Selection system.
- [ ] **v1.1.0**: Basic cell editing and value updates.
- [ ] **v1.2.0**: Live formula engine and recalculation.
- [ ] **v2.0.0**: Advanced styling, charts, and conditional formatting.

## 🤝 Contributing

We love contributions! Check out our [Contributing Guide](CONTRIBUTING.md) to get started.

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

---

<p align="center">
  Built with ❤️ by <a href="https://github.com/vikaspoute">Vikas Poute</a>
</p>
