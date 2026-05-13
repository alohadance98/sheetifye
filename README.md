<div align="center">

# Sheetifye

### The Native High-Performance Spreadsheet & Excel Engine for Flutter

[![Pub Version](https://img.shields.io/pub/v/sheetifye?logo=dart&color=0175C2&labelColor=1d1d1f&label=pub&style=for-the-badge)](https://pub.dev/packages/sheetifye)
[![License](https://img.shields.io/badge/license-MIT-22c55e?labelColor=1d1d1f&style=for-the-badge)](LICENSE)
[![Flutter](https://img.shields.io/badge/Flutter-3.10+-54C5F8?logo=flutter&logoColor=white&labelColor=1d1d1f&style=for-the-badge)](https://flutter.dev)
[![Issues](https://img.shields.io/github/issues/vikaspoute/sheetifye?labelColor=1d1d1f&color=f59e0b&style=for-the-badge)](https://github.com/vikaspoute/sheetifye/issues)

<br/>

**Sheetifye** is a professional-grade **Flutter Excel viewer**, **CSV reader**, and **spreadsheet renderer** built for speed and flexibility. It provides a native, virtualized grid capable of rendering millions of cells with ease, making it the ultimate **spreadsheet UI for Flutter** developers.

<img src="https://raw.githubusercontent.com/vikaspoute/sheetifye/main/screenshots/graphic.png" alt="Sheetifye — High Performance Flutter Excel Viewer" width="100%" />

<br/>

<table border="0" cellspacing="0" cellpadding="8">
  <tr>
    <td align="center" width="33%">
      <img src="https://raw.githubusercontent.com/vikaspoute/sheetifye/main/screenshots/ios.png" alt="Virtualized Spreadsheet Rendering on iOS" width="100%" />
      <br/><sub><b>📱 iOS</b></sub>
    </td>
    <td align="center" width="33%">
      <img src="https://raw.githubusercontent.com/vikaspoute/sheetifye/main/screenshots/android.png" alt="High Performance Excel Grid on Android" width="100%" />
      <br/><sub><b>🤖 Android</b></sub>
    </td>
    <td align="center" width="33%">
      <img src="https://raw.githubusercontent.com/vikaspoute/sheetifye/main/screenshots/web.png" alt="Native XLSX Viewer on Flutter Web" width="100%" />
      <br/><sub><b>🌐 Web / Desktop</b></sub>
    </td>
  </tr>
</table>

[**📖 Documentation**](doc/getting_started.md) &nbsp;·&nbsp; [**💡 Gallery Example**](example/) &nbsp;·&nbsp; [**📋 Release Notes**](CHANGELOG.md) &nbsp;·&nbsp; [**🐛 Report Issue**](https://github.com/vikaspoute/sheetifye/issues)

</div>

---

## 🚀 Feature Highlights

*   ⚡ **High-Performance Virtualization**: Smooth **spreadsheet viewer** experience with 60+ FPS, even with millions of rows and columns.
*   📦 **Native XLSX & CSV Support**: Built-in parsers for **Excel** and **CSV** files that work locally without external dependencies or heavy WebViews.
*   🎨 **Full Theming**: Matches your app’s `ThemeData` automatically or via a dedicated `SheetifyeThemeData`.
*   🖱️ **Interactive Grid**: Advanced selection system supporting single-cell, range selection, and keyboard navigation.
*   📐 **Merged Cells**: Pixel-perfect rendering of complex layouts and merged regions.
*   ⌨️ **Integrated Formula Bar**: View raw cell data and computed formulas in a professional **Excel-like UI**.
*   🌐 **Cross-Platform**: Optimized for touch on Mobile and mouse/keyboard on Desktop and Web.

---

## Why Sheetifye?

Most **Flutter Excel packages** rely on slow WebViews or lack professional features like virtualization and cell selection. **Sheetifye** is a custom-built **spreadsheet engine** that paints directly to the Flutter canvas.

- **No WebView / No PlatformView**: 100% native Flutter rendering.
- **Offline First**: Works entirely offline with a local **XLSX parser**.
- **Memory Efficient**: Uses a specialized LRU cache for formula management and rendering.
- **Developer Friendly**: Drop-in widget that handles all the complexity of Excel layouts.

---

## Supported Platforms

| Platform | Support | Rendering |
|:---|:---:|:---|
| **iOS** | ✅ | Native Canvas |
| **Android** | ✅ | Native Canvas |
| **Web** | ✅ | CanvasKit / HTML |
| **Windows** | ✅ | Native Canvas |
| **macOS** | ✅ | Native Canvas |
| **Linux** | ✅ | Native Canvas |

---

## Installation

Add `sheetifye` to your `pubspec.yaml`:

```bash
flutter pub add sheetifye
```

Or manually:

```yaml
dependencies:
  sheetifye: ^1.0.2
```

---

## Quick Start

### 1. Initialize State
Sheetifye uses [Riverpod](https://riverpod.dev) for high-performance state management. Wrap your app in a `ProviderScope`:

```dart
void main() {
  runApp(const ProviderScope(child: MyApp()));
}
```

### 2. Add the Spreadsheet Viewer
```dart
import 'package:sheetifye/sheetifye.dart';

class MyExcelView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Sheetifye.asset('assets/reports/sales_2024.xlsx'),
    );
  }
}
```

---

## Usage Examples

### 📁 Load from Assets
Perfect for bundling static templates or reports with your application.
```dart
Sheetifye.asset('assets/template.xlsx')
```

### 🌐 Load from Network
Fetch and render remote spreadsheets directly from your API or Cloud Storage.
```dart
Sheetifye.network('https://example.com/data.xlsx')
```

### 💾 Load from File
Ideal for apps that interact with the local device storage or downloads.
```dart
Sheetifye.file(File('/storage/emulated/0/Download/report.xlsx'))
```

### 🧠 Load from Memory
Useful when receiving bytes from a file picker or an encrypted source.
```dart
Sheetifye.memory(excelBytes)
```

---

## Technical Details

### 🏗️ Architecture
Sheetifye follows a **Refined Monolithic Architecture** optimized for speed. The rendering pipeline uses a multi-stage process:
1.  **Virtualization**: Identifies only visible cells.
2.  **Layout**: Computes pixel-perfect positions.
3.  **Painting**: Draws directly to the Canvas in a single pass.

### ⚡ Performance
Designed for **High-Performance Spreadsheet** needs.
- **Memory Footprint**: ~45MB for a 50,000-row dataset.
- **Scroll Latency**: < 1ms on modern devices.
- **Background Parsing**: XLSX files are processed in a separate isolate to prevent UI jank.

### 📑 XLSX & CSV Support
Our **native XLSX & CSV** parser handles:
- Multi-sheet workbooks (XLSX)
- Standard CSV files
- Cell styling (bold, italic, colors)
- Column widths and row heights
- Merged cell regions
- Calculated formula results

---

## Custom Theming

Make your **Excel Grid Flutter** implementation look exactly like your app.

```dart
Sheetifye.asset(
  'assets/data.xlsx',
  theme: SheetifyeThemeData(
    primaryColor: Colors.deepPurple,
    headerBackground: Colors.grey[50],
    gridColor: Colors.blueGrey[100],
    fontFamily: 'Inter',
  ),
)
```

---

## Comparison Section

| Feature | Sheetifye | Syncfusion | PlutoGrid |
|:---|:---:|:---:|:---:|
| **XLSX Parsing** | ✅ Native | 🟡 Required Add-on | ❌ None |
| **Virtualization** | ✅ Built-in | ✅ Built-in | 🟡 Partial |
| **Formula Engine** | ✅ Native AST | 🟡 Partial | ❌ None |
| **Memory Usage** | 💎 Ultra Low | 🔴 High | 🟡 Medium |
| **Customization** | ✅ High | 🟡 Config only | 🟡 Mixins |

---

## Roadmap

- [x] **v1.0.0**: Native XLSX Viewer & Virtualized Grid
- [ ] **v1.1.0**: Basic Cell Editing & In-memory Updates
- [ ] **v1.2.0**: Live Formula Re-calculation Engine
- [ ] **v2.0.0**: Advanced Styling, Charts & Conditional Formatting

---

## Contributing

We welcome contributions to make Sheetifye the best **Flutter spreadsheet package**! Check out our [Contributing Guide](CONTRIBUTING.md) to get started.

## License

Sheetifye is released under the **MIT License**. See [LICENSE](LICENSE) for details.

---

<div align="center">

Built with ❤️ by [Vikas Poute](https://github.com/vikaspoute)

⭐ **Help us grow! If you find Sheetifye useful, please give it a star on [GitHub](https://github.com/vikaspoute/sheetifye).** ⭐

</div>