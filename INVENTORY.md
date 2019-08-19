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
    - [Sine/Cosine](#sinecosine)
    - [Sine](#sine)
    - [Cosine](#cosine)
    - [Tangent](#tangent)
    - [Arc Sine](#arc-sine)
    - [Arc Cosine](#arc-cosine)
    - [Arc Tangent](#arc-tangent)
    - [Hyperbolic Sine](#hyperbolic-sine)
    - [Hyperbolic Cosine](#hyperbolic-cosine)
    - [Hyperbolic Tangent](#hyperbolic-tangent)
    - [Inverse Hyperbolic Sine](#inverse-hyperbolic-sine)
    - [Inverse Hyperbolic Cosine](#inverse-hyperbolic-cosine)
    - [Inverse Hyperbolic Tangent](#inverse-hyperbolic-tangent)
    - [Radians toDegrees](#radians-todegrees)
    - [Degrees to Radians](#degrees-to-radians)
  - [Exponential Functions](#exponential-functions)
    - [Exponential Function](#exponential-function)
    - [Base-2 Exponential Function](#base-2-exponential-function)
    - [Base-e Logarithm](#base-e-logarithm)
    - [Base-2 Logarithm](#base-2-logarithm)
    - [Base-10 Logarithm](#base-10-logarithm)
    - [Base-radix Logarithm](#base-radix-logarithm)
  - [Statistical Operations](#statistical-operations)
    - [Absolute summation](#absolute-summation)
    - [Maximum](#maximum)
    - [Minimum](#minimum)
    - [Arithmetic mean](#arithmetic-mean)
    - [Mean of magnitudes](#mean-of-magnitudes)
    - [Mean of squares](#mean-of-squares)
  - [Auxiliary Functions](#auxiliary-functions)
    - [Absolute value](#absolute-value)
    - [Ceiling function](#ceiling-function)
    - [Signum function](#signum-function)
    - [Floor function](#floor-function)
    - [Multiplicative inverse](#multiplicative-inverse)
    - [Rounding function](#rounding-function)
    - [Integer truncation](#integer-truncation)

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

### [Sine/Cosine](https://en.wikipedia.org/wiki/Trigonometric_functions)

| Arguments | Function | In-Place Function | Operator | In-Place Operator |
|-----------|----------|-------------------|----------|-------------------|
| `(Array)` | `sincos` | n/a               | n/a      | n/a               |

### [Sine](https://en.wikipedia.org/wiki/Trigonometric_functions#cosine)

| Arguments | Function | In-Place Function | Operator | In-Place Operator |
|-----------|----------|-------------------|----------|-------------------|
| `(Array)` | `sin`    | n/a               | n/a      | n/a               |

### [Cosine](https://en.wikipedia.org/wiki/Trigonometric_functions#cosine)

| Arguments | Function | In-Place Function | Operator | In-Place Operator |
|-----------|----------|-------------------|----------|-------------------|
| `(Array)` | `cos`    | n/a               | n/a      | n/a               |

### [Tangent](https://en.wikipedia.org/wiki/Trigonometric_functions#cosine)

| Arguments | Function | In-Place Function | Operator | In-Place Operator |
|-----------|----------|-------------------|----------|-------------------|
| `(Array)` | `tan`    | n/a               | n/a      | n/a               |

### [Arc Sine](https://en.wikipedia.org/wiki/Trigonometric_functions#cosine)

| Arguments | Function | In-Place Function | Operator | In-Place Operator |
|-----------|----------|-------------------|----------|-------------------|
| `(Array)` | `asin`   | n/a               | n/a      | n/a               |

### [Arc Cosine](https://en.wikipedia.org/wiki/Trigonometric_functions#cosine)

| Arguments | Function | In-Place Function | Operator | In-Place Operator |
|-----------|----------|-------------------|----------|-------------------|
| `(Array)` | `acos`   | n/a               | n/a      | n/a               |

### [Arc Tangent](https://en.wikipedia.org/wiki/Trigonometric_functions#cosine)

| Arguments | Function | In-Place Function | Operator | In-Place Operator |
|-----------|----------|-------------------|----------|-------------------|
| `(Array)` | `atan`   | n/a               | n/a      | n/a               |

### [Hyperbolic Sine](https://en.wikipedia.org/wiki/Hyperbolic_function)

| Arguments | Function | In-Place Function | Operator | In-Place Operator |
|-----------|----------|-------------------|----------|-------------------|
| `(Array)` | `sinh`   | n/a               | n/a      | n/a               |

### [Hyperbolic Cosine](https://en.wikipedia.org/wiki/Hyperbolic_function)

| Arguments | Function | In-Place Function | Operator | In-Place Operator |
|-----------|----------|-------------------|----------|-------------------|
| `(Array)` | `cosh`   | n/a               | n/a      | n/a               |

### [Hyperbolic Tangent](https://en.wikipedia.org/wiki/Hyperbolic_function)

| Arguments | Function | In-Place Function | Operator | In-Place Operator |
|-----------|----------|-------------------|----------|-------------------|
| `(Array)` | `tanh`   | n/a               | n/a      | n/a               |

### [Inverse Hyperbolic Sine](https://en.wikipedia.org/wiki/Inverse_hyperbolic_functions)

| Arguments | Function | In-Place Function | Operator | In-Place Operator |
|-----------|----------|-------------------|----------|-------------------|
| `(Array)` | `asinh`  | n/a               | n/a      | n/a               |

### [Inverse Hyperbolic Cosine](https://en.wikipedia.org/wiki/Inverse_hyperbolic_functions)

| Arguments | Function | In-Place Function | Operator | In-Place Operator |
|-----------|----------|-------------------|----------|-------------------|
| `(Array)` | `acosh`  | n/a               | n/a      | n/a               |

### [Inverse Hyperbolic Tangent](https://en.wikipedia.org/wiki/Inverse_hyperbolic_functions)

| Arguments | Function | In-Place Function | Operator | In-Place Operator |
|-----------|----------|-------------------|----------|-------------------|
| `(Array)` | `atanh`  | n/a               | n/a      | n/a               |

### [Radians toDegrees](https://en.wikipedia.org/wiki/Radian)

| Arguments | Function  | In-Place Function | Operator | In-Place Operator |
|-----------|-----------|-------------------|----------|-------------------|
| `(Array)` | `rad2deg` | n/a               | n/a      | n/a               |

### [Degrees to Radians](https://en.wikipedia.org/wiki/Radian)

| Arguments | Function  | In-Place Function | Operator | In-Place Operator |
|-----------|-----------|-------------------|----------|-------------------|
| `(Array)` | `deg2rad` | n/a               | n/a      | n/a               |

</details>

## Exponential Functions

<details open>

<summary>
Exponential functions & operators
</summary>

### [Exponential Function](https://en.wikipedia.org/wiki/Exponential_function)

| Arguments | Function | In-Place Function | Operator | In-Place Operator |
|-----------|----------|-------------------|----------|-------------------|
| `(Array)` | `exp`    | n/a               | n/a      | n/a               |

### [Base-2 Exponential Function](https://en.wikipedia.org/wiki/Exponential_function)

| Arguments | Function | In-Place Function | Operator | In-Place Operator |
|-----------|----------|-------------------|----------|-------------------|
| `(Array)` | `exp2`   | n/a               | n/a      | n/a               |

### [Base-e Logarithm](https://en.wikipedia.org/wiki/Logarithm)

| Arguments | Function | In-Place Function | Operator | In-Place Operator |
|-----------|----------|-------------------|----------|-------------------|
| `(Array)` | `log`    | n/a               | n/a      | n/a               |

### [Base-2 Logarithm](https://en.wikipedia.org/wiki/Logarithm)

| Arguments | Function | In-Place Function | Operator | In-Place Operator |
|-----------|----------|-------------------|----------|-------------------|
| `(Array)` | `log2`   | n/a               | n/a      | n/a               |

### [Base-10 Logarithm](https://en.wikipedia.org/wiki/Logarithm)

| Arguments | Function | In-Place Function | Operator | In-Place Operator |
|-----------|----------|-------------------|----------|-------------------|
| `(Array)` | `log10`  | n/a               | n/a      | n/a               |

### [Base-radix Logarithm](https://en.wikipedia.org/wiki/Logarithm)

| Arguments | Function | In-Place Function | Operator | In-Place Operator |
|-----------|----------|-------------------|----------|-------------------|
| `(Array)` | `logb`   | n/a               | n/a      | n/a               |

</details>

## Statistical Operations

<details open>

<summary>
Statistical functions & operators
</summary>

### [Absolute summation](https://en.wikipedia.org/wiki/Summation)

| Arguments | Function | In-Place Function | Operator | In-Place Operator |
|-----------|----------|-------------------|----------|-------------------|
| `(Array)` | `asum`   | n/a               | n/a      | n/a               |

### [Maximum](https://en.wikipedia.org/wiki/Maximal_and_minimal_elements)

| Arguments | Function | In-Place Function | Operator | In-Place Operator |
|-----------|----------|-------------------|----------|-------------------|
| `(Array)` | `max`    | n/a               | n/a      | n/a               |

### [Minimum](https://en.wikipedia.org/wiki/Maximal_and_minimal_elements)

| Arguments | Function | In-Place Function | Operator | In-Place Operator |
|-----------|----------|-------------------|----------|-------------------|
| `(Array)` | `min`    | n/a               | n/a      | n/a               |

### [Arithmetic mean](https://en.wikipedia.org/wiki/Mean)

| Arguments | Function | In-Place Function | Operator | In-Place Operator |
|-----------|----------|-------------------|----------|-------------------|
| `(Array)` | `mean`   | n/a               | n/a      | n/a               |

### [Mean of magnitudes](https://en.wikipedia.org/wiki/Mean)

| Arguments | Function | In-Place Function | Operator | In-Place Operator |
|-----------|----------|-------------------|----------|-------------------|
| `(Array)` | `meamg`  | n/a               | n/a      | n/a               |

### [Mean of squares](https://en.wikipedia.org/wiki/Mean_square)

| Arguments | Function | In-Place Function | Operator | In-Place Operator |
|-----------|----------|-------------------|----------|-------------------|
| `(Array)` | `measq`  | n/a               | n/a      | n/a               |

</details>

## Auxiliary Functions

<details open>

<summary>
Auxiliary functions & operators
</summary>

### [Absolute value](https://en.wikipedia.org/wiki/Absolute_value)

| Arguments | Function | In-Place Function | Operator | In-Place Operator |
|-----------|----------|-------------------|----------|-------------------|
| `(Array)` | `abs`    | n/a               | n/a      | n/a               |

### [Ceiling function](https://en.wikipedia.org/wiki/Floor_and_ceiling_functions)

| Arguments | Function | In-Place Function | Operator | In-Place Operator |
|-----------|----------|-------------------|----------|-------------------|
| `(Array)` | `ceil`   | n/a               | n/a      | n/a               |

### [Signum function](https://en.wikipedia.org/wiki/Sign_function)

| Arguments | Function   | In-Place Function | Operator | In-Place Operator |
|-----------|------------|-------------------|----------|-------------------|
| `(Array)` | `copysign` | n/a               | n/a      | n/a               |

### [Floor function](https://en.wikipedia.org/wiki/Floor_and_ceiling_functions)

| Arguments | Function | In-Place Function | Operator | In-Place Operator |
|-----------|----------|-------------------|----------|-------------------|
| `(Array)` | `floor`  | n/a               | n/a      | n/a               |

### [Multiplicative inverse](https://en.wikipedia.org/wiki/Multiplicative_inverse)

| Arguments | Function | In-Place Function | Operator | In-Place Operator |
|-----------|----------|-------------------|----------|-------------------|
| `(Array)` | `rec`    | n/a               | n/a      | n/a               |

### [Rounding function](https://en.wikipedia.org/wiki/Rounding)

| Arguments | Function | In-Place Function | Operator | In-Place Operator |
|-----------|----------|-------------------|----------|-------------------|
| `(Array)` | `round`  | n/a               | n/a      | n/a               |

### [Integer truncation](https://en.wikipedia.org/wiki/Truncation)

| Arguments | Function | In-Place Function | Operator | In-Place Operator |
|-----------|----------|-------------------|----------|-------------------|
| `(Array)` | `trunc`  | n/a               | n/a      | n/a               |

</details>
