# Changelog

All notable changes to **Sheetifye** are documented here.
This project follows [Semantic Versioning](https://semver.org/) and [Keep a Changelog](https://keepachangelog.com/en/1.0.0/).

---

## [1.0.0] — 2026-05-12 🎉

> **Initial public release.** The foundation is set — fast, native, and cross-platform.

### ✨ Added

- **Virtualized rendering engine** — high-performance cell renderer that maintains 60+ FPS on large workbooks by painting only visible cells
- **Native XLSX parsing** — full in-app parser with support for loading from `assets`, `file`, `memory`, and `network` sources; no external dependencies required
- **Bi-directional scrolling** — smooth horizontal and vertical scroll for workbooks of any size
- **Selection system** — single-cell and range selection with keyboard and touch input support
- **Formula bar** — integrated viewer displaying raw cell values and formulas for the active selection
- **Merged cell support** — accurate layout and hit-testing across merged cell regions
- **Theme-aware UI** — automatically adapts to the host app's `ThemeData` and `ColorScheme`, with full dark mode support
- **`SheetifyeThemeData`** — fully customizable theme class for colors, typography, and header styling
- **Cross-platform input handling** — touch-optimized on iOS/Android; mouse and keyboard ready on Desktop and Web
- **Developer documentation** — comprehensive getting started guide, API reference, and gallery example app

---

## Upcoming

| Version | ETA | Focus |
|---------|-----|-------|
| **v1.1.0** | Q3 2024 | Basic cell editing · In-memory value updates |
| **v1.2.0** | Q4 2024 | Live formula engine · Real-time recalculation |
| **v2.0.0** | 2025 | Charts · Advanced styling · Conditional formatting |

---

<sub>See something missing? <a href="https://github.com/vikaspoute/sheetifye/issues">Open an issue</a> or check the <a href="https://github.com/vikaspoute/sheetifye/releases">Releases</a> page.</sub>