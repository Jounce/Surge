# Upsurge

[![Build Status](https://travis-ci.org/aleph7/Upsurge.svg?branch=master)](https://travis-ci.org/aleph7/Upsurge)

[Accelerate](https://developer.apple.com/library/mac/documentation/Accelerate/Reference/AccelerateFWRef/index.html#//apple_ref/doc/uid/TP40009465) is a framework that provides high-performance functions for matrix math, digital signal processing, and image manipulation. It harnesses [SIMD](http://en.wikipedia.org/wiki/SIMD) instructions available in modern CPUs to significantly improve performance of certain calculations.

Upsurge is a fork of [Surge](https://github.com/mattt/Surge) written in Swift 2.0. Upsurge focuses more on matrix and vector operations. It's uses a custom `ValueArray` class instead of the built-in array. It being a `class` instead of a `struct` means that you can manage when and if it gets copied, making memory management more explicit. This also allows defining the `+=` operator to mean addition instead of concatenation.

As opposed to Surge, Upsurge does not support `Float`. There is a global `typealias` defining `Real` as a `Double` and this single type is used throughout. This is because supporting `Float` makes the code unnecessarily complicated and in 64-bit achitectures `Double` is as fast as `Float` so there is no practial reason to support it.


## Installation

Upsurge supports both Cocoapods (`pod 'Upsurge'`) and Carthage (`github "aleph7/Upsurge"`). 


## Usage

### Vector operations

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
