# Sheetifye Gallery

A comprehensive demonstration of **Sheetifye**, a high-performance spreadsheet engine for Flutter. This gallery showcases how to integrate native XLSX parsing, virtualized rendering, and custom theming into your own applications.

---

## 🚀 Features Demonstrated
- **Native Loading**: Loading `.xlsx` files from Assets, Network, and Memory.
- **Performance**: Bi-directional scrolling with millions of cells at 60+ FPS.
- **Theming**: Dynamic switching between Light and Dark modes with custom brand colors.
- **Interactions**: Cell selection, range selection, and formula bar integration.
- **Layout**: Handling merged cells and dynamic column/row measurements.

---

## 🛠️ Quick Start (Single-File Example)

If you want to get started with the most basic implementation, copy this into your `main.dart`:

```dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sheetifye/sheetifye.dart';

void main() {
  runApp(
    // 1. Wrap your app in a ProviderScope
    const ProviderScope(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: SpreadsheetHome(),
      ),
    ),
  );
}

class SpreadsheetHome extends StatelessWidget {
  const SpreadsheetHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Sheetifye Demo')),
      // 2. Drop in the Sheetifye widget
      body: Sheetifye.asset(
        'assets/data.xlsx',
        readOnly: true, // Set to false to enable editing (v1.1+)
      ),
    );
  }
}
```

---

## 🏃 How to Run the Full Gallery

1. **Clone the repository**:
   ```bash
   git clone https://github.com/vikaspoute/sheetifye.git
   cd sheetifye/example
   ```

2. **Install dependencies**:
   ```bash
   flutter pub get
   ```

3. **Launch the app**:
   ```bash
   flutter run
   ```

---

## 📂 Project Structure
- `lib/main.dart`: App entry point and `ProviderScope` setup.
- `lib/app.dart`: Main `MaterialApp` and theme configuration.
- `lib/screens/gallery_screen.dart`: The core UI showcasing different loading sources and performance tests.

---

<sub>Built with ❤️ by [Vikas Poute](https://github.com/vikaspoute). Find it useful? Give us a ⭐ on [GitHub](https://github.com/vikaspoute/sheetifye)!</sub>
