import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sheetifye/sheetifye.dart';

/// Sheetifye Example Application
///
/// This minimal example demonstrates the core integration of the Sheetifye
/// spreadsheet engine into a Flutter application.
void main() {
  // Ensure Flutter bindings are initialized if needed (optional here)
  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    // 1. Sheetifye requires a [ProviderScope] at the root of your application
    // to manage the spreadsheet state efficiently.
    const ProviderScope(
      child: SheetifyeApp(),
    ),
  );
}

class SheetifyeApp extends StatelessWidget {
  const SheetifyeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sheetifye Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.blue,
      ),
      home: const SpreadsheetHome(),
    );
  }
}

class SpreadsheetHome extends StatelessWidget {
  const SpreadsheetHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sheetifye: Native Excel Viewer'),
        elevation: 0,
        scrolledUnderElevation: 2,
      ),
      // 2. Simply drop the [Sheetifye] widget into your UI.
      // You can load data from assets, network, file, or memory.
      body: Sheetifye.asset(
        'assets/restaurant_sales.xlsx',
        // Optional: Customize the appearance to match your brand
        theme: SheetifyeThemeData.light().copyWith(
          primaryColor: Colors.blueAccent,
        ),
      ),
    );
  }
}
