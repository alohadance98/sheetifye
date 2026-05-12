# Installation

## Pub.dev

The recommended way to install Sheetify is via [pub.dev](https://pub.dev/packages/sheetify).

```bash
flutter pub add sheetify
```

## Manual Installation

If you need to use a specific version or a fork:

```yaml
dependencies:
  sheetify:
    git:
      url: https://github.com/vikaspoute/sheetify.git
      ref: main
```

## Platform Requirements

### Android
- Minimum SDK: 21
- Internet permission (if using `Sheetify.network`)

### iOS
- Minimum iOS: 12.0

### Web
- Supported on all modern browsers (Chrome, Firefox, Safari, Edge).
- Uses Canvas-based rendering for high performance.

### Desktop
- Windows, macOS, and Linux supported.
- Optimized for mouse-wheel and trackpad scrolling.
