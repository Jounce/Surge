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

@inline(__always)
func withArray<T, S>(from sequence: S, _ closure: (inout [T]) -> ()) -> [T] where S: Sequence, S.Element == T {
    var array = Array(sequence)
    closure(&array)
    return array
}

// MARK: - Addition

public func add<L: UnsafeMemoryAccessible>(_ lhs: L, _ rhs: Float) -> [Float] where L.Element == Float {
    return withArray(from: lhs) { addInPlace(&$0, rhs) }
}

public func add<L: UnsafeMemoryAccessible>(_ lhs: L, _ rhs: Double) -> [Double] where L.Element == Double {
    return withArray(from: lhs) { addInPlace(&$0, rhs) }
}

public func + <L: UnsafeMemoryAccessible>(lhs: L, rhs: Float) -> [Float] where L.Element == Float {
    return add(lhs, rhs)
}

public func + <L: UnsafeMemoryAccessible>(lhs: L, rhs: Double) -> [Double] where L.Element == Double {
    return add(lhs, rhs)
}

// MARK: - Addition: In Place

func addInPlace<L: UnsafeMutableMemoryAccessible>(_ lhs: inout L, _ rhs: Float) where L.Element == Float {
    var scalar = rhs

    lhs.withUnsafeMutableMemory { lm in
        vDSP_vsadd(lm.pointer, numericCast(lm.stride), &scalar, lm.pointer, numericCast(lm.stride), numericCast(lm.count))
    }
}

func addInPlace<L: UnsafeMutableMemoryAccessible>(_ lhs: inout L, _ rhs: Double) where L.Element == Double {
    var scalar = rhs

    lhs.withUnsafeMutableMemory { lm in
        vDSP_vsaddD(lm.pointer, numericCast(lm.stride), &scalar, lm.pointer, numericCast(lm.stride), numericCast(lm.count))
    }
}

public func +=<L: UnsafeMutableMemoryAccessible>(lhs: inout L, rhs: Float) where L.Element == Float {
    return addInPlace(&lhs, rhs)
}

public func +=<L: UnsafeMutableMemoryAccessible>(lhs: inout L, rhs: Double) where L.Element == Double {
    return addInPlace(&lhs, rhs)
}

// MARK: - Element-wise Addition

public func add<L: UnsafeMemoryAccessible, R: UnsafeMemoryAccessible>(_ lhs: L, _ rhs: R) -> [Float] where L.Element == Float, R.Element == Float {
    return elmuladd(lhs, rhs, 1.0)
}

public func add<L: UnsafeMemoryAccessible, R: UnsafeMemoryAccessible>(_ lhs: L, _ rhs: R) -> [Double] where L.Element == Double, R.Element == Double {
    return elmuladd(lhs, rhs, 1.0)
}

public func .+ <L: UnsafeMemoryAccessible, R: UnsafeMemoryAccessible>(lhs: L, rhs: R) -> [Float] where L.Element == Float, R.Element == Float {
    return add(lhs, rhs)
}

public func .+ <L: UnsafeMemoryAccessible, R: UnsafeMemoryAccessible>(lhs: L, rhs: R) -> [Double] where L.Element == Double, R.Element == Double {
    return add(lhs, rhs)
}

// MARK: - Element-wise Addition: In Place

func eladdInPlace<L: UnsafeMutableMemoryAccessible, R: UnsafeMemoryAccessible>(_ lhs: inout L, _ rhs: R) where L.Element == Float, R.Element == Float {
    elmuladdInPlace(&lhs, rhs, 1.0)
}

func eladdInPlace<L: UnsafeMutableMemoryAccessible, R: UnsafeMemoryAccessible>(_ lhs: inout L, _ rhs: R) where L.Element == Double, R.Element == Double {
    elmuladdInPlace(&lhs, rhs, 1.0)
}

public func .+= <L: UnsafeMutableMemoryAccessible, R: UnsafeMemoryAccessible>(lhs: inout L, rhs: R) where L.Element == Float, R.Element == Float {
    return eladdInPlace(&lhs, rhs)
}

public func .+= <L: UnsafeMutableMemoryAccessible, R: UnsafeMemoryAccessible>(lhs: inout L, rhs: R) where L.Element == Double, R.Element == Double {
    return eladdInPlace(&lhs, rhs)
}

// MARK: - Subtraction

public func sub<L: UnsafeMemoryAccessible>(_ lhs: L, _ rhs: Float) -> [Float] where L.Element == Float {
    return withArray(from: lhs) { subInPlace(&$0, rhs) }
}

public func sub<L: UnsafeMemoryAccessible>(_ lhs: L, _ rhs: Double) -> [Double] where L.Element == Double {
    return withArray(from: lhs) { subInPlace(&$0, rhs) }
}

public func - <L: UnsafeMemoryAccessible>(lhs: L, rhs: Float) -> [Float] where L.Element == Float {
    return sub(lhs, rhs)
}

public func - <L: UnsafeMemoryAccessible>(lhs: L, rhs: Double) -> [Double] where L.Element == Double {
    return sub(lhs, rhs)
}

// MARK: - Subtraction: In Place

func subInPlace<L: UnsafeMutableMemoryAccessible>(_ lhs: inout L, _ rhs: Float) where L.Element == Float {
    addInPlace(&lhs, -rhs)
}

func subInPlace<L: UnsafeMutableMemoryAccessible>(_ lhs: inout L, _ rhs: Double) where L.Element == Double {
    addInPlace(&lhs, -rhs)
}

public func -=<L: UnsafeMutableMemoryAccessible>(lhs: inout L, rhs: Float) where L.Element == Float {
    return subInPlace(&lhs, rhs)
}

public func -=<L: UnsafeMutableMemoryAccessible>(lhs: inout L, rhs: Double) where L.Element == Double {
    return subInPlace(&lhs, rhs)
}

// MARK: - Element-wise Subtraction

public func sub<L: UnsafeMemoryAccessible, R: UnsafeMemoryAccessible>(_ lhs: L, _ rhs: R) -> [Float] where L.Element == Float, R.Element == Float {
    return elmuladd(lhs, rhs, -1.0)
}

public func sub<L: UnsafeMemoryAccessible, R: UnsafeMemoryAccessible>(_ lhs: L, _ rhs: R) -> [Double] where L.Element == Double, R.Element == Double {
    return elmuladd(lhs, rhs, -1.0)
}

public func .- <L: UnsafeMemoryAccessible, R: UnsafeMemoryAccessible>(lhs: L, rhs: R) -> [Float] where L.Element == Float, R.Element == Float {
    return sub(lhs, rhs)
}

public func .- <L: UnsafeMemoryAccessible, R: UnsafeMemoryAccessible>(lhs: L, rhs: R) -> [Double] where L.Element == Double, R.Element == Double {
    return sub(lhs, rhs)
}

// MARK: - Element-wise Subtraction: In Place

func elsubInPlace<L: UnsafeMutableMemoryAccessible, R: UnsafeMemoryAccessible>(_ lhs: inout L, _ rhs: R) where L.Element == Float, R.Element == Float {
    elmuladdInPlace(&lhs, rhs, -1.0)
}

func elsubInPlace<L: UnsafeMutableMemoryAccessible, R: UnsafeMemoryAccessible>(_ lhs: inout L, _ rhs: R) where L.Element == Double, R.Element == Double {
    elmuladdInPlace(&lhs, rhs, -1.0)
}

public func .-= <L: UnsafeMutableMemoryAccessible, R: UnsafeMemoryAccessible>(lhs: inout L, rhs: R) where L.Element == Float, R.Element == Float {
    return elsubInPlace(&lhs, rhs)
}

public func .-= <L: UnsafeMutableMemoryAccessible, R: UnsafeMemoryAccessible>(lhs: inout L, rhs: R) where L.Element == Double, R.Element == Double {
    return elsubInPlace(&lhs, rhs)
}

// MARK: - Element-wise Multiply Addition

func elmuladd<L: UnsafeMemoryAccessible, R: UnsafeMemoryAccessible>(_ lhs: L, _ rhs: R, _ alpha: Float) -> [Float] where L.Element == Float, R.Element == Float {
    return withArray(from: lhs) { elmuladdInPlace(&$0, rhs, alpha) }
}

func elmuladd<L: UnsafeMemoryAccessible, R: UnsafeMemoryAccessible>(_ lhs: L, _ rhs: R, _ alpha: Double) -> [Double] where L.Element == Double, R.Element == Double {
    return withArray(from: lhs) { elmuladdInPlace(&$0, rhs, alpha) }
}

// MARK: - Element-wise Multiply Addition: In Place

func elmuladdInPlace<L: UnsafeMutableMemoryAccessible, R: UnsafeMemoryAccessible>(_ lhs: inout L, _ rhs: R, _ alpha: Float) where L.Element == Float, R.Element == Float {
    precondition(lhs.count == rhs.count, "Collections must have the same size")
    lhs.withUnsafeMutableMemory { lm in
        rhs.withUnsafeMemory { rm in
            cblas_saxpy(numericCast(lm.count), alpha, rm.pointer, numericCast(rm.stride), lm.pointer, numericCast(lm.stride))
        }
    }
}

func elmuladdInPlace<L: UnsafeMutableMemoryAccessible, R: UnsafeMemoryAccessible>(_ lhs: inout L, _ rhs: R, _ alpha: Double) where L.Element == Double, R.Element == Double {
    precondition(lhs.count == rhs.count, "Collections must have the same size")
    lhs.withUnsafeMutableMemory { lm in
        rhs.withUnsafeMemory { rm in
            cblas_daxpy(numericCast(lm.count), alpha, rm.pointer, numericCast(rm.stride), lm.pointer, numericCast(lm.stride))
        }
    }
}

// MARK: - Multiplication

public func mul<L: UnsafeMemoryAccessible>(_ lhs: L, _ rhs: Float) -> [Float] where L.Element == Float {
    return withArray(from: lhs) { mulInPlace(&$0, rhs) }
}

public func mul<L: UnsafeMemoryAccessible>(_ lhs: L, _ rhs: Double) -> [Double] where L.Element == Double {
    return withArray(from: lhs) { mulInPlace(&$0, rhs) }
}

public func * <L: UnsafeMemoryAccessible>(lhs: L, rhs: Float) -> [Float] where L.Element == Float {
    return mul(lhs, rhs)
}

public func * <L: UnsafeMemoryAccessible>(lhs: L, rhs: Double) -> [Double] where L.Element == Double {
    return mul(lhs, rhs)
}

// MARK: - Multiplication: In Place

func mulInPlace<L: UnsafeMutableMemoryAccessible>(_ lhs: inout L, _ rhs: Float) where L.Element == Float {
    var scalar = rhs
    lhs.withUnsafeMutableMemory { lm in
        vDSP_vsmul(lm.pointer, numericCast(lm.stride), &scalar, lm.pointer, numericCast(lm.stride), numericCast(lm.count))
    }
}

func mulInPlace<L: UnsafeMutableMemoryAccessible>(_ lhs: inout L, _ rhs: Double) where L.Element == Double {
    var scalar = rhs
    lhs.withUnsafeMutableMemory { lm in
        vDSP_vsmulD(lm.pointer, numericCast(lm.stride), &scalar, lm.pointer, numericCast(lm.stride), numericCast(lm.count))
    }
}

public func *=<L: UnsafeMutableMemoryAccessible>(lhs: inout L, rhs: Float) where L.Element == Float {
    return mulInPlace(&lhs, rhs)
}

public func *=<L: UnsafeMutableMemoryAccessible>(lhs: inout L, rhs: Double) where L.Element == Double {
    return mulInPlace(&lhs, rhs)
}

// MARK: - Element-wise Multiplication

public func elmul<L: UnsafeMemoryAccessible, R: UnsafeMemoryAccessible>(_ lhs: L, _ rhs: R) -> [Float] where L.Element == Float, R.Element == Float {
    return withArray(from: lhs) { elmulInPlace(&$0, rhs) }
}

public func elmul<L: UnsafeMemoryAccessible, R: UnsafeMemoryAccessible>(_ lhs: L, _ rhs: R) -> [Double] where L.Element == Double, R.Element == Double {
    return withArray(from: lhs) { elmulInPlace(&$0, rhs) }
}

public func .* <L: UnsafeMemoryAccessible, R: UnsafeMemoryAccessible>(lhs: L, rhs: R) -> [Float] where L.Element == Float, R.Element == Float {
    return elmul(lhs, rhs)
}

public func .* <L: UnsafeMemoryAccessible, R: UnsafeMemoryAccessible>(lhs: L, rhs: R) -> [Double] where L.Element == Double, R.Element == Double {
    return elmul(lhs, rhs)
}

// MARK: - Element-wise Multiplication: In Place

func elmulInPlace<L: UnsafeMutableMemoryAccessible, R: UnsafeMemoryAccessible>(_ lhs: inout L, _ rhs: R) where L.Element == Float, R.Element == Float {
    precondition(lhs.count == rhs.count, "Collections must have the same size")
    lhs.withUnsafeMutableMemory { lm in
        rhs.withUnsafeMemory { rm in
            vDSP_vmul(lm.pointer, numericCast(lm.stride), rm.pointer, numericCast(rm.stride), lm.pointer, numericCast(lm.stride), numericCast(lm.count))
        }
    }
}

func elmulInPlace<L: UnsafeMutableMemoryAccessible, R: UnsafeMemoryAccessible>(_ lhs: inout L, _ rhs: R) where L.Element == Double, R.Element == Double {
    precondition(lhs.count == rhs.count, "Collections must have the same size")
    lhs.withUnsafeMutableMemory { lm in
        rhs.withUnsafeMemory { rm in
            vDSP_vmulD(lm.pointer, numericCast(lm.stride), rm.pointer, numericCast(rm.stride), lm.pointer, numericCast(lm.stride), numericCast(lm.count))
        }
    }
}

public func .*= <L: UnsafeMutableMemoryAccessible, R: UnsafeMemoryAccessible>(lhs: inout L, rhs: R) where L.Element == Float, R.Element == Float {
    return elmulInPlace(&lhs, rhs)
}

public func .*= <L: UnsafeMutableMemoryAccessible, R: UnsafeMemoryAccessible>(lhs: inout L, rhs: R) where L.Element == Double, R.Element == Double {
    return elmulInPlace(&lhs, rhs)
}

// MARK: - Division

public func div<L: UnsafeMemoryAccessible>(_ lhs: L, _ rhs: Float) -> [Float] where L.Element == Float {
    return withArray(from: lhs) { divInPlace(&$0, rhs) }
}

public func div<L: UnsafeMemoryAccessible>(_ lhs: L, _ rhs: Double) -> [Double] where L.Element == Double {
    return withArray(from: lhs) { divInPlace(&$0, rhs) }
}

public func / <L: UnsafeMemoryAccessible>(lhs: L, rhs: Float) -> [Float] where L.Element == Float {
    return div(lhs, rhs)
}

public func / <L: UnsafeMemoryAccessible>(lhs: L, rhs: Double) -> [Double] where L.Element == Double {
    return div(lhs, rhs)
}

// MARK: - Division: In Place

func divInPlace<L: UnsafeMutableMemoryAccessible>(_ lhs: inout L, _ rhs: Float) where L.Element == Float {
    lhs.withUnsafeMutableMemory { lm in
        var scalar = rhs
        vDSP_vsdiv(lm.pointer, numericCast(lm.stride), &scalar, lm.pointer, numericCast(lm.stride), numericCast(lm.count))
    }
}

func divInPlace<L: UnsafeMutableMemoryAccessible>(_ lhs: inout L, _ rhs: Double) where L.Element == Double {
    lhs.withUnsafeMutableMemory { lm in
        var scalar = rhs
        vDSP_vsdivD(lm.pointer, numericCast(lm.stride), &scalar, lm.pointer, numericCast(lm.stride), numericCast(lm.count))
    }
}

public func /=<L: UnsafeMutableMemoryAccessible>(lhs: inout L, rhs: Float) where L.Element == Float {
    return divInPlace(&lhs, rhs)
}

public func /=<L: UnsafeMutableMemoryAccessible>(lhs: inout L, rhs: Double) where L.Element == Double {
    return divInPlace(&lhs, rhs)
}

// MARK: - Element-wise Division

public func div<L: UnsafeMemoryAccessible, R: UnsafeMemoryAccessible>(_ lhs: L, _ rhs: R) -> [Float] where L.Element == Float, R.Element == Float {
    return withArray(from: lhs) { eldivInPlace(&$0, rhs) }
}

public func div<L: UnsafeMemoryAccessible, R: UnsafeMemoryAccessible>(_ lhs: L, _ rhs: R) -> [Double] where L.Element == Double, R.Element == Double {
    return withArray(from: lhs) { eldivInPlace(&$0, rhs) }
}

public func ./ <L: UnsafeMemoryAccessible, R: UnsafeMemoryAccessible>(lhs: L, rhs: R) -> [Float] where L.Element == Float, R.Element == Float {
    return div(lhs, rhs)
}

public func ./ <L: UnsafeMemoryAccessible, R: UnsafeMemoryAccessible>(lhs: L, rhs: R) -> [Double] where L.Element == Double, R.Element == Double {
    return div(lhs, rhs)
}

// MARK: - Element-wise Division: In Place

func eldivInPlace<L: UnsafeMutableMemoryAccessible, R: UnsafeMemoryAccessible>(_ lhs: inout L, _ rhs: R) where L.Element == Float, R.Element == Float {
    precondition(lhs.count == rhs.count, "Collections must have the same size")
    lhs.withUnsafeMutableMemory { lm in
        rhs.withUnsafeMemory { rm in
            vDSP_vdiv(rm.pointer, numericCast(rm.stride), lm.pointer, numericCast(lm.stride), lm.pointer, numericCast(lm.stride), numericCast(lm.count))
        }
    }
}

func eldivInPlace<L: UnsafeMutableMemoryAccessible, R: UnsafeMemoryAccessible>(_ lhs: inout L, _ rhs: R) where L.Element == Double, R.Element == Double {
    precondition(lhs.count == rhs.count, "Collections must have the same size")
    lhs.withUnsafeMutableMemory { lm in
        rhs.withUnsafeMemory { rm in
            vDSP_vdivD(rm.pointer, numericCast(rm.stride), lm.pointer, numericCast(lm.stride), lm.pointer, numericCast(lm.stride), numericCast(lm.count))
        }
    }
}

public func ./= <L: UnsafeMutableMemoryAccessible, R: UnsafeMemoryAccessible>(lhs: inout L, rhs: R) where L.Element == Float, R.Element == Float {
    return eldivInPlace(&lhs, rhs)
}

public func ./= <L: UnsafeMutableMemoryAccessible, R: UnsafeMemoryAccessible>(lhs: inout L, rhs: R) where L.Element == Double, R.Element == Double {
    return eldivInPlace(&lhs, rhs)
}

// MARK: - Modulo

/// - Warning: Allocates a temporary array from `rhs` via `Array(repeating: rhs, count: lhs.count)`.
public func mod<L: UnsafeMemoryAccessible>(_ lhs: L, _ rhs: Float) -> [Float] where L.Element == Float {
    return withArray(from: lhs) { modInPlace(&$0, rhs) }
}

/// - Warning: Allocates a temporary array from `rhs` via `Array(repeating: rhs, count: lhs.count)`.
public func mod<L: UnsafeMemoryAccessible>(_ lhs: L, _ rhs: Double) -> [Double] where L.Element == Double {
    return withArray(from: lhs) { modInPlace(&$0, rhs) }
}

/// - Warning: Allocates a temporary array from `rhs` via `Array(repeating: rhs, count: lhs.count)`.
public func % <L: UnsafeMemoryAccessible>(lhs: L, rhs: Float) -> [Float] where L.Element == Float {
    return mod(lhs, rhs)
}

/// - Warning: Allocates a temporary array from `rhs` via `Array(repeating: rhs, count: lhs.count)`.
public func % <L: UnsafeMemoryAccessible>(lhs: L, rhs: Double) -> [Double] where L.Element == Double {
    return mod(lhs, rhs)
}

// MARK: - Modulo: In Place

/// - Warning: Allocates a temporary array from `rhs` via `Array(repeating: rhs, count: lhs.count)`.
/// - Warning: does not support memory stride (assumes stride is 1).
func modInPlace<L: UnsafeMutableMemoryAccessible>(_ lhs: inout L, _ rhs: Float) where L.Element == Float {
    let rhs = Array(repeating: rhs, count: lhs.count)
    modInPlace(&lhs, rhs)
}

/// - Warning: Allocates a temporary array from `rhs` via `Array(repeating: rhs, count: lhs.count)`.
/// - Warning: does not support memory stride (assumes stride is 1).
func modInPlace<L: UnsafeMutableMemoryAccessible>(_ lhs: inout L, _ rhs: Double) where L.Element == Double {
    let rhs = Array(repeating: rhs, count: lhs.count)
    modInPlace(&lhs, rhs)
}

/// - Warning: Allocates a temporary array from `rhs` via `Array(repeating: rhs, count: lhs.count)`.
/// - Warning: does not support memory stride (assumes stride is 1).
public func .%= <L: UnsafeMutableMemoryAccessible>(lhs: inout L, rhs: Float) where L.Element == Float {
    return modInPlace(&lhs, rhs)
}

/// - Warning: Allocates a temporary array from `rhs` via `Array(repeating: rhs, count: lhs.count)`.
/// - Warning: does not support memory stride (assumes stride is 1).
public func .%= <L: UnsafeMutableMemoryAccessible>(lhs: inout L, rhs: Double) where L.Element == Double {
    return modInPlace(&lhs, rhs)
}

// MARK: - Element-wise Modulo

/// - Warning: does not support memory stride (assumes stride is 1).
public func mod<L: UnsafeMemoryAccessible, R: UnsafeMemoryAccessible>(_ lhs: L, _ rhs: R) -> [Float] where L.Element == Float, R.Element == Float {
    return withArray(from: lhs) { modInPlace(&$0, rhs) }
}

/// - Warning: does not support memory stride (assumes stride is 1).
public func mod<L: UnsafeMemoryAccessible, R: UnsafeMemoryAccessible>(_ lhs: L, _ rhs: R) -> [Double] where L.Element == Double, R.Element == Double {
    return withArray(from: lhs) { modInPlace(&$0, rhs) }
}

public func .% <L: UnsafeMemoryAccessible, R: UnsafeMemoryAccessible>(lhs: L, rhs: R) -> [Float] where L.Element == Float, R.Element == Float {
    return mod(lhs, rhs)
}

public func .% <L: UnsafeMemoryAccessible, R: UnsafeMemoryAccessible>(lhs: L, rhs: R) -> [Double] where L.Element == Double, R.Element == Double {
    return mod(lhs, rhs)
}

// MARK: - Element-wise Modulo: In Place

/// - Warning: does not support memory stride (assumes stride is 1).
public func modInPlace<L: UnsafeMutableMemoryAccessible, R: UnsafeMemoryAccessible>(_ lhs: inout L, _ rhs: R) where L.Element == Float, R.Element == Float {
    precondition(lhs.count == rhs.count, "Collections must have the same size")
    var elementCount: Int32 = numericCast(lhs.count)
    withUnsafeMutableMemory(&lhs) { lm in
        withUnsafeMemory(rhs) { rm in
            vvfmodf(lm.pointer, lm.pointer, rm.pointer, &elementCount)
        }
    }
}

/// - Warning: does not support memory stride (assumes stride is 1).
public func modInPlace<L: UnsafeMutableMemoryAccessible, R: UnsafeMemoryAccessible>(_ lhs: inout L, _ rhs: R) where L.Element == Double, R.Element == Double {
    precondition(lhs.count == rhs.count, "Collections must have the same size")
    var elementCount: Int32 = numericCast(lhs.count)
    withUnsafeMutableMemory(&lhs) { lm in
        withUnsafeMemory(rhs) { rm in
            vvfmod(lm.pointer, lm.pointer, rm.pointer, &elementCount)
        }
    }
}

public func .%= <L: UnsafeMutableMemoryAccessible, R: UnsafeMemoryAccessible>(lhs: inout L, rhs: R) where L.Element == Float, R.Element == Float {
    return modInPlace(&lhs, rhs)
}

public func .%= <L: UnsafeMutableMemoryAccessible, R: UnsafeMemoryAccessible>(lhs: inout L, rhs: R) where L.Element == Double, R.Element == Double {
    return modInPlace(&lhs, rhs)
}

// MARK: - Remainder

/// - Warning: does not support memory stride (assumes stride is 1).
public func remainder<L: UnsafeMemoryAccessible, R: UnsafeMemoryAccessible>(_ lhs: L, _ rhs: R) -> [Float] where L.Element == Float, R.Element == Float {
    return withArray(from: lhs) { remainderInPlace(&$0, rhs) }
}

/// - Warning: does not support memory stride (assumes stride is 1).
public func remainder<L: UnsafeMemoryAccessible, R: UnsafeMemoryAccessible>(_ lhs: L, _ rhs: R) -> [Double] where L.Element == Double, R.Element == Double {
    return withArray(from: lhs) { remainderInPlace(&$0, rhs) }
}

// MARK: - Remainder: In Place

/// - Warning: does not support memory stride (assumes stride is 1).
func remainderInPlace<L: UnsafeMutableMemoryAccessible, R: UnsafeMemoryAccessible>(_ lhs: inout L, _ rhs: R) where L.Element == Float, R.Element == Float {
    precondition(lhs.count == rhs.count, "Collections must have the same size")
    var elementCount: Int32 = numericCast(lhs.count)
    withUnsafeMutableMemory(&lhs) { lm in
        withUnsafeMemory(rhs) { rm in
            vvremainderf(lm.pointer, lm.pointer, rm.pointer, &elementCount)
        }
    }
}

/// - Warning: does not support memory stride (assumes stride is 1).
func remainderInPlace<L: UnsafeMutableMemoryAccessible, R: UnsafeMemoryAccessible>(_ lhs: inout L, _ rhs: R) where L.Element == Double, R.Element == Double {
    precondition(lhs.count == rhs.count, "Collections must have the same size")
    var elementCount: Int32 = numericCast(lhs.count)
    withUnsafeMutableMemory(&lhs) { lm in
        withUnsafeMemory(rhs) { rm in
            vvremainder(lm.pointer, lm.pointer, rm.pointer, &elementCount)
        }
    }
}

// MARK: - Exponential

/// - Warning: does not support memory stride (assumes stride is 1).
public func exp<X: UnsafeMemoryAccessible>(_ lhs: X) -> [Float] where X.Element == Float {
    return withArray(from: lhs) { expInPlace(&$0) }
}

/// - Warning: does not support memory stride (assumes stride is 1).
public func exp<X: UnsafeMemoryAccessible>(_ lhs: X) -> [Double] where X.Element == Double {
    return withArray(from: lhs) { expInPlace(&$0) }
}

// MARK: - Exponential: In Place

/// - Warning: does not support memory stride (assumes stride is 1).
func expInPlace<X: UnsafeMutableMemoryAccessible>(_ lhs: inout X) where X.Element == Float {
    var elementCount: Int32 = numericCast(lhs.count)
    withUnsafeMutableMemory(&lhs) { lm in
        precondition(lm.stride == 1, "\(#function) does not support strided memory access")
        vvexpf(lm.pointer, lm.pointer, &elementCount)
    }
}

/// - Warning: does not support memory stride (assumes stride is 1).
func expInPlace<X: UnsafeMutableMemoryAccessible>(_ lhs: inout X) where X.Element == Double {
    var elementCount: Int32 = numericCast(lhs.count)
    withUnsafeMutableMemory(&lhs) { lm in
        precondition(lm.stride == 1, "\(#function) does not support strided memory access")
        vvexp(lm.pointer, lm.pointer, &elementCount)
    }
}

// MARK: - Square Exponentiation

/// - Warning: does not support memory stride (assumes stride is 1).
public func exp2<X: UnsafeMemoryAccessible>(_ lhs: X) -> [Float] where X.Element == Float {
    return withArray(from: lhs) { exp2InPlace(&$0) }
}

/// - Warning: does not support memory stride (assumes stride is 1).
public func exp2<X: UnsafeMemoryAccessible>(_ lhs: X) -> [Double] where X.Element == Double {
    return withArray(from: lhs) { exp2InPlace(&$0) }
}

// MARK: - Square Exponentiation: In Place

/// - Warning: does not support memory stride (assumes stride is 1).
func exp2InPlace<X: UnsafeMutableMemoryAccessible>(_ lhs: inout X) where X.Element == Float {
    var elementCount: Int32 = numericCast(lhs.count)
    withUnsafeMutableMemory(&lhs) { lm in
        precondition(lm.stride == 1, "\(#function) does not support strided memory access")
        vvexp2f(lm.pointer, lm.pointer, &elementCount)
    }
}

/// - Warning: does not support memory stride (assumes stride is 1).
func exp2InPlace<X: UnsafeMutableMemoryAccessible>(_ lhs: inout X) where X.Element == Double {
    var elementCount: Int32 = numericCast(lhs.count)
    withUnsafeMutableMemory(&lhs) { lm in
        precondition(lm.stride == 1, "\(#function) does not support strided memory access")
        vvexp2(lm.pointer, lm.pointer, &elementCount)
    }
}

// MARK: - Power

/// - Warning: does not support memory stride (assumes stride is 1).
public func pow<X: UnsafeMemoryAccessible, Y: UnsafeMemoryAccessible>(_ lhs: X, _ rhs: Y) -> [Float] where X.Element == Float, Y.Element == Float {
    return withArray(from: lhs) { powInPlace(&$0, rhs) }
}

/// - Warning: does not support memory stride (assumes stride is 1).
public func pow<X: UnsafeMemoryAccessible, Y: UnsafeMemoryAccessible>(_ lhs: X, _ rhs: Y) -> [Double] where X.Element == Double, Y.Element == Double {
    return withArray(from: lhs) { powInPlace(&$0, rhs) }
}

/// - Warning: Allocates a temporary array from `rhs` via `Array(repeating: rhs, count: lhs.count)`.
public func pow<X: UnsafeMemoryAccessible>(_ lhs: X, _ rhs: Float) -> [Float] where X.Element == Float {
    return withArray(from: lhs) { powInPlace(&$0, rhs) }
}

/// - Warning: Allocates a temporary array from `rhs` via `Array(repeating: rhs, count: lhs.count)`.
public func pow<X: UnsafeMemoryAccessible>(_ lhs: X, _ rhs: Double) -> [Double] where X.Element == Double {
    return withArray(from: lhs) { powInPlace(&$0, rhs) }
}

// MARK: - Power: In Place

/// - Warning: does not support memory stride (assumes stride is 1).
func powInPlace<X: UnsafeMutableMemoryAccessible, Y: UnsafeMemoryAccessible>(_ lhs: inout X, _ rhs: Y) where X.Element == Float, Y.Element == Float {
    precondition(lhs.count == rhs.count, "Collections must have the same size")
    var elementCount: Int32 = numericCast(lhs.count)
    withUnsafeMutableMemory(&lhs) { lm in
        precondition(lm.stride == 1, "\(#function) does not support strided memory access")
        withUnsafeMemory(rhs) { rm in
            precondition(rm.stride == 1, "\(#function) does not support strided memory access")
            vvpowf(lm.pointer, rm.pointer, lm.pointer, &elementCount)
        }
    }
}

/// - Warning: does not support memory stride (assumes stride is 1).
func powInPlace<X: UnsafeMutableMemoryAccessible, Y: UnsafeMemoryAccessible>(_ lhs: inout X, _ rhs: Y) where X.Element == Double, Y.Element == Double {
    precondition(lhs.count == rhs.count, "Collections must have the same size")
    var elementCount: Int32 = numericCast(lhs.count)
    withUnsafeMutableMemory(&lhs) { lm in
        precondition(lm.stride == 1, "\(#function) does not support strided memory access")
        withUnsafeMemory(rhs) { rm in
            precondition(rm.stride == 1, "\(#function) does not support strided memory access")
            vvpow(lm.pointer, rm.pointer, lm.pointer, &elementCount)
        }
    }
}

/// - Warning: Allocates a temporary array from `rhs` via `Array(repeating: rhs, count: lhs.count)`.
func powInPlace<X: UnsafeMutableMemoryAccessible>(_ lhs: inout X, _ rhs: Float) where X.Element == Float {
    let rhs = Array(repeating: rhs, count: lhs.count)
    return powInPlace(&lhs, rhs)
}

/// - Warning: Allocates a temporary array from `rhs` via `Array(repeating: rhs, count: lhs.count)`.
func powInPlace<X: UnsafeMutableMemoryAccessible>(_ lhs: inout X, _ rhs: Double) where X.Element == Double {
    let rhs = Array(repeating: rhs, count: lhs.count)
    return powInPlace(&lhs, rhs)
}

//// MARK: - Square

public func sq<L: UnsafeMemoryAccessible>(_ lhs: L) -> [Float] where L.Element == Float {
    return withArray(from: lhs) { sqInPlace(&$0) }
}

public func sq<L: UnsafeMemoryAccessible>(_ lhs: L) -> [Double] where L.Element == Double {
    return withArray(from: lhs) { sqInPlace(&$0) }
}

// MARK: - Square: In Place

func sqInPlace<L: UnsafeMutableMemoryAccessible>(_ lhs: inout L) where L.Element == Float {
    withUnsafeMutableMemory(&lhs) { lm in
        vDSP_vsq(lm.pointer, numericCast(lm.stride), lm.pointer, numericCast(lm.stride), numericCast(lm.count))
    }
}

public func sqInPlace<L: UnsafeMutableMemoryAccessible>(_ lhs: inout L) where L.Element == Double {
    withUnsafeMutableMemory(&lhs) { lm in
        vDSP_vsqD(lm.pointer, numericCast(lm.stride), lm.pointer, numericCast(lm.stride), numericCast(lm.count))
    }
}

// MARK: - Square Root

/// Elemen-wise square root.
///
/// - Warning: does not support memory stride (assumes stride is 1).
public func sqrt<C: UnsafeMemoryAccessible>(_ lhs: C) -> [Float] where C.Element == Float {
    return withArray(from: lhs) { sqrtInPlace(&$0) }
}

/// Elemen-wise square root.
///
/// - Warning: does not support memory stride (assumes stride is 1).
public func sqrt<C: UnsafeMemoryAccessible>(_ lhs: C) -> [Double] where C.Element == Double {
    return withArray(from: lhs) { sqrtInPlace(&$0) }
}

/// Elemen-wise square root with custom output storage.
///
/// - Warning: does not support memory stride (assumes stride is 1).
public func sqrt<MI: UnsafeMemoryAccessible, MO: UnsafeMutableMemoryAccessible>(_ lhs: MI, into results: inout MO) where MI.Element == Float, MO.Element == Float {
    return lhs.withUnsafeMemory { lm in
        results.withUnsafeMutableMemory { rm in
            precondition(lm.stride == 1 && rm.stride == 1, "sqrt doesn't support step values other than 1")
            precondition(rm.count >= lm.count, "`results` doesnt have enough capacity to store the results")
            vvsqrtf(rm.pointer, lm.pointer, [numericCast(lm.count)])
        }
    }
}

/// Elemen-wise square root with custom output storage.
///
/// - Warning: does not support memory stride (assumes stride is 1).
public func sqrt<MI: UnsafeMemoryAccessible, MO: UnsafeMutableMemoryAccessible>(_ lhs: MI, into results: inout MO) where MI.Element == Double, MO.Element == Double {
    return lhs.withUnsafeMemory { lm in
        results.withUnsafeMutableMemory { rm in
            precondition(lm.stride == 1 && rm.stride == 1, "sqrt doesn't support step values other than 1")
            precondition(rm.count >= lm.count, "`results` doesnt have enough capacity to store the results")
            vvsqrt(rm.pointer, lm.pointer, [numericCast(lm.count)])
        }
    }
}

// MARK: - Square Root: In Place

/// Elemen-wise square root.
///
/// - Warning: does not support memory stride (assumes stride is 1).
func sqrtInPlace<C: UnsafeMutableMemoryAccessible>(_ lhs: inout C) where C.Element == Float {
    var elementCount: Int32 = numericCast(lhs.count)
    lhs.withUnsafeMutableMemory { lm in
        precondition(lm.stride == 1, "\(#function) doesn't support step values other than 1")
        vvsqrtf(lm.pointer, lm.pointer, &elementCount)
    }
}

/// Elemen-wise square root.
///
/// - Warning: does not support memory stride (assumes stride is 1).
func sqrtInPlace<C: UnsafeMutableMemoryAccessible>(_ lhs: inout C) where C.Element == Double {
    var elementCount: Int32 = numericCast(lhs.count)
    lhs.withUnsafeMutableMemory { lm in
        precondition(lm.stride == 1, "\(#function) doesn't support step values other than 1")
        vvsqrt(lm.pointer, lm.pointer, &elementCount)
    }
}

// MARK: - Dot Product

public func dot<L: UnsafeMemoryAccessible, R: UnsafeMemoryAccessible>(_ lhs: L, _ rhs: R) -> Float where L.Element == Float, R.Element == Float {
    return withUnsafeMemory(lhs, rhs) { lm, rm in
        precondition(lm.count == rm.count, "Vectors must have equal count")
        var result: Float = 0.0
        withUnsafeMutablePointer(to: &result) { pointer in
            vDSP_dotpr(lm.pointer, numericCast(lm.stride), rm.pointer, numericCast(rm.stride), pointer, numericCast(lm.count))
        }
        return result
    }
}

public func dot<L: UnsafeMemoryAccessible, R: UnsafeMemoryAccessible>(_ lhs: L, _ rhs: R) -> Double where L.Element == Double, R.Element == Double {
    return withUnsafeMemory(lhs, rhs) { lm, rm in
        precondition(lm.count == rm.count, "Vectors must have equal count")
        var result: Double = 0.0
        withUnsafeMutablePointer(to: &result) { pointer in
            vDSP_dotprD(lm.pointer, numericCast(lm.stride), rm.pointer, numericCast(rm.stride), pointer, numericCast(lm.count))
        }
        return result
    }
}

infix operator •: MultiplicationPrecedence

public func • <L: UnsafeMemoryAccessible, R: UnsafeMemoryAccessible>(lhs: L, rhs: R) -> Double where L.Element == Double, R.Element == Double {
    return dot(lhs, rhs)
}

public func • <L: UnsafeMemoryAccessible, R: UnsafeMemoryAccessible>(lhs: L, rhs: R) -> Float where L.Element == Float, R.Element == Float {
    return dot(lhs, rhs)
}

// MARK: - Distance

public func dist<L: UnsafeMemoryAccessible, R: UnsafeMemoryAccessible>(_ lhs: L, _ rhs: R) -> Float where L.Element == Float, R.Element == Float {
    return sqrt(distSq(lhs, rhs))
}

public func dist<L: UnsafeMemoryAccessible, R: UnsafeMemoryAccessible>(_ lhs: L, _ rhs: R) -> Double where L.Element == Double, R.Element == Double {
    return sqrt(distSq(lhs, rhs))
}

// MARK: - Distance Squared

public func distSq<L: UnsafeMemoryAccessible, R: UnsafeMemoryAccessible>(_ lhs: L, _ rhs: R) -> Float where L.Element == Float, R.Element == Float {
    precondition(lhs.count == rhs.count, "Vectors must have equal count")
    var partialDistancesSquared = lhs .- rhs
    sqInPlace(&partialDistancesSquared)
    return sum(partialDistancesSquared)
}

public func distSq<L: UnsafeMemoryAccessible, R: UnsafeMemoryAccessible>(_ lhs: L, _ rhs: R) -> Double where L.Element == Double, R.Element == Double {
    precondition(lhs.count == rhs.count, "Vectors must have equal count")
    var partialDistancesSquared = lhs .- rhs
    sqInPlace(&partialDistancesSquared)
    return sum(partialDistancesSquared)
}
