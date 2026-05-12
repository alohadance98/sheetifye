import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sheetify/src/features/grid/widgets/sheet_grid.dart';
import 'package:sheetify/src/features/formula_bar/widgets/formula_bar.dart';
import 'package:sheetify/src/features/tabs/widgets/sheet_tabs.dart';
import 'package:sheetify/src/features/workbook/state/workbook_state.dart';
import 'package:sheetify/src/features/toolbar/widgets/sheetify_toolbar.dart';
import 'package:sheetify/src/core/theme/sheetify_theme.dart';
import 'package:sheetify/src/core/theme/sheetify_spacing_tokens.dart';
import 'package:sheetify/src/core/theme/sheetify_dimensions.dart';

class SheetifyWorkbook extends ConsumerStatefulWidget {
  final bool readOnly;

  const SheetifyWorkbook({super.key, this.readOnly = true});

  @override
  ConsumerState<SheetifyWorkbook> createState() => _SheetifyWorkbookState();
}

class _SheetifyWorkbookState extends ConsumerState<SheetifyWorkbook> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      ref.read(workbookProvider.notifier).setReadOnly(widget.readOnly);
    });
  }

  @override
  void didUpdateWidget(SheetifyWorkbook oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.readOnly != widget.readOnly) {
      ref.read(workbookProvider.notifier).setReadOnly(widget.readOnly);
    }
  }

  @override
  Widget build(BuildContext context) {
    final controller = ref.read(workbookProvider.notifier);
    final state = ref.watch(workbookProvider);

    return Focus(
      autofocus: true,
      onKeyEvent: (node, event) {
        if (event is KeyDownEvent) {
          if (event.logicalKey == LogicalKeyboardKey.arrowUp) {
            controller.moveActiveCell(-1, 0);
            return KeyEventResult.handled;
          } else if (event.logicalKey == LogicalKeyboardKey.arrowDown) {
            controller.moveActiveCell(1, 0);
            return KeyEventResult.handled;
          } else if (event.logicalKey == LogicalKeyboardKey.arrowLeft) {
            controller.moveActiveCell(0, -1);
            return KeyEventResult.handled;
          } else if (event.logicalKey == LogicalKeyboardKey.arrowRight) {
            controller.moveActiveCell(0, 1);
            return KeyEventResult.handled;
          } else if (event.logicalKey == LogicalKeyboardKey.enter) {
            if (!state.readOnly) {
              controller.setEditing(true);
              return KeyEventResult.handled;
            }
          } else if (event.logicalKey == LogicalKeyboardKey.delete ||
              event.logicalKey == LogicalKeyboardKey.backspace) {
            if (!state.readOnly && state.mainSelection != null) {
              controller.clearRange(state.mainSelection!);
              return KeyEventResult.handled;
            }
          }
        }
        return KeyEventResult.ignored;
      },
      child: Material(
        color: SheetifyTheme.of(context).backgroundColor,
        child: SafeArea(
          top: false,
          child: Column(
            children: [
              SheetifyToolbar(controller: controller),
              // if (state.readOnly)
              //   _buildViewOnlyIndicator(context),
              const FormulaBar(),
              const Expanded(child: SheetGrid()),
              const SheetTabs(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildViewOnlyIndicator(BuildContext context) {
    final theme = SheetifyTheme.of(context);
    return Container(
      width: double.infinity,
      color: theme.statusIndicatorBackgroundColor,
      padding: SheetifySpacingTokens.statusPadding,
      child: Row(
        children: [
          Icon(
            Icons.visibility_outlined,
            size: SheetifyDimensions.iconSizeSmall,
            color: theme.statusIndicatorForegroundColor,
          ),
          const SizedBox(width: SheetifySpacingTokens.small),
          Text('VIEW ONLY', style: theme.statusLabelTextStyle),
          const Spacer(),
          Text(
            'Changes cannot be saved',
            style: theme.statusBodyTextStyle.copyWith(
              color: theme.statusIndicatorForegroundColor.withOpacity(0.8),
            ),
          ),
        ],
      ),
    );
  }
}
