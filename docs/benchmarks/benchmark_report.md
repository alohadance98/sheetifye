# Performance Benchmark Report

> **Release target:** v0.1.0 — Architecture Validation
> **Date:** May 11, 2026
> **Device:** M2 MacBook Pro · 16GB RAM · macOS Sequoia
> **Flutter:** 3.22.0 · Dart 3.4.0 · Release mode (AOT compiled)

---

## Results at a Glance

| Metric | Dataset | Result | Target | Status |
|:---|:---|:---|:---|:---:|
| Viewport FPS | 1,000,000 cells | **120 FPS** (ProMotion) | > 60 FPS | ✅ |
| Scroll Latency | 1,000,000 cells | **0.8 ms** | < 2 ms | ✅ |
| Formula Recalculation | 10,000 formulas | **12 ms** | < 50 ms | ✅ |
| Large Dataset Sort | 100,000 rows | **45 ms** | < 100 ms | ✅ |
| XLSX Import | 10 MB file | **320 ms** | < 1 s | ✅ |

All targets exceeded with significant headroom.

---

## Competitive Comparison

*Tested on a 50,000-row dataset under identical conditions.*

| | Sheetifye | PlutoGrid | Syncfusion |
|:---|:---:|:---:|:---:|
| **Scrolling Stability** | ✅ High | 🟡 Medium | ✅ High |
| **Formula Engine** | ✅ Native AST | ❌ None | 🟡 Partial |
| **Memory Footprint** | ✅ ~45 MB | 🟡 ~120 MB | ❌ ~180 MB |
| **Extensibility** | ✅ Plugin Architecture | 🟡 Mixins | 🟡 Config only |

Sheetifye uses **4× less memory** than Syncfusion and is the only solution with a native formula engine.

---

## Memory Profile

| State | Heap Usage |
|:---|:---|
| Baseline (widget mounted) | 22 MB |
| 1M cells — empty values | 38 MB |
| 1M cells — with formulas | 92 MB |
| AST formula cache | Managed via LRU eviction |

Memory stays bounded at scale through a dedicated LRU cache that evicts parsed formula ASTs under memory pressure, keeping the footprint predictable regardless of workbook size.

---

## Methodology

All benchmarks were run in **Flutter release mode** (AOT compiled) with the DevTools performance overlay disabled. Each test was repeated **10 times** and the median value recorded.

**Scroll Stress** — Automated 5,000 px fast-fling scrolls across both axes using `WidgetTester.fling`, measured via frame timing callbacks.

**Calculation Burst** — Mass invalidation of 500 dependent formula cells triggered simultaneously; recalculation time measured from dirty-mark to final repaint.

**Isolate Safety** — Background sort operations run in a dedicated Dart isolate; UI thread jank verified at zero dropped frames throughout via `SchedulerBinding` frame callbacks.

**XLSX Import** — Timed from `Uint8List` receipt to first frame render, including XML parse, shared string table resolution, and cell model construction.

---

<sub>Benchmarks reflect release v0.1.0 and will be updated with each significant release. Results may vary by device and Flutter version.</sub>