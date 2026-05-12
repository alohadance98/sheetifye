# Sheetify Architecture

Sheetify is a federated, high-performance spreadsheet platform built for the Flutter ecosystem.

# Sheetify Architecture (Stabilized)

Sheetify is a high-performance spreadsheet platform built for the Flutter ecosystem, utilizing a refined monolithic architecture for maximum performance and simplified maintainability.

## Unified Core Architecture

- **`lib/src/domain`**: Pure entities (Workbook, Sheet, Cell) that define the state.
- **`lib/src/engine`**: Specialized runtime systems (Formula, Render, Layout, Selection) that operate on the domain.
- **`lib/src/features`**: UI components and state management (Riverpod-based controllers).
- **`lib/src/core`**: Lightweight shared utilities, themes, and constants.

## The WorkbookController (Central Hub)

The `WorkbookController` is the single source of truth for the application. It orchestrates:
1. **Mutations**: Via the `CommandManager` (Undo/Redo support).
2. **Computations**: Via the `RecalculationEngine`.
3. **Interactions**: Selection management, drag-to-select, and clipboard synchronization.

1. **Virtualization**: The `VirtualizationEngine` calculates the visible row/column ranges based on scroll offsets.
2. **Layout**: The `LayoutEngine` provides cumulative offsets and sizes for every cell, supporting dynamic resizing.
3. **Index Mapping**: The `IndexMappingEngine` maps logical data rows to visual rows for sorting and filtering.
4. **Painting**: The `GridPainter` executes high-performance Canvas drawing for the visible viewport.

## The Computation Engine

1. **Tokenization**: Formulas are scanned into a stream of tokens.
2. **Parsing**: Tokens are transformed into an Abstract Syntax Tree (AST).
3. **Dependency Graph**: Relationships between cells are mapped to enable incremental recalculation.
4. **Evaluation**: The `FormulaEvaluator` traverses the AST to compute final values.

## Extensibility

Plugins can extend Sheetify by registering:
- Custom Formula Functions
- Custom Cell Renderers
- Custom Overlay Layers
- Custom Persistence Adapters
