# Publishing Sheetifye to pub.dev

This guide covers the full release workflow for [Sheetifye](https://pub.dev/packages/sheetifye) — the native Flutter spreadsheet engine.

---

## Pre-Release Checklist

### 1. Update `pubspec.yaml`

- Bump the version following [semantic versioning](https://semver.org/):
  - **PATCH** (`1.1.x`) — bug fixes, no API changes
  - **MINOR** (`1.x.0`) — new backwards-compatible features (e.g. new loader constructors, new theme fields)
  - **MAJOR** (`x.0.0`) — breaking API changes (e.g. removing/renaming public constructors or callbacks)
- Confirm `homepage`, `repository`, `issue_tracker`, and `description` are accurate
- Double-check all dependency version constraints

### 2. Update `CHANGELOG.md`

Add a dated entry at the top for the new version. Follow the existing format — group changes under `Added`, `Changed`, `Fixed`, and `Removed`. Example:

```markdown
## [1.2.0] — 2026-05-19

### Added
- Conditional formatting support
- Cell comments with author metadata

### Fixed
- Formula engine crash on circular references with three or more cells
```

### 3. Verify the Test Suite

Sheetifye ships with **324+ tests** across engine, widget, and integration layers. All must pass before any release:

```bash
fvm flutter test
```

Run analysis and ensure zero issues:

```bash
fvm flutter analyze
```

Format all Dart code:

```bash
dart format .
```

### 4. Smoke-Test the Example App

Run the example app on at least one mobile and one desktop/web target and verify:

- XLSX and CSV loading works (asset, network, file, memory)
- Cell editing and formula entry function correctly
- Undo/redo and clipboard behave as expected
- Save/Save As/Discard hooks fire properly
- Workbook action menu renders correctly on mobile (bottom sheet) and desktop (popup)

---

## Publishing

### Dry Run

Always do a dry run first to catch metadata or analysis errors before they go public:

```bash
flutter pub publish --dry-run
```

Fix any warnings or errors before proceeding. Common issues:
- Missing or malformed `doc/` links referenced in README
- Screenshot files referenced but missing from the repo
- Dependency constraints that are too tight or too loose

### Publish

```bash
flutter pub publish
```

You'll be prompted to authenticate with your Google account if you haven't already. The publisher must have upload rights on [pub.dev/packages/sheetifye](https://pub.dev/packages/sheetifye).

### Post-Publish Verification

1. Visit [pub.dev/packages/sheetifye](https://pub.dev/packages/sheetifye) and confirm the new version is listed
2. Check that the README renders correctly (tables, screenshots, code blocks)
3. Verify the [pub.dev score](https://pub.dev/packages/sheetifye/score) — Likes, Pub Points, and Popularity
4. Create a GitHub Release tagged `v<version>` and paste the CHANGELOG entry as the release notes

---

## Improving the pub.dev Score

pub.dev awards up to **140 Pub Points** across these categories:

| Category | Points | How Sheetifye earns them |
|---|---|---|
| **Follow Dart file conventions** | 20 | `dart format`, no analysis issues |
| **Provide documentation** | 20 | Dartdoc comments on all public APIs |
| **Platform support** | 20 | All 6 platforms declared in `pubspec.yaml` |
| **Pass static analysis** | 50 | Zero `flutter analyze` warnings |
| **Support up-to-date dependencies** | 20 | Keep SDK and deps current |
| **Null safety** | 10 | Already enforced — keep it |

Specific actions that move the needle for Sheetifye:

- **Dartdoc all public symbols** — `Sheetifye`, `WorkbookExporter`, `SheetifyeThemeData`, `WorkbookAction`, all callbacks. The doc page is the first thing potential adopters see.
- **Keep dependencies current** — Riverpod releases frequently; falling behind hurts the score.
- **Respond to GitHub issues** — Maintenance activity is factored into popularity signals.
- **Add a CI badge to README** — Shows the package is actively tested (GitHub Actions workflow already exists at `.github/workflows/`).

---

## Versioning Reference

Current roadmap as declared in README:

| Version | Status | Scope |
|---|---|---|
| v1.0.0 | ✅ Released | XLSX viewer, virtualized grid, formula bar, merged cells, theming |
| v1.1.0 | ✅ Released | Full editing, persistence lifecycle, undo/redo, clipboard, autofill, formula engine, validation |
| v1.2.0 | 🔲 Planned | Conditional formatting, charts, cell comments, multi-sheet editing |
| v2.0.0 | 🔲 Planned | Collaborative editing hooks, advanced styling, named ranges, pivot tables |

---

## Resources

- [pub.dev — Sheetifye](https://pub.dev/packages/sheetifye)
- [Dart Publishing Documentation](https://dart.dev/tools/pub/publishing)
- [pub.dev Help — Publishing](https://pub.dev/help/publishing)
- [Semantic Versioning](https://semver.org/)
- [Flutter Package Development Guide](https://docs.flutter.dev/packages-and-plugins/developing-packages)
- [Sheetifye Architecture Guide](https://github.com/vikaspoute/sheetifye/blob/main/doc/architecture.md)
- [Contributing Guide](https://github.com/vikaspoute/sheetifye/blob/main/CONTRIBUTING.md)
