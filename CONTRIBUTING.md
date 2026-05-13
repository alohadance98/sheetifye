# Contributing to Sheetifye

First off, thank you for considering contributing to **Sheetifye**! It's people like you that make the Flutter community such an amazing place to build.

This project is a high-performance **Excel viewer** and **spreadsheet engine**, and we aim for the highest standards of code quality and performance.

---

## 🛠️ How Can I Contribute?

### 🐛 Reporting Bugs
- **Search First**: Check if the issue already exists in our [Issue Tracker](https://github.com/vikaspoute/sheetifye/issues).
- **Be Descriptive**: Include your Flutter version (`flutter doctor`), device info, and clear steps to reproduce.
- **Provide Context**: Screenshots, GIFs, or a minimal reproduction project are extremely helpful.

### ✨ Feature Requests
- **Explain the Use Case**: Why is this feature needed? How does it improve the **spreadsheet experience** for developers?
- **Propose a Design**: If you have an idea for the API or UI, we'd love to hear it.

### ⌨️ Pull Requests
1.  **Fork & Branch**: Create your feature branch from `main`.
2.  **Follow Style**: Adhere to the [Effective Dart](https://dart.dev/guides/language/effective-dart) guidelines.
3.  **Test Your Changes**: If you're adding a feature, add unit or widget tests.
4.  **Update Docs**: If you've changed public APIs, update the relevant markdown files.
5.  **Lint Check**: Run `flutter analyze` and ensure zero warnings.

---

## 🏗️ Technical Guidelines

Sheetifye is built on a custom rendering engine. Before contributing to the core, please read the:
- [Architecture Guide](doc/architecture.md)
- [Performance Benchmarks](doc/benchmarks/benchmark_report.md)

### Key Rules:
- **Zero Heavy Dependencies**: We aim to keep the package lightweight.
- **Canvas-First**: Core grid rendering must happen on the Canvas, not via individual Widgets per cell.
- **Isolate Safety**: Heavy parsing or calculation logic should be isolate-aware.

---

## 📜 Code of Conduct
Please be respectful and professional in all interactions. We follow the standard [Contributor Covenant](CODE_OF_CONDUCT.md).

## Questions?
Feel free to open a [Discussion](https://github.com/vikaspoute/sheetifye/discussions) or reach out to the maintainers.

---

<sub>Thank you for helping us build the best **Flutter spreadsheet package**!</sub>
