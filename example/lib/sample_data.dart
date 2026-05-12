import 'package:sheetify/sheetify.dart';

class SampleData {
  static Workbook createFinanceWorkbook() {
    final Map<String, Cell> cells = {};
    final sheet = Sheet(
      id: 'finance-1',
      name: 'Q2 Revenue',
      cells: cells,
      rowCount: 1000,
      columnCount: 20,
      frozenRows: 1,
      frozenColumns: 1,
    );

    // 1. Headers
    cells['0,0'] = const Cell(
        id: '0,0',
        row: 0,
        column: 0,
        value: 'Category',
        style: CellStyle(isBold: true));
    cells['0,1'] = const Cell(
        id: '0,1',
        row: 0,
        column: 1,
        value: 'April',
        style: CellStyle(isBold: true));
    cells['0,2'] = const Cell(
        id: '0,2',
        row: 0,
        column: 2,
        value: 'May',
        style: CellStyle(isBold: true));
    cells['0,3'] = const Cell(
        id: '0,3',
        row: 0,
        column: 3,
        value: 'June',
        style: CellStyle(isBold: true));
    cells['0,4'] = const Cell(
        id: '0,4',
        row: 0,
        column: 4,
        value: 'Total',
        style: CellStyle(isBold: true));

    // 2. Data Rows
    final categories = [
      'Product Revenue',
      'Service Income',
      'Ads Revenue',
      'Consulting',
      'Other'
    ];
    for (int i = 0; i < categories.length; i++) {
      final r = i + 1;
      cells['$r,0'] = Cell(id: '$r,0', row: r, column: 0, value: categories[i]);
      cells['$r,1'] =
          Cell(id: '$r,1', row: r, column: 1, value: 1000.0 * (i + 1));
      cells['$r,2'] =
          Cell(id: '$r,2', row: r, column: 2, value: 1200.0 * (i + 1));
      cells['$r,3'] =
          Cell(id: '$r,3', row: r, column: 3, value: 1500.0 * (i + 1));

      // Total Formula: =B(i+1)+C(i+1)+D(i+1)
      final rowLabel = r + 1;
      cells['$r,4'] = Cell(
          id: '$r,4',
          row: r,
          column: 4,
          value: 0.0, // Initial
          formula: '=B$rowLabel+C$rowLabel+D$rowLabel');
    }

    // 3. Grand Total
    const totalRow = 6;
    cells['$totalRow,0'] = const Cell(
        id: '$totalRow,0',
        row: totalRow,
        column: 0,
        value: 'GRAND TOTAL',
        style: CellStyle(isBold: true));
    cells['$totalRow,4'] = const Cell(
        id: '$totalRow,4',
        row: totalRow,
        column: 4,
        value: 0.0,
        formula: '=SUM(E2:E6)');

    // 4. Stress Test Data (1000 rows)
    for (int i = 10; i < 1000; i++) {
      cells['$i,0'] = Cell(id: '$i,0', row: i, column: 0, value: 'Record #$i');
      cells['$i,1'] = Cell(id: '$i,1', row: i, column: 1, value: i * 10.0);
      cells['$i,2'] = Cell(id: '$i,2', row: i, column: 2, value: i * 20.0);
    }

    // 5. Merged Cells
    sheet.mergedCells.addRegion(GridRange.fromRect(0, 5, 0, 8)); // Merge F1:I1
    cells['0,5'] = const Cell(
        id: '0,5',
        row: 0,
        column: 5,
        value: 'Quarterly Breakdown (Merged Header)',
        style: CellStyle(isBold: true));

    return Workbook(
      id: 'finance-workbook',
      name: 'Finance Demo',
      sheets: [sheet],
    );
  }
}
