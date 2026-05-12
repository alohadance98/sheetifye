import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sheetify/src/domain/entities/workbook.dart';
import 'package:sheetify/src/data/sources/sheetify_source.dart';
import 'package:sheetify/src/data/adapters/xlsx/xlsx_adapter.dart';
import 'package:sheetify/src/core/theme/sheetify_theme.dart';
import 'package:sheetify/src/core/theme/sheetify_theme_data.dart';
import 'package:sheetify/src/features/workbook/state/workbook_state.dart';
import 'package:sheetify/src/features/workbook/widgets/sheetify_workbook.dart';
import 'package:sheetify/src/public/widgets/sheetify_shimmer.dart';

typedef SheetifyLoadingBuilder = Widget Function(BuildContext context);
typedef SheetifyErrorBuilder =
    Widget Function(BuildContext context, Object error);

/// A high-performance spreadsheet widget for Flutter.
///
/// [Sheetify] provides a virtualized grid for viewing and interacting with
/// spreadsheet data. It supports loading data from various sources (assets,
/// files, network, memory) and features native XLSX parsing.
///
/// ### Basic Usage:
/// ```dart
/// Sheetify.asset('assets/my_data.xlsx')
/// ```
///
/// To use [Sheetify], your app must be wrapped in a `ProviderScope` (from `flutter_riverpod`).
class Sheetify extends ConsumerStatefulWidget {
  /// The source from which to load the spreadsheet data.
  final SheetifySource source;

  /// Whether the spreadsheet is in read-only mode.
  ///
  /// In read-only mode, selection and editing features are disabled.
  /// Defaults to `true`.
  final bool readOnly;

  /// Custom theme data for the spreadsheet.
  ///
  /// If null, it will automatically detect the app's brightness and use
  /// [SheetifyThemeData.light()] or [SheetifyThemeData.dark()].
  final SheetifyThemeData? theme;

  /// Optional builder to show a custom loading widget while the data is parsing.
  ///
  /// Defaults to a [SheetifyShimmer] effect.
  final SheetifyLoadingBuilder? loadingBuilder;

  /// Optional builder to show a custom error widget if loading fails.
  final SheetifyErrorBuilder? errorBuilder;

  /// Creates a [Sheetify] widget with a generic [SheetifySource].
  const Sheetify({
    super.key,
    required this.source,
    this.readOnly = true,
    this.theme,
    this.loadingBuilder,
    this.errorBuilder,
  });

  /// Creates a [Sheetify] widget that loads data from an asset.
  ///
  /// [assetName] is the path to the XLSX file in your project's assets.
  factory Sheetify.asset(
    String assetName, {
    Key? key,
    bool readOnly = true,
    SheetifyThemeData? theme,
    SheetifyLoadingBuilder? loadingBuilder,
    SheetifyErrorBuilder? errorBuilder,
  }) => Sheetify(
    key: key,
    source: AssetSheetifySource(assetName),
    readOnly: readOnly,
    theme: theme,
    loadingBuilder: loadingBuilder,
    errorBuilder: errorBuilder,
  );

  /// Creates a [Sheetify] widget that loads data from a local file.
  factory Sheetify.file(
    File file, {
    Key? key,
    bool readOnly = true,
    SheetifyThemeData? theme,
    SheetifyLoadingBuilder? loadingBuilder,
    SheetifyErrorBuilder? errorBuilder,
  }) => Sheetify(
    key: key,
    source: FileSheetifySource(file),
    readOnly: readOnly,
    theme: theme,
    loadingBuilder: loadingBuilder,
    errorBuilder: errorBuilder,
  );

  /// Creates a [Sheetify] widget that loads data from a byte array.
  factory Sheetify.memory(
    Uint8List bytes, {
    Key? key,
    String? name,
    bool readOnly = true,
    SheetifyThemeData? theme,
    SheetifyLoadingBuilder? loadingBuilder,
    SheetifyErrorBuilder? errorBuilder,
  }) => Sheetify(
    key: key,
    source: MemorySheetifySource(bytes, name: name),
    readOnly: readOnly,
    theme: theme,
    loadingBuilder: loadingBuilder,
    errorBuilder: errorBuilder,
  );

  /// Creates a [Sheetify] widget that loads data from a URL.
  factory Sheetify.network(
    String url, {
    Key? key,
    String? name,
    Map<String, String>? headers,
    bool readOnly = true,
    SheetifyThemeData? theme,
    SheetifyLoadingBuilder? loadingBuilder,
    SheetifyErrorBuilder? errorBuilder,
  }) => Sheetify(
    key: key,
    source: NetworkSheetifySource(url, name: name, headers: headers),
    readOnly: readOnly,
    theme: theme,
    loadingBuilder: loadingBuilder,
    errorBuilder: errorBuilder,
  );

  @override
  ConsumerState<Sheetify> createState() => _SheetifyState();
}

class _SheetifyState extends ConsumerState<Sheetify> {
  bool _isLoading = true;
  Object? _error;
  String? _lastCacheKey;

  @override
  void initState() {
    super.initState();
    _loadSheet();
  }

  @override
  void didUpdateWidget(Sheetify oldWidget) {
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
            ? SheetifyThemeData.dark()
            : SheetifyThemeData.light());

    return SheetifyTheme(
      data: themeData,
      child: Builder(
        builder: (context) {
          if (_isLoading) {
            return widget.loadingBuilder?.call(context) ??
                const SheetifyShimmer();
          }

          if (_error != null) {
            return widget.errorBuilder?.call(context, _error!) ??
                _buildDefaultError(context, themeData);
          }

          return SheetifyWorkbook(readOnly: widget.readOnly);
        },
      ),
    );
  }

  Widget _buildDefaultError(BuildContext context, SheetifyThemeData theme) {
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
