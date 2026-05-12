import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sheetify_example/app.dart';

void main() {
  runApp(
    const ProviderScope(
      child: SheetifyExampleApp(),
    ),
  );
}
