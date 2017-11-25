// Copyright © 2014–2015 Mattt Thompson (http://mattt.me)
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

public func sum<C: ContinuousCollection>(_ x: C) -> Float where C.Iterator.Element == Float {
    var result: Float = 0.0
    withUnsafePointersAndCountsTo(x) { x, count -> Void in
        withUnsafeMutablePointer(to: &result) { pointer in
            vDSP_sve(x, 1, pointer, vDSP_Length(count))
        }
    }
    return result
}

public func sum<C: ContinuousCollection>(_ x: C) -> Double where C.Iterator.Element == Double {
    var result: Double = 0.0
    withUnsafePointersAndCountsTo(x) { x, count in
        withUnsafeMutablePointer(to: &result) { pointer in
            vDSP_sveD(x, 1, pointer, vDSP_Length(count))
        }
    }
    return result
}

// MARK: Sum of Absolute Values

public func asum<C: ContinuousCollection>(_ x: C) -> Float where C.Iterator.Element == Float {
    return x.withUnsafeBufferPointer { bufferPointer in
        guard let x = bufferPointer.baseAddress else {
            return 0
        }
        return cblas_sasum(Int32(bufferPointer.count), x, 1)
    }
}

public func asum<C: ContinuousCollection>(_ x: C) -> Double where C.Iterator.Element == Double {
    return x.withUnsafeBufferPointer { bufferPointer in
        guard let x = bufferPointer.baseAddress else {
            return 0
        }
        return cblas_dasum(Int32(bufferPointer.count), x, 1)
    }
}

// MARK: Sum of Square Values

public func sumsq<C: ContinuousCollection>(_ x: C) -> Float where C.Iterator.Element == Float {
    var result: Float = 0
    withUnsafePointersAndCountsTo(x) { x, count in
        withUnsafeMutablePointer(to: &result) { pointer in
            vDSP_svesq(x, 1, pointer, vDSP_Length(count))
        }
    }
    return result
}

public func sumsq<C: ContinuousCollection>(_ x: C) -> Double where C.Iterator.Element == Double {
    var result: Double = 0
    withUnsafePointersAndCountsTo(x) { x, count in
        withUnsafeMutablePointer(to: &result) { pointer in
            vDSP_svesqD(x, 1, pointer, vDSP_Length(count))
        }
    }
    return result
}

// MARK: Maximum

public func max<C: ContinuousCollection>(_ x: C) -> Float where C.Iterator.Element == Float {
    var result: Float = 0.0
    withUnsafePointersAndCountsTo(x) { x, count in
        withUnsafeMutablePointer(to: &result) { pointer in
            vDSP_maxv(x, 1, pointer, vDSP_Length(count))
        }
    }
    return result
}

public func max<C: ContinuousCollection>(_ x: C) -> Double where C.Iterator.Element == Double {
    var result: Double = 0.0
    withUnsafePointersAndCountsTo(x) { x, count in
        withUnsafeMutablePointer(to: &result) { pointer in
            vDSP_maxvD(x, 1, pointer, vDSP_Length(count))
        }
    }
    return result
}

// MARK: Minimum

public func min<C: ContinuousCollection>(_ x: C) -> Float where C.Iterator.Element == Float {
    var result: Float = 0.0
    withUnsafePointersAndCountsTo(x) { x, count in
        withUnsafeMutablePointer(to: &result) { pointer in
            vDSP_minv(x, 1, pointer, vDSP_Length(count))
        }
    }
    return result
}

public func min<C: ContinuousCollection>(_ x: C) -> Double where C.Iterator.Element == Double {
    var result: Double = 0.0
    withUnsafePointersAndCountsTo(x) { x, count in
        withUnsafeMutablePointer(to: &result) { pointer in
            vDSP_minvD(x, 1, pointer, vDSP_Length(count))
        }
    }
    return result
}

// MARK: Mean

public func mean<C: ContinuousCollection>(_ x: C) -> Float where C.Iterator.Element == Float {
    var result: Float = 0.0
    withUnsafePointersAndCountsTo(x) { x, count in
        withUnsafeMutablePointer(to: &result) { pointer in
            vDSP_meanv(x, 1, pointer, vDSP_Length(count))
        }
    }
    return result
}

public func mean<C: ContinuousCollection>(_ x: C) -> Double where C.Iterator.Element == Double {
    var result: Double = 0.0
    withUnsafePointersAndCountsTo(x) { x, count in
        withUnsafeMutablePointer(to: &result) { pointer in
            vDSP_meanvD(x, 1, pointer, vDSP_Length(count))
        }
    }
    return result
}

// MARK: Mean Magnitude

public func meamg<C: ContinuousCollection>(_ x: C) -> Float where C.Iterator.Element == Float {
    var result: Float = 0.0
    withUnsafePointersAndCountsTo(x) { x, count in
        withUnsafeMutablePointer(to: &result) { pointer in
            vDSP_meamgv(x, 1, pointer, vDSP_Length(count))
        }
    }
    return result
}

public func meamg<C: ContinuousCollection>(_ x: C) -> Double where C.Iterator.Element == Double {
    var result: Double = 0.0
    withUnsafePointersAndCountsTo(x) { x, count in
        withUnsafeMutablePointer(to: &result) { pointer in
            vDSP_meamgvD(x, 1, pointer, vDSP_Length(count))
        }
    }
    return result
}

// MARK: Mean Square Value

public func measq<C: ContinuousCollection>(_ x: C) -> Float where C.Iterator.Element == Float {
    var result: Float = 0.0
    withUnsafePointersAndCountsTo(x) { x, count in
        withUnsafeMutablePointer(to: &result) { pointer in
            vDSP_measqv(x, 1, pointer, vDSP_Length(count))
        }
    }
    return result
}

public func measq<C: ContinuousCollection>(_ x: C) -> Double where C.Iterator.Element == Double {
    var result: Double = 0.0
    withUnsafePointersAndCountsTo(x) { x, count in
        withUnsafeMutablePointer(to: &result) { pointer in
            vDSP_measqvD(x, 1, pointer, vDSP_Length(count))
        }
    }
    return result
}

// MARK: Add

public func add<X: ContinuousCollection, Y: ContinuousCollection>(_ x: X, _ y: Y) -> [Float] where X.Iterator.Element == Float, Y.Iterator.Element == Float {
    var results = [Float](y)
    x.withUnsafeBufferPointer { xbp in
        results.withUnsafeMutableBufferPointer { rbp in
            cblas_saxpy(Int32(xbp.count), 1.0, xbp.baseAddress, 1, rbp.baseAddress, 1)
        }
    }
    return results
}

public func add<X: ContinuousCollection, Y: ContinuousCollection>(_ x: X, _ y: Y) -> [Double] where X.Iterator.Element == Double, Y.Iterator.Element == Double {
    var results = [Double](y)
    x.withUnsafeBufferPointer { xbp in
        results.withUnsafeMutableBufferPointer { rbp in
            cblas_daxpy(Int32(xbp.count), 1.0, xbp.baseAddress, 1, rbp.baseAddress, 1)
        }
    }
    return results
}

// MARK: Subtraction

public func sub<X: ContinuousCollection, Y: ContinuousCollection>(_ x: X, _ y: Y) -> [Float] where X.Iterator.Element == Float, Y.Iterator.Element == Float {
    var results = [Float](y)
    x.withUnsafeBufferPointer { xbp in
        results.withUnsafeMutableBufferPointer { rbp in
            catlas_saxpby(Int32(xbp.count), 1.0, xbp.baseAddress, 1, -1, rbp.baseAddress, 1)
        }
    }
    return results
}

public func sub<X: ContinuousCollection, Y: ContinuousCollection>(_ x: X, _ y: Y) -> [Double] where X.Iterator.Element == Double, Y.Iterator.Element == Double {
    var results = [Double](y)
    x.withUnsafeBufferPointer { xbp in
        results.withUnsafeMutableBufferPointer { rbp in
            catlas_daxpby(Int32(xbp.count), 1.0, xbp.baseAddress, 1, -1, rbp.baseAddress, 1)
        }
    }
    return results
}

// MARK: Multiply

public func mul<X: ContinuousCollection, Y: ContinuousCollection>(_ x: X, _ y: Y) -> [Float] where X.Iterator.Element == Float, Y.Iterator.Element == Float {
    var results = [Float](repeating: 0.0, count: numericCast(x.count))
    withUnsafeBufferPointersTo(x, y) { xbp, ybp in
        guard let xp = xbp.baseAddress, let yp = ybp.baseAddress else {
            return
        }
        results.withUnsafeMutableBufferPointer { rbp in
            vDSP_vmul(xp, 1, yp, 1, rbp.baseAddress!, 1, vDSP_Length(xbp.count))
        }
    }
    return results
}

public func mul<X: ContinuousCollection, Y: ContinuousCollection>(_ x: X, _ y: Y) -> [Double] where X.Iterator.Element == Double, Y.Iterator.Element == Double {
    var results = [Double](repeating: 0.0, count: numericCast(x.count))
    withUnsafeBufferPointersTo(x, y) { xbp, ybp in
        guard let xp = xbp.baseAddress, let yp = ybp.baseAddress else {
            return
        }
        results.withUnsafeMutableBufferPointer { rbp in
            vDSP_vmulD(xp, 1, yp, 1, rbp.baseAddress!, 1, vDSP_Length(xbp.count))
        }
    }
    return results
}

// MARK: Divide

public func div<X: ContinuousCollection, Y: ContinuousCollection>(_ x: X, _ y: Y) -> [Float] where X.Iterator.Element == Float, Y.Iterator.Element == Float {
    var results = [Float](repeating: 0.0, count: numericCast(x.count))
    withUnsafeBufferPointersTo(x, y) { xbp, ybp in
        guard let xp = xbp.baseAddress, let yp = ybp.baseAddress else {
            return
        }
        results.withUnsafeMutableBufferPointer { rbp in
            vvdivf(rbp.baseAddress!, xp, yp, [Int32(xbp.count)])
        }
    }
    return results
}

public func div<X: ContinuousCollection, Y: ContinuousCollection>(_ x: X, _ y: Y) -> [Double] where X.Iterator.Element == Double, Y.Iterator.Element == Double {
    var results = [Double](repeating: 0.0, count: numericCast(x.count))
    withUnsafeBufferPointersTo(x, y) { xbp, ybp in
        guard let xp = xbp.baseAddress, let yp = ybp.baseAddress else {
            return
        }
        results.withUnsafeMutableBufferPointer { rbp in
            vvdiv(rbp.baseAddress!, xp, yp, [Int32(xbp.count)])
        }
    }
    return results
}

// MARK: Modulo

public func mod<X: ContinuousCollection, Y: ContinuousCollection>(_ x: X, _ y: Y) -> [Float] where X.Iterator.Element == Float, Y.Iterator.Element == Float {
    var results = [Float](repeating: 0.0, count: numericCast(x.count))
    withUnsafeBufferPointersTo(x, y) { xbp, ybp in
        guard let xp = xbp.baseAddress, let yp = ybp.baseAddress else {
            return
        }
        results.withUnsafeMutableBufferPointer { rbp in
            vvfmodf(rbp.baseAddress!, xp, yp, [Int32(xbp.count)])
        }
    }
    return results
}

public func mod<X: ContinuousCollection, Y: ContinuousCollection>(_ x: X, _ y: Y) -> [Double] where X.Iterator.Element == Double, Y.Iterator.Element == Double {
    var results = [Double](repeating: 0.0, count: numericCast(x.count))
    withUnsafeBufferPointersTo(x, y) { xbp, ybp in
        guard let xp = xbp.baseAddress, let yp = ybp.baseAddress else {
            return
        }
        results.withUnsafeMutableBufferPointer { rbp in
            vvfmod(rbp.baseAddress!, xp, yp, [Int32(xbp.count)])
        }
    }
    return results
}

// MARK: Remainder

public func remainder<X: ContinuousCollection, Y: ContinuousCollection>(_ x: X, _ y: Y) -> [Float] where X.Iterator.Element == Float, Y.Iterator.Element == Float {
    var results = [Float](repeating: 0.0, count: numericCast(x.count))
    withUnsafeBufferPointersTo(x, y) { xbp, ybp in
        guard let xp = xbp.baseAddress, let yp = ybp.baseAddress else {
            return
        }
        results.withUnsafeMutableBufferPointer { rbp in
            vvremainderf(rbp.baseAddress!, xp, yp, [Int32(xbp.count)])
        }
    }
    return results
}

public func remainder<X: ContinuousCollection, Y: ContinuousCollection>(_ x: X, _ y: Y) -> [Double] where X.Iterator.Element == Double, Y.Iterator.Element == Double {
    var results = [Double](repeating: 0.0, count: numericCast(x.count))
    withUnsafeBufferPointersTo(x, y) { xbp, ybp in
        guard let xp = xbp.baseAddress, let yp = ybp.baseAddress else {
            return
        }
        results.withUnsafeMutableBufferPointer { rbp in
            vvremainder(rbp.baseAddress!, xp, yp, [Int32(xbp.count)])
        }
    }
    return results
}

// MARK: Square Root

public func sqrt<C: ContinuousCollection>(_ x: C) -> [Float] where C.Iterator.Element == Float {
    var results = [Float](repeating: 0.0, count: numericCast(x.count))
    withUnsafePointersAndCountsTo(x) { x, count in
        results.withUnsafeMutableBufferPointer { bufferPointer in
            vvsqrtf(bufferPointer.baseAddress!, x, [Int32(count)])
        }
    }
    return results
}

public func sqrt<C: ContinuousCollection>(_ x: C) -> [Double] where C.Iterator.Element == Double {
    var results = [Double](repeating: 0.0, count: numericCast(x.count))
    withUnsafePointersAndCountsTo(x) { x, count in
        results.withUnsafeMutableBufferPointer { bufferPointer in
            vvsqrt(bufferPointer.baseAddress!, x, [Int32(count)])
        }
    }
    return results
}

// MARK: Dot Product

public func dot<X: ContinuousCollection, Y: ContinuousCollection>(_ x: X, _ y: Y) -> Float where X.Iterator.Element == Float, Y.Iterator.Element == Float {
    precondition(x.count == y.count, "Vectors must have equal count")

    var result: Float = 0.0
    withUnsafeBufferPointersTo(x, y) { xbp, ybp in
        guard let xp = xbp.baseAddress, let yp = ybp.baseAddress else {
            return
        }
        withUnsafeMutablePointer(to: &result) { pointer in
            vDSP_dotpr(xp, 1, yp, 1, pointer, vDSP_Length(xbp.count))
        }
    }

    return result
}

public func dot<X: ContinuousCollection, Y: ContinuousCollection>(_ x: X, _ y: Y) -> Double where X.Iterator.Element == Double, Y.Iterator.Element == Double {
    precondition(x.count == y.count, "Vectors must have equal count")

    var result: Double = 0.0
    withUnsafeBufferPointersTo(x, y) { xbp, ybp in
        guard let xp = xbp.baseAddress, let yp = ybp.baseAddress else {
            return
        }
        withUnsafeMutablePointer(to: &result) { pointer in
            vDSP_dotprD(xp, 1, yp, 1, pointer, vDSP_Length(xbp.count))
        }
    }

    return result
}

// MARK: - Distance

public func dist<X: ContinuousCollection, Y: ContinuousCollection>(_ x: X, _ y: Y) -> Float where X.Iterator.Element == Float, Y.Iterator.Element == Float {
    precondition(x.count == y.count, "Vectors must have equal count")
    let sub = x - y
    var squared = [Float](repeating: 0.0, count: numericCast(x.count))
    squared.withUnsafeMutableBufferPointer { bufferPointer in
        vDSP_vsq(sub, 1, bufferPointer.baseAddress!, 1, vDSP_Length(x.count))
    }
    return sqrt(sum(squared))
}

public func dist<X: ContinuousCollection, Y: ContinuousCollection>(_ x: X, _ y: Y) -> Double where X.Iterator.Element == Double, Y.Iterator.Element == Double {
    precondition(x.count == y.count, "Vectors must have equal count")
    let sub = x - y
    var squared = [Double](repeating: 0.0, count: numericCast(x.count))
    squared.withUnsafeMutableBufferPointer { bufferPointer in
        vDSP_vsqD(sub, 1, bufferPointer.baseAddress!, 1, vDSP_Length(x.count))
    }
    return sqrt(sum(squared))
}

// MARK: - Operators

public func + <L: ContinuousCollection, R: ContinuousCollection>(lhs: L, rhs: R) -> [Float] where L.Iterator.Element == Float, R.Iterator.Element == Float {
    return add(lhs, rhs)
}

public func + <L: ContinuousCollection, R: ContinuousCollection>(lhs: L, rhs: R) -> [Double] where L.Iterator.Element == Double, R.Iterator.Element == Double {
    return add(lhs, rhs)
}

public func + <L: ContinuousCollection>(lhs: L, rhs: Float) -> [Float] where L.Iterator.Element == Float {
    return add(lhs, [Float](repeating: rhs, count: numericCast(lhs.count)))
}

public func + <L: ContinuousCollection>(lhs: L, rhs: Double) -> [Double] where L.Iterator.Element == Double {
    return add(lhs, [Double](repeating: rhs, count: numericCast(lhs.count)))
}

public func - <L: ContinuousCollection, R: ContinuousCollection>(lhs: L, rhs: R) -> [Float] where L.Iterator.Element == Float, R.Iterator.Element == Float {
    return sub(lhs, rhs)
}

public func - <L: ContinuousCollection, R: ContinuousCollection>(lhs: L, rhs: R) -> [Double] where L.Iterator.Element == Double, R.Iterator.Element == Double {
    return sub(lhs, rhs)
}

public func - <L: ContinuousCollection>(lhs: L, rhs: Float) -> [Float] where L.Iterator.Element == Float {
    return sub(lhs, [Float](repeating: rhs, count: numericCast(lhs.count)))
}

public func - <L: ContinuousCollection>(lhs: L, rhs: Double) -> [Double] where L.Iterator.Element == Double {
    return sub(lhs, [Double](repeating: rhs, count: numericCast(lhs.count)))
}

public func / <L: ContinuousCollection, R: ContinuousCollection>(lhs: L, rhs: R) -> [Float] where L.Iterator.Element == Float, R.Iterator.Element == Float {
    return div(lhs, rhs)
}

public func / <L: ContinuousCollection, R: ContinuousCollection>(lhs: L, rhs: R) -> [Double] where L.Iterator.Element == Double, R.Iterator.Element == Double {
    return div(lhs, rhs)
}

public func / <L: ContinuousCollection>(lhs: L, rhs: Float) -> [Float] where L.Iterator.Element == Float {
    return div(lhs, [Float](repeating: rhs, count: numericCast(lhs.count)))
}

public func / <L: ContinuousCollection>(lhs: L, rhs: Double) -> [Double] where L.Iterator.Element == Double {
    return div(lhs, [Double](repeating: rhs, count: numericCast(lhs.count)))
}

public func * <L: ContinuousCollection, R: ContinuousCollection>(lhs: L, rhs: R) -> [Float] where L.Iterator.Element == Float, R.Iterator.Element == Float {
    return mul(lhs, rhs)
}

public func * <L: ContinuousCollection, R: ContinuousCollection>(lhs: L, rhs: R) -> [Double] where L.Iterator.Element == Double, R.Iterator.Element == Double {
    return mul(lhs, rhs)
}

public func * <L: ContinuousCollection>(lhs: L, rhs: Float) -> [Float] where L.Iterator.Element == Float {
    return mul(lhs, [Float](repeating: rhs, count: numericCast(lhs.count)))
}

public func * <L: ContinuousCollection>(lhs: L, rhs: Double) -> [Double] where L.Iterator.Element == Double {
    return mul(lhs, [Double](repeating: rhs, count: numericCast(lhs.count)))
}

public func % <L: ContinuousCollection, R: ContinuousCollection>(lhs: L, rhs: R) -> [Float] where L.Iterator.Element == Float, R.Iterator.Element == Float {
    return mod(lhs, rhs)
}

public func % <L: ContinuousCollection, R: ContinuousCollection>(lhs: L, rhs: R) -> [Double] where L.Iterator.Element == Double, R.Iterator.Element == Double {
    return mod(lhs, rhs)
}

public func % <L: ContinuousCollection>(lhs: L, rhs: Float) -> [Float] where L.Iterator.Element == Float {
    return mod(lhs, [Float](repeating: rhs, count: numericCast(lhs.count)))
}

public func % <L: ContinuousCollection>(lhs: L, rhs: Double) -> [Double] where L.Iterator.Element == Double {
    return mod(lhs, [Double](repeating: rhs, count: numericCast(lhs.count)))
}

infix operator •
public func • <L: ContinuousCollection, R: ContinuousCollection>(lhs: L, rhs: R) -> Double where L.Iterator.Element == Double, R.Iterator.Element == Double {
    return dot(lhs, rhs)
}

public func • <L: ContinuousCollection, R: ContinuousCollection>(lhs: L, rhs: R) -> Float where L.Iterator.Element == Float, R.Iterator.Element == Float {
    return dot(lhs, rhs)
}
