# Surge [![Build Status](https://travis-ci.org/mattt/Surge.svg?branch=master)](https://travis-ci.org/mattt/Surge) [![GitHub license](https://img.shields.io/badge/license-MIT-lightgrey.svg)](https://github.com/mattt/Surge/blob/master/LICENSE)

Surge is a Swift library that uses the Accelerate framework to provide high-performance functions for matrix math, digital signal processing, and image manipulation.

Accelerate exposes [SIMD](http://en.wikipedia.org/wiki/SIMD) instructions available in modern CPUs to significantly improve performance of certain calculations. Because of its relative obscurity and inconvenient APIs, Accelerate is not commonly used by developers, which is a shame, since many applications could benefit from these performance optimizations.

**Surge aims to bring Accelerate to the mainstream, making it as easy (and nearly as fast, in most cases) to perform computation over a set of numbers as for a single member.**

Though, keep in mind: _Accelerate is not a silver bullet_. Under certain conditions, such as performing simple calculations over a small data set, Accelerate can be out-performed by conventional algorithms. Always benchmark to determine the performance characteristics of each potential approach.

---

> Curious about the name _Surge_? Back in the mid 90's, Apple, IBM, and Motorola teamed up to create [AltiVec](http://en.wikipedia.org/wiki/AltiVec) (a.k.a the Velocity Engine), which provided a SIMD instruction set for the PowerPC architecture. When Apple made the switch to Intel CPUs, AltiVec was ported to the x86 architecture and rechristened [Accelerate](https://developer.apple.com/library/mac/documentation/Accelerate/Reference/AccelerateFWRef/_index.html). The derivative of Accelerate (and second derivative of Velocity) is known as either [jerk, jolt, surge, or lurch](http://en.wikipedia.org/wiki/Jerk_%28physics%29), hence the name of this library.

---

## Performance

Initial benchmarks on iOS devices and the iOS simulator indicate significant performance improvements over a conventional Swift implementation.

```swift
import Surge

let numbers: [Double] = ...
var sum: Double = 0.0

// Naïve Swift Implementation
sum = reduce(numbers, 0.0, +)

// Surge Implementation
sum = Surge.sum(numbers)
```

_(Time in milliseconds, Optimization Level `-Ofast`)_

|    _n_     |   Swift          |   Surge       |   Δ       |
|------------|------------------|---------------|-----------|
| 100        | 0.269081         | 0.004453      | ~60x      |
| 100000     | 251.037254       | 0.028687      | ~9000x    |
| 100000000  | 239474.689326    | 57.009841     | ~4000x    |

> Surge's performance characteristics have not yet been thoroughly evaluated, though initial benchmarks show incredible promise. Further investigation is definitely warranted.

## Installation

_The infrastructure and best practices for distributing Swift libraries are currently in flux during this beta period of Swift & Xcode. In the meantime, you can add Surge as a git submodule, drag the `Surge.xcodeproj` file into your Xcode project, and add `Surge.framework` as a dependency for your target._

---

## Inventory

> Surge functions are named according to their corresponding "Math.h" functions, where applicable (omitting `f` and `d` affixes, since type information is communicated and enforced by the language's type system).

### Arithmetic

- `sum`
- `asum`
- `max`
- `min`
- `mean`
- `meamg`
- `measq`
- `add`
- `sub`
- `mul`
- `div`
- `mod`
- `remainder`
- `sqrt`

### Auxilliary

- `abs`
- `ceil`
- `copysign`
- `floor`
- `rec`
- `round`
- `trunc`

### Convolution

- `conv`
- `xcorr`

### Exponential

- `exp`
- `exp2`
- `log`
- `log2`
- `log10`
- `logb`

### FFT

- `fft`

### Hyperbolic

- `sinh`
- `cosh`
- `tanh`
- `asinh`
- `acosh`
- `atanh`

### Matrix

- `add`
- `mul`
- `inv`
- `transpose`

### Power

- `pow`

### Trigonometric

- `sincos`
- `sin`
- `cos`
- `tan`
- `asin`
- `acos`
- `atan`
- `rad2deg`
- `deg2rad`

## Usage

### Computing Sum of `[Double]`

```swift
import Surge

let n = [1.0, 2.0, 3.0, 4.0, 5.0]
let sum = Surge.sum(n) // 15.0
```

### Computing Product of Two `[Double]`s

```swift
import Surge

let a = [1.0, 3.0, 5.0, 7.0]
let b = [2.0, 4.0, 6.0, 8.0]

let product = Surge.mul(a, b) // [2.0, 12.0, 30.0, 56.0]
```

---

## License

Surge is available under the MIT license. See the LICENSE file for more info.
