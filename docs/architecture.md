# Architecture

> Sheetifye is a high-performance spreadsheet platform for the Flutter ecosystem, built on a refined monolithic architecture optimised for rendering speed, predictable state, and long-term extensibility.

---

## Directory Structure

```
lib/src/
├── domain/       # Pure entities — Workbook, Sheet, Cell, CellRange
├── engine/       # Runtime systems — Formula, Render, Layout, Selection
├── features/     # UI components and Riverpod-based state controllers
└── core/         # Shared utilities, theme constants, and extensions
```

Each layer has a single, clear responsibility. `domain` never imports from `engine` or `features`. `engine` never imports from `features`. Dependencies flow strictly downward.

---

## WorkbookController

The `WorkbookController` is the single source of truth for the entire application. All state changes pass through it — nothing mutates the workbook directly.

It orchestrates three concerns:

**Mutations** — every user action (edit, format, resize) is wrapped in a `Command` and dispatched through the `CommandManager`, giving full undo/redo support with zero additional code at the call site.

**Computations** — after a mutation, the `RecalculationEngine` identifies dirty cells via the dependency graph and recomputes only what changed.

**Interactions** — selection state, drag-to-select, and clipboard read/write are all managed here, keeping interaction logic centralised and testable.

---

## Rendering Pipeline

When the scroll position changes, four systems run in sequence:

```
ScrollOffset
    │
    ▼
VirtualizationEngine   →   which rows and columns are visible?
    │
    ▼
IndexMappingEngine     →   map logical data rows to visual rows (sort/filter)
    │
    ▼
LayoutEngine           →   compute pixel offsets and sizes for each visible cell
    │
    ▼
GridPainter            →   draw visible cells to Canvas in a single pass
```

Only visible cells are ever measured or painted. This is what keeps frame time flat regardless of workbook size.

---

## Formula Engine

Formulas are evaluated in four stages:

```
Raw String  →  Tokenizer  →  Parser  →  AST  →  FormulaEvaluator  →  Value
                                           │
                                    DependencyGraph
                                  (incremental updates)
```

**Tokenizer** — scans the raw formula string into a typed token stream.

**Parser** — transforms tokens into an Abstract Syntax Tree (AST) using a recursive descent approach.

**Dependency Graph** — tracks relationships between cells so that only the affected subgraph is re-evaluated when a value changes, not the entire workbook.

**FormulaEvaluator** — traverses the AST and resolves cell references, built-in functions, and operators into a final typed value.

---

## Extensibility

Sheetifye exposes a plugin interface for registering custom behaviour without modifying core internals:

| Extension Point | Use Case |
|:---|:---|
| **Custom Formula Functions** | Add domain-specific functions (e.g. `=MYCOMPANY_TAX()`) |
| **Custom Cell Renderers** | Render arbitrary widgets inside a cell (chips, badges, sparklines) |
| **Custom Overlay Layers** | Draw annotations, comments, or heatmaps above the grid |
| **Custom Persistence Adapters** | Load and save workbooks from any backend or format |

All extension points are registered at the `WorkbookController` level and are fully isolated from core rendering logic.

---

<sub>This document reflects the architecture as of v1.0.0. Updated alongside significant structural changes.</sub>