import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sheetifye/src/domain/entities/workbook.dart';
import 'package:sheetifye/src/data/sources/sheetifye_source.dart';
import 'package:sheetifye/src/data/adapters/xlsx/xlsx_adapter.dart';
import 'package:sheetifye/src/core/theme/sheetifye_theme.dart';
import 'package:sheetifye/src/core/theme/sheetifye_theme_data.dart';
import 'package:sheetifye/src/features/workbook/state/workbook_state.dart';
import 'package:sheetifye/src/features/workbook/widgets/sheetifye_workbook.dart';
import 'package:sheetifye/src/public/widgets/sheetifye_shimmer.dart';

typedef SheetifyeLoadingBuilder = Widget Function(BuildContext context);
typedef SheetifyeErrorBuilder =
    Widget Function(BuildContext context, Object error);

/// A high-performance spreadsheet widget for Flutter.
///
/// [Sheetifye] provides a virtualized grid for viewing and interacting with
/// spreadsheet data. It supports loading data from various sources (assets,
/// files, network, memory) and features native XLSX parsing.
///
/// ### Basic Usage:
/// ```dart
/// Sheetifye.asset('assets/my_data.xlsx')
/// ```
///
/// To use [Sheetifye], your app must be wrapped in a `ProviderScope` (from `flutter_riverpod`).
class Sheetifye extends ConsumerStatefulWidget {
  /// The source from which to load the spreadsheet data.
  final SheetifyeSource source;

  /// Whether the spreadsheet is in read-only mode.
  ///
  /// In read-only mode, selection and editing features are disabled.
  /// Defaults to `true`.
  final bool readOnly;

  /// Custom theme data for the spreadsheet.
  ///
  /// If null, it will automatically detect the app's brightness and use
  /// [SheetifyeThemeData.light()] or [SheetifyeThemeData.dark()].
  final SheetifyeThemeData? theme;

  /// Optional builder to show a custom loading widget while the data is parsing.
  ///
  /// Defaults to a [SheetifyeShimmer] effect.
  final SheetifyeLoadingBuilder? loadingBuilder;

  /// Optional builder to show a custom error widget if loading fails.
  final SheetifyeErrorBuilder? errorBuilder;

  /// Creates a [Sheetifye] widget with a generic [SheetifyeSource].
  const Sheetifye({
    super.key,
    required this.source,
    this.readOnly = true,
    this.theme,
    this.loadingBuilder,
    this.errorBuilder,
  });

  /// Creates a [Sheetifye] widget that loads data from an asset.
  ///
  /// [assetName] is the path to the XLSX file in your project's assets.
  factory Sheetifye.asset(
    String assetName, {
    Key? key,
    bool readOnly = true,
    SheetifyeThemeData? theme,
    SheetifyeLoadingBuilder? loadingBuilder,
    SheetifyeErrorBuilder? errorBuilder,
  }) => Sheetifye(
    key: key,
    source: AssetSheetifyeSource(assetName),
    readOnly: readOnly,
    theme: theme,
    loadingBuilder: loadingBuilder,
    errorBuilder: errorBuilder,
  );

  /// Creates a [Sheetifye] widget that loads data from a local file.
  factory Sheetifye.file(
    File file, {
    Key? key,
    bool readOnly = true,
    SheetifyeThemeData? theme,
    SheetifyeLoadingBuilder? loadingBuilder,
    SheetifyeErrorBuilder? errorBuilder,
  }) => Sheetifye(
    key: key,
    source: FileSheetifyeSource(file),
    readOnly: readOnly,
    theme: theme,
    loadingBuilder: loadingBuilder,
    errorBuilder: errorBuilder,
  );

  /// Creates a [Sheetifye] widget that loads data from a byte array.
  factory Sheetifye.memory(
    Uint8List bytes, {
    Key? key,
    String? name,
    bool readOnly = true,
    SheetifyeThemeData? theme,
    SheetifyeLoadingBuilder? loadingBuilder,
    SheetifyeErrorBuilder? errorBuilder,
  }) => Sheetifye(
    key: key,
    source: MemorySheetifyeSource(bytes, name: name),
    readOnly: readOnly,
    theme: theme,
    loadingBuilder: loadingBuilder,
    errorBuilder: errorBuilder,
  );

  /// Creates a [Sheetifye] widget that loads data from a URL.
  factory Sheetifye.network(
    String url, {
    Key? key,
    String? name,
    Map<String, String>? headers,
    bool readOnly = true,
    SheetifyeThemeData? theme,
    SheetifyeLoadingBuilder? loadingBuilder,
    SheetifyeErrorBuilder? errorBuilder,
  }) => Sheetifye(
    key: key,
    source: NetworkSheetifyeSource(url, name: name, headers: headers),
    readOnly: readOnly,
    theme: theme,
    loadingBuilder: loadingBuilder,
    errorBuilder: errorBuilder,
  );

  @override
  ConsumerState<Sheetifye> createState() => _SheetifyeState();
}

class _SheetifyeState extends ConsumerState<Sheetifye> {
  bool _isLoading = true;
  Object? _error;
  String? _lastCacheKey;

  @override
  void initState() {
    super.initState();
    _loadSheet();
  }

  @override
  void didUpdateWidget(Sheetifye oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.source.cacheKey != widget.source.cacheKey) {
      _loadSheet();
    }
  }

  Future<void> _loadSheet() async {
    final cacheKey = widget.source.cacheKey;
    if (_lastCacheKey == cacheKey) return;

    setState(() {
      _isLoading = true;
      _error = null;
    });

    try {
      final result = await widget.source.loadBytes();
      final bytes = result.bytes;
      final detectedName = result.name ?? 'Imported Workbook';

      final workbook = await compute(_parseXlsx, (
        bytes: bytes,
        name: detectedName,
      ));

      ref.read(workbookProvider.notifier).loadWorkbook(workbook);
      ref.read(workbookProvider.notifier).setReadOnly(widget.readOnly);

      _lastCacheKey = cacheKey;
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _isLoading = false;
          _error = e;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final themeData =
        widget.theme ??
        (Theme.of(context).brightness == Brightness.dark
            ? SheetifyeThemeData.dark()
            : SheetifyeThemeData.light());

    return SheetifyeTheme(
      data: themeData,
      child: Builder(
        builder: (context) {
          if (_isLoading) {
            return widget.loadingBuilder?.call(context) ??
                const SheetifyeShimmer();
          }

          if (_error != null) {
            return widget.errorBuilder?.call(context, _error!) ??
                _buildDefaultError(context, themeData);
          }

          return SheetifyeWorkbook(readOnly: widget.readOnly);
        },
      ),
    );
  }

  Widget _buildDefaultError(BuildContext context, SheetifyeThemeData theme) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.error_outline, color: theme.error, size: 48),
          const SizedBox(height: 16),
          Text(
            'Failed to load spreadsheet\n$_error',
            textAlign: TextAlign.center,
            style: TextStyle(color: theme.error),
          ),
          const SizedBox(height: 16),
          ElevatedButton(onPressed: _loadSheet, child: const Text('Retry')),
        ],
      ),
    );
  }
}

Workbook _parseXlsx(({Uint8List bytes, String name}) params) {
  return XlsxAdapter.parse(params.bytes, name: params.name);
}
