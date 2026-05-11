/// All user-visible strings in one place.
///
/// When you add i18n later, swap each getter for a lookup call
/// without touching any widget file.
abstract final class AppStrings {
  // ── App ───────────────────────────────────────────────────────────────────
  static const appTitle = 'excel_dart viewer';
  static const appTagline = 'Pure-Dart Excel reader';

  // ── Actions ───────────────────────────────────────────────────────────────
  static const openFile = 'Open file';
  static const openAnotherFile = 'Open another file';
  static const close = 'Close';
  static const retry = 'Retry';

  // ── Empty state ───────────────────────────────────────────────────────────
  static const emptyTitle = 'No file open';
  static const emptySubtitle =
      'Tap the button below to pick an .xlsx file from your device.';

  // ── Formula bar ───────────────────────────────────────────────────────────
  static const formulaBarHint = 'Select a cell';
  static const formulaPrefix = '=';

  // ── Cell types (shown as badge labels) ───────────────────────────────────
  static const cellTypeString = 'STR';
  static const cellTypeNumber = 'NUM';
  static const cellTypeDate = 'DATE';
  static const cellTypeBool = 'BOOL';
  static const cellTypeFormula = 'FX';
  static const cellTypeError = 'ERR';
  static const cellTypeGeneral = 'GEN';

  // ── Errors ────────────────────────────────────────────────────────────────
  static const errorParseTitle = 'Could not open file';
  static const errorNoPermission = 'File permission denied.';
  static const errorNotXlsx =
      'The selected file is not a valid .xlsx workbook.';
  static const errorUnknown = 'An unexpected error occurred.';
  static const errorFilePicker = 'No file was selected.';

  // ── Stats / info ──────────────────────────────────────────────────────────
  static String sheetCount(int n) => '$n ${n == 1 ? 'sheet' : 'sheets'}';
  static String cellCount(int n) => '$n ${n == 1 ? 'cell' : 'cells'}';
  static String rowColSize(int rows, int cols) => '${rows}R × ${cols}C';

  // ── Snackbar ─────────────────────────────────────────────────────────────
  static const fileLoadedSuccess = 'File loaded successfully';
}
