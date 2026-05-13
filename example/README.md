# Sheetifye Gallery & Quick Start

Welcome to the **Sheetifye** example gallery. This project demonstrates how to build a professional **spreadsheet UI in Flutter** using our high-performance engine.

---

## 🚀 Quick Start (Copy-Paste)

If you want to add a **spreadsheet viewer** to your app in under a minute, copy this into your `main.dart`:

```dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sheetifye/sheetifye.dart';

void main() {
  runApp(
    const ProviderScope( // 1. Wrap with ProviderScope
      child: MaterialApp(
        home: Scaffold(
          body: Sheetifye.asset('assets/data.xlsx'), // 2. Drop the widget
        ),
      ),
    ),
  );
}
```

---

## 🎨 Features Demonstrated

- **Multi-Format Support**: Native loading of both **XLSX** and **CSV** files.
- **Dynamic Theming**: Switching between light and dark modes with custom accent colors.
- **Performance Stress Tests**: Smooth scrolling with datasets containing millions of cells.
- **Selection API**: How to listen to cell selections and interact with the grid programmatically.
- **Formula Bar Integration**: Syncing a custom UI with the active sheet's data.

---

## 🏃 Running the Gallery

1.  **Clone & Navigate**:
    ```bash
    git clone https://github.com/vikaspoute/sheetifye.git
    cd sheetifye/example
    ```
2.  **Install & Launch**:
    ```bash
    flutter pub get
    flutter run
    ```

---

## 📂 Project Structure

- `lib/main.dart`: Simplified entry point.
- `lib/app.dart`: App-level configuration and theme.
- `lib/screens/gallery_screen.dart`: The core UI showcasing different loading sources and performance benchmarks.

---

<sub>Built with ❤️ for the Flutter community. If you find this example helpful, give us a ⭐ on [GitHub](https://github.com/vikaspoute/sheetifye)!</sub>
