import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:sheetify/sheetify.dart';

class GalleryScreen extends StatelessWidget {
  const GalleryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sheetify Gallery'),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildSection(context, 'Loading Sources'),
          _buildExampleTile(
            context,
            icon: Icons.folder_open,
            title: 'Load from Assets',
            subtitle: 'Perfect for bundled templates and reports.',
            onTap: () =>
                _openViewer(context, Sheetify.asset('restaurant_sales.xlsx')),
          ),
          _buildExampleTile(
            context,
            icon: Icons.cloud_download,
            title: 'Load from Network',
            subtitle: 'Fetch dynamic spreadsheets from a remote URL.',
            onTap: () => _openViewer(
              context,
              Sheetify.network(
                'https://github.com/vikaspoute/sheetify/raw/main/example/restaurant_sales.xlsx',
                name: 'Network Workbook',
              ),
            ),
          ),
          const SizedBox(height: 24),
          _buildSection(context, 'Themes & Customization'),
          _buildExampleTile(
            context,
            icon: Icons.dark_mode,
            title: 'Dark Mode',
            subtitle: 'Professional dark theme for low-light environments.',
            onTap: () => _openViewer(
              context,
              Sheetify.asset(
                'restaurant_sales.xlsx',
                theme: SheetifyThemeData.dark(),
              ),
            ),
          ),
          _buildExampleTile(
            context,
            icon: Icons.palette,
            title: 'Custom Brand Theme',
            subtitle: 'Matching the spreadsheet to your app brand.',
            onTap: () => _openViewer(
              context,
              Sheetify.asset(
                'restaurant_sales.xlsx',
                theme: SheetifyThemeData.light().copyWith(
                  primaryColor: Colors.deepPurple,
                  selectionColor: Colors.deepPurple.withOpacity(0.1),
                  headerBackgroundColor: Colors.deepPurple.shade50,
                ),
              ),
            ),
          ),
          const SizedBox(height: 24),
          _buildSection(context, 'Performance'),
          _buildExampleTile(
            context,
            icon: Icons.speed,
            title: 'Million Cell Stress Test',
            subtitle: 'Smooth scrolling with massive datasets.',
            onTap: () => _openViewer(
              context,
              Sheetify(
                source: MemorySheetifySource(
                  // In a real app, this would be a large file
                  // For demo, we just use the same asset
                  Uint8List(0),
                  name: 'Large Workbook',
                ),
              ),
              isStressTest: true,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSection(BuildContext context, String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Text(
        title,
        style: Theme.of(context).textTheme.titleSmall?.copyWith(
              color: Theme.of(context).colorScheme.primary,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.2,
            ),
      ),
    );
  }

  Widget _buildExampleTile(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: Colors.grey.shade200),
      ),
      child: ListTile(
        leading: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color:
                Theme.of(context).colorScheme.primaryContainer.withOpacity(0.4),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, color: Theme.of(context).colorScheme.primary),
        ),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(subtitle),
        trailing: const Icon(Icons.chevron_right),
        onTap: onTap,
      ),
    );
  }

  void _openViewer(BuildContext context, Widget sheetify,
      {bool isStressTest = false}) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => Scaffold(
          body: sheetify,
        ),
      ),
    );
  }
}
