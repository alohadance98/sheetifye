import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sheetify/src/core/theme/sheetify_dimensions.dart';
import 'package:sheetify/src/core/theme/sheetify_spacing_tokens.dart';
import 'package:sheetify/src/core/theme/sheetify_theme.dart';
import 'package:sheetify/src/features/workbook/state/workbook_state.dart';

class CellEditorOverlay extends ConsumerStatefulWidget {
  final VoidCallback onCancel;
  final Function(String) onCommit;

  const CellEditorOverlay({
    super.key,
    required this.onCancel,
    required this.onCommit,
  });

  @override
  ConsumerState<CellEditorOverlay> createState() => _CellEditorOverlayState();
}

class _CellEditorOverlayState extends ConsumerState<CellEditorOverlay> {
  late TextEditingController _controller;
  late FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    final state = ref.read(workbookProvider);
    final activeCell = state.activeCell;
    final cell = activeCell != null
        ? state
              .workbook
              .activeSheet
              .cells['${activeCell.row},${activeCell.column}']
        : null;
    final initialValue = cell?.rawInput ?? cell?.value?.toString() ?? '';

    _controller = TextEditingController(text: initialValue);
    _focusNode = FocusNode();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _focusNode.requestFocus();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(workbookProvider);
    final theme = SheetifyTheme.of(context);

    if (state.activeCell == null || !state.isEditing) {
      return const SizedBox.shrink();
    }

    return Container(
      decoration: BoxDecoration(
        color: theme.surfaceColor,
        border: Border.all(
          color: theme.selectionBorderColor,
          width: SheetifyDimensions.activeCellStrokeWidth,
        ),
        boxShadow: [
          BoxShadow(color: theme.shadowColor, blurRadius: 4, spreadRadius: 1),
        ],
      ),
      child: TextField(
        controller: _controller,
        focusNode: _focusNode,
        decoration: const InputDecoration(
          border: InputBorder.none,
          isDense: true,
          contentPadding: EdgeInsets.all(SheetifySpacingTokens.small),
        ),
        style: theme.gridCellTextStyle,
        maxLines: null,
        onSubmitted: (value) {
          ref.read(workbookProvider.notifier).commitEdit(value);
        },
      ),
    );
  }
}
