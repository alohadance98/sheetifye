import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sheetifye/src/core/theme/sheetifye_theme.dart';
import 'package:sheetifye/src/core/theme/sheetifye_spacing_tokens.dart';
import 'package:sheetifye/src/core/theme/sheetifye_dimensions.dart';
import 'package:sheetifye/src/features/workbook/state/workbook_state.dart';

class FormulaBar extends ConsumerWidget {
  const FormulaBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(workbookProvider);
    final theme = SheetifyeTheme.of(context);
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
      padding: SheetifyeSpacingTokens.formulaBarPadding,
      decoration: BoxDecoration(
        color: theme.formulaBarBackgroundColor,
        border: Border(bottom: BorderSide(color: theme.gridLineColor)),
      ),
      child: Row(
        children: [
          // Cell Address Chip
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: SheetifyeSpacingTokens.small,
              vertical: 2,
            ),
            decoration: BoxDecoration(
              color: theme.primaryColor,
              borderRadius: BorderRadius.circular(
                SheetifyeDimensions.cornerRadiusSmall,
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
          const SizedBox(width: SheetifyeSpacingTokens.medium),
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
