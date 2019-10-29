// Copyright © 2014-2019 the Surge contributors
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

import Foundation

// MARK: - Random: Uniform Distribution

public func random(
    count: Int,
    in range: ClosedRange<Float> = 0.0...1.0
) -> [Float] {
    var generator = SystemRandomNumberGenerator()
    return random(count: count, in: range, using: &generator)
}

public func random(
    count: Int,
    in range: ClosedRange<Double> = 0.0...1.0
) -> [Double] {
    var generator = SystemRandomNumberGenerator()
    return random(count: count, in: range, using: &generator)
}

public func random<T>(
    count: Int,
    in range: ClosedRange<Float>,
    using generator: inout T
) -> [Float] where T: RandomNumberGenerator {
    return (0..<count).map { _ in Float.random(in: range, using: &generator) }
}

public func random<T>(
    count: Int,
    in range: ClosedRange<Double>,
    using generator: inout T
) -> [Double] where T: RandomNumberGenerator {
    return (0..<count).map { _ in Double.random(in: range, using: &generator) }
}

public func randomNormal(
    count: Int,
    mu: Float = 0.0,
    sigma: Float = 1.0
) -> [Float] {
    var generator = SystemRandomNumberGenerator()
    return randomNormal(count: count, mu: mu, sigma: sigma, using: &generator)
}

public func randomNormal(
    count: Int,
    mu: Double = 0.0,
    sigma: Double = 1.0
) -> [Double] {
    var generator = SystemRandomNumberGenerator()
    return randomNormal(count: count, mu: mu, sigma: sigma, using: &generator)
}

public func randomNormal<T>(
    count: Int,
    mu: Float = 0.0,
    sigma: Float = 1.0,
    using generator: inout T
) -> [Float] where T: RandomNumberGenerator {
    var lhs: [Float] = random(count: count, in: 0.0...1.0, using: &generator)
    var rhs: [Float] = random(count: count, in: 0.0...1.0, using: &generator)

    boxMullerTransformInPlace(&lhs, &rhs)

    // After applying the transform `lhs` holds values with a sigma of `1.0` and a mu of `0.0`.

    // stdNormal * sigma + mu
    mulInPlace(&lhs, sigma)
    addInPlace(&lhs, mu)

    return lhs
}

public func randomNormal<T>(
    count: Int,
    mu: Double = 0.0,
    sigma: Double = 1.0,
    using generator: inout T
) -> [Double] where T: RandomNumberGenerator {
    // Box-Muller transform

    var lhs: [Double] = random(count: count, in: 0.0...1.0, using: &generator)
    var rhs: [Double] = random(count: count, in: 0.0...1.0, using: &generator)

    boxMullerTransformInPlace(&lhs, &rhs)

    // After applying the transform `lhs` holds values with a sigma of `1.0` and a mu of `0.0`.

    // stdNormal * sigma + mu
    mulInPlace(&lhs, sigma)
    addInPlace(&lhs, mu)

    return lhs
}

/// Performs the Box-Muller transform in-place.
///
/// - Note:
///   Upon return `lhs` will contain the result of the transform,
///   while `rhs` will will contain discardable, undefined content.
internal func boxMullerTransformInPlace<L, R>(
    _ lhs: inout L,
    _ rhs: inout R
) where L: UnsafeMutableMemoryAccessible, R: UnsafeMutableMemoryAccessible, L.Element == Float, R.Element == Float {
    // Semantically this function calculates the following formula,
    // implementing to the Box-Muller transform:
    //
    // ```
    // return sqrt(-2.0 * log(lhs)) .* cos(2.0 * .pi * rhs)
    // ```
    //
    // But instead of creating (and shortly later disposing) a temporary array
    // on every partial expression we perform them efficiently in-place,
    // allocating and re-using nothing but the initial buffers `u1` and `u2`:
    //
    // The in-place operations correspond to above formula like this:
    //
    // ┌─2─────────────────┐
    // │    ┌─1───────────┐│
    // │    │      ┌─0────┐│
    // sqrt(-2.0 * log(lhs)) .* cos(2.0 * .pi * rhs)
    // │                            └─3───────────┘│
    // │                        └─4────────────────┘
    // └─5─────────────────────────────────────────┘

    logInPlace(&lhs) // 0
    mulInPlace(&lhs, -2.0) // 1
    sqrtInPlace(&lhs) // 2

    mulInPlace(&rhs, 2.0 * .pi) // 3
    cosInPlace(&rhs) // 4

    elmulInPlace(&lhs, rhs) // 5
}

/// Performs the Box-Muller transform in-place.
///
/// - Note:
///   Upon return `lhs` will contain the result of the transform,
///   while `rhs` will will contain discardable, undefined content.
internal func boxMullerTransformInPlace<L, R>(
    _ lhs: inout L,
    _ rhs: inout R
) where L: UnsafeMutableMemoryAccessible, R: UnsafeMutableMemoryAccessible, L.Element == Double, R.Element == Double {
    // Semantically this function calculates the following formula,
    // implementing to the Box-Muller transform:
    //
    // ```
    // return sqrt(-2.0 * log(lhs)) .* cos(2.0 * .pi * rhs)
    // ```
    //
    // But instead of creating (and shortly later disposing) a temporary array
    // on every partial expression we perform them efficiently in-place,
    // allocating and re-using nothing but the initial buffers `u1` and `u2`:
    //
    // The in-place operations correspond to above formula like this:
    //
    // ┌─2─────────────────┐
    // │    ┌─1───────────┐│
    // │    │      ┌─0────┐│
    // sqrt(-2.0 * log(lhs)) .* cos(2.0 * .pi * rhs)
    // │                            └─3───────────┘│
    // │                        └─4────────────────┘
    // └─5─────────────────────────────────────────┘

    logInPlace(&lhs) // 0
    mulInPlace(&lhs, -2.0) // 1
    sqrtInPlace(&lhs) // 2

    mulInPlace(&rhs, 2.0 * .pi) // 3
    cosInPlace(&rhs) // 4

    elmulInPlace(&lhs, rhs) // 5
}
