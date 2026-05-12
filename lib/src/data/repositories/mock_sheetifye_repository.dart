import 'package:sheetifye/src/domain/contracts/sheetifye_repository.dart';
import 'package:sheetifye/src/domain/entities/workbook.dart';

class MockSheetifyeRepository implements SheetifyeRepository {
  @override
  Future<Workbook> loadWorkbook(String id) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return Workbook(
      id: id,
      name: 'Sample Workbook',
      sheets: [Sheet(id: 'sheet1', name: 'Sheet1')],
    );
  }

  @override
  Future<void> saveWorkbook(Workbook workbook) async {
    await Future.delayed(const Duration(milliseconds: 300));
  }

  @override
  Future<List<Workbook>> getWorkbooks() async {
    return [
      const Workbook(id: '1', name: 'Budget 2024'),
      const Workbook(id: '2', name: 'Sales Data'),
    ];
  }

  @override
  Future<void> deleteWorkbook(String id) async {}
}
