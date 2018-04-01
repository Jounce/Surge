// Copyright © 2014-2018 the Surge contributors
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

// MARK: Sum

public func sum<C: UnsafeMemoryAccessible>(_ x: C) -> Float where C.Element == Float {
    var result: Float = 0.0
    x.withUnsafeMemory { xm in
        withUnsafeMutablePointer(to: &result) { pointer in
            vDSP_sve(xm.pointer, xm.stride, pointer, numericCast(xm.count))
        }
    }
    return result
}

public func sum<C: UnsafeMemoryAccessible>(_ x: C) -> Double where C.Element == Double {
    var result: Double = 0.0
    x.withUnsafeMemory { xm in
        withUnsafeMutablePointer(to: &result) { pointer in
            vDSP_sveD(xm.pointer, xm.stride, pointer, numericCast(xm.count))
        }
    }
    return result
}

// MARK: Sum of Absolute Values

public func asum<C: UnsafeMemoryAccessible>(_ x: C) -> Float where C.Element == Float {
    return x.withUnsafeMemory { xm in
        cblas_sasum(numericCast(xm.count), xm.pointer, numericCast(xm.stride))
    }
}

public func asum<C: UnsafeMemoryAccessible>(_ x: C) -> Double where C.Element == Double {
    return x.withUnsafeMemory { xm in
        cblas_dasum(numericCast(xm.count), xm.pointer, numericCast(xm.stride))
    }
}

// MARK: Sum of Square Values

public func sumsq<C: UnsafeMemoryAccessible>(_ x: C) -> Float where C.Element == Float {
    var result: Float = 0
    x.withUnsafeMemory { xm in
        withUnsafeMutablePointer(to: &result) { pointer in
            vDSP_svesq(xm.pointer, xm.stride, pointer, numericCast(xm.count))
        }
    }
    return result
}

public func sumsq<C: UnsafeMemoryAccessible>(_ x: C) -> Double where C.Element == Double {
    var result: Double = 0
    x.withUnsafeMemory { xm in
        withUnsafeMutablePointer(to: &result) { pointer in
            vDSP_svesqD(xm.pointer, xm.stride, pointer, numericCast(xm.count))
        }
    }
    return result
}

// MARK: Maximum

public func max<C: UnsafeMemoryAccessible>(_ x: C) -> Float where C.Element == Float {
    var result: Float = 0.0
    x.withUnsafeMemory { xm in
        withUnsafeMutablePointer(to: &result) { pointer in
            vDSP_maxv(xm.pointer, xm.stride, pointer, numericCast(xm.count))
        }
    }
    return result
}

public func max<C: UnsafeMemoryAccessible>(_ x: C) -> Double where C.Element == Double {
    var result: Double = 0.0
    x.withUnsafeMemory { xm in
        withUnsafeMutablePointer(to: &result) { pointer in
            vDSP_maxvD(xm.pointer, xm.stride, pointer, numericCast(xm.count))
        }
    }
    return result
}

// MARK: Minimum

public func min<C: UnsafeMemoryAccessible>(_ x: C) -> Float where C.Element == Float {
    var result: Float = 0.0
    x.withUnsafeMemory { xm in
        withUnsafeMutablePointer(to: &result) { pointer in
            vDSP_minv(xm.pointer, xm.stride, pointer, numericCast(xm.count))
        }
    }
    return result
}

public func min<C: UnsafeMemoryAccessible>(_ x: C) -> Double where C.Element == Double {
    var result: Double = 0.0
    x.withUnsafeMemory { xm in
        withUnsafeMutablePointer(to: &result) { pointer in
            vDSP_minvD(xm.pointer, xm.stride, pointer, numericCast(xm.count))
        }
    }
    return result
}

// MARK: Mean

public func mean<C: UnsafeMemoryAccessible>(_ x: C) -> Float where C.Element == Float {
    var result: Float = 0.0
    x.withUnsafeMemory { xm in
        withUnsafeMutablePointer(to: &result) { pointer in
            vDSP_meanv(xm.pointer, xm.stride, pointer, numericCast(xm.count))
        }
    }
    return result
}

public func mean<C: UnsafeMemoryAccessible>(_ x: C) -> Double where C.Element == Double {
    var result: Double = 0.0
    x.withUnsafeMemory { xm in
        withUnsafeMutablePointer(to: &result) { pointer in
            vDSP_meanvD(xm.pointer, xm.stride, pointer, numericCast(xm.count))
        }
    }
    return result
}

// MARK: Mean Magnitude

public func meamg<C: UnsafeMemoryAccessible>(_ x: C) -> Float where C.Element == Float {
    var result: Float = 0.0
    x.withUnsafeMemory { xm in
        withUnsafeMutablePointer(to: &result) { pointer in
            vDSP_meamgv(xm.pointer, xm.stride, pointer, numericCast(xm.count))
        }
    }
    return result
}

public func meamg<C: UnsafeMemoryAccessible>(_ x: C) -> Double where C.Element == Double {
    var result: Double = 0.0
    x.withUnsafeMemory { xm in
        withUnsafeMutablePointer(to: &result) { pointer in
            vDSP_meamgvD(xm.pointer, xm.stride, pointer, numericCast(xm.count))
        }
    }
    return result
}

// MARK: Mean Square Value

public func measq<C: UnsafeMemoryAccessible>(_ x: C) -> Float where C.Element == Float {
    var result: Float = 0.0
    x.withUnsafeMemory { xm in
        withUnsafeMutablePointer(to: &result) { pointer in
            vDSP_measqv(xm.pointer, xm.stride, pointer, numericCast(xm.count))
        }
    }
    return result
}

public func measq<C: UnsafeMemoryAccessible>(_ x: C) -> Double where C.Element == Double {
    var result: Double = 0.0
    x.withUnsafeMemory { xm in
        withUnsafeMutablePointer(to: &result) { pointer in
            vDSP_measqvD(xm.pointer, xm.stride, pointer, numericCast(xm.count))
        }
    }
    return result
}

// MARK: Add

public func add<X: UnsafeMemoryAccessible, Y: UnsafeMemoryAccessible>(_ x: X, _ y: Y) -> [Float] where X.Element == Float, Y.Element == Float {
    var results = [Float](y)
    x.withUnsafeMemory { xm in
        results.withUnsafeMutableBufferPointer { rbp in
            cblas_saxpy(numericCast(xm.count), 1.0, xm.pointer, numericCast(xm.stride), rbp.baseAddress, 1)
        }
    }
    return results
}

public func add<X: UnsafeMemoryAccessible, Y: UnsafeMemoryAccessible>(_ x: X, _ y: Y) -> [Double] where X.Element == Double, Y.Element == Double {
    var results = [Double](y)
    x.withUnsafeMemory { xm in
        results.withUnsafeMutableBufferPointer { rbp in
            cblas_daxpy(numericCast(xm.count), 1.0, xm.pointer, numericCast(xm.stride), rbp.baseAddress, 1)
        }
    }
    return results
}

// MARK: Subtraction

public func sub<X: UnsafeMemoryAccessible, Y: UnsafeMemoryAccessible>(_ x: X, _ y: Y) -> [Float] where X.Element == Float, Y.Element == Float {
    var results = [Float](y)
    x.withUnsafeMemory { xm in
        results.withUnsafeMutableBufferPointer { rbp in
            catlas_saxpby(numericCast(xm.count), 1.0, xm.pointer, numericCast(xm.stride), -1, rbp.baseAddress, 1)
        }
    }
    return results
}

public func sub<X: UnsafeMemoryAccessible, Y: UnsafeMemoryAccessible>(_ x: X, _ y: Y) -> [Double] where X.Element == Double, Y.Element == Double {
    var results = [Double](y)
    x.withUnsafeMemory { xm in
        results.withUnsafeMutableBufferPointer { rbp in
            catlas_daxpby(numericCast(xm.count), 1.0, xm.pointer, numericCast(xm.stride), -1, rbp.baseAddress, 1)
        }
    }
    return results
}

// MARK: Multiply

public func mul<X: UnsafeMemoryAccessible, Y: UnsafeMemoryAccessible>(_ x: X, _ y: Y) -> [Float] where X.Element == Float, Y.Element == Float {
    return withUnsafeMemory(x, y) { xm, ym in
        var results = [Float](repeating: 0.0, count: numericCast(xm.count))
        results.withUnsafeMutableBufferPointer { rbp in
            vDSP_vmul(xm.pointer, xm.stride, ym.pointer, ym.stride, rbp.baseAddress!, 1, numericCast(xm.count))
        }
        return results
    }
}

public func mul<X: UnsafeMemoryAccessible, Y: UnsafeMemoryAccessible>(_ x: X, _ y: Y) -> [Double] where X.Element == Double, Y.Element == Double {
    return withUnsafeMemory(x, y) { xm, ym in
        var results = [Double](repeating: 0.0, count: numericCast(xm.count))
        results.withUnsafeMutableBufferPointer { rbp in
            vDSP_vmulD(xm.pointer, xm.stride, ym.pointer, ym.stride, rbp.baseAddress!, 1, numericCast(xm.count))
        }
        return results
    }
}

// MARK: Divide

/// Elemen-wise vector division.
///
/// - Warning: does not support memory stride (assumes stride is 1).
public func div<X: UnsafeMemoryAccessible, Y: UnsafeMemoryAccessible>(_ x: X, _ y: Y) -> [Float] where X.Element == Float, Y.Element == Float {
    return withUnsafeMemory(x, y) { xm, ym in
        precondition(xm.stride == 1 && ym.stride == 1, "\(#function) does not support strided memory access")
        var results = [Float](repeating: 0.0, count: numericCast(xm.count))
        results.withUnsafeMutableBufferPointer { rbp in
            vvdivf(rbp.baseAddress!, xm.pointer, ym.pointer, [numericCast(xm.count)])
        }
        return results
    }
}

/// Elemen-wise vector division.
///
/// - Warning: does not support memory stride (assumes stride is 1).
public func div<X: UnsafeMemoryAccessible, Y: UnsafeMemoryAccessible>(_ x: X, _ y: Y) -> [Double] where X.Element == Double, Y.Element == Double {
    return withUnsafeMemory(x, y) { xm, ym in
        precondition(xm.stride == 1 && ym.stride == 1, "\(#function) does not support strided memory access")
        var results = [Double](repeating: 0.0, count: numericCast(xm.count))
        results.withUnsafeMutableBufferPointer { rbp in
            vvdiv(rbp.baseAddress!, xm.pointer, ym.pointer, [numericCast(xm.count)])
        }
        return results
    }
}

// MARK: Modulo

/// Elemen-wise modulo.
///
/// - Warning: does not support memory stride (assumes stride is 1).
public func mod<X: UnsafeMemoryAccessible, Y: UnsafeMemoryAccessible>(_ x: X, _ y: Y) -> [Float] where X.Element == Float, Y.Element == Float {
    return withUnsafeMemory(x, y) { xm, ym in
        precondition(xm.stride == 1 && ym.stride == 1, "\(#function) does not support strided memory access")
        var results = [Float](repeating: 0.0, count: numericCast(xm.count))
        results.withUnsafeMutableBufferPointer { rbp in
            vvfmodf(rbp.baseAddress!, xm.pointer, ym.pointer, [numericCast(xm.count)])
        }
        return results
    }
}

/// Elemen-wise modulo.
///
/// - Warning: does not support memory stride (assumes stride is 1).
public func mod<X: UnsafeMemoryAccessible, Y: UnsafeMemoryAccessible>(_ x: X, _ y: Y) -> [Double] where X.Element == Double, Y.Element == Double {
    return withUnsafeMemory(x, y) { xm, ym in
        precondition(xm.stride == 1 && ym.stride == 1, "\(#function) does not support strided memory access")
        var results = [Double](repeating: 0.0, count: numericCast(xm.count))
        results.withUnsafeMutableBufferPointer { rbp in
            vvfmod(rbp.baseAddress!, xm.pointer, ym.pointer, [numericCast(xm.count)])
        }
        return results
    }
}

// MARK: Remainder

/// Elemen-wise remainder.
///
/// - Warning: does not support memory stride (assumes stride is 1).
public func remainder<X: UnsafeMemoryAccessible, Y: UnsafeMemoryAccessible>(_ x: X, _ y: Y) -> [Float] where X.Element == Float, Y.Element == Float {
    return withUnsafeMemory(x, y) { xm, ym in
        precondition(xm.stride == 1 && ym.stride == 1, "\(#function) does not support strided memory access")
        var results = [Float](repeating: 0.0, count: numericCast(xm.count))
        results.withUnsafeMutableBufferPointer { rbp in
            vvremainderf(rbp.baseAddress!, xm.pointer, ym.pointer, [numericCast(xm.count)])
        }
        return results
    }
}

/// Elemen-wise remainder.
///
/// - Warning: does not support memory stride (assumes stride is 1).
public func remainder<X: UnsafeMemoryAccessible, Y: UnsafeMemoryAccessible>(_ x: X, _ y: Y) -> [Double] where X.Element == Double, Y.Element == Double {
    return withUnsafeMemory(x, y) { xm, ym in
        precondition(xm.stride == 1 && ym.stride == 1, "\(#function) does not support strided memory access")
        var results = [Double](repeating: 0.0, count: numericCast(xm.count))
        results.withUnsafeMutableBufferPointer { rbp in
            vvremainder(rbp.baseAddress!, xm.pointer, ym.pointer, [numericCast(xm.count)])
        }
        return results
    }
}

// MARK: Square Root

/// Elemen-wise square root.
///
/// - Warning: does not support memory stride (assumes stride is 1).
public func sqrt<C: UnsafeMemoryAccessible>(_ x: C) -> [Float] where C.Element == Float {
    return x.withUnsafeMemory { xm in
        precondition(xm.stride == 1, "\(#function) does not support strided memory access")
        var results = [Float](repeating: 0.0, count: numericCast(xm.count))
        results.withUnsafeMutableBufferPointer { bufferPointer in
            vvsqrtf(bufferPointer.baseAddress!, xm.pointer, [numericCast(xm.count)])
        }
        return results
    }
}

/// Elemen-wise square root.
///
/// - Warning: does not support memory stride (assumes stride is 1).
public func sqrt<C: UnsafeMemoryAccessible>(_ x: C) -> [Double] where C.Element == Double {
    return x.withUnsafeMemory { xm in
        precondition(xm.stride == 1, "\(#function) does not support strided memory access")
        var results = [Double](repeating: 0.0, count: numericCast(xm.count))
        results.withUnsafeMutableBufferPointer { bufferPointer in
            vvsqrt(bufferPointer.baseAddress!, xm.pointer, [numericCast(xm.count)])
        }
        return results
    }
}

// MARK: Dot Product

public func dot<X: UnsafeMemoryAccessible, Y: UnsafeMemoryAccessible>(_ x: X, _ y: Y) -> Float where X.Element == Float, Y.Element == Float {
    return withUnsafeMemory(x, y) { xm, ym in
        precondition(xm.count == ym.count, "Vectors must have equal count")

        var result: Float = 0.0
        withUnsafeMutablePointer(to: &result) { pointer in
            vDSP_dotpr(xm.pointer, xm.stride, ym.pointer, ym.stride, pointer, numericCast(xm.count))
        }

        return result
    }
}

public func dot<X: UnsafeMemoryAccessible, Y: UnsafeMemoryAccessible>(_ x: X, _ y: Y) -> Double where X.Element == Double, Y.Element == Double {
    return withUnsafeMemory(x, y) { xm, ym in
        precondition(xm.count == ym.count, "Vectors must have equal count")

        var result: Double = 0.0
        withUnsafeMutablePointer(to: &result) { pointer in
            vDSP_dotprD(xm.pointer, xm.stride, ym.pointer, ym.stride, pointer, numericCast(xm.count))
        }

        return result
    }
}

// MARK: - Distance

public func dist<X: UnsafeMemoryAccessible, Y: UnsafeMemoryAccessible>(_ x: X, _ y: Y) -> Float where X.Element == Float, Y.Element == Float {
    precondition(x.count == y.count, "Vectors must have equal count")
    let sub = x - y
    var squared = [Float](repeating: 0.0, count: numericCast(x.count))
    squared.withUnsafeMutableBufferPointer { bufferPointer in
        vDSP_vsq(sub, 1, bufferPointer.baseAddress!, 1, numericCast(x.count))
    }
    return sqrt(sum(squared))
}

public func dist<X: UnsafeMemoryAccessible, Y: UnsafeMemoryAccessible>(_ x: X, _ y: Y) -> Double where X.Element == Double, Y.Element == Double {
    precondition(x.count == y.count, "Vectors must have equal count")
    let sub = x - y
    var squared = [Double](repeating: 0.0, count: numericCast(x.count))
    squared.withUnsafeMutableBufferPointer { bufferPointer in
        vDSP_vsqD(sub, 1, bufferPointer.baseAddress!, 1, numericCast(x.count))
    }
    return sqrt(sum(squared))
}

// MARK: - Operators

public func + <L: UnsafeMemoryAccessible, R: UnsafeMemoryAccessible>(lhs: L, rhs: R) -> [Float] where L.Element == Float, R.Element == Float {
    return add(lhs, rhs)
}

public func + <L: UnsafeMemoryAccessible, R: UnsafeMemoryAccessible>(lhs: L, rhs: R) -> [Double] where L.Element == Double, R.Element == Double {
    return add(lhs, rhs)
}

public func + <L: UnsafeMemoryAccessible>(lhs: L, rhs: Float) -> [Float] where L.Element == Float {
    return add(lhs, [Float](repeating: rhs, count: numericCast(lhs.count)))
}

public func + <L: UnsafeMemoryAccessible>(lhs: L, rhs: Double) -> [Double] where L.Element == Double {
    return add(lhs, [Double](repeating: rhs, count: numericCast(lhs.count)))
}

public func - <L: UnsafeMemoryAccessible, R: UnsafeMemoryAccessible>(lhs: L, rhs: R) -> [Float] where L.Element == Float, R.Element == Float {
    return sub(lhs, rhs)
}

public func - <L: UnsafeMemoryAccessible, R: UnsafeMemoryAccessible>(lhs: L, rhs: R) -> [Double] where L.Element == Double, R.Element == Double {
    return sub(lhs, rhs)
}

public func - <L: UnsafeMemoryAccessible>(lhs: L, rhs: Float) -> [Float] where L.Element == Float {
    return sub(lhs, [Float](repeating: rhs, count: numericCast(lhs.count)))
}

public func - <L: UnsafeMemoryAccessible>(lhs: L, rhs: Double) -> [Double] where L.Element == Double {
    return sub(lhs, [Double](repeating: rhs, count: numericCast(lhs.count)))
}

public func / <L: UnsafeMemoryAccessible, R: UnsafeMemoryAccessible>(lhs: L, rhs: R) -> [Float] where L.Element == Float, R.Element == Float {
    return div(lhs, rhs)
}

public func / <L: UnsafeMemoryAccessible, R: UnsafeMemoryAccessible>(lhs: L, rhs: R) -> [Double] where L.Element == Double, R.Element == Double {
    return div(lhs, rhs)
}

public func / <L: UnsafeMemoryAccessible>(lhs: L, rhs: Float) -> [Float] where L.Element == Float {
    return div(lhs, [Float](repeating: rhs, count: numericCast(lhs.count)))
}

public func / <L: UnsafeMemoryAccessible>(lhs: L, rhs: Double) -> [Double] where L.Element == Double {
    return div(lhs, [Double](repeating: rhs, count: numericCast(lhs.count)))
}

public func * <L: UnsafeMemoryAccessible, R: UnsafeMemoryAccessible>(lhs: L, rhs: R) -> [Float] where L.Element == Float, R.Element == Float {
    return mul(lhs, rhs)
}

public func * <L: UnsafeMemoryAccessible, R: UnsafeMemoryAccessible>(lhs: L, rhs: R) -> [Double] where L.Element == Double, R.Element == Double {
    return mul(lhs, rhs)
}

public func * <L: UnsafeMemoryAccessible>(lhs: L, rhs: Float) -> [Float] where L.Element == Float {
    return mul(lhs, [Float](repeating: rhs, count: numericCast(lhs.count)))
}

public func * <L: UnsafeMemoryAccessible>(lhs: L, rhs: Double) -> [Double] where L.Element == Double {
    return mul(lhs, [Double](repeating: rhs, count: numericCast(lhs.count)))
}

public func % <L: UnsafeMemoryAccessible, R: UnsafeMemoryAccessible>(lhs: L, rhs: R) -> [Float] where L.Element == Float, R.Element == Float {
    return mod(lhs, rhs)
}

public func % <L: UnsafeMemoryAccessible, R: UnsafeMemoryAccessible>(lhs: L, rhs: R) -> [Double] where L.Element == Double, R.Element == Double {
    return mod(lhs, rhs)
}

public func % <L: UnsafeMemoryAccessible>(lhs: L, rhs: Float) -> [Float] where L.Element == Float {
    return mod(lhs, [Float](repeating: rhs, count: numericCast(lhs.count)))
}

public func % <L: UnsafeMemoryAccessible>(lhs: L, rhs: Double) -> [Double] where L.Element == Double {
    return mod(lhs, [Double](repeating: rhs, count: numericCast(lhs.count)))
}

infix operator •
public func • <L: UnsafeMemoryAccessible, R: UnsafeMemoryAccessible>(lhs: L, rhs: R) -> Double where L.Element == Double, R.Element == Double {
    return dot(lhs, rhs)
}

public func • <L: UnsafeMemoryAccessible, R: UnsafeMemoryAccessible>(lhs: L, rhs: R) -> Float where L.Element == Float, R.Element == Float {
    return dot(lhs, rhs)
}
