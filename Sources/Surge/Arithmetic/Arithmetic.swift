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

// MARK: - Addition

public func add<L: UnsafeMemoryAccessible>(_ lhs: L, _ rhs: Float) -> [Float] where L.Element == Float {
    return add(lhs, [Float](repeating: rhs, count: numericCast(lhs.count)))
}

public func add<L: UnsafeMemoryAccessible>(_ lhs: L, _ rhs: Double) -> [Double] where L.Element == Double {
    return add(lhs, [Double](repeating: rhs, count: numericCast(lhs.count)))
}

public func + <L: UnsafeMemoryAccessible>(lhs: L, rhs: Float) -> [Float] where L.Element == Float {
    return add(lhs, rhs)
}

public func + <L: UnsafeMemoryAccessible>(lhs: L, rhs: Double) -> [Double] where L.Element == Double {
    return add(lhs, rhs)
}

// MARK: - Addition: In Place

func addInPlace<L: UnsafeMutableMemoryAccessible>(_ lhs: inout L, _ rhs: Float) where L.Element == Float {
    lhs.withUnsafeMutableMemory { lm in
        var scalar = rhs
        vDSP_vsadd(lm.pointer, numericCast(lm.stride), &scalar, lm.pointer, numericCast(lm.stride), numericCast(lm.count))
    }
}

func addInPlace<L: UnsafeMutableMemoryAccessible>(_ lhs: inout L, _ rhs: Double) where L.Element == Double {
    lhs.withUnsafeMutableMemory { lm in
        var scalar = rhs
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
    precondition(lhs.count == rhs.count, "Collections must have the same size")
    var results = [Float](rhs)
    lhs.withUnsafeMemory { lhsMemory in
        results.withUnsafeMutableBufferPointer { bufferPointer in
            cblas_saxpy(numericCast(lhsMemory.count), 1.0, lhsMemory.pointer, numericCast(lhsMemory.stride), bufferPointer.baseAddress, 1)
        }
    }
    return results
}

public func add<L: UnsafeMemoryAccessible, R: UnsafeMemoryAccessible>(_ lhs: L, _ rhs: R) -> [Double] where L.Element == Double, R.Element == Double {
    precondition(lhs.count == rhs.count, "Collections must have the same size")
    var results = [Double](rhs)
    lhs.withUnsafeMemory { lhsMemory in
        results.withUnsafeMutableBufferPointer { bufferPointer in
            cblas_daxpy(numericCast(lhsMemory.count), 1.0, lhsMemory.pointer, numericCast(lhsMemory.stride), bufferPointer.baseAddress, 1)
        }
    }
    return results
}

public func .+ <L: UnsafeMemoryAccessible, R: UnsafeMemoryAccessible>(lhs: L, rhs: R) -> [Float] where L.Element == Float, R.Element == Float {
    return add(lhs, rhs)
}

public func .+ <L: UnsafeMemoryAccessible, R: UnsafeMemoryAccessible>(lhs: L, rhs: R) -> [Double] where L.Element == Double, R.Element == Double {
    return add(lhs, rhs)
}

// MARK: - Element-wise Addition: In Place

func addInPlace<L: UnsafeMutableMemoryAccessible, R: UnsafeMemoryAccessible>(_ lhs: inout L, _ rhs: R) where L.Element == Float, R.Element == Float {
    lhs.withUnsafeMutableMemory { lm in
        rhs.withUnsafeMemory { rm in
            vDSP_vadd(lm.pointer, numericCast(lm.stride), rm.pointer, numericCast(rm.stride), lm.pointer, numericCast(lm.stride), numericCast(lm.count))
        }
    }
}

func addInPlace<L: UnsafeMutableMemoryAccessible, R: UnsafeMemoryAccessible>(_ lhs: inout L, _ rhs: R) where L.Element == Double, R.Element == Double {
    lhs.withUnsafeMutableMemory { lm in
        rhs.withUnsafeMemory { rm in
            vDSP_vaddD(lm.pointer, numericCast(lm.stride), rm.pointer, numericCast(rm.stride), lm.pointer, numericCast(lm.stride), numericCast(lm.count))
        }
    }
}

public func .+= <L: UnsafeMutableMemoryAccessible, R: UnsafeMemoryAccessible>(lhs: inout L, rhs: R) where L.Element == Float, R.Element == Float {
    return addInPlace(&lhs, rhs)
}

public func .+= <L: UnsafeMutableMemoryAccessible, R: UnsafeMemoryAccessible>(lhs: inout L, rhs: R) where L.Element == Double, R.Element == Double {
    return addInPlace(&lhs, rhs)
}

// MARK: - Subtraction

public func sub<L: UnsafeMemoryAccessible>(_ lhs: L, _ rhs: Float) -> [Float] where L.Element == Float {
    return sub(lhs, [Float](repeating: rhs, count: numericCast(lhs.count)))
}

public func sub<L: UnsafeMemoryAccessible>(_ lhs: L, _ rhs: Double) -> [Double] where L.Element == Double {
    return sub(lhs, [Double](repeating: rhs, count: numericCast(lhs.count)))
}

public func - <L: UnsafeMemoryAccessible>(lhs: L, rhs: Float) -> [Float] where L.Element == Float {
    return sub(lhs, rhs)
}

public func - <L: UnsafeMemoryAccessible>(lhs: L, rhs: Double) -> [Double] where L.Element == Double {
    return sub(lhs, rhs)
}

// MARK: - Subtraction: In Place

func subInPlace<L: UnsafeMutableMemoryAccessible>(_ lhs: inout L, _ rhs: Float) where L.Element == Float {
    lhs.withUnsafeMutableMemory { lm in
        var scalar = -rhs
        vDSP_vsadd(lm.pointer, numericCast(lm.stride), &scalar, lm.pointer, numericCast(lm.stride), numericCast(lm.count))
    }
}

func subInPlace<L: UnsafeMutableMemoryAccessible>(_ lhs: inout L, _ rhs: Double) where L.Element == Double {
    lhs.withUnsafeMutableMemory { lm in
        var scalar = -rhs
        vDSP_vsaddD(lm.pointer, numericCast(lm.stride), &scalar, lm.pointer, numericCast(lm.stride), numericCast(lm.count))
    }
}

public func -=<L: UnsafeMutableMemoryAccessible>(lhs: inout L, rhs: Float) where L.Element == Float {
    return subInPlace(&lhs, rhs)
}

public func -=<L: UnsafeMutableMemoryAccessible>(lhs: inout L, rhs: Double) where L.Element == Double {
    return subInPlace(&lhs, rhs)
}

// MARK: - Element-wise Subtraction

public func sub<L: UnsafeMemoryAccessible, R: UnsafeMemoryAccessible>(_ lhs: L, _ rhs: R) -> [Float] where L.Element == Float, R.Element == Float {
    precondition(lhs.count == rhs.count, "Collections must have the same size")
    var results = [Float](rhs)
    lhs.withUnsafeMemory { lhsMemory in
        results.withUnsafeMutableBufferPointer { bufferPointer in
            catlas_saxpby(numericCast(lhsMemory.count), 1.0, lhsMemory.pointer, numericCast(lhsMemory.stride), -1, bufferPointer.baseAddress, 1)
        }
    }
    return results
}

public func sub<L: UnsafeMemoryAccessible, R: UnsafeMemoryAccessible>(_ lhs: L, _ rhs: R) -> [Double] where L.Element == Double, R.Element == Double {
    precondition(lhs.count == rhs.count, "Collections must have the same size")
    var results = [Double](rhs)
    lhs.withUnsafeMemory { lhsMemory in
        results.withUnsafeMutableBufferPointer { bufferPointer in
            catlas_daxpby(numericCast(lhsMemory.count), 1.0, lhsMemory.pointer, numericCast(lhsMemory.stride), -1, bufferPointer.baseAddress, 1)
        }
    }
    return results
}

public func .- <L: UnsafeMemoryAccessible, R: UnsafeMemoryAccessible>(lhs: L, rhs: R) -> [Float] where L.Element == Float, R.Element == Float {
    return sub(lhs, rhs)
}

public func .- <L: UnsafeMemoryAccessible, R: UnsafeMemoryAccessible>(lhs: L, rhs: R) -> [Double] where L.Element == Double, R.Element == Double {
    return sub(lhs, rhs)
}

// MARK: - Element-wise Subtraction: In Place

func subInPlace<L: UnsafeMutableMemoryAccessible, R: UnsafeMemoryAccessible>(_ lhs: inout L, _ rhs: R) where L.Element == Float, R.Element == Float {
    lhs.withUnsafeMutableMemory { lm in
        rhs.withUnsafeMemory { rm in
            vDSP_vsub(rm.pointer, numericCast(rm.stride), lm.pointer, numericCast(lm.stride), lm.pointer, numericCast(lm.stride), numericCast(lm.count))
        }
    }
}

func subInPlace<L: UnsafeMutableMemoryAccessible, R: UnsafeMemoryAccessible>(_ lhs: inout L, _ rhs: R) where L.Element == Double, R.Element == Double {
    lhs.withUnsafeMutableMemory { lm in
        rhs.withUnsafeMemory { rm in
            vDSP_vsubD(rm.pointer, numericCast(rm.stride), lm.pointer, numericCast(lm.stride), lm.pointer, numericCast(lm.stride), numericCast(lm.count))
        }
    }
}

public func .-= <L: UnsafeMutableMemoryAccessible, R: UnsafeMemoryAccessible>(lhs: inout L, rhs: R) where L.Element == Float, R.Element == Float {
    return subInPlace(&lhs, rhs)
}

public func .-= <L: UnsafeMutableMemoryAccessible, R: UnsafeMemoryAccessible>(lhs: inout L, rhs: R) where L.Element == Double, R.Element == Double {
    return subInPlace(&lhs, rhs)
}

// MARK: - Multiplication

public func mul<L: UnsafeMemoryAccessible>(_ lhs: L, _ rhs: Float) -> [Float] where L.Element == Float {
    return mul(lhs, [Float](repeating: rhs, count: numericCast(lhs.count)))
}

public func mul<L: UnsafeMemoryAccessible>(_ lhs: L, _ rhs: Double) -> [Double] where L.Element == Double {
    return mul(lhs, [Double](repeating: rhs, count: numericCast(lhs.count)))
}

public func * <L: UnsafeMemoryAccessible>(lhs: L, rhs: Float) -> [Float] where L.Element == Float {
    return mul(lhs, rhs)
}

public func * <L: UnsafeMemoryAccessible>(lhs: L, rhs: Double) -> [Double] where L.Element == Double {
    return mul(lhs, rhs)
}

// MARK: - Multiplication: In Place

func mulInPlace<L: UnsafeMutableMemoryAccessible>(_ lhs: inout L, _ rhs: Float) where L.Element == Float {
    lhs.withUnsafeMutableMemory { lm in
        var scalar = rhs
        vDSP_vsmul(lm.pointer, numericCast(lm.stride), &scalar, lm.pointer, numericCast(lm.stride), numericCast(lm.count))
    }
}

func mulInPlace<L: UnsafeMutableMemoryAccessible>(_ lhs: inout L, _ rhs: Double) where L.Element == Double {
    lhs.withUnsafeMutableMemory { lm in
        var scalar = rhs
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

public func mul<L: UnsafeMemoryAccessible, R: UnsafeMemoryAccessible>(_ lhs: L, _ rhs: R) -> [Float] where L.Element == Float, R.Element == Float {
    precondition(lhs.count == rhs.count, "Collections must have the same size")
    return withUnsafeMemory(lhs, rhs) { lhsMemory, rhsMemory in
        var results = [Float](repeating: 0.0, count: numericCast(lhsMemory.count))
        results.withUnsafeMutableBufferPointer { bufferPointer in
            vDSP_vmul(lhsMemory.pointer, numericCast(lhsMemory.stride), rhsMemory.pointer, numericCast(rhsMemory.stride), bufferPointer.baseAddress!, 1, numericCast(lhsMemory.count))
        }
        return results
    }
}

public func mul<L: UnsafeMemoryAccessible, R: UnsafeMemoryAccessible>(_ lhs: L, _ rhs: R) -> [Double] where L.Element == Double, R.Element == Double {
    precondition(lhs.count == rhs.count, "Collections must have the same size")
    return withUnsafeMemory(lhs, rhs) { lhsMemory, rhsMemory in
        var results = [Double](repeating: 0.0, count: numericCast(lhsMemory.count))
        results.withUnsafeMutableBufferPointer { bufferPointer in
            vDSP_vmulD(lhsMemory.pointer, numericCast(lhsMemory.stride), rhsMemory.pointer, numericCast(rhsMemory.stride), bufferPointer.baseAddress!, 1, numericCast(lhsMemory.count))
        }
        return results
    }
}

public func .* <L: UnsafeMemoryAccessible, R: UnsafeMemoryAccessible>(lhs: L, rhs: R) -> [Float] where L.Element == Float, R.Element == Float {
    return mul(lhs, rhs)
}

public func .* <L: UnsafeMemoryAccessible, R: UnsafeMemoryAccessible>(lhs: L, rhs: R) -> [Double] where L.Element == Double, R.Element == Double {
    return mul(lhs, rhs)
}

// MARK: - Element-wise Multiplication: In Place

func mulInPlace<L: UnsafeMutableMemoryAccessible, R: UnsafeMemoryAccessible>(_ lhs: inout L, _ rhs: R) where L.Element == Float, R.Element == Float {
    lhs.withUnsafeMutableMemory { lm in
        rhs.withUnsafeMemory { rm in
            vDSP_vmul(lm.pointer, numericCast(lm.stride), rm.pointer, numericCast(rm.stride), lm.pointer, numericCast(lm.stride), numericCast(lm.count))
        }
    }
}

func mulInPlace<L: UnsafeMutableMemoryAccessible, R: UnsafeMemoryAccessible>(_ lhs: inout L, _ rhs: R) where L.Element == Double, R.Element == Double {
    lhs.withUnsafeMutableMemory { lm in
        rhs.withUnsafeMemory { rm in
            vDSP_vmulD(lm.pointer, numericCast(lm.stride), rm.pointer, numericCast(rm.stride), lm.pointer, numericCast(lm.stride), numericCast(lm.count))
        }
    }
}

public func .*= <L: UnsafeMutableMemoryAccessible, R: UnsafeMemoryAccessible>(lhs: inout L, rhs: R) where L.Element == Float, R.Element == Float {
    return mulInPlace(&lhs, rhs)
}

public func .*= <L: UnsafeMutableMemoryAccessible, R: UnsafeMemoryAccessible>(lhs: inout L, rhs: R) where L.Element == Double, R.Element == Double {
    return mulInPlace(&lhs, rhs)
}

// MARK: - Division

public func div<L: UnsafeMemoryAccessible>(_ lhs: L, _ rhs: Float) -> [Float] where L.Element == Float {
    return div(lhs, [Float](repeating: rhs, count: numericCast(lhs.count)))
}

public func div<L: UnsafeMemoryAccessible>(_ lhs: L, _ rhs: Double) -> [Double] where L.Element == Double {
    return div(lhs, [Double](repeating: rhs, count: numericCast(lhs.count)))
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
    precondition(lhs.count == rhs.count, "Collections must have the same size")
    return withUnsafeMemory(lhs, rhs) { lhsMemory, rhsMemory in
        var results = [Float](repeating: 0.0, count: numericCast(lhsMemory.count))
        results.withUnsafeMutableBufferPointer { bufferPointer in
            vDSP_vdiv(rhsMemory.pointer, numericCast(rhsMemory.stride), lhsMemory.pointer, numericCast(lhsMemory.stride), bufferPointer.baseAddress!, 1, numericCast(lhsMemory.count))
        }
        return results
    }
}

public func div<L: UnsafeMemoryAccessible, R: UnsafeMemoryAccessible>(_ lhs: L, _ rhs: R) -> [Double] where L.Element == Double, R.Element == Double {
    precondition(lhs.count == rhs.count, "Collections must have the same size")
    return withUnsafeMemory(lhs, rhs) { lhsMemory, rhsMemory in
        var results = [Double](repeating: 0.0, count: numericCast(lhsMemory.count))
        results.withUnsafeMutableBufferPointer { bufferPointer in
            vDSP_vdivD(rhsMemory.pointer, numericCast(rhsMemory.stride), lhsMemory.pointer, numericCast(lhsMemory.stride), bufferPointer.baseAddress!, 1, numericCast(lhsMemory.count))
        }
        return results
    }
}

public func ./ <L: UnsafeMemoryAccessible, R: UnsafeMemoryAccessible>(lhs: L, rhs: R) -> [Float] where L.Element == Float, R.Element == Float {
    return div(lhs, rhs)
}

public func ./ <L: UnsafeMemoryAccessible, R: UnsafeMemoryAccessible>(lhs: L, rhs: R) -> [Double] where L.Element == Double, R.Element == Double {
    return div(lhs, rhs)
}

// MARK: - Element-wise Division: In Place

func divInPlace<L: UnsafeMutableMemoryAccessible, R: UnsafeMemoryAccessible>(_ lhs: inout L, _ rhs: R) where L.Element == Float, R.Element == Float {
    lhs.withUnsafeMutableMemory { lm in
        rhs.withUnsafeMemory { rm in
            vDSP_vdiv(rm.pointer, numericCast(rm.stride), lm.pointer, numericCast(lm.stride), lm.pointer, numericCast(lm.stride), numericCast(lm.count))
        }
    }
}

func divInPlace<L: UnsafeMutableMemoryAccessible, R: UnsafeMemoryAccessible>(_ lhs: inout L, _ rhs: R) where L.Element == Double, R.Element == Double {
    lhs.withUnsafeMutableMemory { lm in
        rhs.withUnsafeMemory { rm in
            vDSP_vdivD(rm.pointer, numericCast(rm.stride), lm.pointer, numericCast(lm.stride), lm.pointer, numericCast(lm.stride), numericCast(lm.count))
        }
    }
}

public func ./= <L: UnsafeMutableMemoryAccessible, R: UnsafeMemoryAccessible>(lhs: inout L, rhs: R) where L.Element == Float, R.Element == Float {
    return divInPlace(&lhs, rhs)
}

public func ./= <L: UnsafeMutableMemoryAccessible, R: UnsafeMemoryAccessible>(lhs: inout L, rhs: R) where L.Element == Double, R.Element == Double {
    return divInPlace(&lhs, rhs)
}

// MARK: - Modulo

public func mod<L: UnsafeMemoryAccessible>(_ lhs: L, _ rhs: Float) -> [Float] where L.Element == Float {
    return mod(lhs, [Float](repeating: rhs, count: numericCast(lhs.count)))
}

public func mod<L: UnsafeMemoryAccessible>(_ lhs: L, _ rhs: Double) -> [Double] where L.Element == Double {
    return mod(lhs, [Double](repeating: rhs, count: numericCast(lhs.count)))
}

public func % <L: UnsafeMemoryAccessible>(lhs: L, rhs: Float) -> [Float] where L.Element == Float {
    return mod(lhs, rhs)
}

public func % <L: UnsafeMemoryAccessible>(lhs: L, rhs: Double) -> [Double] where L.Element == Double {
    return mod(lhs, rhs)
}

// MARK: - Element-wise Modulo

/// - Warning: does not support memory stride (assumes stride is 1).
public func mod<L: UnsafeMemoryAccessible, R: UnsafeMemoryAccessible>(_ lhs: L, _ rhs: R) -> [Float] where L.Element == Float, R.Element == Float {
    precondition(lhs.count == rhs.count, "Collections must have the same size")
    return withUnsafeMemory(lhs, rhs) { lhsMemory, rhsMemory in
        precondition(lhsMemory.stride == 1 && rhsMemory.stride == 1, "\(#function) does not support strided memory access")
        var results = [Float](repeating: 0.0, count: numericCast(lhsMemory.count))
        results.withUnsafeMutableBufferPointer { bufferPointer in
            vvfmodf(bufferPointer.baseAddress!, lhsMemory.pointer, rhsMemory.pointer, [numericCast(lhsMemory.count)])
        }
        return results
    }
}

/// - Warning: does not support memory stride (assumes stride is 1).
public func mod<L: UnsafeMemoryAccessible, R: UnsafeMemoryAccessible>(_ lhs: L, _ rhs: R) -> [Double] where L.Element == Double, R.Element == Double {
    precondition(lhs.count == rhs.count, "Collections must have the same size")
    return withUnsafeMemory(lhs, rhs) { lhsMemory, rhsMemory in
        precondition(lhsMemory.stride == 1 && rhsMemory.stride == 1, "\(#function) does not support strided memory access")
        var results = [Double](repeating: 0.0, count: numericCast(lhsMemory.count))
        results.withUnsafeMutableBufferPointer { bufferPointer in
            vvfmod(bufferPointer.baseAddress!, lhsMemory.pointer, rhsMemory.pointer, [numericCast(lhsMemory.count)])
        }
        return results
    }
}

public func .% <L: UnsafeMemoryAccessible, R: UnsafeMemoryAccessible>(lhs: L, rhs: R) -> [Float] where L.Element == Float, R.Element == Float {
    return mod(lhs, rhs)
}

public func .% <L: UnsafeMemoryAccessible, R: UnsafeMemoryAccessible>(lhs: L, rhs: R) -> [Double] where L.Element == Double, R.Element == Double {
    return mod(lhs, rhs)
}

// MARK: - Remainder

/// Elemen-wise remainder.
///
/// - Warning: does not support memory stride (assumes stride is 1).
public func remainder<L: UnsafeMemoryAccessible, R: UnsafeMemoryAccessible>(_ lhs: L, _ rhs: R) -> [Float] where L.Element == Float, R.Element == Float {
    precondition(lhs.count == rhs.count, "Collections must have the same size")
    return withUnsafeMemory(lhs, rhs) { lhsMemory, rhsMemory in
        precondition(lhsMemory.stride == 1 && rhsMemory.stride == 1, "\(#function) does not support strided memory access")
        var results = [Float](repeating: 0.0, count: numericCast(lhsMemory.count))
        results.withUnsafeMutableBufferPointer { bufferPointer in
            vvremainderf(bufferPointer.baseAddress!, lhsMemory.pointer, rhsMemory.pointer, [numericCast(lhsMemory.count)])
        }
        return results
    }
}

/// Elemen-wise remainder.
///
/// - Warning: does not support memory stride (assumes stride is 1).
public func remainder<L: UnsafeMemoryAccessible, R: UnsafeMemoryAccessible>(_ lhs: L, _ rhs: R) -> [Double] where L.Element == Double, R.Element == Double {
    precondition(lhs.count == rhs.count, "Collections must have the same size")
    return withUnsafeMemory(lhs, rhs) { lhsMemory, rhsMemory in
        precondition(lhsMemory.stride == 1 && rhsMemory.stride == 1, "\(#function) does not support strided memory access")
        var results = [Double](repeating: 0.0, count: numericCast(lhsMemory.count))
        results.withUnsafeMutableBufferPointer { bufferPointer in
            vvremainder(bufferPointer.baseAddress!, lhsMemory.pointer, rhsMemory.pointer, [numericCast(lhsMemory.count)])
        }
        return results
    }
}

// MARK: - Exponential

/// - Warning: does not support memory stride (assumes stride is 1).
public func exp<X: UnsafeMemoryAccessible>(_ lhs: X) -> [Float] where X.Element == Float {
    return lhs.withUnsafeMemory { lhsMemory in
        precondition(lhsMemory.stride == 1, "\(#function) does not support strided memory access")

        var lhsCount = Int32(lhs.count)

        var results = [Float](repeating: 0.0, count: lhs.count)
        results.withUnsafeMutableBufferPointer { bufferPointer in
            vvexpf(bufferPointer.baseAddress!, lhsMemory.pointer, &lhsCount)
        }

        return results
    }
}

/// - Warning: does not support memory stride (assumes stride is 1).
public func exp<X: UnsafeMemoryAccessible>(_ lhs: X) -> [Double] where X.Element == Double {
    return lhs.withUnsafeMemory { lhsMemory in
        precondition(lhsMemory.stride == 1, "\(#function) does not support strided memory access")

        var lhsCount = Int32(lhs.count)

        var results = [Double](repeating: 0.0, count: lhs.count)
        results.withUnsafeMutableBufferPointer { bufferPointer in
            vvexp(bufferPointer.baseAddress!, lhsMemory.pointer, &lhsCount)
        }

        return results
    }
}

// MARK: - Square Exponentiation

/// - Warning: does not support memory stride (assumes stride is 1).
public func exp2<X: UnsafeMemoryAccessible>(_ lhs: X) -> [Float] where X.Element == Float {
    return lhs.withUnsafeMemory { lhsMemory in
        precondition(lhsMemory.stride == 1, "\(#function) does not support strided memory access")

        var lhsCount = Int32(lhs.count)

        var results = [Float](repeating: 0.0, count: lhs.count)
        results.withUnsafeMutableBufferPointer { bufferPointer in
            vvexp2f(bufferPointer.baseAddress!, lhsMemory.pointer, &lhsCount)
        }

        return results
    }
}

/// - Warning: does not support memory stride (assumes stride is 1).
public func exp2<X: UnsafeMemoryAccessible>(_ lhs: X) -> [Double] where X.Element == Double {
    return lhs.withUnsafeMemory { lhsMemory in
        precondition(lhsMemory.stride == 1, "\(#function) does not support strided memory access")

        var lhsCount = Int32(lhs.count)

        var results = [Double](repeating: 0.0, count: lhs.count)
        results.withUnsafeMutableBufferPointer { bufferPointer in
            vvexp2(bufferPointer.baseAddress!, lhsMemory.pointer, &lhsCount)
        }

        return results
    }
}

// MARK: - Power

/// - Warning: does not support memory stride (assumes stride is 1).
public func pow<X: UnsafeMemoryAccessible, Y: UnsafeMemoryAccessible>(_ lhs: X, _ rhs: Y) -> [Float] where X.Element == Float, Y.Element == Float {
    return withUnsafeMemory(lhs, rhs) { lhsMemory, rhsMemory in
        precondition(lhsMemory.stride == 1 && rhsMemory.stride == 1, "\(#function) does not support strided memory access")

        var lhsCount = Int32(lhs.count)

        var results = [Float](repeating: 0.0, count: lhs.count)
        results.withUnsafeMutableBufferPointer { pointer in
            vvpowf(pointer.baseAddress!, rhsMemory.pointer, lhsMemory.pointer, &lhsCount)
        }

        return results
    }
}

/// - Warning: does not support memory stride (assumes stride is 1).
public func pow<X: UnsafeMemoryAccessible, Y: UnsafeMemoryAccessible>(_ lhs: X, _ rhs: Y) -> [Double] where X.Element == Double, Y.Element == Double {
    return withUnsafeMemory(lhs, rhs) { lhsMemory, rhsMemory in
        precondition(lhsMemory.stride == 1 && rhsMemory.stride == 1, "\(#function) does not support strided memory access")

        var lhsCount = Int32(lhs.count)

        var results = [Double](repeating: 0.0, count: lhs.count)
        results.withUnsafeMutableBufferPointer { pointer in
            vvpow(pointer.baseAddress!, rhsMemory.pointer, lhsMemory.pointer, &lhsCount)
        }

        return results
    }
}

public func pow<X: UnsafeMemoryAccessible>(_ lhs: X, _ rhs: Float) -> [Float] where X.Element == Float {
    let rhs = [Float](repeating: rhs, count: lhs.count)
    return pow(lhs, rhs)
}

public func pow<X: UnsafeMemoryAccessible>(_ lhs: X, _ rhs: Double) -> [Double] where X.Element == Double {
    let rhs = [Double](repeating: rhs, count: lhs.count)
    return pow(lhs, rhs)
}

// MARK: - Square Root

/// Elemen-wise square root.
///
/// - Warning: does not support memory stride (assumes stride is 1).
public func sqrt<C: UnsafeMemoryAccessible>(_ lhs: C) -> [Float] where C.Element == Float {
    var results = [Float](repeating: 0.0, count: numericCast(lhs.count))
    sqrt(lhs, into: &results)
    return results
}

/// Elemen-wise square root with custom output storage.
///
/// - Warning: does not support memory stride (assumes stride is 1).
public func sqrt<MI: UnsafeMemoryAccessible, MO: UnsafeMutableMemoryAccessible>(_ lhs: MI, into results: inout MO) where MI.Element == Float, MO.Element == Float {
    return lhs.withUnsafeMemory { lhsMemory in
        results.withUnsafeMutableMemory { rm in
            precondition(lhsMemory.stride == 1 && rm.stride == 1, "sqrt doesn't support step values other than 1")
            precondition(rm.count >= lhsMemory.count, "`results` doesnt have enough capacity to store the results")
            vvsqrtf(rm.pointer, lhsMemory.pointer, [numericCast(lhsMemory.count)])
        }
    }
}

/// Elemen-wise square root.
///
/// - Warning: does not support memory stride (assumes stride is 1).
public func sqrt<C: UnsafeMemoryAccessible>(_ lhs: C) -> [Double] where C.Element == Double {
    var results = [Double](repeating: 0.0, count: numericCast(lhs.count))
    sqrt(lhs, into: &results)
    return results
}

/// Elemen-wise square root with custom output storage.
///
/// - Warning: does not support memory stride (assumes stride is 1).
public func sqrt<MI: UnsafeMemoryAccessible, MO: UnsafeMutableMemoryAccessible>(_ lhs: MI, into results: inout MO) where MI.Element == Double, MO.Element == Double {
    return lhs.withUnsafeMemory { lhsMemory in
        results.withUnsafeMutableMemory { rm in
            precondition(lhsMemory.stride == 1 && rm.stride == 1, "sqrt doesn't support step values other than 1")
            precondition(rm.count >= lhsMemory.count, "`results` doesnt have enough capacity to store the results")
            vvsqrt(rm.pointer, lhsMemory.pointer, [numericCast(lhsMemory.count)])
        }
    }
}

// MARK: - Dot Product

public func dot<L: UnsafeMemoryAccessible, R: UnsafeMemoryAccessible>(_ lhs: L, _ rhs: R) -> Float where L.Element == Float, R.Element == Float {
    return withUnsafeMemory(lhs, rhs) { lhsMemory, rhsMemory in
        precondition(lhsMemory.count == rhsMemory.count, "Vectors must have equal count")

        var result: Float = 0.0
        withUnsafeMutablePointer(to: &result) { pointer in
            vDSP_dotpr(lhsMemory.pointer, numericCast(lhsMemory.stride), rhsMemory.pointer, numericCast(rhsMemory.stride), pointer, numericCast(lhsMemory.count))
        }

        return result
    }
}

public func dot<L: UnsafeMemoryAccessible, R: UnsafeMemoryAccessible>(_ lhs: L, _ rhs: R) -> Double where L.Element == Double, R.Element == Double {
    return withUnsafeMemory(lhs, rhs) { lhsMemory, rhsMemory in
        precondition(lhsMemory.count == rhsMemory.count, "Vectors must have equal count")

        var result: Double = 0.0
        withUnsafeMutablePointer(to: &result) { pointer in
            vDSP_dotprD(lhsMemory.pointer, numericCast(lhsMemory.stride), rhsMemory.pointer, numericCast(rhsMemory.stride), pointer, numericCast(lhsMemory.count))
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
    let sub = lhs .- rhs
    var squared = [Float](repeating: 0.0, count: numericCast(lhs.count))
    squared.withUnsafeMutableBufferPointer { bufferPointer in
        vDSP_vsq(sub, 1, bufferPointer.baseAddress!, 1, numericCast(lhs.count))
    }
    return sum(squared)
}

public func distSq<L: UnsafeMemoryAccessible, R: UnsafeMemoryAccessible>(_ lhs: L, _ rhs: R) -> Double where L.Element == Double, R.Element == Double {
    precondition(lhs.count == rhs.count, "Vectors must have equal count")
    let sub = lhs .- rhs
    var squared = [Double](repeating: 0.0, count: numericCast(lhs.count))
    squared.withUnsafeMutableBufferPointer { bufferPointer in
        vDSP_vsqD(sub, 1, bufferPointer.baseAddress!, 1, numericCast(lhs.count))
    }
    return sum(squared)
}
