# Theming Sheetifye

Sheetifye is designed to feel native to your application. It adapts automatically to your `ThemeData`, but also provides granular control via `SheetifyeThemeData`.

## Automatic Theming

By default, Sheetifye detects your app's brightness (Light/Dark) and primary colors.

## Customizing the Theme

Use the `theme` parameter in the `Sheetifye` widget:

```dart
Sheetifye.asset(
  'inventory.xlsx',
  theme: SheetifyeThemeData(
    primary: Colors.indigo,
    accent: Colors.orange,
    gridLineColor: Colors.grey.withOpacity(0.2),
    headerBackground: Colors.grey[100]!,
    headerTextColor: Colors.black87,
    selectionColor: Colors.indigo.withOpacity(0.1),
    fontFamily: 'Roboto Mono',
  ),
)
```

## Dark Mode

Sheetifye includes a built-in dark theme optimized for readability:

```dart
Sheetifye.asset(
  'inventory.xlsx',
  theme: SheetifyeThemeData.dark(),
)
```

## Design Tokens

| Token | Description | Default (Light) |
|-------|-------------|-----------------|
| `primary` | Selection borders, focus indicators | `Blue` |
| `background` | Spreadsheet canvas background | `White` |
| `surface` | Cell background | `White` |
| `headerBackground` | Row/Column header color | `Grey[50]` |
| `gridLineColor` | Lines between cells | `Grey[300]` |
| `selectionColor` | Fill color for selected ranges | `Blue[50]` |

## Typography

You can override the default font family for the entire spreadsheet:

```dart
SheetifyeThemeData(
  fontFamily: GoogleFonts.inter().fontFamily,
)
```
