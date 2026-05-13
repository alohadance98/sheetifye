# Performance Benchmark Report (v1.0.0)

> **Release Status:** Stable Public Release
> **Date:** May 13, 2026
> **Device:** M2 MacBook Pro · 16GB RAM · macOS Sequoia
> **Flutter:** 3.22.0 · Dart 3.4.0 · Release mode (AOT compiled)

---

## Results at a Glance

| Metric | Dataset | Result | Target | Status |
|:---|:---|:---|:---|:---:|
| **Viewport FPS** | 1,000,000 cells | **120 FPS** (ProMotion) | > 60 FPS | ✅ |
| **Scroll Latency** | 1,000,000 cells | **0.6 ms** | < 2 ms | ✅ |
| **Formula Recalculation** | 10,000 formulas | **8 ms** | < 50 ms | ✅ |
| **Large Dataset Sort** | 100,000 rows | **35 ms** | < 100 ms | ✅ |
| **XLSX / CSV Import** | 10 MB file | **280 ms** | < 1 s | ✅ |

---

## Competitive Comparison

*Tested on a 50,000-row dataset under identical conditions.*

| Feature | Sheetifye | PlutoGrid | Syncfusion |
|:---|:---:|:---:|:---:|
| **Scrolling Stability** | ✅ High | 🟡 Medium | ✅ High |
| **Memory Footprint** | ✅ ~42 MB | 🟡 ~120 MB | ❌ ~180 MB |
| **Parsing Speed** | ✅ Native Isolate | ❌ Slow / None | 🟡 External Plugin |
| **UI Fluidity** | ✅ 60+ FPS | 🟡 Variable | ✅ 60+ FPS |

Sheetifye uses **4× less memory** than enterprise solutions while providing a more fluid **spreadsheet viewer** experience for Flutter.

---

## Memory Profile

Memory usage remains bounded even as the dataset grows, thanks to our specialized **LRU Cache** for cell data and rendering artifacts.

- **Baseline (idle)**: 22 MB
- **100k Cells**: 35 MB
- **1M Cells**: 88 MB

---

## Methodology

Benchmarks are conducted in **Flutter release mode** using the `SchedulerBinding` frame timing callbacks to ensure zero dropped frames during stress tests. 

1.  **Scroll Stress**: Automated 5,000 px fast-fling scrolls across both axes.
2.  **Calculation Burst**: Simultaneous invalidation of 500 dependent cells.
3.  **Cold Start Import**: Measuring time from file selection to first frame render.

---

<sub>Benchmarks reflect Sheetifye v1.0.0. Performance may vary based on hardware and Flutter version. We continuously optimize our engine for the best **high-performance spreadsheet** experience.</sub>