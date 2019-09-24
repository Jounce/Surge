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
    var results = [Float](repeating: lhs, count: numericCast(rhs.count))
    elmulInPlace(&results, rhs)
    return results
}

public func mul<R: UnsafeMemoryAccessible>(_ lhs: Double, _ rhs: R) -> [Double] where R.Element == Double {
    var results = [Double](repeating: lhs, count: numericCast(rhs.count))
    elmulInPlace(&results, rhs)
    return results
}

public func * <R: UnsafeMemoryAccessible>(lhs: Float, rhs: R) -> [Float] where R.Element == Float {
    return mul(lhs, rhs)
}

public func * <R: UnsafeMemoryAccessible>(lhs: Double, rhs: R) -> [Double] where R.Element == Double {
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
