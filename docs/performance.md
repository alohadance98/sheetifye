# Performance

Sheetifye is built for speed. It can handle workbooks with millions of cells while maintaining a consistent 60+ FPS.

## How it Works

### 1. Virtualized Rendering
Sheetifye only renders the cells that are currently visible on the screen. As you scroll, cells are recycled and updated lazily. This keeps the memory footprint low regardless of the total workbook size.

### 2. Dual-Axis Synchronization
The horizontal and vertical scroll systems are decoupled yet synchronized, allowing for smooth panning in any direction.

### 3. Isolate-based Parsing
Loading a large spreadsheet can be CPU-intensive. Sheetifye moves the parsing logic to a background worker (Isolate), ensuring your UI never stutters during the loading phase.

### 4. Sparse Data Structures
Instead of storing a massive 2D array, Sheetifye uses a sparse data structure to represent the workbook. Empty cells consume virtually zero memory.

## Benchmarks

| Workbook Size | Memory Usage | Load Time (Avg) |
|---------------|--------------|-----------------|
| 1,000 cells | ~5MB | < 100ms |
| 100,000 cells | ~15MB | ~400ms |
| 1,000,000 cells | ~45MB | ~1.2s |

*Tested on iPhone 13 / Google Pixel 6.*

## Optimization Tips

- **Use `readOnly: true`**: If you don't need editing, keep the spreadsheet in read-only mode to disable the selection and editing overlays.
- **Minimize Overlays**: Avoid stacking many widgets on top of the spreadsheet.
- **Pre-load Data**: If you know which spreadsheet the user will view, start loading it into memory before they navigate to the page.
