import 'dart:io';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

/// Base class for defining a source of spreadsheet data.
///
/// Implementations of [SheetifyeSource] are responsible for loading the
/// raw bytes of a spreadsheet (usually XLSX) and providing an optional name.
abstract class SheetifyeSource {
  /// Constant constructor for [SheetifyeSource].
  const SheetifyeSource();

  /// Loads the raw bytes of the spreadsheet.
  ///
  /// Returns a record containing the [Uint8List] of bytes and an optional [name].
  Future<({Uint8List bytes, String? name})> loadBytes();

  /// A unique key to represent this source, used for caching and state management.
  String get cacheKey;
}

/// A source that loads spreadsheet data from a Flutter asset.
class AssetSheetifyeSource extends SheetifyeSource {
  /// The path to the asset.
  final String assetName;

  /// Optional [AssetBundle] to use. Defaults to [rootBundle].
  final AssetBundle? bundle;

  /// Creates an [AssetSheetifyeSource] for the given [assetName].
  const AssetSheetifyeSource(this.assetName, {this.bundle});

  @override
  Future<({Uint8List bytes, String? name})> loadBytes() async {
    final data = await (bundle ?? rootBundle).load(assetName);
    return (bytes: data.buffer.asUint8List(), name: assetName.split('/').last);
  }

  @override
  String get cacheKey => 'asset:$assetName';
}

/// A source that loads spreadsheet data from a local [File].
class FileSheetifyeSource extends SheetifyeSource {
  /// The local file to load.
  final File file;

  /// Creates a [FileSheetifyeSource] for the given [file].
  const FileSheetifyeSource(this.file);

  @override
  Future<({Uint8List bytes, String? name})> loadBytes() async {
    final bytes = await file.readAsBytes();
    return (bytes: bytes, name: file.path.split(Platform.pathSeparator).last);
  }

  @override
  String get cacheKey => 'file:${file.path}';
}

/// A source that loads spreadsheet data from an in-memory byte array.
class MemorySheetifyeSource extends SheetifyeSource {
  /// The raw bytes of the spreadsheet.
  final Uint8List bytes;

  /// An optional name for the workbook.
  final String? name;

  /// Creates a [MemorySheetifyeSource] from the given [bytes].
  const MemorySheetifyeSource(this.bytes, {this.name});

  @override
  Future<({Uint8List bytes, String? name})> loadBytes() async =>
      (bytes: bytes, name: name);

  @override
  String get cacheKey => 'memory:${name ?? bytes.hashCode}';
}

/// A source that loads spreadsheet data from a remote URL via HTTP GET.
class NetworkSheetifyeSource extends SheetifyeSource {
  /// The URL of the spreadsheet file.
  final String url;

  /// An optional name for the workbook. If not provided, it will be
  /// inferred from the URL path.
  final String? name;

  /// Optional HTTP headers to include in the request.
  final Map<String, String>? headers;

  /// Creates a [NetworkSheetifyeSource] for the given [url].
  const NetworkSheetifyeSource(this.url, {this.name, this.headers});

  @override
  Future<({Uint8List bytes, String? name})> loadBytes() async {
    final response = await http.get(Uri.parse(url), headers: headers);
    if (response.statusCode == 200) {
      String? detectedName;
      final finalUrl = response.request?.url;
      if (finalUrl != null && finalUrl.pathSegments.isNotEmpty) {
        final last = finalUrl.pathSegments.last;
        if (last.isNotEmpty) {
          detectedName = last;
        }
      }

      return (bytes: response.bodyBytes, name: name ?? detectedName);
    } else {
      throw Exception(
        'Failed to load sheet from network: ${response.statusCode}',
      );
    }
  }

  @override
  String get cacheKey => 'network:$url';
}
