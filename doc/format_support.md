# Format Support: XLSX & CSV

Sheetifye provides native parsing for **Excel (.xlsx)** and **CSV** files without requiring external installations or heavy dependencies.

## XLSX Supported Features

- [x] **Cell Values**: Text, Numbers, Dates, Booleans.
- [x] **Merged Cells**: Proper rendering and selection handling.
- [x] **Column Widths**: Respects custom widths defined in Excel.
- [x] **Row Heights**: Adaptive and custom height support.
- [x] **Basic Styling**: Bold, Italic, Font Colors (v1).
- [x] **Multiple Sheets**: Tabbed navigation between workbooks.
- [x] **Formula Results**: Displays the last calculated value stored in the file.

## CSV Supported Features

- [x] **Standard Parsing**: Handles comma-separated values natively.
- [x] **Auto-Detection**: Automatic recognition of CSV format based on file extension or content.
- [x] **Large File Support**: Efficiently handles massive CSV datasets via virtualization.
- [x] **Encoding**: Supports UTF-8 and standard text encodings.

## Limitations (v1)

- [ ] **Live Formula Engine**: v1 displays results but does not recalculate formulas on the fly for XLSX.
- [ ] **Charts & Images**: Not rendered in the grid.
- [ ] **Conditional Formatting**: Partially supported.
- [ ] **Macros/VBA**: Not supported.

## Loading Methods

| Method | Use Case |
|--------|----------|
| `Sheetifye.asset()` | Static data bundled with your app (XLSX/CSV). |
| `Sheetifye.file()` | Local files from device storage. |
| `Sheetifye.network()` | Remote spreadsheets (reports, cloud data). |
| `Sheetifye.memory()` | In-memory bytes (e.g., from a file picker). |

## Performance Tip

For very large files (>50MB), we recommend using the provided factory constructors which automatically handle parsing in a background isolate to keep the UI responsive.

---

<sub>Sheetifye aims to be the most comprehensive **Flutter spreadsheet package** for professional data visualization.</sub>
