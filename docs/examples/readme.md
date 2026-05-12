# Examples

Real-world recipes for integrating Sheetifye into your Flutter app.
Each example is self-contained, copy-paste ready, and links to full working source code.

> [!TIP]
> All source files live in the [`example/`](../example) directory. Clone the repo and run `flutter run` to see every example live on your device.

---

## Getting Data In

Start here. These examples cover every way to load a spreadsheet into Sheetifye.

| Example | What you'll learn |
|:---|:---|
| [Load from Assets](asset_loading.md) | Bundle an `.xlsx` file with your app and render it at startup |
| [Load from Network](network_loading.md) | Fetch a remote spreadsheet with loading and error states |
| [Load from Memory](memory_loading.md) | Pass raw `Uint8List` bytes — useful after your own network fetch or file picker |

---

## Customisation

Make Sheetifye look and behave exactly the way your app needs.

| Example | What you'll learn |
|:---|:---|
| [Custom Theming](custom_theming.md) | Apply your brand's colors, typography, and header styles via `SheetifyeThemeData` |
| [Handling Selection Changes](selection_handling.md) | React to cell and range selection events in your own UI |
| [ReadOnly vs Editing Mode](mode_comparison.md) | Switch between view-only and interactive editing modes at runtime |

---

## What's Coming

These examples are in progress and will be added in upcoming releases.

| Example | Target Version |
|:---|:---|
| Formula display and evaluation | v1.2.0 |
| Exporting to XLSX from memory | v1.1.0 |
| Conditional row highlighting | v2.0.0 |

---

<sub>Something missing? <a href="https://github.com/vikaspoute/sheetifye/issues">Open an issue</a> and suggest an example — community requests shape what gets documented next.</sub>