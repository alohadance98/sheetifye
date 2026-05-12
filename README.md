<div align="center">

# ⚡ Sheetifye

**The spreadsheet widget Flutter was missing.**

[![Pub Version](https://img.shields.io/pub/v/sheetifye?logo=dart&color=0175C2&labelColor=1d1d1f&label=pub&style=for-the-badge)](https://pub.dev/packages/sheetifye)
[![License](https://img.shields.io/badge/license-MIT-22c55e?labelColor=1d1d1f&style=for-the-badge)](LICENSE)
[![Flutter](https://img.shields.io/badge/Flutter-3.10+-54C5F8?logo=flutter&logoColor=white&labelColor=1d1d1f&style=for-the-badge)](https://flutter.dev)
[![Issues](https://img.shields.io/github/issues/vikaspoute/sheetifye?labelColor=1d1d1f&color=f59e0b&style=for-the-badge)](https://github.com/vikaspoute/sheetifye/issues)

</div>

<br/>

> [!TIP]
> **One widget. Native XLSX. 60+ FPS. Zero dependencies.**
> Drop `Sheetifye` into any Flutter app and get a fully interactive spreadsheet viewer — on Mobile, Desktop, and Web — in under 5 minutes.

<br/>

<img src="https://raw.githubusercontent.com/vikaspoute/sheetifye/main/screenshots/graphic.png" alt="Sheetifye — See it in action" width="100%" />

<br/>

<div align="center">

<table border="0" cellspacing="0" cellpadding="8">
  <tr>
    <td align="center" width="33%">
      <img src="https://raw.githubusercontent.com/vikaspoute/sheetifye/main/screenshots/ios.png" alt="iOS" width="100%" />
      <br/><sub><b>📱 iOS</b></sub>
    </td>
    <td align="center" width="33%">
      <img src="https://raw.githubusercontent.com/vikaspoute/sheetifye/main/screenshots/android.png" alt="Android" width="100%" />
      <br/><sub><b>🤖 Android</b></sub>
    </td>
    <td align="center" width="33%">
      <img src="https://raw.githubusercontent.com/vikaspoute/sheetifye/main/screenshots/web.png" alt="Web" width="100%" />
      <br/><sub><b>🌐 Web</b></sub>
    </td>
  </tr>
</table>

[**📖 Docs**](docs/getting_started.md) &nbsp;·&nbsp; [**💡 Examples**](example/) &nbsp;·&nbsp; [**📋 Changelog**](CHANGELOG.md) &nbsp;·&nbsp; [**🐛 Report Bug**](https://github.com/vikaspoute/sheetifye/issues)

</div>

---

## Why Sheetifye?

Most Flutter apps that deal with data eventually hit the same wall: you need to show a spreadsheet, but the options are either too heavy, require a server, or look nothing like a real Excel file.

Sheetifye solves this with a purpose-built virtualized renderer that parses `.xlsx` natively, in-app, with no external dependencies. It handles workbooks at any scale while feeling completely native on every platform.

```
✦ No Excel required     ✦ Works fully offline     ✦ One widget, all platforms
```

---

## Features

<table>
  <tr>
    <td>🚀 <strong>Virtualized Rendering</strong></td>
    <td>Renders only what's on screen — 60+ FPS even with millions of cells</td>
  </tr>
  <tr>
    <td>📦 <strong>Native XLSX Parsing</strong></td>
    <td>Full in-app parser with no external dependencies or installations</td>
  </tr>
  <tr>
    <td>🎨 <strong>Theme Aware</strong></td>
    <td>Automatically adapts to your app's <code>ThemeData</code> and <code>ColorScheme</code></td>
  </tr>
  <tr>
    <td>🖱️ <strong>Smart Selection</strong></td>
    <td>Single cell and range selection with full keyboard and touch support</td>
  </tr>
  <tr>
    <td>⌨️ <strong>Formula Bar</strong></td>
    <td>Integrated viewer that shows raw cell values and formulas</td>
  </tr>
  <tr>
    <td>📐 <strong>Merged Cells</strong></td>
    <td>Accurate rendering and hit-testing across merged cell regions</td>
  </tr>
  <tr>
    <td>🌐 <strong>Cross-Platform</strong></td>
    <td>Touch-optimized on mobile, mouse & keyboard ready on desktop and web</td>
  </tr>
</table>

---

## Quick Start

### 1 · Add the dependency

```yaml
# pubspec.yaml
dependencies:
  sheetifye: ^1.0.0
```

```bash
flutter pub add sheetifye
```

### 2 · Wrap with ProviderScope

Sheetifye uses [Riverpod](https://riverpod.dev) internally. Add `ProviderScope` at your app root:

```dart
void main() {
  runApp(const ProviderScope(child: MyApp()));
}
```

### 3 · Drop in the widget

```dart
import 'package:sheetifye/sheetifye.dart';

class SpreadsheetPage extends StatelessWidget {
  const SpreadsheetPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Sheetifye.asset('assets/reports/annual_sales.xlsx'),
    );
  }
}
```

> That's it. You have a fully interactive spreadsheet viewer.

---

## Data Sources

```dart
// 📁 From app assets
Sheetifye.asset('assets/data.xlsx')

// 🌐 From a remote URL
Sheetifye.network('https://example.com/reports/q4.xlsx')

// 💾 From the device file system
Sheetifye.file(File('/path/to/spreadsheet.xlsx'))

// 🧠 From raw bytes
Sheetifye.memory(bytes)
```

---

## Theming

```dart
Sheetifye.asset(
  'assets/data.xlsx',
  theme: SheetifyeThemeData(
    primary: Colors.indigo,
    accent: Colors.amber,
    headerBackground: Colors.grey.shade100,
    fontFamily: 'Inter',
  ),
)
```

> When no theme is set, Sheetifye inherits your app's active `ThemeData` and `ColorScheme` automatically.

---

## Roadmap

| Version | Status | Highlights |
|---------|--------|------------|
| **v1.0.0** | ✅ Released | Virtualized viewer · XLSX parsing · Selection · Formula bar · Merged cells |
| **v1.1.0** | 🔨 In Progress | Basic cell editing · In-memory value updates |
| **v1.2.0** | 📋 Planned | Live formula engine · Real-time recalculation |
| **v2.0.0** | 🔮 Future | Advanced styling · Charts · Conditional formatting |

---

## Contributing

All contributions are welcome — bug fixes, features, docs, and ideas.

```bash
# 1. Fork & clone
git clone https://github.com/vikaspoute/sheetifye.git

# 2. Install dependencies
flutter pub get

# 3. Run tests
flutter test
```

Read the [Contributing Guide](CONTRIBUTING.md) before opening a pull request. For major changes, open an issue first.

---

## License

Distributed under the **MIT License**. See [`LICENSE`](LICENSE) for details.

---

<div align="center">

<br/>

Built with ❤️ by [Vikas Poute](https://github.com/vikaspoute)

<br/>

⭐ **Found it useful? A star goes a long way — it helps others discover Sheetifye!** ⭐

</div>