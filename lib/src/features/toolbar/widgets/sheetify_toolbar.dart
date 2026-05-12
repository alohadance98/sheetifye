import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sheetify/src/core/theme/sheetify_theme.dart';
import 'package:sheetify/src/core/theme/sheetify_dimensions.dart';
import 'package:sheetify/src/core/theme/sheetify_spacing_tokens.dart';
import 'package:sheetify/src/features/workbook/state/workbook_state.dart';

class SheetifyToolbar extends ConsumerStatefulWidget {
  final WorkbookController controller;

  const SheetifyToolbar({super.key, required this.controller});

  @override
  ConsumerState<SheetifyToolbar> createState() => _SheetifyToolbarState();
}

class _SheetifyToolbarState extends ConsumerState<SheetifyToolbar> {
  late TextEditingController _searchController;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController(
      text: ref.read(workbookProvider).searchQuery ?? '',
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(workbookProvider);
    final theme = SheetifyTheme.of(context);
    final topPadding = MediaQuery.of(context).padding.top;

    return Container(
      height: theme.toolbarHeight + topPadding,
      padding: EdgeInsets.fromLTRB(
        SheetifySpacingTokens.small,
        topPadding,
        SheetifySpacingTokens.small,
        SheetifySpacingTokens.zero,
      ),
      decoration: BoxDecoration(
        color: theme.primaryColor,
        boxShadow: [
          BoxShadow(
            color: theme.shadowColor,
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          if (state.isSearchOpen) ...[
            IconButton(
              icon: Icon(
                Icons.arrow_back,
                color: theme.toolbarTextStyle.color,
                size: SheetifyDimensions.iconSizeMedium,
              ),
              onPressed: () {
                _searchController.clear();
                widget.controller.toggleSearch();
              },
            ),
            Expanded(
              child: TextField(
                controller: _searchController,
                autofocus: true,
                onChanged: (val) => widget.controller.updateSearch(val),
                style: theme.toolbarTextStyle,
                cursorColor: theme.toolbarTextStyle.color,
                decoration: InputDecoration(
                  hintText: 'Search...',
                  hintStyle: theme.toolbarTextStyle.copyWith(
                    color: theme.toolbarTextStyle.color?.withOpacity(0.7),
                  ),
                  border: InputBorder.none,
                ),
              ),
            ),
            if (_searchController.text.isNotEmpty)
              IconButton(
                icon: Icon(
                  Icons.close,
                  color: theme.toolbarTextStyle.color,
                  size: SheetifyDimensions.iconSizeMedium,
                ),
                onPressed: () {
                  _searchController.clear();
                  widget.controller.updateSearch('');
                },
              ),
          ] else ...[
            Icon(
              Icons.table_chart,
              color: theme.toolbarTextStyle.color?.withOpacity(0.9),
              size: SheetifyDimensions.iconSizeMedium,
            ),
            SizedBox(width: SheetifySpacingTokens.medium),
            Expanded(
              child: Text(
                state.workbook.name,
                style: theme.toolbarTextStyle,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            _ToolbarIcon(
              icon: Icons.search,
              onPressed: () => widget.controller.toggleSearch(),
            ),
          ],
        ],
      ),
    );
  }
}

class _ToolbarIcon extends StatelessWidget {
  final IconData icon;
  final VoidCallback? onPressed;

  const _ToolbarIcon({required this.icon, this.onPressed});

  @override
  Widget build(BuildContext context) {
    final theme = SheetifyTheme.of(context);
    return IconButton(
      icon: Icon(
        icon,
        size: SheetifyDimensions.iconSizeLarge,
        color: theme.toolbarTextStyle.color,
      ),
      onPressed: onPressed,
      splashRadius: 20,
      constraints: const BoxConstraints(),
      padding: const EdgeInsets.all(SheetifySpacingTokens.small),
    );
  }
}
