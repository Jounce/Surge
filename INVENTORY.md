# Inventory

- [Inventory](#inventory)
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
    - [Radians ↔︎ Degrees](#radians-%e2%86%94%ef%b8%8e-degrees)
  - [Exponential Function](#exponential-function)
  - [Logarithm](#logarithm)
  - [Statistical Operations](#statistical-operations)
    - [Summation](#summation-1)
    - [Minimum/Maximum](#minimummaximum)
    - [Mean](#mean)
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

| Arguments          | Function   | In-Place Function | Operator     | In-Place Operator |
|--------------------|------------|-------------------|--------------|-------------------|
| `(Array, Array)`   | `add`      | `addInPlace`      | `.+` (infix) | `.+=` (infix)     |
| `(Array, Scalar)`  | `add`      | `addInPlace`      | `+` (infix)  | `+=` (infix)      |
| `(Matrix, Matrix)` | `add`      | n/a               | `+` (infix)  | n/a               |
| `(Matrix, Scalar)` | n/a        | n/a               | `+` (infix)  | n/a               |
| `(Vector, Vector)` | `func add` | `addInPlace`      | `+` (infix)  | `+=` (infix)      |
| `(Vector, Scalar)` | `func add` | `addInPlace`      | `+` (infix)  | `+=` (infix)      |

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

| Arguments          | Function | In-Place Function | Operator     | In-Place Operator |
|--------------------|----------|-------------------|--------------|-------------------|
| `(Array, Array)`   | `sub`    | `subInPlace`      | `.-` (infix) | `.-=` (infix)     |
| `(Array, Scalar)`  | `sub`    | `subInPlace`      | `-` (infix)  | `-=` (infix)      |
| `(Matrix, Matrix)` | `sub`    | n/a               | `-` (infix)  | n/a               |
| `(Matrix, Scalar)` | n/a      | n/a               | n/a          | n/a               |
| `(Vector, Vector)` | `sub`    | `subInPlace`      | `-` (infix)  | `-=` (infix)      |
| `(Vector, Scalar)` | `sub`    | `subInPlace`      | `-` (infix)  | `-=` (infix)      |

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

| Arguments          | Function | In-Place Function | Operator     | In-Place Operator |
|--------------------|----------|-------------------|--------------|-------------------|
| `(Array, Array)`   | `mul`    | `mulInPlace`      | `.*` (infix) | `.*=` (infix)     |
| `(Array, Scalar)`  | `mul`    | `mulInPlace`      | `*` (infix)  | `*=` (infix)      |
| `(Matrix, Matrix)` | `mul`    | n/a               | `*` (infix)  | n/a               |
| `(Matrix, Vector)` | `mul`    | n/a               | `*` (infix)  | n/a               |
| `(Matrix, Scalar)` | `mul`    | n/a               | `*` (infix)  | n/a               |
| `(Vector, Matrix)` | `mul`    | n/a               | `*` (infix)  | n/a               |
| `(Vector, Scalar)` | `mul`    | `mulInPlace`      | `*` (infix)  | `*=` (infix)      |
| `(Scalar, Array)`  | `mul`    | n/a               | `*` (infix)  | n/a               |
| `(Scalar, Matrix)` | `mul`    | n/a               | `*` (infix)  | n/a               |
| `(Scalar, Vector)` | `mul`    | n/a               | `*` (infix)  | n/a               |

</details>

### [Element-wise multiplication](https://en.wikipedia.org/wiki/Multiplication)

<details open>

<summary>
Element-wise multiplication functions & operators
</summary>

| Arguments          | Function | In-Place Function | Operator     | In-Place Operator |
|--------------------|----------|-------------------|--------------|-------------------|
| `(Matrix, Matrix)` | `elmul`  | n/a               | n/a          | n/a               |
| `(Vector, Vector)` | `elmul`  | `elmulInPlace`    | `.*` (infix) | `.*=` (infix)     |

<!-- FIXME: The does not seem to be a `.*` implemented for `(Matrix, Matrix)`. -->

</details>

### [Division](https://en.wikipedia.org/wiki/Division_(mathematics))

<details open>

<summary>
Division functions & operators
</summary>

| Arguments          | Function | In-Place Function | Operator     | In-Place Operator |
|--------------------|----------|-------------------|--------------|-------------------|
| `(Array, Array)`   | `div`    | `divInPlace`      | `./` (infix) | `./=` (infix)     |
| `(Array, Scalar)`  | `div`    | `divInPlace`      | `/` (infix)  | `/=` (infix)      |
| `(Matrix, Matrix)` | `div`    | n/a               | `/` (infix)  | n/a               |
| `(Matrix, Scalar)` | n/a      | n/a               | `/` (infix)  | n/a               |
| `(Vector, Scalar)` | `div`    | `divInPlace`      | `/` (infix)  | `/=` (infix)      |

<!-- FIXME: Func `div` of `(Array, Array)` should be called `eldiv`, no? -->
<!-- FIXME: Missing `div` function for `(Matrix, Scalar)`. -->

</details>

### [Element-wise Division](https://en.wikipedia.org/wiki/Division_(mathematics))

<details open>

<summary>
Element-wise multiplication functions & operators
</summary>

| Arguments          | Function | In-Place Function | Operator     | In-Place Operator |
|--------------------|----------|-------------------|--------------|-------------------|
| `(Vector, Vector)` | `eldiv`  | `eldivInPlace`    | `./` (infix) | `./=` (infix)     |

</details>

### [Modulo](https://en.wikipedia.org/wiki/Modulo_operation)

<details open>

<summary>
Modulo functions & operators
</summary>

| Arguments         | Function | In-Place Function | Operator     | In-Place Operator |
|-------------------|----------|-------------------|--------------|-------------------|
| `(Array, Array)`  | `mod`    | n/a               | `.%` (infix) | n/a               |
| `(Array, Scalar)` | `mod`    | n/a               | `%` (infix)  | n/a               |

<!-- FIXME: Do we need `mod` functions/operators for `Matrix`? -->
<!-- FIXME: Do we need `mod` functions/operators for `Vector`? -->

</details>

### [Remainder](https://en.wikipedia.org/wiki/Remainder)

<details open>

<summary>
Remainder functions & operators
</summary>

| Arguments         | Function    | In-Place Function | Operator | In-Place Operator |
|-------------------|-------------|-------------------|----------|-------------------|
| `(Array, Array)`  | `remainder` | n/a               | n/a      | n/a               |
| `(Array, Scalar)` | `remainder` | n/a               | n/a      | n/a               |

<!-- FIXME: Do we need `remainder` functions /operators for `Matrix`? -->
<!-- FIXME: Do we need `remainder` functions /operators for `Vector`? -->

</details>

### [Square Root](https://en.wikipedia.org/wiki/Square_root)

<details open>

<summary>
Square root functions & operators
</summary>

| Arguments | Function | In-Place Function | Operator | In-Place Operator |
|-----------|----------|-------------------|----------|-------------------|
| `(Array)` | `sqrt`   | n/a               | n/a      | n/a               |

<!-- FIXME: The seems to be a variant `func sqrt<MI, MO>(_ x: MI, into results: inout MO)` that could be made into a `sqrtInPlace`-->

<!-- FIXME: Do we need `sqrt` functions/operators for `Matrix`? -->
<!-- FIXME: Do we need `sqrt` functions/operators for `Vector`? -->

</details>

### [Summation](https://en.wikipedia.org/wiki/Summation)

<details open>

<summary>
Sum functions & operators
</summary>

| Arguments  | Function | In-Place Function | Operator | In-Place Operator |
|------------|----------|-------------------|----------|-------------------|
| `(Array)`  | `sum`    | n/a               | n/a      | n/a               |
| `(Matrix)` | `sum`    | n/a               | n/a      | n/a               |

<!-- FIXME: Do we need `sum` functions/operators for `Vector`? -->

</details>

### [Dot Product](https://en.wikipedia.org/wiki/Dot_product)

<details open>

<summary>
Dot product functions & operators
</summary>

| Arguments          | Function | In-Place Function | Operator    | In-Place Operator |
|--------------------|----------|-------------------|-------------|-------------------|
| `(Array, Array)`   | `dot`    | n/a               | `•` (infix) | n/a               |
| `(Vector, Vector)` | `dot`    | n/a               | `•` (infix) | n/a               |

<!-- FIXME: Do we need `dot` functions/operators for `Matrix`? -->

</details>

### [Distance](https://en.wikipedia.org/wiki/Euclidean_distance)

<details open>

<summary>
Distance functions & operators
</summary>

| Arguments          | Function | In-Place Function | Operator | In-Place Operator |
|--------------------|----------|-------------------|----------|-------------------|
| `(Array, Array)`   | `dist`   | n/a               | n/a      | n/a               |
| `(Vector, Vector)` | `dist`   | n/a               | n/a      | n/a               |

### [Squared Distance](https://en.wikipedia.org/wiki/Euclidean_distance#Squared_Euclidean_distance)

<details open>

<summary>
Squared distance functions & operators
</summary>

| Arguments          | Function | In-Place Function | Operator | In-Place Operator |
|--------------------|----------|-------------------|----------|-------------------|
| `(Array, Array)`   | `distSq` | n/a               | n/a      | n/a               |
| `(Vector, Vector)` | `distSq` | n/a               | n/a      | n/a               |

</details>

### [Power](https://en.wikipedia.org/wiki/Power_(mathematics))

<details open>

<summary>
Power functions & operators
</summary>

| Arguments          | Function | In-Place Function | Operator     | In-Place Operator |
|--------------------|----------|-------------------|--------------|-------------------|
| `(Array, Array)`   | `pow`    | n/a               | `**` (infix) | n/a               |
| `(Array, Scalar)`  | `pow`    | n/a               | `**` (infix) | n/a               |
| `(Matrix, Scalar)` | `pow`    | n/a               | `**` (infix) | n/a               |
| `(Vector, Vector)` | `pow`    | n/a               | n/a          | n/a               |

<!-- FIXME: Shouldn't the `pow`/`**` function/operator of `(Array, Array)` be `elpow`/`.**`? -->
<!-- FIXME: Shouldn't the `pow`/`**` function/operator of `(Vector, Vector)` be `elpow`/`.**`? -->
<!-- FIXME: The does not seem to be a corresponding `.**` operator implemented. -->
<!-- FIXME: Do we need `pow` functions/operators for `(Vector, Scalar)`? -->

### [Exponential](https://en.wikipedia.org/wiki/Exponential_function)

<details open>

<summary>
Exponential functions & operators
</summary>

| Arguments  | Function | In-Place Function | Operator | In-Place Operator |
|------------|----------|-------------------|----------|-------------------|
| `(Array)`  | `exp`    | n/a               | n/a      | n/a               |
| `(Matrix)` | `exp`    | n/a               | n/a      | n/a               |
| `(Vector)` | `exp`    | n/a               | n/a      | n/a               |

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

### [Mean](https://en.wikipedia.org/wiki/Mean)

| Arguments | Function | Operation                                                    |
|-----------|----------|--------------------------------------------------------------|
| `(Array)` | `mean`   | [Mean](https://en.wikipedia.org/wiki/Mean)                   |
| `(Array)` | `meamg`  | Mean of Magnitudes                                           |
| `(Array)` | `measq`  | [Mean of squares](https://en.wikipedia.org/wiki/Mean_square) |

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
