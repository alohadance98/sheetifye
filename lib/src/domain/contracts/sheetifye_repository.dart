import 'package:sheetifye/src/domain/entities/workbook.dart';

abstract class SheetifyeRepository {
  Future<Workbook> loadWorkbook(String id);
  Future<void> saveWorkbook(Workbook workbook);
  Future<List<Workbook>> getWorkbooks();
  Future<void> deleteWorkbook(String id);
}
