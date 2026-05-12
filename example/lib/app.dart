import 'package:flutter/material.dart';
import 'package:sheetify_example/screens/gallery_screen.dart';

class SheetifyExampleApp extends StatelessWidget {
  const SheetifyExampleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sheetify Gallery',
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
