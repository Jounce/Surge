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
public func sincos<L: UnsafeMemoryAccessible>(_ lhs: L) -> (sin: [Float], cos: [Float]) where L.Element == Float {
    return withUnsafeMemory(lhs) { lm in
        precondition(lm.stride == 1, "\(#function) does not support strided memory access")
        var sin = [Float](repeating: 0.0, count: numericCast(lm.count))
        var cos = [Float](repeating: 0.0, count: numericCast(lm.count))
        withUnsafeMutableMemory(&sin, &cos) { sinm, cosm in
            vvsincosf(sinm.pointer, cosm.pointer, lm.pointer, [numericCast(lm.count)])
        }
        return (sin, cos)
    }
}

/// - Warning: does not support memory stride (assumes stride is 1).
public func sincos<L: UnsafeMemoryAccessible>(_ lhs: L) -> (sin: [Double], cos: [Double]) where L.Element == Double {
    return withUnsafeMemory(lhs) { lm in
        precondition(lm.stride == 1, "\(#function) does not support strided memory access")
        var sin = [Double](repeating: 0.0, count: numericCast(lm.count))
        var cos = [Double](repeating: 0.0, count: numericCast(lm.count))
        withUnsafeMutableMemory(&sin, &cos) { sinm, cosm in
            vvsincos(sinm.pointer, cosm.pointer, lm.pointer, [numericCast(lm.count)])
        }
        return (sin, cos)
    }
}

// MARK: - Sine

/// - Warning: does not support memory stride (assumes stride is 1).
public func sin<L: UnsafeMemoryAccessible>(_ lhs: L) -> [Float] where L.Element == Float {
    return withUnsafeMemory(lhs) { lm in
        precondition(lm.stride == 1, "\(#function) does not support strided memory access")
        var results = [Float](repeating: 0.0, count: numericCast(lm.count))
        results.withUnsafeMutableBufferPointer { pointer in
            vvsinf(pointer.baseAddress!, lm.pointer, [numericCast(lm.count)])
        }
        return results
    }
}

/// - Warning: does not support memory stride (assumes stride is 1).
public func sin<L: UnsafeMemoryAccessible>(_ lhs: L) -> [Double] where L.Element == Double {
    return withUnsafeMemory(lhs) { lm in
        precondition(lm.stride == 1, "\(#function) does not support strided memory access")
        var results = [Double](repeating: 0.0, count: numericCast(lm.count))
        results.withUnsafeMutableBufferPointer { pointer in
            vvsin(pointer.baseAddress!, lm.pointer, [numericCast(lm.count)])
        }
        return results
    }
}

// MARK: - Cosine

/// - Warning: does not support memory stride (assumes stride is 1).
public func cos<L: UnsafeMemoryAccessible>(_ lhs: L) -> [Float] where L.Element == Float {
    return withUnsafeMemory(lhs) { lm in
        precondition(lm.stride == 1, "\(#function) does not support strided memory access")
        var results = [Float](repeating: 0.0, count: numericCast(lm.count))
        results.withUnsafeMutableBufferPointer { pointer in
            vvcosf(pointer.baseAddress!, lm.pointer, [numericCast(lm.count)])
        }
        return results
    }
}

/// - Warning: does not support memory stride (assumes stride is 1).
public func cos<L: UnsafeMemoryAccessible>(_ lhs: L) -> [Double] where L.Element == Double {
    return withUnsafeMemory(lhs) { lm in
        precondition(lm.stride == 1, "\(#function) does not support strided memory access")
        var results = [Double](repeating: 0.0, count: numericCast(lm.count))
        results.withUnsafeMutableBufferPointer { pointer in
            vvcos(pointer.baseAddress!, lm.pointer, [numericCast(lm.count)])
        }
        return results
    }
}

// MARK: - Tangent

/// - Warning: does not support memory stride (assumes stride is 1).
public func tan<L: UnsafeMemoryAccessible>(_ lhs: L) -> [Float] where L.Element == Float {
    return withUnsafeMemory(lhs) { lm in
        precondition(lm.stride == 1, "\(#function) does not support strided memory access")
    var results = [Float](repeating: 0.0, count: numericCast(lm.count))
        results.withUnsafeMutableBufferPointer { pointer in
            vvtanf(pointer.baseAddress!, lm.pointer, [numericCast(lm.count)])
        }
        return results
    }
}

/// - Warning: does not support memory stride (assumes stride is 1).
public func tan<L: UnsafeMemoryAccessible>(_ lhs: L) -> [Double] where L.Element == Double {
    return withUnsafeMemory(lhs) { lm in
        precondition(lm.stride == 1, "\(#function) does not support strided memory access")
        var results = [Double](repeating: 0.0, count: numericCast(lm.count))
        results.withUnsafeMutableBufferPointer { pointer in
            vvtan(pointer.baseAddress!, lm.pointer, [numericCast(lm.count)])
        }
        return results
    }
}

// MARK: - Arcsine

/// - Warning: does not support memory stride (assumes stride is 1).
public func asin<L: UnsafeMemoryAccessible>(_ lhs: L) -> [Float] where L.Element == Float {
    return withUnsafeMemory(lhs) { lm in
        precondition(lm.stride == 1, "\(#function) does not support strided memory access")
        var results = [Float](repeating: 0.0, count: numericCast(lm.count))
        results.withUnsafeMutableBufferPointer { pointer in
            vvasinf(pointer.baseAddress!, lm.pointer, [numericCast(lm.count)])
        }
        return results
    }
}

/// - Warning: does not support memory stride (assumes stride is 1).
public func asin<L: UnsafeMemoryAccessible>(_ lhs: L) -> [Double] where L.Element == Double {
    return withUnsafeMemory(lhs) { lm in
        precondition(lm.stride == 1, "\(#function) does not support strided memory access")
        var results = [Double](repeating: 0.0, count: numericCast(lm.count))
        results.withUnsafeMutableBufferPointer { pointer in
            vvasin(pointer.baseAddress!, lm.pointer, [numericCast(lm.count)])
        }
        return results
    }
}

// MARK: - Arccosine

/// - Warning: does not support memory stride (assumes stride is 1).
public func acos<L: UnsafeMemoryAccessible>(_ lhs: L) -> [Float] where L.Element == Float {
    return withUnsafeMemory(lhs) { lm in
        precondition(lm.stride == 1, "\(#function) does not support strided memory access")
        var results = [Float](repeating: 0.0, count: numericCast(lm.count))
        results.withUnsafeMutableBufferPointer { pointer in
            vvacosf(pointer.baseAddress!, lm.pointer, [numericCast(lm.count)])
        }
        return results
    }
}

/// - Warning: does not support memory stride (assumes stride is 1).
public func acos<L: UnsafeMemoryAccessible>(_ lhs: L) -> [Double] where L.Element == Double {
    return withUnsafeMemory(lhs) { lm in
        precondition(lm.stride == 1, "\(#function) does not support strided memory access")
        var results = [Double](repeating: 0.0, count: numericCast(lm.count))
        results.withUnsafeMutableBufferPointer { pointer in
            vvacos(pointer.baseAddress!, lm.pointer, [numericCast(lm.count)])
        }
        return results
    }
}

// MARK: - Arctangent

/// - Warning: does not support memory stride (assumes stride is 1).
public func atan<L: UnsafeMemoryAccessible>(_ lhs: L) -> [Float] where L.Element == Float {
    return withUnsafeMemory(lhs) { lm in
        precondition(lm.stride == 1, "\(#function) does not support strided memory access")
        var results = [Float](repeating: 0.0, count: numericCast(lm.count))
        results.withUnsafeMutableBufferPointer { pointer in
            vvatanf(pointer.baseAddress!, lm.pointer, [numericCast(lm.count)])
        }
        return results
    }
}

/// - Warning: does not support memory stride (assumes stride is 1).
public func atan<L: UnsafeMemoryAccessible>(_ lhs: L) -> [Double] where L.Element == Double {
    return withUnsafeMemory(lhs) { lm in
        precondition(lm.stride == 1, "\(#function) does not support strided memory access")
        var results = [Double](repeating: 0.0, count: numericCast(lm.count))
        results.withUnsafeMutableBufferPointer { pointer in
            vvatan(pointer.baseAddress!, lm.pointer, [numericCast(lm.count)])
        }
        return results
    }
}

// MARK: -

// MARK: - Radians to Degrees

/// - Warning: does not support memory stride (assumes stride is 1).
func rad2deg<L: UnsafeMemoryAccessible>(_ lhs: L) -> [Float] where L.Element == Float {
    return withUnsafeMemory(lhs) { lm in
        precondition(lm.stride == 1, "\(#function) does not support strided memory access")
        var results = [Float](repeating: 0.0, count: numericCast(lm.count))
        let divisor = [Float](repeating: Float.pi / 180.0, count: numericCast(lm.count))
        results.withUnsafeMutableBufferPointer { pointer in
            vvdivf(pointer.baseAddress!, lm.pointer, divisor, [numericCast(lm.count)])
        }
        return results
    }
}

/// - Warning: does not support memory stride (assumes stride is 1).
func rad2deg<L: UnsafeMemoryAccessible>(_ lhs: L) -> [Double] where L.Element == Double {
    return withUnsafeMemory(lhs) { lm in
        precondition(lm.stride == 1, "\(#function) does not support strided memory access")
        var results = [Double](repeating: 0.0, count: numericCast(lm.count))
        let divisor = [Double](repeating: Double.pi / 180.0, count: numericCast(lm.count))
        results.withUnsafeMutableBufferPointer { pointer in
            vvdiv(pointer.baseAddress!, lm.pointer, divisor, [numericCast(lm.count)])
        }
        return results
    }
}

// MARK: - Degrees to Radians

/// - Warning: does not support memory stride (assumes stride is 1).
func deg2rad<L: UnsafeMemoryAccessible>(_ lhs: L) -> [Float] where L.Element == Float {
    return withUnsafeMemory(lhs) { lm in
        precondition(lm.stride == 1, "\(#function) does not support strided memory access")
        var results = [Float](repeating: 0.0, count: numericCast(lm.count))
        let divisor = [Float](repeating: 180.0 / Float.pi, count: numericCast(lm.count))
        results.withUnsafeMutableBufferPointer { pointer in
            vvdivf(pointer.baseAddress!, lm.pointer, divisor, [numericCast(lm.count)])
        }
        return results
    }
}

/// - Warning: does not support memory stride (assumes stride is 1).
func deg2rad<L: UnsafeMemoryAccessible>(_ lhs: L) -> [Double] where L.Element == Double {
    return withUnsafeMemory(lhs) { lm in
        precondition(lm.stride == 1, "\(#function) does not support strided memory access")
        var results = [Double](repeating: 0.0, count: numericCast(lm.count))
        let divisor = [Double](repeating: 180.0 / Double.pi, count: numericCast(lm.count))
        results.withUnsafeMutableBufferPointer { pointer in
            vvdiv(pointer.baseAddress!, lm.pointer, divisor, [numericCast(lm.count)])
        }
        return results
    }
}

// MARK: - Hyperbolic Sine

/// - Warning: does not support memory stride (assumes stride is 1).
public func sinh<L: UnsafeMemoryAccessible>(_ lhs: L) -> [Float] where L.Iterator.Element == Float {
    return lhs.withUnsafeMemory { lm in
        precondition(lm.stride == 1, "\(#function) does not support strided memory access")
        var results = [Float](repeating: 0.0, count: numericCast(lhs.count))
        results.withUnsafeMutableBufferPointer { rbp in
            vvsinhf(rbp.baseAddress!, lm.pointer, [numericCast(lm.count)])
        }
        return results
    }
}

/// - Warning: does not support memory stride (assumes stride is 1).
public func sinh<L: UnsafeMemoryAccessible>(_ lhs: L) -> [Double] where L.Iterator.Element == Double {
    return lhs.withUnsafeMemory { lm in
        precondition(lm.stride == 1, "\(#function) does not support strided memory access")
        var results = [Double](repeating: 0.0, count: numericCast(lhs.count))
        results.withUnsafeMutableBufferPointer { rbp in
            vvsinh(rbp.baseAddress!, lm.pointer, [numericCast(lm.count)])
        }
        return results
    }
}

// MARK: - Hyperbolic Cosine

/// - Warning: does not support memory stride (assumes stride is 1).
public func cosh<L: UnsafeMemoryAccessible>(_ lhs: L) -> [Float] where L.Iterator.Element == Float {
    return lhs.withUnsafeMemory { lm in
        precondition(lm.stride == 1, "\(#function) does not support strided memory access")
        var results = [Float](repeating: 0.0, count: numericCast(lhs.count))
        results.withUnsafeMutableBufferPointer { rbp in
            vvcoshf(rbp.baseAddress!, lm.pointer, [numericCast(lm.count)])
        }
        return results
    }
}

/// - Warning: does not support memory stride (assumes stride is 1).
public func cosh<L: UnsafeMemoryAccessible>(_ lhs: L) -> [Double] where L.Iterator.Element == Double {
    return lhs.withUnsafeMemory { lm in
        precondition(lm.stride == 1, "\(#function) does not support strided memory access")
        var results = [Double](repeating: 0.0, count: numericCast(lhs.count))
        results.withUnsafeMutableBufferPointer { rbp in
            vvcosh(rbp.baseAddress!, lm.pointer, [numericCast(lm.count)])
        }
        return results
    }
}

// MARK: - Hyperbolic Tangent

/// - Warning: does not support memory stride (assumes stride is 1).
public func tanh<L: UnsafeMemoryAccessible>(_ lhs: L) -> [Float] where L.Iterator.Element == Float {
    return lhs.withUnsafeMemory { lm in
        precondition(lm.stride == 1, "\(#function) does not support strided memory access")
        var results = [Float](repeating: 0.0, count: numericCast(lhs.count))
        results.withUnsafeMutableBufferPointer { rbp in
            vvtanhf(rbp.baseAddress!, lm.pointer, [numericCast(lm.count)])
        }
        return results
    }
}

/// - Warning: does not support memory stride (assumes stride is 1).
public func tanh<L: UnsafeMemoryAccessible>(_ lhs: L) -> [Double] where L.Iterator.Element == Double {
    return lhs.withUnsafeMemory { lm in
        precondition(lm.stride == 1, "\(#function) does not support strided memory access")
        var results = [Double](repeating: 0.0, count: numericCast(lhs.count))
        results.withUnsafeMutableBufferPointer { rbp in
            vvtanh(rbp.baseAddress!, lm.pointer, [numericCast(lm.count)])
        }
        return results
    }
}

// MARK: - Inverse Hyperbolic Sine

/// - Warning: does not support memory stride (assumes stride is 1).
public func asinh<L: UnsafeMemoryAccessible>(_ lhs: L) -> [Float] where L.Iterator.Element == Float {
    return lhs.withUnsafeMemory { lm in
        precondition(lm.stride == 1, "\(#function) does not support strided memory access")
        var results = [Float](repeating: 0.0, count: numericCast(lhs.count))
        results.withUnsafeMutableBufferPointer { rbp in
            vvasinhf(rbp.baseAddress!, lm.pointer, [numericCast(lm.count)])
        }
        return results
    }
}

/// - Warning: does not support memory stride (assumes stride is 1).
public func asinh<L: UnsafeMemoryAccessible>(_ lhs: L) -> [Double] where L.Iterator.Element == Double {
    return lhs.withUnsafeMemory { lm in
        precondition(lm.stride == 1, "\(#function) does not support strided memory access")
        var results = [Double](repeating: 0.0, count: numericCast(lhs.count))
        results.withUnsafeMutableBufferPointer { rbp in
            vvasinh(rbp.baseAddress!, lm.pointer, [numericCast(lm.count)])
        }
        return results
    }
}

// MARK: - Inverse Hyperbolic Cosine

/// - Warning: does not support memory stride (assumes stride is 1).
public func acosh<L: UnsafeMemoryAccessible>(_ lhs: L) -> [Float] where L.Iterator.Element == Float {
    return lhs.withUnsafeMemory { lm in
        precondition(lm.stride == 1, "\(#function) does not support strided memory access")
        var results = [Float](repeating: 0.0, count: numericCast(lhs.count))
        results.withUnsafeMutableBufferPointer { rbp in
            vvacoshf(rbp.baseAddress!, lm.pointer, [numericCast(lm.count)])
        }
        return results
    }
}

/// - Warning: does not support memory stride (assumes stride is 1).
public func acosh<L: UnsafeMemoryAccessible>(_ lhs: L) -> [Double] where L.Iterator.Element == Double {
    return lhs.withUnsafeMemory { lm in
        precondition(lm.stride == 1, "\(#function) does not support strided memory access")
        var results = [Double](repeating: 0.0, count: numericCast(lhs.count))
        results.withUnsafeMutableBufferPointer { rbp in
            vvacosh(rbp.baseAddress!, lm.pointer, [numericCast(lm.count)])
        }
        return results
    }
}

// MARK: - Inverse Hyperbolic Tangent

/// - Warning: does not support memory stride (assumes stride is 1).
public func atanh<L: UnsafeMemoryAccessible>(_ lhs: L) -> [Float] where L.Iterator.Element == Float {
    return lhs.withUnsafeMemory { lm in
        precondition(lm.stride == 1, "\(#function) does not support strided memory access")
        var results = [Float](repeating: 0.0, count: numericCast(lhs.count))
        results.withUnsafeMutableBufferPointer { rbp in
            vvatanhf(rbp.baseAddress!, lm.pointer, [numericCast(lm.count)])
        }
        return results
    }
}

/// - Warning: does not support memory stride (assumes stride is 1).
public func atanh<L: UnsafeMemoryAccessible>(_ lhs: L) -> [Double] where L.Iterator.Element == Double {
    return lhs.withUnsafeMemory { lm in
        precondition(lm.stride == 1, "\(#function) does not support strided memory access")
        var results = [Double](repeating: 0.0, count: numericCast(lhs.count))
        results.withUnsafeMutableBufferPointer { rbp in
            vvatanh(rbp.baseAddress!, lm.pointer, [numericCast(lm.count)])
        }
        return results
    }
}
