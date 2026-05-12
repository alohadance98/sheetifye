import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sheetifye/src/core/theme/sheetifye_theme.dart';
import 'package:sheetifye/src/core/theme/sheetifye_spacing_tokens.dart';
import 'package:sheetifye/src/core/theme/sheetifye_dimensions.dart';
import 'package:sheetifye/src/features/workbook/state/workbook_state.dart';

class SheetTabs extends ConsumerWidget {
  const SheetTabs({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(workbookProvider);
    final theme = SheetifyeTheme.of(context);
    final sheets = state.workbook.sheets;
    final activeIndex = state.workbook.activeSheetIndex;

    return Container(
      height: theme.tabAreaHeight,
      decoration: BoxDecoration(
        color: theme.surfaceColor,
        border: Border(top: BorderSide(color: theme.gridLineColor)),
      ),
      child: Row(
        children: [
          Expanded(
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: sheets.length,
              itemBuilder: (context, index) {
                final isActive = index == activeIndex;
                final sheet = sheets[index];

                return GestureDetector(
                  onTap: () {
                    ref.read(workbookProvider.notifier).switchSheet(index);
                  },
                  onSecondaryTapDown: (details) => _showSheetOptions(
                    context,
                    ref,
                    index,
                    sheet.name,
                    sheets.length > 1,
                    details.globalPosition,
                  ),
                  child: Container(
                    padding: SheetifyeSpacingTokens.tabPadding,
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: isActive
                              ? theme.primaryColor
                              : Colors.transparent,
                          width: 2,
                        ),
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.table_rows_outlined,
                          size: SheetifyeDimensions.iconSizeSmall,
                          color: isActive
                              ? theme.primaryColor
                              : theme.headerForegroundColor,
                        ),
                        const SizedBox(width: SheetifyeSpacingTokens.small),
                        Text(
                          sheet.name,
                          style: isActive
                              ? theme.tabActiveTextStyle
                              : theme.tabInactiveTextStyle,
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void _showSheetOptions(
    BuildContext context,
    WidgetRef ref,
    int index,
    String currentName,
    bool canDelete,
    Offset position,
  ) {
    final RenderBox? overlay =
        Overlay.of(context).context.findRenderObject() as RenderBox?;
    if (overlay == null) return;

    final RelativeRect menuPosition = RelativeRect.fromRect(
      Rect.fromPoints(position, position),
      Offset.zero & overlay.size,
    );

    final theme = SheetifyeTheme.of(context);
    showMenu(
      context: context,
      position: menuPosition,
      elevation: 8,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(
          SheetifyeDimensions.cornerRadiusMedium,
        ),
      ),
      items: [
        const PopupMenuItem(
          value: 'rename',
          child: Row(
            children: [
              Icon(Icons.edit, size: SheetifyeDimensions.iconSizeSmall),
              SizedBox(width: SheetifyeSpacingTokens.medium),
              Text('Rename'),
            ],
          ),
        ),
        if (canDelete)
          PopupMenuItem(
            value: 'delete',
            child: Row(
              children: [
                Icon(
                  Icons.delete,
                  size: SheetifyeDimensions.iconSizeSmall,
                  color: theme.error,
                ),
                const SizedBox(width: SheetifyeSpacingTokens.medium),
                Text('Delete', style: TextStyle(color: theme.error)),
              ],
            ),
          ),
      ],
    ).then((value) {
      if (!context.mounted) return;
      if (value == 'rename') {
        _showRenameDialog(context, ref, index, currentName);
      } else if (value == 'delete') {
        _showDeleteConfirmation(context, ref, index, currentName);
      }
    });
  }

  void _showRenameDialog(
    BuildContext context,
    WidgetRef ref,
    int index,
    String currentName,
  ) {
    final controller = TextEditingController(text: currentName);
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Rename Sheet'),
        content: TextField(
          controller: controller,
          autofocus: true,
          decoration: const InputDecoration(
            hintText: 'New sheet name',
            border: OutlineInputBorder(),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              final name = controller.text.trim();
              if (name.isNotEmpty) {
                ref.read(workbookProvider.notifier).renameSheet(index, name);
                Navigator.pop(context);
              }
            },
            child: const Text('Rename'),
          ),
        ],
      ),
    );
  }

  void _showDeleteConfirmation(
    BuildContext context,
    WidgetRef ref,
    int index,
    String sheetName,
  ) {
    final theme = SheetifyeTheme.of(context);
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Sheet'),
        content: Text(
          'Are you sure you want to delete "$sheetName"?\nThis action cannot be undone.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              ref.read(workbookProvider.notifier).deleteSheet(index);
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(backgroundColor: theme.error),
            child: Text('Delete', style: TextStyle(color: theme.surfaceColor)),
          ),
        ],
      ),
    );
  }
}
