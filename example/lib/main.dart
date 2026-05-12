import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sheetifye/sheetifye.dart';

/// This is a minimal, self-contained example of how to use [Sheetifye].
/// 
/// For a full-featured demonstration including network loading, custom theming,
/// and performance stress tests, check out the [GalleryScreen] in our repository.
void main() {
  runApp(
    // 1. Sheetifye requires a ProviderScope at the root of your app.
    const ProviderScope(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: SheetifyeExample(),
      ),
    ),
  );
}

class SheetifyeExample extends StatelessWidget {
  const SheetifyeExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sheetifye Quick Start'),
        centerTitle: true,
      ),
      // 2. Simply drop the Sheetifye widget. Here we load from assets.
      body: Sheetifye.asset(
        'assets/restaurant_sales.xlsx',
        // Optional: match the theme to your brand
        theme: SheetifyeThemeData.light().copyWith(
          primaryColor: Colors.blue,
        ),
      ),
    );
  }
}
