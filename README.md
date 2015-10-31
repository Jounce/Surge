# Upsurge

[![Build Status](https://travis-ci.org/aleph7/Upsurge.svg?branch=master)](https://travis-ci.org/aleph7/Upsurge)

[Accelerate](https://developer.apple.com/library/mac/documentation/Accelerate/Reference/AccelerateFWRef/index.html#//apple_ref/doc/uid/TP40009465) is a framework that provides high-performance functions for matrix math, digital signal processing, and image manipulation. It harnesses [SIMD](http://en.wikipedia.org/wiki/SIMD) instructions available in modern CPUs to significantly improve performance of certain calculations.

Upsurge is a fork of [Surge](https://github.com/mattt/Surge) written in Swift 2.0. Upsurge focuses more on matrix and vector operations. It's uses a custom `ValueArray` class instead of the built-in array. It being a `class` instead of a `struct` means that you can manage when and if it gets copied, making memory management more explicit. This also allows defining the `+=` operator to mean addition instead of concatenation.

As opposed to Surge, Upsurge does not support `Float`. There is a global `typealias` defining `Real` as a `Double` and this single type is used throughout. This is because supporting `Float` makes the code unnecessarily complicated and in 64-bit achitectures `Double` is as fast as `Float` so there is no practial reason to support it.


## Installation

Upsurge supports both Cocoapods (`pod 'Upsurge'`) and Carthage (`github "aleph7/Upsurge"`). 


## Usage

### Vector operations

Upsurge defines the `ValueArray` class to store a one-dimensional collection of values. But the name you will most likely use is `RealArray` which is a type alias to `ValueArray<Double>`. From now on we will refer to it as a `RealArray` but it all applies to other types of `ValueArray`.

`RealArray` is very similar to Swift's `Array` but it's optimized to reduce unnecessary memory allocation. These are the most important differences:
* `RealArray` instances have a fixed size defined on creation. When you create a `RealArray` you can define a capacity: `var a = RealArray(capacity: 100)` and then append elements up to that capacity. Or you can create it with specific elements `var a: RealArray = [1.0, 2.0, 3.0]` but then you can't add any more elements.
* `RealArray` is a class. That means that creating a new variable will only create a reference and modifying the reference will also modify the original. For instance doing `var a: RealArray = [1, 2, 3]; var b = a; b[0] = 5` will result in a being `[5, 2, 3]`. If you want to create a copy you need to do `var b = RealArray(a)` or `var b = a.copy()`.
* You **can** create an uninitialized `RealArray` by doing `var a = RealArray(capacity: n)` or `var a = RealArray(count: n)`. This is good for when you are going to fill up the array yourself. But you can also use `var a = RealArray(count: n, repeatedValue: 0.0)` if you do want to initialize all the values.

Here is and example of doing arithmetic on `RealArray`s:
```swift
import Upsurge

let a: RealArray = [1.0, 3.0, 5.0, 7.0]
let b: RealArray = [2.0, 4.0, 6.0, 8.0]
let addition = a + b // [3.0, 7.0, 11.0, 15.0]
let product  = a • b // 100.0

```

### Matrix operations

```swift
import Upsurge

let A = RealMatrix([
    [1,  1],
    [1, -1]
])
let C = RealMatrix([
    [3],
    [1]
])

// find B such that A*B=C
let B = inv(A) * C // [2.0, 1.0]′

// Verify result
let r = A*B - C    // zero   
```

---

## License

Upsurge is available under the MIT license. See the LICENSE file for more info.
