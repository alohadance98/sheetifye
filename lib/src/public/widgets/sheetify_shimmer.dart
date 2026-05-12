import 'package:flutter/material.dart';
import 'package:sheetify/src/core/theme/sheetify_dimensions.dart';
import 'package:sheetify/src/core/theme/sheetify_spacing_tokens.dart';
import 'package:sheetify/src/core/theme/sheetify_theme.dart';
import 'package:shimmer/shimmer.dart';

class SheetifyShimmer extends StatelessWidget {
  const SheetifyShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = SheetifyTheme.of(context);
    final baseColor = theme.gridLineColor;
    final highlightColor = theme.surfaceColor;
    final headerColor = theme.headerBackgroundColor;

    final topPadding = MediaQuery.of(context).padding.top;

    return Shimmer.fromColors(
      baseColor: baseColor,
      highlightColor: highlightColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // 1. Toolbar Placeholder
          Container(
            height: theme.toolbarHeight + topPadding,
            padding: EdgeInsets.fromLTRB(
              SheetifySpacingTokens.medium,
              topPadding,
              SheetifySpacingTokens.medium,
              SheetifySpacingTokens.zero,
            ),
            color: headerColor,
            child: Row(
              children: List.generate(
                8,
                (i) => Container(
                  width: SheetifyDimensions.iconSizeLarge,
                  height: SheetifyDimensions.iconSizeLarge,
                  margin: const EdgeInsets.only(
                    right: SheetifySpacingTokens.medium,
                  ),
                  decoration: BoxDecoration(
                    color: baseColor,
                    borderRadius: BorderRadius.circular(
                      SheetifyDimensions.cornerRadiusSmall,
                    ),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 1),
          // 2. Formula Bar Placeholder
          Container(
            height: theme.formulaBarHeight,
            padding: SheetifySpacingTokens.formulaBarPadding,
            color: theme.surfaceColor,
            child: Row(
              children: [
                Container(
                  width: theme.rowHeaderWidth,
                  height: 20,
                  decoration: BoxDecoration(
                    color: baseColor,
                    borderRadius: BorderRadius.circular(
                      SheetifyDimensions.cornerRadiusSmall,
                    ),
                  ),
                ),
                const SizedBox(width: SheetifySpacingTokens.small),
                Expanded(child: Container(height: 20, color: baseColor)),
              ],
            ),
          ),
          const SizedBox(height: 1),
          // 3. Column Headers
          Row(
            children: [
              Container(
                width: theme.rowHeaderWidth,
                height: theme.columnHeaderHeight,
                color: headerColor,
              ),
              ...List.generate(
                6,
                (i) => Expanded(
                  child: Container(
                    height: theme.columnHeaderHeight,
                    margin: const EdgeInsets.only(left: 1),
                    color: headerColor,
                  ),
                ),
              ),
            ],
          ),
          // 4. Main Grid
          Expanded(
            child: ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              itemCount: 20,
              itemBuilder: (context, index) => Row(
                children: [
                  Container(
                    width: theme.rowHeaderWidth,
                    height: theme.rowHeight,
                    margin: const EdgeInsets.only(bottom: 1),
                    color: headerColor,
                  ),
                  ...List.generate(
                    6,
                    (i) => Expanded(
                      child: Container(
                        height: theme.rowHeight,
                        margin: const EdgeInsets.only(left: 1, bottom: 1),
                        padding: const EdgeInsets.all(
                          SheetifySpacingTokens.small,
                        ),
                        color: theme.surfaceColor,
                        child: i % 2 == 0
                            ? Container(
                                width: double.infinity,
                                height: 12,
                                decoration: BoxDecoration(
                                  color: baseColor.withOpacity(0.5),
                                  borderRadius: BorderRadius.circular(2),
                                ),
                              )
                            : null,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          // 5. Sheet Tabs Bar
          Container(
            height: theme.tabAreaHeight,
            padding: SheetifySpacingTokens.tabPadding,
            color: theme.surfaceColor,
            child: Row(
              children: [
                Container(
                  width: 80,
                  height: 24,
                  decoration: BoxDecoration(
                    color: baseColor,
                    borderRadius: BorderRadius.circular(
                      SheetifyDimensions.cornerRadiusSmall,
                    ),
                  ),
                ),
                const SizedBox(width: SheetifySpacingTokens.small),
                Container(
                  width: 80,
                  height: 24,
                  decoration: BoxDecoration(
                    color: baseColor.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(
                      SheetifyDimensions.cornerRadiusSmall,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
