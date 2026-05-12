# XLSX Support

Sheetifye provides native parsing for `.xlsx` files without requiring external Excel installations.

## Supported Features

- [x] **Cell Values**: Text, Numbers, Dates, Booleans.
- [x] **Merged Cells**: Proper rendering and selection handling.
- [x] **Column Widths**: Respects custom widths defined in Excel.
- [x] **Row Heights**: Adaptive and custom height support.
- [x] **Basic Styling**: Bold, Italic, Font Colors (v1).
- [x] **Multiple Sheets**: Tabbed navigation between workbooks.
- [x] **Formula Results**: Displays the last calculated value stored in the file.

## Limitations (v1)

- [ ] **Live Formula Engine**: v1 displays results but does not recalculate formulas on the fly.
- [ ] **Charts & Images**: Not rendered in the grid.
- [ ] **Conditional Formatting**: Partially supported.
- [ ] **Macros/VBA**: Not supported.

## Loading Methods

| Method | Use Case |
|--------|----------|
| `Sheetifye.asset()` | Static data bundled with your app. |
| `Sheetifye.file()` | Local files from device storage. |
| `Sheetifye.network()` | Remote spreadsheets (reports, cloud data). |
| `Sheetifye.memory()` | In-memory bytes (e.g., from a file picker). |

## Performance Tip

For very large XLSX files (>50MB), we recommend using `compute()` to parse the file in a background isolate to keep the UI responsive. Sheetifye handles this automatically for you when using the factory constructors.
