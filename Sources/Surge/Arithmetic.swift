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

// MARK: Add

public func add<X: UnsafeMemoryAccessible, Y: UnsafeMemoryAccessible>(_ x: X, _ y: Y) -> [Float] where X.Element == Float, Y.Element == Float {
    precondition(x.count == y.count, "Collections must have the same size")
    var results = [Float](y)
    x.withUnsafeMemory { xm in
        results.withUnsafeMutableBufferPointer { rbp in
            cblas_saxpy(numericCast(xm.count), 1.0, xm.pointer, numericCast(xm.stride), rbp.baseAddress, 1)
        }
    }
    return results
}

public func add<X: UnsafeMemoryAccessible, Y: UnsafeMemoryAccessible>(_ x: X, _ y: Y) -> [Double] where X.Element == Double, Y.Element == Double {
    precondition(x.count == y.count, "Collections must have the same size")
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
    precondition(x.count == y.count, "Collections must have the same size")
    var results = [Float](y)
    x.withUnsafeMemory { xm in
        results.withUnsafeMutableBufferPointer { rbp in
            catlas_saxpby(numericCast(xm.count), 1.0, xm.pointer, numericCast(xm.stride), -1, rbp.baseAddress, 1)
        }
    }
    return results
}

public func sub<X: UnsafeMemoryAccessible, Y: UnsafeMemoryAccessible>(_ x: X, _ y: Y) -> [Double] where X.Element == Double, Y.Element == Double {
    precondition(x.count == y.count, "Collections must have the same size")
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
    precondition(x.count == y.count, "Collections must have the same size")
    return withUnsafeMemory(x, y) { xm, ym in
        var results = [Float](repeating: 0.0, count: numericCast(xm.count))
        results.withUnsafeMutableBufferPointer { rbp in
            vDSP_vmul(xm.pointer, xm.stride, ym.pointer, ym.stride, rbp.baseAddress!, 1, numericCast(xm.count))
        }
        return results
    }
}

public func mul<X: UnsafeMemoryAccessible, Y: UnsafeMemoryAccessible>(_ x: X, _ y: Y) -> [Double] where X.Element == Double, Y.Element == Double {
    precondition(x.count == y.count, "Collections must have the same size")
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
public func div<X: UnsafeMemoryAccessible, Y: UnsafeMemoryAccessible>(_ x: X, _ y: Y) -> [Float] where X.Element == Float, Y.Element == Float {
    precondition(x.count == y.count, "Collections must have the same size")
    return withUnsafeMemory(x, y) { xm, ym in
        var results = [Float](repeating: 0.0, count: numericCast(xm.count))
        results.withUnsafeMutableBufferPointer { rbp in
            vDSP_vdiv(ym.pointer, ym.stride, xm.pointer, xm.stride, rbp.baseAddress!, 1, numericCast(xm.count))
        }
        return results
    }
}

/// Elemen-wise vector division.
public func div<X: UnsafeMemoryAccessible, Y: UnsafeMemoryAccessible>(_ x: X, _ y: Y) -> [Double] where X.Element == Double, Y.Element == Double {
    precondition(x.count == y.count, "Collections must have the same size")
    return withUnsafeMemory(x, y) { xm, ym in
        var results = [Double](repeating: 0.0, count: numericCast(xm.count))
        results.withUnsafeMutableBufferPointer { rbp in
            vDSP_vdivD(ym.pointer, ym.stride, xm.pointer, xm.stride, rbp.baseAddress!, 1, numericCast(xm.count))
        }
        return results
    }
}

// MARK: Modulo

/// Elemen-wise modulo.
///
/// - Warning: does not support memory stride (assumes stride is 1).
public func mod<X: UnsafeMemoryAccessible, Y: UnsafeMemoryAccessible>(_ x: X, _ y: Y) -> [Float] where X.Element == Float, Y.Element == Float {
    precondition(x.count == y.count, "Collections must have the same size")
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
    precondition(x.count == y.count, "Collections must have the same size")
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
    precondition(x.count == y.count, "Collections must have the same size")
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
    precondition(x.count == y.count, "Collections must have the same size")
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
    var results = [Float](repeating: 0.0, count: numericCast(x.count))
    sqrt(x, into: &results)
    return results
}

/// Elemen-wise square root with custom output storage.
///
/// - Warning: does not support memory stride (assumes stride is 1).
public func sqrt<MI: UnsafeMemoryAccessible, MO: UnsafeMutableMemoryAccessible>(_ x: MI, into results: inout MO) where MI.Element == Float, MO.Element == Float {
    return x.withUnsafeMemory { xm in
        results.withUnsafeMutableMemory { rm in
            precondition(xm.stride == 1 && rm.stride == 1, "sqrt doesn't support step values other than 1")
            precondition(rm.count >= xm.count, "`results` doesnt have enough capacity to store the results")
            vvsqrtf(rm.pointer, xm.pointer, [numericCast(xm.count)])
        }
    }
}

/// Elemen-wise square root.
///
/// - Warning: does not support memory stride (assumes stride is 1).
public func sqrt<C: UnsafeMemoryAccessible>(_ x: C) -> [Double] where C.Element == Double {
    var results = [Double](repeating: 0.0, count: numericCast(x.count))
    sqrt(x, into: &results)
    return results
}

/// Elemen-wise square root with custom output storage.
///
/// - Warning: does not support memory stride (assumes stride is 1).
public func sqrt<MI: UnsafeMemoryAccessible, MO: UnsafeMutableMemoryAccessible>(_ x: MI, into results: inout MO) where MI.Element == Double, MO.Element == Double {
    return x.withUnsafeMemory { xm in
        results.withUnsafeMutableMemory { rm in
            precondition(xm.stride == 1 && rm.stride == 1, "sqrt doesn't support step values other than 1")
            precondition(rm.count >= xm.count, "`results` doesnt have enough capacity to store the results")
            vvsqrt(rm.pointer, xm.pointer, [numericCast(xm.count)])
        }
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
    let sub = x .- y
    var squared = [Float](repeating: 0.0, count: numericCast(x.count))
    squared.withUnsafeMutableBufferPointer { bufferPointer in
        vDSP_vsq(sub, 1, bufferPointer.baseAddress!, 1, numericCast(x.count))
    }
    return sqrt(sum(squared))
}

public func dist<X: UnsafeMemoryAccessible, Y: UnsafeMemoryAccessible>(_ x: X, _ y: Y) -> Double where X.Element == Double, Y.Element == Double {
    precondition(x.count == y.count, "Vectors must have equal count")
    let sub = x .- y
    var squared = [Double](repeating: 0.0, count: numericCast(x.count))
    squared.withUnsafeMutableBufferPointer { bufferPointer in
        vDSP_vsqD(sub, 1, bufferPointer.baseAddress!, 1, numericCast(x.count))
    }
    return sqrt(sum(squared))
}

// MARK: - Operators

// MARK: Elemen-wise addition

infix operator .+: AdditionPrecedence
infix operator .+=: AssignmentPrecedence

public func .+= <L: UnsafeMutableMemoryAccessible, R: UnsafeMemoryAccessible>(lhs: inout L, rhs: R) where L.Element == Float, R.Element == Float {
    lhs.withUnsafeMutableMemory { lm in
        rhs.withUnsafeMemory { rm in
            vDSP_vadd(lm.pointer, lm.stride, rm.pointer, rm.stride, lm.pointer, lm.stride, numericCast(lm.count))
        }
    }
}

public func .+= <L: UnsafeMutableMemoryAccessible, R: UnsafeMemoryAccessible>(lhs: inout L, rhs: R) where L.Element == Double, R.Element == Double {
    lhs.withUnsafeMutableMemory { lm in
        rhs.withUnsafeMemory { rm in
            vDSP_vaddD(lm.pointer, lm.stride, rm.pointer, rm.stride, lm.pointer, lm.stride, numericCast(lm.count))
        }
    }
}

public func .+ <L: UnsafeMemoryAccessible, R: UnsafeMemoryAccessible>(lhs: L, rhs: R) -> [Float] where L.Element == Float, R.Element == Float {
    return add(lhs, rhs)
}

public func .+ <L: UnsafeMemoryAccessible, R: UnsafeMemoryAccessible>(lhs: L, rhs: R) -> [Double] where L.Element == Double, R.Element == Double {
    return add(lhs, rhs)
}

// MARK: Scalar addition

public func +=<L: UnsafeMutableMemoryAccessible>(lhs: inout L, rhs: Float) where L.Element == Float {
    lhs.withUnsafeMutableMemory { lm in
        var scalar = rhs
        vDSP_vsadd(lm.pointer, lm.stride, &scalar, lm.pointer, lm.stride, numericCast(lm.count))
    }
}

public func +=<L: UnsafeMutableMemoryAccessible>(lhs: inout L, rhs: Double) where L.Element == Double {
    lhs.withUnsafeMutableMemory { lm in
        var scalar = rhs
        vDSP_vsaddD(lm.pointer, lm.stride, &scalar, lm.pointer, lm.stride, numericCast(lm.count))
    }
}

public func + <L: UnsafeMemoryAccessible>(lhs: L, rhs: Float) -> [Float] where L.Element == Float {
    return add(lhs, [Float](repeating: rhs, count: numericCast(lhs.count)))
}

public func + <L: UnsafeMemoryAccessible>(lhs: L, rhs: Double) -> [Double] where L.Element == Double {
    return add(lhs, [Double](repeating: rhs, count: numericCast(lhs.count)))
}

// MARK: Element-wise subtraction

infix operator .-: AdditionPrecedence
infix operator .-=: AssignmentPrecedence

public func .-= <L: UnsafeMutableMemoryAccessible, R: UnsafeMemoryAccessible>(lhs: inout L, rhs: R) where L.Element == Float, R.Element == Float {
    lhs.withUnsafeMutableMemory { lm in
        rhs.withUnsafeMemory { rm in
            vDSP_vsub(rm.pointer, rm.stride, lm.pointer, lm.stride, lm.pointer, lm.stride, numericCast(lm.count))
        }
    }
}

public func .-= <L: UnsafeMutableMemoryAccessible, R: UnsafeMemoryAccessible>(lhs: inout L, rhs: R) where L.Element == Double, R.Element == Double {
    lhs.withUnsafeMutableMemory { lm in
        rhs.withUnsafeMemory { rm in
            vDSP_vsubD(rm.pointer, rm.stride, lm.pointer, lm.stride, lm.pointer, lm.stride, numericCast(lm.count))
        }
    }
}

public func .- <L: UnsafeMemoryAccessible, R: UnsafeMemoryAccessible>(lhs: L, rhs: R) -> [Float] where L.Element == Float, R.Element == Float {
    return sub(lhs, rhs)
}

public func .- <L: UnsafeMemoryAccessible, R: UnsafeMemoryAccessible>(lhs: L, rhs: R) -> [Double] where L.Element == Double, R.Element == Double {
    return sub(lhs, rhs)
}

// MARK: Scalar subtraction

public func -=<L: UnsafeMutableMemoryAccessible>(lhs: inout L, rhs: Float) where L.Element == Float {
    lhs.withUnsafeMutableMemory { lm in
        var scalar = -rhs
        vDSP_vsadd(lm.pointer, lm.stride, &scalar, lm.pointer, lm.stride, numericCast(lm.count))
    }
}

public func -=<L: UnsafeMutableMemoryAccessible>(lhs: inout L, rhs: Double) where L.Element == Double {
    lhs.withUnsafeMutableMemory { lm in
        var scalar = -rhs
        vDSP_vsaddD(lm.pointer, lm.stride, &scalar, lm.pointer, lm.stride, numericCast(lm.count))
    }
}

public func - <L: UnsafeMemoryAccessible>(lhs: L, rhs: Float) -> [Float] where L.Element == Float {
    return sub(lhs, [Float](repeating: rhs, count: numericCast(lhs.count)))
}

public func - <L: UnsafeMemoryAccessible>(lhs: L, rhs: Double) -> [Double] where L.Element == Double {
    return sub(lhs, [Double](repeating: rhs, count: numericCast(lhs.count)))
}

// MARK: Element-wise division

infix operator ./: MultiplicationPrecedence
infix operator ./=: AssignmentPrecedence

public func ./= <L: UnsafeMutableMemoryAccessible, R: UnsafeMemoryAccessible>(lhs: inout L, rhs: R) where L.Element == Float, R.Element == Float {
    lhs.withUnsafeMutableMemory { lm in
        rhs.withUnsafeMemory { rm in
            vDSP_vdiv(lm.pointer, lm.stride, rm.pointer, rm.stride, lm.pointer, lm.stride, numericCast(lm.count))
        }
    }
}

public func ./= <L: UnsafeMutableMemoryAccessible, R: UnsafeMemoryAccessible>(lhs: inout L, rhs: R) where L.Element == Double, R.Element == Double {
    lhs.withUnsafeMutableMemory { lm in
        rhs.withUnsafeMemory { rm in
            vDSP_vdivD(lm.pointer, lm.stride, rm.pointer, rm.stride, lm.pointer, lm.stride, numericCast(lm.count))
        }
    }
}

public func ./ <L: UnsafeMemoryAccessible, R: UnsafeMemoryAccessible>(lhs: L, rhs: R) -> [Float] where L.Element == Float, R.Element == Float {
    return div(lhs, rhs)
}

public func ./ <L: UnsafeMemoryAccessible, R: UnsafeMemoryAccessible>(lhs: L, rhs: R) -> [Double] where L.Element == Double, R.Element == Double {
    return div(lhs, rhs)
}

// MARK: Scalar division

public func /=<L: UnsafeMutableMemoryAccessible>(lhs: inout L, rhs: Float) where L.Element == Float {
    lhs.withUnsafeMutableMemory { lm in
        var scalar = rhs
        vDSP_vsdiv(lm.pointer, lm.stride, &scalar, lm.pointer, lm.stride, numericCast(lm.count))
    }
}

public func /=<L: UnsafeMutableMemoryAccessible>(lhs: inout L, rhs: Double) where L.Element == Double {
    lhs.withUnsafeMutableMemory { lm in
        var scalar = rhs
        vDSP_vsdivD(lm.pointer, lm.stride, &scalar, lm.pointer, lm.stride, numericCast(lm.count))
    }
}

public func / <L: UnsafeMemoryAccessible>(lhs: L, rhs: Float) -> [Float] where L.Element == Float {
    return div(lhs, [Float](repeating: rhs, count: numericCast(lhs.count)))
}

public func / <L: UnsafeMemoryAccessible>(lhs: L, rhs: Double) -> [Double] where L.Element == Double {
    return div(lhs, [Double](repeating: rhs, count: numericCast(lhs.count)))
}

// MARK: Element-wise multiplication

infix operator .*: MultiplicationPrecedence
infix operator .*=: AssignmentPrecedence

public func .*= <L: UnsafeMutableMemoryAccessible, R: UnsafeMemoryAccessible>(lhs: inout L, rhs: R) where L.Element == Float, R.Element == Float {
    lhs.withUnsafeMutableMemory { lm in
        rhs.withUnsafeMemory { rm in
            vDSP_vmul(lm.pointer, lm.stride, rm.pointer, rm.stride, lm.pointer, lm.stride, numericCast(lm.count))
        }
    }
}

public func .*= <L: UnsafeMutableMemoryAccessible, R: UnsafeMemoryAccessible>(lhs: inout L, rhs: R) where L.Element == Double, R.Element == Double {
    lhs.withUnsafeMutableMemory { lm in
        rhs.withUnsafeMemory { rm in
            vDSP_vmulD(lm.pointer, lm.stride, rm.pointer, rm.stride, lm.pointer, lm.stride, numericCast(lm.count))
        }
    }
}

public func .* <L: UnsafeMemoryAccessible, R: UnsafeMemoryAccessible>(lhs: L, rhs: R) -> [Float] where L.Element == Float, R.Element == Float {
    return mul(lhs, rhs)
}

public func .* <L: UnsafeMemoryAccessible, R: UnsafeMemoryAccessible>(lhs: L, rhs: R) -> [Double] where L.Element == Double, R.Element == Double {
    return mul(lhs, rhs)
}

// MARK: Scalar multiplication

public func *=<L: UnsafeMutableMemoryAccessible>(lhs: inout L, rhs: Float) where L.Element == Float {
    lhs.withUnsafeMutableMemory { lm in
        var scalar = rhs
        vDSP_vsmul(lm.pointer, lm.stride, &scalar, lm.pointer, lm.stride, numericCast(lm.count))
    }
}

public func *=<L: UnsafeMutableMemoryAccessible>(lhs: inout L, rhs: Double) where L.Element == Double {
    lhs.withUnsafeMutableMemory { lm in
        var scalar = rhs
        vDSP_vsmulD(lm.pointer, lm.stride, &scalar, lm.pointer, lm.stride, numericCast(lm.count))
    }
}

public func * <L: UnsafeMemoryAccessible>(lhs: L, rhs: Float) -> [Float] where L.Element == Float {
    return mul(lhs, [Float](repeating: rhs, count: numericCast(lhs.count)))
}

public func * <L: UnsafeMemoryAccessible>(lhs: L, rhs: Double) -> [Double] where L.Element == Double {
    return mul(lhs, [Double](repeating: rhs, count: numericCast(lhs.count)))
}

// MARK: Modulo

infix operator .%: MultiplicationPrecedence
infix operator .%=: AssignmentPrecedence

public func .% <L: UnsafeMemoryAccessible, R: UnsafeMemoryAccessible>(lhs: L, rhs: R) -> [Float] where L.Element == Float, R.Element == Float {
    return mod(lhs, rhs)
}

public func .% <L: UnsafeMemoryAccessible, R: UnsafeMemoryAccessible>(lhs: L, rhs: R) -> [Double] where L.Element == Double, R.Element == Double {
    return mod(lhs, rhs)
}

public func % <L: UnsafeMemoryAccessible>(lhs: L, rhs: Float) -> [Float] where L.Element == Float {
    return mod(lhs, [Float](repeating: rhs, count: numericCast(lhs.count)))
}

public func % <L: UnsafeMemoryAccessible>(lhs: L, rhs: Double) -> [Double] where L.Element == Double {
    return mod(lhs, [Double](repeating: rhs, count: numericCast(lhs.count)))
}

// MARK: Dot product

infix operator •: MultiplicationPrecedence
public func • <L: UnsafeMemoryAccessible, R: UnsafeMemoryAccessible>(lhs: L, rhs: R) -> Double where L.Element == Double, R.Element == Double {
    return dot(lhs, rhs)
}

public func • <L: UnsafeMemoryAccessible, R: UnsafeMemoryAccessible>(lhs: L, rhs: R) -> Float where L.Element == Float, R.Element == Float {
    return dot(lhs, rhs)
}
