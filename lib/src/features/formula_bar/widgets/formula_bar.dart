import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sheetify/src/core/theme/sheetify_theme.dart';
import 'package:sheetify/src/core/theme/sheetify_spacing_tokens.dart';
import 'package:sheetify/src/core/theme/sheetify_dimensions.dart';
import 'package:sheetify/src/features/workbook/state/workbook_state.dart';

class FormulaBar extends ConsumerWidget {
  const FormulaBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(workbookProvider);
    final theme = SheetifyTheme.of(context);
    final activeCell = state.activeCell;
    final cellValue = activeCell != null
        ? state
                  .workbook
                  .activeSheet
                  .cells['${activeCell.row},${activeCell.column}']
                  ?.value
                  ?.toString() ??
              ''
        : '';

    return Container(
      height: theme.formulaBarHeight,
      padding: SheetifySpacingTokens.formulaBarPadding,
      decoration: BoxDecoration(
        color: theme.formulaBarBackgroundColor,
        border: Border(bottom: BorderSide(color: theme.gridLineColor)),
      ),
      child: Row(
        children: [
          // Cell Address Chip
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: SheetifySpacingTokens.small,
              vertical: 2,
            ),
            decoration: BoxDecoration(
              color: theme.primaryColor,
              borderRadius: BorderRadius.circular(
                SheetifyDimensions.cornerRadiusSmall,
              ),
            ),
            child: Text(
              activeCell?.toA1() ?? '',
              style: theme.formulaBarTextStyle.copyWith(
                color: theme.surfaceColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(width: SheetifySpacingTokens.medium),
          // Formula / Value Text
          Expanded(
            child: Text(
              cellValue.isEmpty ? '(empty)' : cellValue,
              style: theme.formulaBarTextStyle.copyWith(
                color: theme.formulaBarForegroundColor,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
