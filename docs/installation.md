# Installation

## Pub.dev

The recommended way to install Sheetifye is via [pub.dev](https://pub.dev/packages/sheetifye).

```bash
flutter pub add sheetifye
```

## Manual Installation

If you need to use a specific version or a fork:

```yaml
dependencies:
  sheetifye:
    git:
      url: https://github.com/vikaspoute/sheetifye.git
      ref: main
```

## Platform Requirements

### Android
- Minimum SDK: 21
- Internet permission (if using `Sheetifye.network`)

### iOS
- Minimum iOS: 12.0

### Web
- Supported on all modern browsers (Chrome, Firefox, Safari, Edge).
- Uses Canvas-based rendering for high performance.

### Desktop
- Windows, macOS, and Linux supported.
- Optimized for mouse-wheel and trackpad scrolling.
