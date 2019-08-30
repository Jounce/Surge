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

public func mul<R: UnsafeMemoryAccessible>(_ lhs: Float, _ rhs: R) -> [Float] where R.Element == Float {
    return mul([Float](repeating: lhs, count: numericCast(rhs.count)), rhs)
}

public func mul<R: UnsafeMemoryAccessible>(_ lhs: Double, _ rhs: R) -> [Double] where R.Element == Double {
    return mul([Double](repeating: lhs, count: numericCast(rhs.count)), rhs)
}

public func * <R: UnsafeMemoryAccessible>(lhs: Float, rhs: R) -> [Float] where R.Element == Float {
    return mul(lhs, rhs)
}

public func * <R: UnsafeMemoryAccessible>(lhs: Double, rhs: R) -> [Double] where R.Element == Double {
    return mul(lhs, rhs)
}

public func mul(_ x: Float, _ y: Vector<Float>) -> Vector<Float> {
    return Vector(mul(x, y.scalars))
}

public func mul(_ x: Double, _ y: Vector<Double>) -> Vector<Double> {
    return Vector(mul(x, y.scalars))
}

public func * (lhs: Float, rhs: Vector<Float>) -> Vector<Float> {
    return mul(lhs, rhs)
}

public func * (lhs: Double, rhs: Vector<Double>) -> Vector<Double> {
    return mul(lhs, rhs)
}

public func mul(_ alpha: Float, _ x: Matrix<Float>) -> Matrix<Float> {
    var results = x
    results.grid.withUnsafeMutableBufferPointer { pointer in
        cblas_sscal(Int32(x.grid.count), alpha, pointer.baseAddress!, 1)
    }

    return results
}

public func mul(_ alpha: Double, _ x: Matrix<Double>) -> Matrix<Double> {
    var results = x
    results.grid.withUnsafeMutableBufferPointer { pointer in
        cblas_dscal(Int32(x.grid.count), alpha, pointer.baseAddress!, 1)
    }

    return results
}

public func * (lhs: Float, rhs: Matrix<Float>) -> Matrix<Float> {
    return mul(lhs, rhs)
}

public func * (lhs: Double, rhs: Matrix<Double>) -> Matrix<Double> {
    return mul(lhs, rhs)
}
