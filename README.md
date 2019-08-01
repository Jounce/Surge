# Surge

[![Build Status](https://travis-ci.org/mattt/Surge.svg?branch=master)](https://travis-ci.org/mattt/Surge) [![GitHub license](https://img.shields.io/badge/license-MIT-lightgrey.svg)](https://github.com/mattt/Surge/blob/master/LICENSE) [![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage) [![SPM compatible](https://img.shields.io/badge/spm-compatible-brightgreen.svg?style=flat)](https://swift.org/package-manager) [![CocoaPods](https://img.shields.io/cocoapods/v/Surge.svg)](https://cocoapods.org/pods/Surge)

Surge is a Swift library that uses the Accelerate framework to provide high-performance functions for matrix math, digital signal processing, and image manipulation.

Accelerate exposes [SIMD](http://en.wikipedia.org/wiki/SIMD) instructions available in modern CPUs to significantly improve performance of certain calculations. Because of its relative obscurity and inconvenient APIs, Accelerate is not commonly used by developers, which is a shame, since many applications could benefit from these performance optimizations.

**Surge aims to bring Accelerate to the mainstream, making it as easy (and nearly as fast, in most cases) to perform computation over a set of numbers as for a single member.**

Though, keep in mind: _Accelerate is not a silver bullet_. Under certain conditions, such as performing simple calculations over a small data set, Accelerate can be out-performed by conventional algorithms. Always benchmark to determine the performance characteristics of each potential approach.

---

> Curious about the name _Surge_? Back in the mid 90's, Apple, IBM, and Motorola teamed up to create [AltiVec](http://en.wikipedia.org/wiki/AltiVec) (a.k.a the Velocity Engine), which provided a SIMD instruction set for the PowerPC architecture. When Apple made the switch to Intel CPUs, AltiVec was ported to the x86 architecture and rechristened [Accelerate](https://developer.apple.com/library/mac/documentation/Accelerate/Reference/AccelerateFWRef/_index.html). The derivative of Accelerate (and second derivative of Velocity) is known as either [jerk, jolt, surge, or lurch](http://en.wikipedia.org/wiki/Jerk_%28physics%29), hence the name of this library.

---

## Installation

_The infrastructure and best practices for distributing Swift libraries are currently in flux during this beta period of Swift & Xcode. In the meantime, you can add Surge as a git submodule, drag the `Surge.xcodeproj` file into your Xcode project, and add `Surge.framework` as a dependency for your target._

Surge uses Swift 5. This means that your code has to be written in Swift 5 due to current binary compatibility limitations.

### Swift Package Manager

To use [Swift Package Manager](https://swift.org/package-manager/) add Surge to your `Package.swift` file:

```swift
let package = Package(
    name: "myproject",
    dependencies: [
        .package(url: "https://github.com/mattt/Surge.git", .upToNextMajor(from: "2.0.0")),
    ],
    targets: [
        .target(
            name: "myproject",
            dependencies: ["Surge"]),
    ]
)
```

Then run `swift build`.

### CocoaPods

To use [CocoaPods](https://cocoapods.org) add Surge to your `Podfile`:

```ruby
source 'https://github.com/CocoaPods/Specs.git'
platform :ios, '10.0'
use_frameworks!

target '<Your Target Name>' do
    pod 'Surge', '~> 2.0.0'
end
```

Then run `pod install`.

### Carthage

To use [Carthage](https://github.com/Carthage/Carthage) add Surge to your `Cartfile`:

```ruby
github "mattt/Surge" ~> 2.0.0
```

Then run `carthage update` and use the framework in `Carthage/Build/<platform>`.

---

## Inventory

> Surge functions are named according to their corresponding "Math.h" functions, where applicable (omitting `f` and `d` affixes, since type information is communicated and enforced by the language's type system).

### Arithmetic

- `sum`: [Summation](https://en.wikipedia.org/wiki/Summation)
- `asum`: [Absolute summation](https://en.wikipedia.org/wiki/Summation)
- `max`: [Maximum](https://en.wikipedia.org/wiki/Maximal_and_minimal_elements)
- `min`: [Minimum](https://en.wikipedia.org/wiki/Maximal_and_minimal_elements)
- `mean`: [Arithmetic mean](https://en.wikipedia.org/wiki/Mean)
- `meamg`: [Mean of magnitudes](https://en.wikipedia.org/wiki/Mean)
- `measq`: [Mean of squares](https://en.wikipedia.org/wiki/Mean_square)
- `add`: [Addition](https://en.wikipedia.org/wiki/Addition)
- `sub`: [Subtraction](https://en.wikipedia.org/wiki/Subtraction)
- `mul`: [Multiplication](https://en.wikipedia.org/wiki/Multiplication)
- `div`: [Division](https://en.wikipedia.org/wiki/Division_(mathematics))
- `mod`: [Modulo](https://en.wikipedia.org/wiki/Modulo_operation)
- `remainder`: [Remainder](https://en.wikipedia.org/wiki/Remainder)
- `sqrt`: [Square root](https://en.wikipedia.org/wiki/Square_root)

### Auxiliary

- `abs`: [Absolute value](https://en.wikipedia.org/wiki/Absolute_value)
- `ceil`: [Ceiling function](https://en.wikipedia.org/wiki/Floor_and_ceiling_functions)
- `copysign`: [Signum function](https://en.wikipedia.org/wiki/Sign_function)
- `floor`: [Floor function](https://en.wikipedia.org/wiki/Floor_and_ceiling_functions)
- `rec`: [Multiplicative inverse](https://en.wikipedia.org/wiki/Multiplicative_inverse)
- `round`: [Rounding function](https://en.wikipedia.org/wiki/Rounding)
- `trunc`: [Integer truncation](https://en.wikipedia.org/wiki/Truncation)

### Convolution

- `conv`: [Convolution](https://en.wikipedia.org/wiki/Convolution)
- `xcorr`: [Cross correlation](https://en.wikipedia.org/wiki/Cross-correlation)

### Exponential

- `exp`: [Exponential function](https://en.wikipedia.org/wiki/Exponential_function)
- `exp2`: [Base-2 exponential function](https://en.wikipedia.org/wiki/Exponential_function)
- `log`: [Base-e logarithm](https://en.wikipedia.org/wiki/Logarithm)
- `log2`: [Base-2 logarithm](https://en.wikipedia.org/wiki/Logarithm)
- `log10`: [Base-10 logarithm](https://en.wikipedia.org/wiki/Logarithm)
- `logb`: [Base-radix logarithm](https://en.wikipedia.org/wiki/Logarithm)

### FFT

- `fft`: [Fast fourier transform](https://en.wikipedia.org/wiki/Fast_Fourier_transform)

### Hyperbolic

- `sinh`: [Hyperbolic sine](https://en.wikipedia.org/wiki/Hyperbolic_function)
- `cosh`: [Hyperbolic cosine](https://en.wikipedia.org/wiki/Hyperbolic_function)
- `tanh`: [Hyperbolic tangent](https://en.wikipedia.org/wiki/Hyperbolic_function)
- `asinh`: [Inverse hyperbolic cosine](https://en.wikipedia.org/wiki/Inverse_hyperbolic_functions)
- `acosh`: [Inverse hyperbolic cosine](https://en.wikipedia.org/wiki/Inverse_hyperbolic_functions)
- `atanh`: [Inverse hyperbolic cosine](https://en.wikipedia.org/wiki/Inverse_hyperbolic_functions)

### Matrix

- `sum`: [Axis-wise summation](https://en.wikipedia.org/wiki/Summation)
- `add`: [Matrix addition](https://en.wikipedia.org/wiki/Matrix_addition)
- `sub`: [Matrix subtraction](https://en.wikipedia.org/wiki/Matrix_subtraction)
- `mul`: [Matrix multiplication](https://en.wikipedia.org/wiki/Matrix_multiplication)
- `div`: [Matrix division](https://en.wikipedia.org/wiki/Division_(mathematics)#Of_matrices)
- `inv`: [Matrix inversion](https://en.wikipedia.org/wiki/Matrix_inversion)
- `transpose`: [Matrix transpose](https://en.wikipedia.org/wiki/Matrix_transpose)
- `det`: [Determinant](https://en.wikipedia.org/wiki/Matrix_determinant)
- `pow`: [Element-wise power](https://en.wikipedia.org/wiki/Power_(mathematics))
- `exp`: [Element-wise exponential function](https://en.wikipedia.org/wiki/Exponential_function)
- `elmul`: [Element-wise matrix multiplication](https://en.wikipedia.org/wiki/Multiplication)

### Power

- `pow`: [Power](https://en.wikipedia.org/wiki/Power_(mathematics))

### Trigonometric

- `sincos`
- `sin`: [Sine function](https://en.wikipedia.org/wiki/Trigonometric_functions#cosine)
- `cos`: [Cosine function](https://en.wikipedia.org/wiki/Trigonometric_functions#cosine)
- `tan`: [Tangent function](https://en.wikipedia.org/wiki/Trigonometric_functions#cosine)
- `asin`: [Arc sine function](https://en.wikipedia.org/wiki/Trigonometric_functions#cosine)
- `acos`: [Arc cosine function](https://en.wikipedia.org/wiki/Trigonometric_functions#cosine)
- `atan`: [Arc tangent function](https://en.wikipedia.org/wiki/Trigonometric_functions#cosine)
- `rad2deg`: [Radians to degrees](https://en.wikipedia.org/wiki/Radian)
- `deg2rad`: [degrees to radians](https://en.wikipedia.org/wiki/Radian)

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
