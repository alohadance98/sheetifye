import 'package:flutter/material.dart';
import 'screens/gallery_screen.dart';

class SheetifyeExampleApp extends StatelessWidget {
  const SheetifyeExampleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sheetifye Gallery',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.blue,
        brightness: Brightness.light,
      ),
      darkTheme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.blue,
        brightness: Brightness.dark,
      ),
      home: const GalleryScreen(),
    );
  }
}
