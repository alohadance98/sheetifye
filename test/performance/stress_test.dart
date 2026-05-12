import 'package:flutter_test/flutter_test.dart';
import 'package:sheetify/src/domain/entities/workbook.dart';
import 'package:sheetify/src/features/workbook/state/workbook_state.dart';

void main() {
  group('Sheetify Stress Testing (1 Million Cells)', () {
    test(
      'WorkbookController should handle 1,000,000 cell sheet initialization',
      () {
        final workbook = Workbook(
          id: 'stress-test-wb',
          name: 'Stress Test',
          sheets: [
            Sheet(
              id: 'huge-sheet',
              name: 'HugeSheet',
              rowCount: 10000,
              columnCount: 100,
            ),
          ],
        );

        final controller = WorkbookController();
        // Initialize with large workbook
        controller.state = controller.state.copyWith(workbook: workbook);

        expect(controller.state.workbook.activeSheet.rowCount, 10000);
        expect(controller.state.workbook.activeSheet.columnCount, 100);
      },
    );
  });
}
