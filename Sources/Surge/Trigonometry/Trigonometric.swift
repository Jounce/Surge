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

// MARK: - Sine-Cosine

/// - Warning: does not support memory stride (assumes stride is 1).
public func sincos<L>(_ lhs: L) -> (sin: [Float], cos: [Float]) where L: UnsafeMemoryAccessible, L.Element == Float {
    return withUnsafeMemory(lhs) { lm in
        precondition(lm.stride == 1, "\(#function) does not support strided memory access")
        var sin = [Float](repeating: 0.0, count: numericCast(lm.count))
        var cos = [Float](repeating: 0.0, count: numericCast(lm.count))
        var elementCount = Int32(lm.count)
        withUnsafeMutableMemory(&sin, &cos) { sinm, cosm in
            vvsincosf(sinm.pointer, cosm.pointer, lm.pointer, &elementCount)
        }
        return (sin, cos)
    }
}

/// - Warning: does not support memory stride (assumes stride is 1).
public func sincos<L>(_ lhs: L) -> (sin: [Double], cos: [Double]) where L: UnsafeMemoryAccessible, L.Element == Double {
    return withUnsafeMemory(lhs) { lm in
        precondition(lm.stride == 1, "\(#function) does not support strided memory access")
        var sin = [Double](repeating: 0.0, count: numericCast(lm.count))
        var cos = [Double](repeating: 0.0, count: numericCast(lm.count))
        var elementCount = Int32(lm.count)
        withUnsafeMutableMemory(&sin, &cos) { sinm, cosm in
            vvsincos(sinm.pointer, cosm.pointer, lm.pointer, &elementCount)
        }
        return (sin, cos)
    }
}

// MARK: - Sine

/// - Warning: does not support memory stride (assumes stride is 1).
public func sin<L>(_ lhs: L) -> [Float] where L: UnsafeMemoryAccessible, L.Element == Float {
    return withArray(from: lhs) { sinInPlace(&$0) }
}

/// - Warning: does not support memory stride (assumes stride is 1).
func sinInPlace<L>(_ lhs: inout L) where L: UnsafeMutableMemoryAccessible, L.Element == Float {
    return withUnsafeMutableMemory(&lhs) { lm in
        precondition(lm.stride == 1, "\(#function) does not support strided memory access")
        var elementCount = Int32(lm.count)
        vvsinf(lm.pointer, lm.pointer, &elementCount)
    }
}

/// - Warning: does not support memory stride (assumes stride is 1).
public func sin<L>(_ lhs: L) -> [Double] where L: UnsafeMemoryAccessible, L.Element == Double {
    return withArray(from: lhs) { sinInPlace(&$0) }
}

/// - Warning: does not support memory stride (assumes stride is 1).
func sinInPlace<L>(_ lhs: inout L) where L: UnsafeMutableMemoryAccessible, L.Element == Double {
    return withUnsafeMutableMemory(&lhs) { lm in
        precondition(lm.stride == 1, "\(#function) does not support strided memory access")
        var elementCount = Int32(lm.count)
        vvsin(lm.pointer, lm.pointer, &elementCount)
    }
}

// MARK: - Cosine

/// - Warning: does not support memory stride (assumes stride is 1).
public func cos<L>(_ lhs: L) -> [Float] where L: UnsafeMemoryAccessible, L.Element == Float {
    return withArray(from: lhs) { cosInPlace(&$0) }
}

/// - Warning: does not support memory stride (assumes stride is 1).
func cosInPlace<L>(_ lhs: inout L) where L: UnsafeMutableMemoryAccessible, L.Element == Float {
    return withUnsafeMutableMemory(&lhs) { lm in
        precondition(lm.stride == 1, "\(#function) does not support strided memory access")
        var elementCount = Int32(lm.count)
        vvcosf(lm.pointer, lm.pointer, &elementCount)
    }
}

/// - Warning: does not support memory stride (assumes stride is 1).
public func cos<L>(_ lhs: L) -> [Double] where L: UnsafeMemoryAccessible, L.Element == Double {
    return withArray(from: lhs) { cosInPlace(&$0) }
}

/// - Warning: does not support memory stride (assumes stride is 1).
func cosInPlace<L>(_ lhs: inout L) where L: UnsafeMutableMemoryAccessible, L.Element == Double {
    return withUnsafeMutableMemory(&lhs) { lm in
        precondition(lm.stride == 1, "\(#function) does not support strided memory access")
        var elementCount = Int32(lm.count)
        vvcos(lm.pointer, lm.pointer, &elementCount)
    }
}

// MARK: - Tangent

/// - Warning: does not support memory stride (assumes stride is 1).
public func tan<L>(_ lhs: L) -> [Float] where L: UnsafeMemoryAccessible, L.Element == Float {
    return withArray(from: lhs) { tanInPlace(&$0) }
}

/// - Warning: does not support memory stride (assumes stride is 1).
func tanInPlace<L>(_ lhs: inout L) where L: UnsafeMutableMemoryAccessible, L.Element == Float {
    return withUnsafeMutableMemory(&lhs) { lm in
        precondition(lm.stride == 1, "\(#function) does not support strided memory access")
        var elementCount = Int32(lm.count)
        vvtanf(lm.pointer, lm.pointer, &elementCount)
    }
}

/// - Warning: does not support memory stride (assumes stride is 1).
public func tan<L>(_ lhs: L) -> [Double] where L: UnsafeMemoryAccessible, L.Element == Double {
    return withArray(from: lhs) { tanInPlace(&$0) }
}

/// - Warning: does not support memory stride (assumes stride is 1).
func tanInPlace<L>(_ lhs: inout L) where L: UnsafeMutableMemoryAccessible, L.Element == Double {
    return withUnsafeMutableMemory(&lhs) { lm in
        precondition(lm.stride == 1, "\(#function) does not support strided memory access")
        var elementCount = Int32(lm.count)
        vvtan(lm.pointer, lm.pointer, &elementCount)
    }
}

// MARK: - Arc Sine

/// - Warning: does not support memory stride (assumes stride is 1).
public func asin<L>(_ lhs: L) -> [Float] where L: UnsafeMemoryAccessible, L.Element == Float {
    return withArray(from: lhs) { asinInPlace(&$0) }
}

/// - Warning: does not support memory stride (assumes stride is 1).
func asinInPlace<L>(_ lhs: inout L) where L: UnsafeMutableMemoryAccessible, L.Element == Float {
    return withUnsafeMutableMemory(&lhs) { lm in
        precondition(lm.stride == 1, "\(#function) does not support strided memory access")
        var elementCount = Int32(lm.count)
        vvasinf(lm.pointer, lm.pointer, &elementCount)
    }
}

/// - Warning: does not support memory stride (assumes stride is 1).
public func asin<L>(_ lhs: L) -> [Double] where L: UnsafeMemoryAccessible, L.Element == Double {
    return withArray(from: lhs) { asinInPlace(&$0) }
}

/// - Warning: does not support memory stride (assumes stride is 1).
func asinInPlace<L>(_ lhs: inout L) where L: UnsafeMutableMemoryAccessible, L.Element == Double {
    return withUnsafeMutableMemory(&lhs) { lm in
        precondition(lm.stride == 1, "\(#function) does not support strided memory access")
        var elementCount = Int32(lm.count)
        vvasin(lm.pointer, lm.pointer, &elementCount)
    }
}

// MARK: - Arc Cosine

/// - Warning: does not support memory stride (assumes stride is 1).
public func acos<L>(_ lhs: L) -> [Float] where L: UnsafeMemoryAccessible, L.Element == Float {
    return withArray(from: lhs) { acosInPlace(&$0) }
}

/// - Warning: does not support memory stride (assumes stride is 1).
func acosInPlace<L>(_ lhs: inout L) where L: UnsafeMutableMemoryAccessible, L.Element == Float {
    return withUnsafeMutableMemory(&lhs) { lm in
        precondition(lm.stride == 1, "\(#function) does not support strided memory access")
        var elementCount = Int32(lm.count)
        vvacosf(lm.pointer, lm.pointer, &elementCount)
    }
}

/// - Warning: does not support memory stride (assumes stride is 1).
public func acos<L>(_ lhs: L) -> [Double] where L: UnsafeMemoryAccessible, L.Element == Double {
    return withArray(from: lhs) { acosInPlace(&$0) }
}

/// - Warning: does not support memory stride (assumes stride is 1).
func acosInPlace<L>(_ lhs: inout L) where L: UnsafeMutableMemoryAccessible, L.Element == Double {
    return withUnsafeMutableMemory(&lhs) { lm in
        precondition(lm.stride == 1, "\(#function) does not support strided memory access")
        var elementCount = Int32(lm.count)
        vvacos(lm.pointer, lm.pointer, &elementCount)
    }
}

// MARK: - Arc Tangent

/// - Warning: does not support memory stride (assumes stride is 1).
public func atan<L>(_ lhs: L) -> [Float] where L: UnsafeMemoryAccessible, L.Element == Float {
    return withArray(from: lhs) { atanInPlace(&$0) }
}

/// - Warning: does not support memory stride (assumes stride is 1).
func atanInPlace<L>(_ lhs: inout L) where L: UnsafeMutableMemoryAccessible, L.Element == Float {
    return withUnsafeMutableMemory(&lhs) { lm in
        precondition(lm.stride == 1, "\(#function) does not support strided memory access")
        var elementCount = Int32(lm.count)
        vvatanf(lm.pointer, lm.pointer, &elementCount)
    }
}

/// - Warning: does not support memory stride (assumes stride is 1).
public func atan<L>(_ lhs: L) -> [Double] where L: UnsafeMemoryAccessible, L.Element == Double {
    return withArray(from: lhs) { atanInPlace(&$0) }
}

/// - Warning: does not support memory stride (assumes stride is 1).
func atanInPlace<L>(_ lhs: inout L) where L: UnsafeMutableMemoryAccessible, L.Element == Double {
    return withUnsafeMutableMemory(&lhs) { lm in
        precondition(lm.stride == 1, "\(#function) does not support strided memory access")
        var elementCount = Int32(lm.count)
        vvatan(lm.pointer, lm.pointer, &elementCount)
    }
}

// MARK: - Hyperbolic Sine

/// - Warning: does not support memory stride (assumes stride is 1).
public func sinh<L>(_ lhs: L) -> [Float] where L: UnsafeMemoryAccessible, L.Element == Float {
    return withArray(from: lhs) { sinhInPlace(&$0) }
}

/// - Warning: does not support memory stride (assumes stride is 1).
func sinhInPlace<L>(_ lhs: inout L) where L: UnsafeMutableMemoryAccessible, L.Element == Float {
    return withUnsafeMutableMemory(&lhs) { lm in
        precondition(lm.stride == 1, "\(#function) does not support strided memory access")
        var elementCount = Int32(lm.count)
        vvsinhf(lm.pointer, lm.pointer, &elementCount)
    }
}

/// - Warning: does not support memory stride (assumes stride is 1).
public func sinh<L>(_ lhs: L) -> [Double] where L: UnsafeMemoryAccessible, L.Element == Double {
    return withArray(from: lhs) { sinhInPlace(&$0) }
}

/// - Warning: does not support memory stride (assumes stride is 1).
func sinhInPlace<L>(_ lhs: inout L) where L: UnsafeMutableMemoryAccessible, L.Element == Double {
    return withUnsafeMutableMemory(&lhs) { lm in
        precondition(lm.stride == 1, "\(#function) does not support strided memory access")
        var elementCount = Int32(lm.count)
        vvsinh(lm.pointer, lm.pointer, &elementCount)
    }
}

// MARK: - Hyperbolic Cosine

/// - Warning: does not support memory stride (assumes stride is 1).
public func cosh<L>(_ lhs: L) -> [Float] where L: UnsafeMemoryAccessible, L.Element == Float {
    return withArray(from: lhs) { coshInPlace(&$0) }
}

/// - Warning: does not support memory stride (assumes stride is 1).
func coshInPlace<L>(_ lhs: inout L) where L: UnsafeMutableMemoryAccessible, L.Element == Float {
    return withUnsafeMutableMemory(&lhs) { lm in
        precondition(lm.stride == 1, "\(#function) does not support strided memory access")
        var elementCount = Int32(lm.count)
        vvcoshf(lm.pointer, lm.pointer, &elementCount)
    }
}

/// - Warning: does not support memory stride (assumes stride is 1).
public func cosh<L>(_ lhs: L) -> [Double] where L: UnsafeMemoryAccessible, L.Element == Double {
    return withArray(from: lhs) { coshInPlace(&$0) }
}

/// - Warning: does not support memory stride (assumes stride is 1).
func coshInPlace<L>(_ lhs: inout L) where L: UnsafeMutableMemoryAccessible, L.Element == Double {
    return withUnsafeMutableMemory(&lhs) { lm in
        precondition(lm.stride == 1, "\(#function) does not support strided memory access")
        var elementCount = Int32(lm.count)
        vvcosh(lm.pointer, lm.pointer, &elementCount)
    }
}

// MARK: - Hyperbolic Tangent

/// - Warning: does not support memory stride (assumes stride is 1).
public func tanh<L>(_ lhs: L) -> [Float] where L: UnsafeMemoryAccessible, L.Element == Float {
    return withArray(from: lhs) { tanhInPlace(&$0) }
}

/// - Warning: does not support memory stride (assumes stride is 1).
func tanhInPlace<L>(_ lhs: inout L) where L: UnsafeMutableMemoryAccessible, L.Element == Float {
    return withUnsafeMutableMemory(&lhs) { lm in
        precondition(lm.stride == 1, "\(#function) does not support strided memory access")
        var elementCount = Int32(lm.count)
        vvtanhf(lm.pointer, lm.pointer, &elementCount)
    }
}

/// - Warning: does not support memory stride (assumes stride is 1).
public func tanh<L>(_ lhs: L) -> [Double] where L: UnsafeMemoryAccessible, L.Element == Double {
    return withArray(from: lhs) { tanhInPlace(&$0) }
}

/// - Warning: does not support memory stride (assumes stride is 1).
func tanhInPlace<L>(_ lhs: inout L) where L: UnsafeMutableMemoryAccessible, L.Element == Double {
    return withUnsafeMutableMemory(&lhs) { lm in
        precondition(lm.stride == 1, "\(#function) does not support strided memory access")
        var elementCount = Int32(lm.count)
        vvtanh(lm.pointer, lm.pointer, &elementCount)
    }
}

// MARK: - Inverse Hyperbolic Sine

/// - Warning: does not support memory stride (assumes stride is 1).
public func asinh<L>(_ lhs: L) -> [Float] where L: UnsafeMemoryAccessible, L.Element == Float {
    return withArray(from: lhs) { asinhInPlace(&$0) }
}

/// - Warning: does not support memory stride (assumes stride is 1).
func asinhInPlace<L>(_ lhs: inout L) where L: UnsafeMutableMemoryAccessible, L.Element == Float {
    return withUnsafeMutableMemory(&lhs) { lm in
        precondition(lm.stride == 1, "\(#function) does not support strided memory access")
        var elementCount = Int32(lm.count)
        vvasinhf(lm.pointer, lm.pointer, &elementCount)
    }
}

/// - Warning: does not support memory stride (assumes stride is 1).
public func asinh<L>(_ lhs: L) -> [Double] where L: UnsafeMemoryAccessible, L.Element == Double {
    return withArray(from: lhs) { asinhInPlace(&$0) }
}

/// - Warning: does not support memory stride (assumes stride is 1).
func asinhInPlace<L>(_ lhs: inout L) where L: UnsafeMutableMemoryAccessible, L.Element == Double {
    return withUnsafeMutableMemory(&lhs) { lm in
        precondition(lm.stride == 1, "\(#function) does not support strided memory access")
        var elementCount = Int32(lm.count)
        vvasinh(lm.pointer, lm.pointer, &elementCount)
    }
}

// MARK: - Inverse Hyperbolic Cosine

/// - Warning: does not support memory stride (assumes stride is 1).
public func acosh<L>(_ lhs: L) -> [Float] where L: UnsafeMemoryAccessible, L.Element == Float {
    return withArray(from: lhs) { acoshInPlace(&$0) }
}

/// - Warning: does not support memory stride (assumes stride is 1).
func acoshInPlace<L>(_ lhs: inout L) where L: UnsafeMutableMemoryAccessible, L.Element == Float {
    return withUnsafeMutableMemory(&lhs) { lm in
        precondition(lm.stride == 1, "\(#function) does not support strided memory access")
        var elementCount = Int32(lm.count)
        vvacoshf(lm.pointer, lm.pointer, &elementCount)
    }
}

/// - Warning: does not support memory stride (assumes stride is 1).
public func acosh<L>(_ lhs: L) -> [Double] where L: UnsafeMemoryAccessible, L.Element == Double {
    return withArray(from: lhs) { acoshInPlace(&$0) }
}

/// - Warning: does not support memory stride (assumes stride is 1).
func acoshInPlace<L>(_ lhs: inout L) where L: UnsafeMutableMemoryAccessible, L.Element == Double {
    return withUnsafeMutableMemory(&lhs) { lm in
        precondition(lm.stride == 1, "\(#function) does not support strided memory access")
        var elementCount = Int32(lm.count)
        vvacosh(lm.pointer, lm.pointer, &elementCount)
    }
}

// MARK: - Inverse Hyperbolic Tangent

/// - Warning: does not support memory stride (assumes stride is 1).
public func atanh<L>(_ lhs: L) -> [Float] where L: UnsafeMemoryAccessible, L.Element == Float {
    return withArray(from: lhs) { atanhInPlace(&$0) }
}

/// - Warning: does not support memory stride (assumes stride is 1).
func atanhInPlace<L>(_ lhs: inout L) where L: UnsafeMutableMemoryAccessible, L.Element == Float {
    return withUnsafeMutableMemory(&lhs) { lm in
        precondition(lm.stride == 1, "\(#function) does not support strided memory access")
        var elementCount = Int32(lm.count)
        vvatanhf(lm.pointer, lm.pointer, &elementCount)
    }
}

/// - Warning: does not support memory stride (assumes stride is 1).
public func atanh<L>(_ lhs: L) -> [Double] where L: UnsafeMemoryAccessible, L.Element == Double {
    return withArray(from: lhs) { atanhInPlace(&$0) }
}

/// - Warning: does not support memory stride (assumes stride is 1).
func atanhInPlace<L>(_ lhs: inout L) where L: UnsafeMutableMemoryAccessible, L.Element == Double {
    return withUnsafeMutableMemory(&lhs) { lm in
        precondition(lm.stride == 1, "\(#function) does not support strided memory access")
        var elementCount = Int32(lm.count)
        vvatanh(lm.pointer, lm.pointer, &elementCount)
    }
}

// MARK: - Radians to Degrees

/// - Warning: does not support memory stride (assumes stride is 1).
func rad2deg<L>(_ lhs: L) -> [Float] where L: UnsafeMemoryAccessible, L.Element == Float {
    return withUnsafeMemory(lhs) { lm in
        precondition(lm.stride == 1, "\(#function) does not support strided memory access")
        var elementCount = Int32(lm.count)
        var results = [Float](repeating: 0.0, count: numericCast(lm.count))
        let divisor = [Float](repeating: Float.pi / 180.0, count: numericCast(lm.count))
        results.withUnsafeMutableBufferPointer { pointer in
            vvdivf(pointer.baseAddress!, lm.pointer, divisor, &elementCount)
        }
        return results
    }
}

/// - Warning: does not support memory stride (assumes stride is 1).
func rad2degInPlace<L>(_ lhs: L) -> [Float] where L: UnsafeMemoryAccessible, L.Element == Float {
    return withUnsafeMemory(lhs) { lm in
        precondition(lm.stride == 1, "\(#function) does not support strided memory access")
        var elementCount = Int32(lm.count)
        var results = [Float](repeating: 0.0, count: numericCast(lm.count))
        let divisor = [Float](repeating: Float.pi / 180.0, count: numericCast(lm.count))
        results.withUnsafeMutableBufferPointer { pointer in
            vvdivf(pointer.baseAddress!, lm.pointer, divisor, &elementCount)
        }
        return results
    }
}

/// - Warning: does not support memory stride (assumes stride is 1).
func rad2deg<L>(_ lhs: L) -> [Double] where L: UnsafeMemoryAccessible, L.Element == Double {
    return withUnsafeMemory(lhs) { lm in
        precondition(lm.stride == 1, "\(#function) does not support strided memory access")
        var elementCount = Int32(lm.count)
        var results = [Double](repeating: 0.0, count: numericCast(lm.count))
        let divisor = [Double](repeating: Double.pi / 180.0, count: numericCast(lm.count))
        results.withUnsafeMutableBufferPointer { pointer in
            vvdiv(pointer.baseAddress!, lm.pointer, divisor, &elementCount)
        }
        return results
    }
}

// MARK: - Degrees to Radians

/// - Warning: does not support memory stride (assumes stride is 1).
func deg2rad<L>(_ lhs: L) -> [Float] where L: UnsafeMemoryAccessible, L.Element == Float {
    return withUnsafeMemory(lhs) { lm in
        precondition(lm.stride == 1, "\(#function) does not support strided memory access")
        var elementCount = Int32(lm.count)
        var results = [Float](repeating: 0.0, count: numericCast(lm.count))
        let divisor = [Float](repeating: 180.0 / Float.pi, count: numericCast(lm.count))
        results.withUnsafeMutableBufferPointer { pointer in
            vvdivf(pointer.baseAddress!, lm.pointer, divisor, &elementCount)
        }
        return results
    }
}

/// - Warning: does not support memory stride (assumes stride is 1).
func deg2rad<L>(_ lhs: L) -> [Double] where L: UnsafeMemoryAccessible, L.Element == Double {
    return withUnsafeMemory(lhs) { lm in
        precondition(lm.stride == 1, "\(#function) does not support strided memory access")
        var elementCount = Int32(lm.count)
        var results = [Double](repeating: 0.0, count: numericCast(lm.count))
        let divisor = [Double](repeating: 180.0 / Double.pi, count: numericCast(lm.count))
        results.withUnsafeMutableBufferPointer { pointer in
            vvdiv(pointer.baseAddress!, lm.pointer, divisor, &elementCount)
        }
        return results
    }
}
