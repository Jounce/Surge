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

import Accelerate

// MARK: - Multiplication

public func mul<R>(_ lhs: Float, _ rhs: R) -> [Float] where R: UnsafeMemoryAccessible, R.Element == Float {
    var results = [Float](repeating: lhs, count: numericCast(rhs.count))
    elmulInPlace(&results, rhs)
    return results
}

public func mul<R>(_ lhs: Double, _ rhs: R) -> [Double] where R: UnsafeMemoryAccessible, R.Element == Double {
    var results = [Double](repeating: lhs, count: numericCast(rhs.count))
    elmulInPlace(&results, rhs)
    return results
}

public func * <R>(lhs: Float, rhs: R) -> [Float] where R: UnsafeMemoryAccessible, R.Element == Float {
    return mul(lhs, rhs)
}

public func * <R>(lhs: Double, rhs: R) -> [Double] where R: UnsafeMemoryAccessible, R.Element == Double {
    return mul(lhs, rhs)
}

public func mul(_ lhs: Float, _ rhs: Vector<Float>) -> Vector<Float> {
    return Vector(mul(lhs, rhs.scalars))
}

public func mul(_ lhs: Double, _ rhs: Vector<Double>) -> Vector<Double> {
    return Vector(mul(lhs, rhs.scalars))
}

public func * (lhs: Float, rhs: Vector<Float>) -> Vector<Float> {
    return mul(lhs, rhs)
}

public func * (lhs: Double, rhs: Vector<Double>) -> Vector<Double> {
    return mul(lhs, rhs)
}

public func mul(_ lhs: Float, _ rhs: Matrix<Float>) -> Matrix<Float> {
    var results = rhs
    results.grid.withUnsafeMutableBufferPointer { pointer in
        cblas_sscal(Int32(rhs.grid.count), lhs, pointer.baseAddress!, 1)
    }

    return results
}

public func mul(_ lhs: Double, _ rhs: Matrix<Double>) -> Matrix<Double> {
    var results = rhs
    results.grid.withUnsafeMutableBufferPointer { pointer in
        cblas_dscal(Int32(rhs.grid.count), lhs, pointer.baseAddress!, 1)
    }

    return results
}

public func * (lhs: Float, rhs: Matrix<Float>) -> Matrix<Float> {
    return mul(lhs, rhs)
}

public func * (lhs: Double, rhs: Matrix<Double>) -> Matrix<Double> {
    return mul(lhs, rhs)
}

extension Float {
    /// Generates a normal-distributed random value with given
    /// `mean` (aka "mu") and `stdDeviation` (aka "sigma").
    public static func randomNormal(
        mean: Float = 0.0,
        stdDeviation: Float = 1.0
    ) -> Float {
        var generator = SystemRandomNumberGenerator()
        return randomNormal(mean: mean, stdDeviation: stdDeviation, using: &generator)
    }

    /// Generates a normal-distributed random value with given
    /// `mean` (aka "mu") and `stdDeviation` (aka "sigma")
    /// based on the provided random-number `generator`.
    public static func randomNormal<T>(
        mean: Float = 0.0,
        stdDeviation: Float = 1.0,
        using generator: inout T
    ) -> Float where T: RandomNumberGenerator {
        let lhs = Float.random(in: 0.0...1.0, using: &generator)
        let rhs = Float.random(in: 0.0...1.0, using: &generator)

        let z = sqrt(-2.0 * log(lhs)) * cos(2.0 * .pi * rhs)

        // After applying the transform `z` holds values with a stdDeviation of `1.0` and a mean of `0.0`.

        return z * stdDeviation + mean
    }
}

extension Double {
    /// Generates a normal-distributed random value with given
    /// `mean` (aka "mu") and `stdDeviation` (aka "sigma").
    public static func randomNormal(
        mean: Double = 0.0,
        stdDeviation: Double = 1.0
    ) -> Double {
        var generator = SystemRandomNumberGenerator()
        return randomNormal(mean: mean, stdDeviation: stdDeviation, using: &generator)
    }

    /// Generates a normal-distributed random value with given
    /// `mean` (aka "mu") and `stdDeviation` (aka "sigma")
    /// based on the provided random-number `generator`.
    public static func randomNormal<T>(
        mean: Double = 0.0,
        stdDeviation: Double = 1.0,
        using generator: inout T
    ) -> Double where T: RandomNumberGenerator {
        let lhs = Double.random(in: 0.0...1.0, using: &generator)
        let rhs = Double.random(in: 0.0...1.0, using: &generator)

        let z = sqrt(-2.0 * log(lhs)) * cos(2.0 * .pi * rhs)

        // After applying the transform `z` holds values with a stdDeviation of `1.0` and a mean of `0.0`.

        return z * stdDeviation + mean
    }
}
