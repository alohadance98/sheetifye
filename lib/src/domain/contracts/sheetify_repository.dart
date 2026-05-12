import 'package:sheetify/src/domain/entities/workbook.dart';

abstract class SheetifyRepository {
  Future<Workbook> loadWorkbook(String id);
  Future<void> saveWorkbook(Workbook workbook);
  Future<List<Workbook>> getWorkbooks();
  Future<void> deleteWorkbook(String id);
}
