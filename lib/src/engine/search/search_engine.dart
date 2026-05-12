import 'package:sheetify/src/domain/entities/workbook.dart';
import 'package:sheetify/src/core/utils/grid_utils.dart';

class SearchEngine {
  List<GridCoordinate> search(Sheet sheet, String query, {bool matchCase = false}) {
    if (query.isEmpty) return [];
    
    final results = <GridCoordinate>[];
    final searchTerm = matchCase ? query : query.toLowerCase();

    sheet.cells.forEach((key, cell) {
      final value = cell.value?.toString() ?? '';
      final target = matchCase ? value : value.toLowerCase();
      
      if (target.contains(searchTerm)) {
        results.add(GridCoordinate(cell.row, cell.column));
      }
    });

    return results;
  }
}
