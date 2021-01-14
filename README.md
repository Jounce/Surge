# Surge

[![Build Status][build status badge]][build status]
[![License][license badge]][license]
![CocoaPods platforms][cocoapods platforms badge]
[![CocoaPods compatible][cocoapods badge]][cocoapods]
[![Carthage compatible][carthage badge]][carthage]
[![Swift Package Manager compatible][swift package manager badge]][swift package manager]

Surge is a Swift library that uses the Accelerate framework to provide high-performance functions for matrix math, digital signal processing, and image manipulation.

Accelerate exposes [SIMD](http://en.wikipedia.org/wiki/SIMD) instructions available in modern CPUs to significantly improve performance of certain calculations. Because of its relative obscurity and inconvenient APIs, Accelerate is not commonly used by developers, which is a shame, since many applications could benefit from these performance optimizations.

**Surge aims to bring Accelerate to the mainstream, making it as easy (and nearly as fast, in most cases) to perform computation over a set of numbers as for a single member.**

Though, keep in mind: _Accelerate is not a silver bullet_. Under certain conditions, such as performing simple calculations over a small data set, Accelerate can be out-performed by conventional algorithms. Always benchmark to determine the performance characteristics of each potential approach.

---

> Curious about the name _Surge_? (And _Jounce_?)
> Back in the mid 90's, Apple, IBM, and Motorola teamed up to create
> [AltiVec](http://en.wikipedia.org/wiki/AltiVec) (a.k.a the Velocity Engine),
> which provided a SIMD instruction set for the PowerPC architecture.
> When Apple made the switch to Intel CPUs,
> AltiVec was ported to the x86 architecture and rechristened
> [Accelerate](https://developer.apple.com/documentation/Accelerate).
> The derivative of Accelerate (and second derivative of Velocity)
> is known as either [jerk, jolt, _surge_, or lurch](http://en.wikipedia.org/wiki/Jerk_%28physics%29);
> if you take the derivative of surge,
> you get the [_jounce_](https://en.wikipedia.org/wiki/Jounce) ---
> hence the name of this library and its parent organization.

---

## Installation

_The infrastructure and best practices for distributing Swift libraries are currently in flux during this beta period of Swift & Xcode. In the meantime, you can add Surge as a git submodule, drag the `Surge.xcodeproj` file into your Xcode project, and add `Surge.framework` as a dependency for your target._

Surge uses Swift 5. This means that your code has to be written in Swift 5 due to current binary compatibility limitations.

## License

Surge is available under the MIT license. See the LICENSE file for more info.

### Swift Package Manager

To use [Swift Package Manager](https://swift.org/package-manager/) add Surge to your `Package.swift` file:

```swift
let package = Package(
    name: "myproject",
    dependencies: [
        .package(url: "https://github.com/Jounce/Surge.git", .upToNextMajor(from: "2.3.2")),
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
    pod 'Surge', '~> 2.3.2'
end
```

Then run `pod install`.

### Carthage

To use [Carthage](https://github.com/Carthage/Carthage) add Surge to your `Cartfile`:

```ruby
github "Jounce/Surge" ~> 2.3.2
```

Then run `carthage update` and use the framework in `Carthage/Build/<platform>`.

---

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

let product = Surge.elmul(a, b) // [2.0, 12.0, 30.0, 56.0]
```

# Inventory

- [Installation](#installation)
- [License](#license)
  - [Swift Package Manager](#swift-package-manager)
  - [CocoaPods](#cocoapods)
  - [Carthage](#carthage)
- [Usage](#usage)
  - [Computing Sum of `[Double]`](#computing-sum-of-double)
  - [Computing Product of Two `[Double]`s](#computing-product-of-two-doubles)
- [General Arithmetic Operations](#general-arithmetic-operations)
  - [Addition](#addition)
  - [Subtraction](#subtraction)
  - [Multiplication](#multiplication)
  - [Element-wise multiplication](#element-wise-multiplication)
  - [Division)](#division)
  - [Element-wise Division)](#element-wise-division)
  - [Modulo](#modulo)
  - [Remainder](#remainder)
  - [Square Root](#square-root)
  - [Summation](#summation)
  - [Dot Product](#dot-product)
  - [Distance](#distance)
  - [Squared Distance](#squared-distance)
  - [Power)](#power)
  - [Exponential](#exponential)
- [Trigonometric Operations](#trigonometric-operations)
  - [Sine/Cosine/Tangent](#sinecosinetangent)
  - [Arc Sine/Cosine/Tangent](#arc-sinecosinetangent)
  - [Hyperbolic Sine/Cosine/Tangent](#hyperbolic-sinecosinetangent)
  - [Inverse Hyperbolic Sine/Cosine/Tangent](#inverse-hyperbolic-sinecosinetangent)
  - [Radians ↔︎ Degrees](#radians-︎-degrees)
- [Exponential Function](#exponential-function)
- [Logarithm](#logarithm)
- [Statistical Operations](#statistical-operations)
  - [Summation](#summation-1)
  - [Minimum/Maximum](#minimummaximum)
  - [Mean/Variance](#meanvariance)
- [Auxiliary Functions](#auxiliary-functions)
  - [Rounding Functions](#rounding-functions)
  - [Absolute value](#absolute-value)
  - [Signum function](#signum-function)
  - [Multiplicative inverse](#multiplicative-inverse)
- [Matrix-specific Operations](#matrix-specific-operations)
  - [Matrix Inversion](#matrix-inversion)
  - [Matrix Transposition](#matrix-transposition)
  - [Matrix Determinant](#matrix-determinant)
  - [Eigen Decomposition](#eigen-decomposition)
- [DSP-specific Operations](#dsp-specific-operations)
  - [Fast Fourier Transform](#fast-fourier-transform)
  - [Convolution](#convolution)
  - [Cross-Correlation](#cross-correlation)

## General Arithmetic Operations

### [Addition](https://en.wikipedia.org/wiki/Addition)

<details open>

<summary>
Addition functions & operators
</summary>

| Arguments          | Function | Operator     | In-Place Operator |
|--------------------|----------|--------------|-------------------|
| `(Array, Array)`   | `add`    | `.+` (infix) | `.+=` (infix)     |
| `(Array, Scalar)`  | `add`    | `+` (infix)  | `+=` (infix)      |
| `(Matrix, Matrix)` | `add`    | `+` (infix)  | `+=` (infix)      |
| `(Matrix, Scalar)` | n/a      | n/a          | n/a               |
| `(Vector, Vector)` | `add`    | `+` (infix)  | `+=` (infix)      |
| `(Vector, Scalar)` | `add`    | `+` (infix)  | `+=` (infix)      |

<!--
Internal use only:

| In-Place Function |
|-------------------|
| `addInPlace`      |
| `addInPlace`      |
| n/a               |
| n/a               |
| `addInPlace`      |
| `addInPlace`      |
-->

<!-- FIXME: `add` for `(Array, Array)` should be called `eladd`/`.+`, no? -->
<!-- FIXME: Missing `add` function for `(Matrix, Scalar)`. -->
<!-- FIXME: Missing `add` functions/operators for `(Matrix, Vector)`. -->
<!-- FIXME: Missing `addInPlace` function for `(Matrix, Scalar)` & `(Matrix, Matrix)`. -->

</details>

### [Subtraction](https://en.wikipedia.org/wiki/Subtraction)

<details open>

<summary>
Subtraction functions & operators
</summary>

| Arguments          | Function | Operator     | In-Place Operator |
|--------------------|----------|--------------|-------------------|
| `(Array, Array)`   | `sub`    | `.-` (infix) | `.-=` (infix)     |
| `(Array, Scalar)`  | `sub`    | `-` (infix)  | `-=` (infix)      |
| `(Matrix, Matrix)` | `sub`    | `-` (infix)  | `-=` (infix)      |
| `(Matrix, Scalar)` | n/a      | n/a          | n/a               |
| `(Vector, Vector)` | `sub`    | `-` (infix)  | `-=` (infix)      |
| `(Vector, Scalar)` | `sub`    | `-` (infix)  | `-=` (infix)      |

<!--
Internal use only:

| In-Place Function |
|-------------------|
| `subInPlace`      |
| `subInPlace`      |
| n/a               |
| n/a               |
| `subInPlace`      |
| `subInPlace`      |
-->

<!-- FIXME: `sub` for `(Array, Array)` should be called `elsub`/`.-`, no? -->
<!-- FIXME: Missing `sub` function/operator for `(Matrix, Scalar)`. -->
<!-- FIXME: Missing `sub` functions/operators for `(Matrix, Vector)`. -->
<!-- FIXME: Missing `subInPlace` function for `(Matrix, Scalar)` & `(Matrix, Matrix)`. -->

</details>

### [Multiplication](https://en.wikipedia.org/wiki/Multiplication)

<details open>

<summary>
Multiplication functions & operators
</summary>

| Arguments          | Function | Operator     | In-Place Operator |
|--------------------|----------|--------------|-------------------|
| `(Array, Array)`   | `mul`    | `.*` (infix) | `.*=` (infix)     |
| `(Array, Scalar)`  | `mul`    | `*` (infix)  | `*=` (infix)      |
| `(Matrix, Matrix)` | `mul`    | `*` (infix)  | n/a               |
| `(Matrix, Vector)` | `mul`    | `*` (infix)  | n/a               |
| `(Matrix, Scalar)` | `mul`    | `*` (infix)  | n/a               |
| `(Vector, Matrix)` | `mul`    | `*` (infix)  | n/a               |
| `(Vector, Scalar)` | `mul`    | `*` (infix)  | `*=` (infix)      |
| `(Scalar, Array)`  | `mul`    | `*` (infix)  | n/a               |
| `(Scalar, Matrix)` | `mul`    | `*` (infix)  | n/a               |
| `(Scalar, Vector)` | `mul`    | `*` (infix)  | n/a               |

<!--
Internal use only:

| In-Place Function |
|-------------------|
| `mulInPlace`      |
| `mulInPlace`      |
| n/a               |
| n/a               |
| n/a               |
| n/a               |
| `mulInPlace`      |
| n/a               |
| n/a               |
| n/a               |
-->

</details>

### [Element-wise multiplication](https://en.wikipedia.org/wiki/Multiplication)

<details open>

<summary>
Element-wise multiplication functions & operators
</summary>

| Arguments          | Function | Operator     | In-Place Operator |
|--------------------|----------|--------------|-------------------|
| `(Matrix, Matrix)` | `elmul`  | n/a          | n/a               |
| `(Vector, Vector)` | `elmul`  | `.*` (infix) | `.*=` (infix)     |

<!--
Internal use only:

| In-Place Function |
|-------------------|
| n/a               |
| `elmulInPlace`    |
-->

<!-- FIXME: The does not seem to be a `.*` implemented for `(Matrix, Matrix)`. -->

</details>

### [Division](https://en.wikipedia.org/wiki/Division_(mathematics))

<details open>

<summary>
Division functions & operators
</summary>

| Arguments          | Function | Operator     | In-Place Operator |
|--------------------|----------|--------------|-------------------|
| `(Array, Array)`   | `div`    | `./` (infix) | `./=` (infix)     |
| `(Array, Scalar)`  | `div`    | `/` (infix)  | `/=` (infix)      |
| `(Matrix, Matrix)` | `div`    | `/` (infix)  | n/a               |
| `(Matrix, Scalar)` | n/a      | `/` (infix)  | n/a               |
| `(Vector, Scalar)` | `div`    | `/` (infix)  | `/=` (infix)      |

<!--
Internal use only:

| In-Place Function |
|-------------------|
| `divInPlace`      |
| `divInPlace`      |
| n/a               |
| n/a               |
| `divInPlace`      |
-->

<!-- FIXME: Func `div` of `(Array, Array)` should be called `eldiv`, no? -->
<!-- FIXME: Missing `div` function for `(Matrix, Scalar)`. -->

</details>

### [Element-wise Division](https://en.wikipedia.org/wiki/Division_(mathematics))

<details open>

<summary>
Element-wise multiplication functions & operators
</summary>

| Arguments          | Function | Operator     | In-Place Operator |
|--------------------|----------|--------------|-------------------|
| `(Vector, Vector)` | `eldiv`  | `./` (infix) | `./=` (infix)     |

<!--
Internal use only:

| In-Place Function |
|-------------------|
| `eldivInPlace`    |
 -->

</details>

### [Modulo](https://en.wikipedia.org/wiki/Modulo_operation)

<details open>

<summary>
Modulo functions & operators
</summary>

| Arguments         | Function | Operator     | In-Place Operator |
|-------------------|----------|--------------|-------------------|
| `(Array, Array)`  | `mod`    | `.%` (infix) | n/a               |
| `(Array, Scalar)` | `mod`    | `%` (infix)  | n/a               |

<!--
Internal use only:

| In-Place Function |
|-------------------|
| n/a               |
| n/a               |
-->

<!-- FIXME: Do we need `mod` functions/operators for `Matrix`? -->
<!-- FIXME: Do we need `mod` functions/operators for `Vector`? -->

</details>

### [Remainder](https://en.wikipedia.org/wiki/Remainder)

<details open>

<summary>
Remainder functions & operators
</summary>

| Arguments         | Function    | Operator | In-Place Operator |
|-------------------|-------------|----------|-------------------|
| `(Array, Array)`  | `remainder` | n/a      | n/a               |
| `(Array, Scalar)` | `remainder` | n/a      | n/a               |

<!--
Internal use only:

| In-Place Function |
|-------------------|
| n/a               |
| n/a               |
 -->

<!-- FIXME: Do we need `remainder` functions /operators for `Matrix`? -->
<!-- FIXME: Do we need `remainder` functions /operators for `Vector`? -->

</details>

### [Square Root](https://en.wikipedia.org/wiki/Square_root)

<details open>

<summary>
Square root functions & operators
</summary>

| Arguments | Function | Operator | In-Place Operator |
|-----------|----------|----------|-------------------|
| `(Array)` | `sqrt`   | n/a      | n/a               |

<!--
Internal use only:

| In-Place Function |
|-------------------|
| n/a               |
 -->

<!-- FIXME: The seems to be a variant `func sqrt<MI, MO>(_ x: MI, into results: inout MO)` that could be made into a `sqrtInPlace`-->

<!-- FIXME: Do we need `sqrt` functions/operators for `Matrix`? -->
<!-- FIXME: Do we need `sqrt` functions/operators for `Vector`? -->

</details>

### [Summation](https://en.wikipedia.org/wiki/Summation)

<details open>

<summary>
Sum functions & operators
</summary>

| Arguments  | Function | Operator | In-Place Operator |
|------------|----------|----------|-------------------|
| `(Array)`  | `sum`    | n/a      | n/a               |
| `(Matrix)` | `sum`    | n/a      | n/a               |

<!--
Internal use only:

| In-Place Function |
|-------------------|
| n/a               |
| n/a               |
 -->

<!-- FIXME: Do we need `sum` functions/operators for `Vector`? -->

</details>

### [Dot Product](https://en.wikipedia.org/wiki/Dot_product)

<details open>

<summary>
Dot product functions & operators
</summary>

| Arguments          | Function | Operator    | In-Place Operator |
|--------------------|----------|-------------|-------------------|
| `(Array, Array)`   | `dot`    | `•` (infix) | n/a               |
| `(Vector, Vector)` | `dot`    | `•` (infix) | n/a               |

<!--
Internal use only:

| In-Place Function |
|-------------------|
| n/a               |
| n/a               |
 -->

<!-- FIXME: Do we need `dot` functions/operators for `Matrix`? -->

</details>

### [Distance](https://en.wikipedia.org/wiki/Euclidean_distance)

<details open>

<summary>
Distance functions & operators
</summary>

| Arguments          | Function | Operator | In-Place Operator |
|--------------------|----------|----------|-------------------|
| `(Array, Array)`   | `dist`   | n/a      | n/a               |
| `(Vector, Vector)` | `dist`   | n/a      | n/a               |

<!--
Internal use only:

| In-Place Function |
|-------------------|
| n/a               |
| n/a               |
 -->

### [Squared Distance](https://en.wikipedia.org/wiki/Euclidean_distance#Squared_Euclidean_distance)

<details open>

<summary>
Squared distance functions & operators
</summary>

| Arguments          | Function | Operator | In-Place Operator |
|--------------------|----------|----------|-------------------|
| `(Array, Array)`   | `distSq` | n/a      | n/a               |
| `(Vector, Vector)` | `distSq` | n/a      | n/a               |

<!--
Internal use only:

| In-Place Function |
|-------------------|
| n/a               |
| n/a               |
 -->

</details>

### [Power](https://en.wikipedia.org/wiki/Power_(mathematics))

<details open>

<summary>
Power functions & operators
</summary>

| Arguments          | Function | Operator     | In-Place Operator |
|--------------------|----------|--------------|-------------------|
| `(Array, Array)`   | `pow`    | `.**` (infix) | `.**=` (infix)    |
| `(Array, Scalar)`  | `pow`    | `**` (infix) | `**=` (infix)     |
| `(Matrix, Scalar)` | `pow`    | n/a          | n/a               |
| `(Vector, Vector)` | `pow`    | n/a          | n/a               |

([Serial exponentiation](https://en.wikipedia.org/wiki/Order_of_operations#Serial_exponentiation): `a ** b ** c == a ** (b ** c)`)

<!--
Internal use only:

| In-Place Function |
|-------------------|
| n/a               |
| n/a               |
| n/a               |
| n/a               |
 -->

<!-- FIXME: Shouldn't the `pow`/`**` function/operator of `(Array, Array)` be `elpow`/`.**`? -->
<!-- FIXME: Shouldn't the `pow`/`**` function/operator of `(Vector, Vector)` be `elpow`/`.**`? -->
<!-- FIXME: The does not seem to be a corresponding `.**` operator implemented. -->
<!-- FIXME: Do we need `pow` functions/operators for `(Vector, Scalar)`? -->

### [Exponential](https://en.wikipedia.org/wiki/Exponential_function)

<details open>

<summary>
Exponential functions & operators
</summary>

| Arguments  | Function | Operator | In-Place Operator |
|------------|----------|----------|-------------------|
| `(Array)`  | `exp`    | n/a      | n/a               |
| `(Matrix)` | `exp`    | n/a      | n/a               |
| `(Vector)` | `exp`    | n/a      | n/a               |

<!--
Internal use only:

| In-Place Function |
|-------------------|
| n/a               |
| n/a               |
| n/a               |
 -->

</details>

## Trigonometric Operations

<details open>

<summary>
Trigonometric functions & operators
</summary>

### [Sine/Cosine/Tangent](https://en.wikipedia.org/wiki/Trigonometric_functions)

| Arguments | Function | Operation     |
|-----------|----------|---------------|
| `(Array)` | `sin`    | Sine          |
| `(Array)` | `cos`    | Cosine        |
| `(Array)` | `tan`    | Tangent       |
| `(Array)` | `sincos` | Sine & Cosine |

### [Arc Sine/Cosine/Tangent](https://en.wikipedia.org/wiki/Trigonometric_functions)

| Arguments | Function | Operation   |
|-----------|----------|-------------|
| `(Array)` | `asin`   | Arc Sine    |
| `(Array)` | `acos`   | Arc Cosine  |
| `(Array)` | `atan`   | Arc Tangent |

### [Hyperbolic Sine/Cosine/Tangent](https://en.wikipedia.org/wiki/Hyperbolic_function)

| Arguments | Function | Operation          |
|-----------|----------|--------------------|
| `(Array)` | `sinh`   | Hyperbolic Sine    |
| `(Array)` | `cosh`   | Hyperbolic Cosine  |
| `(Array)` | `tanh`   | Hyperbolic Tangent |

### [Inverse Hyperbolic Sine/Cosine/Tangent](https://en.wikipedia.org/wiki/Inverse_hyperbolic_functions)

| Arguments | Function | Operation                  |
|-----------|----------|----------------------------|
| `(Array)` | `asinh`  | Inverse Hyperbolic Sine    |
| `(Array)` | `acosh`  | Inverse Hyperbolic Cosine  |
| `(Array)` | `atanh`  | Inverse Hyperbolic Tangent |

### [Radians ↔︎ Degrees](https://en.wikipedia.org/wiki/Angle#Types_of_angles)

| Arguments | Function  | Operation                                                                                                  |
|-----------|-----------|------------------------------------------------------------------------------------------------------------|
| `(Array)` | `rad2deg` | [Radians](https://en.wikipedia.org/wiki/Radian) to [Degrees](https://en.wikipedia.org/wiki/Degree_(angle)) |
| `(Array)` | `deg2rad` | [Degrees](https://en.wikipedia.org/wiki/Degree_(angle)) to [Radians](https://en.wikipedia.org/wiki/Radian) |

</details>

## [Exponential Function](https://en.wikipedia.org/wiki/Exponential_function)

<details open>

<summary>
Exponential functions & operators
</summary>

| Arguments | Function | Operation                   |
|-----------|----------|-----------------------------|
| `(Array)` | `exp`    | Base-e Exponential Function |
| `(Array)` | `exp2`   | Base-2 Exponential Function |

</details>

## [Logarithm](https://en.wikipedia.org/wiki/Logarithm)

<details open>

<summary>
Exponential functions & operators
</summary>

| Arguments | Function | Operation         |
|-----------|----------|-------------------|
| `(Array)` | `log`    | Base-e Logarithm  |
| `(Array)` | `log2`   | Base-2 Logarithm  |
| `(Array)` | `log10`  | Base-10 Logarithm |
| `(Array)` | `logb`   | Base-b Logarithm  |

</details>

## Statistical Operations

<details open>

<summary>
Statistical functions & operators
</summary>

### [Summation](https://en.wikipedia.org/wiki/Summation)

| Arguments | Function | Operation          |
|-----------|----------|--------------------|
| `(Array)` | `sum`    | Summation          |
| `(Array)` | `asum`   | Absolute Summation |

### [Minimum/Maximum](https://en.wikipedia.org/wiki/Maximal_and_minimal_elements)

| Arguments | Function | Operation |
|-----------|----------|-----------|
| `(Array)` | `min`    | Minimum   |
| `(Array)` | `max`    | Maximum   |

### [Mean/Variance](https://en.wikipedia.org/wiki/Mean)

| Arguments | Function   | Operation                                                              |
|-----------|------------|------------------------------------------------------------------------|
| `(Array)` | `mean`     | [Mean](https://en.wikipedia.org/wiki/Mean)                             |
| `(Array)` | `meamg`    | Mean of Magnitudes                                                     |
| `(Array)` | `measq`    | [Mean of Squares](https://en.wikipedia.org/wiki/Mean_square)           |
| `(Array)` | `variance` | [Variance](https://en.wikipedia.org/wiki/Variance)                     |
| `(Array)` | `std`      | [Standard Deviation](https://en.wikipedia.org/wiki/Standard_deviation) |

</details>

## Auxiliary Functions

<details open>

<summary>
Auxiliary functions & operators
</summary>

### [Rounding Functions](https://en.wikipedia.org/wiki/Rounding)

| Arguments | Function | Operation                                                             |
|-----------|----------|-----------------------------------------------------------------------|
| `(Array)` | `ceil`   | [Ceiling](https://en.wikipedia.org/wiki/Floor_and_ceiling_functions)  |
| `(Array)` | `floor`  | [Flooring](https://en.wikipedia.org/wiki/Floor_and_ceiling_functions) |
| `(Array)` | `round`  | [Rounding](https://en.wikipedia.org/wiki/Rounding)                    |
| `(Array)` | `trunc`  | [Integer truncation](https://en.wikipedia.org/wiki/Truncation)        |

### [Absolute value](https://en.wikipedia.org/wiki/Absolute_value)

| Arguments | Function | In-Place Function | Operator | In-Place Operator |
|-----------|----------|-------------------|----------|-------------------|
| `(Array)` | `abs`    | n/a               | n/a      | n/a               |

### [Signum function](https://en.wikipedia.org/wiki/Sign_function)

| Arguments | Function   | In-Place Function | Operator | In-Place Operator |
|-----------|------------|-------------------|----------|-------------------|
| `(Array)` | `copysign` | n/a               | n/a      | n/a               |

### [Multiplicative inverse](https://en.wikipedia.org/wiki/Multiplicative_inverse)

| Arguments | Function | In-Place Function | Operator | In-Place Operator |
|-----------|----------|-------------------|----------|-------------------|
| `(Array)` | `rec`    | n/a               | n/a      | n/a               |

</details>

## Matrix-specific Operations

<details open>

<summary>
Matrix-specific functions & operators
</summary>

### [Matrix Inversion](https://en.wikipedia.org/wiki/Invertible_matrix)

| Arguments  | Function | In-Place Function | Operator | In-Place Operator |
|------------|----------|-------------------|----------|-------------------|
| `(Matrix)` | `inv`    | n/a               | n/a      | n/a               |

### [Matrix Transposition](https://en.wikipedia.org/wiki/Matrix_transpose)

| Arguments  | Function    | In-Place Function | Operator      | In-Place Operator |
|------------|-------------|-------------------|---------------|-------------------|
| `(Matrix)` | `transpose` | n/a               | `′` (postfix) | n/a               |

### [Matrix Determinant](https://en.wikipedia.org/wiki/Matrix_determinant)

| Arguments  | Function | In-Place Function | Operator | In-Place Operator |
|------------|----------|-------------------|----------|-------------------|
| `(Matrix)` | `det`    | n/a               | n/a      | n/a               |

### [Eigen Decomposition](https://en.wikipedia.org/wiki/Eigen_decomposition)

| Arguments  | Function         | In-Place Function | Operator | In-Place Operator |
|------------|------------------|-------------------|----------|-------------------|
| `(Matrix)` | `eigenDecompose` | n/a               | n/a      | n/a               |

</details>

## DSP-specific Operations

<details open>

<summary>
Fast fourier transform functions & operators
</summary>

### [Fast Fourier Transform](https://en.wikipedia.org/wiki/Convolution)

| Arguments | Function | In-Place Function | Operator | In-Place Operator |
|-----------|----------|-------------------|----------|-------------------|
| `(Array)` | `fft`    | n/a               | n/a      | n/a               |

### [Convolution](https://en.wikipedia.org/wiki/Convolution)

| Arguments        | Function | In-Place Function | Operator | In-Place Operator |
|------------------|----------|-------------------|----------|-------------------|
| `(Array, Array)` | `conv`   | n/a               | n/a      | n/a               |

### [Cross-Correlation](https://en.wikipedia.org/wiki/Cross-correlation)

| Arguments        | Function | In-Place Function | Operator | In-Place Operator |
|------------------|----------|-------------------|----------|-------------------|
| `(Array, Array)` | `xcorr`  | n/a               | n/a      | n/a               |
| `(Array)`        | `xcorr`  | n/a               | n/a      | n/a               |

</details>

[build status]: https://github.com/Jounce/Surge/actions?query=workflow%3ACI
[build status badge]: https://github.com/Jounce/Surge/workflows/CI/badge.svg
[license]: https://opensource.org/licenses/MIT
[license badge]: https://img.shields.io/cocoapods/l/Surge.svg
[cocoapods platforms badge]: https://img.shields.io/cocoapods/p/Surge.svg
[cocoapods]: https://cocoapods.org/pods/Surge
[cocoapods badge]: https://img.shields.io/cocoapods/v/Surge.svg
[carthage]: https://github.com/Carthage/Carthage
[carthage badge]: https://img.shields.io/badge/Carthage-compatible-4BC51D.svg
[swift package manager badge]: https://img.shields.io/badge/spm-compatible-brightgreen.svg?style=flat
[swift package manager]: https://swift.org/package-manager
