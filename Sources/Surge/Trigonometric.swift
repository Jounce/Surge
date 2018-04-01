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

// MARK: Sine-Cosine

/// - Warning: does not support memory stride (assumes stride is 1).
public func sincos<X: UnsafeMemoryAccessible>(_ x: X) -> (sin: [Float], cos: [Float]) where X.Element == Float {
    return withUnsafeMemory(x) { xm in
        precondition(xm.stride == 1, "\(#function) does not support strided memory access")
        var sin = [Float](repeating: 0.0, count: numericCast(xm.count))
        var cos = [Float](repeating: 0.0, count: numericCast(xm.count))
        withUnsafeMutableMemory(&sin, &cos) { sinm, cosm in
            vvsincosf(sinm.pointer, cosm.pointer, xm.pointer, [numericCast(xm.count)])
        }
        return (sin, cos)
    }
}

/// - Warning: does not support memory stride (assumes stride is 1).
public func sincos<X: UnsafeMemoryAccessible>(_ x: X) -> (sin: [Double], cos: [Double]) where X.Element == Double {
    return withUnsafeMemory(x) { xm in
        precondition(xm.stride == 1, "\(#function) does not support strided memory access")
        var sin = [Double](repeating: 0.0, count: numericCast(xm.count))
        var cos = [Double](repeating: 0.0, count: numericCast(xm.count))
        withUnsafeMutableMemory(&sin, &cos) { sinm, cosm in
            vvsincos(sinm.pointer, cosm.pointer, xm.pointer, [numericCast(xm.count)])
        }
        return (sin, cos)
    }
}

// MARK: Sine

/// - Warning: does not support memory stride (assumes stride is 1).
public func sin<X: UnsafeMemoryAccessible>(_ x: X) -> [Float] where X.Element == Float {
    return withUnsafeMemory(x) { xm in
        precondition(xm.stride == 1, "\(#function) does not support strided memory access")
        var results = [Float](repeating: 0.0, count: numericCast(xm.count))
        results.withUnsafeMutableBufferPointer { pointer in
            vvsinf(pointer.baseAddress!, xm.pointer, [numericCast(xm.count)])
        }
        return results
    }
}

/// - Warning: does not support memory stride (assumes stride is 1).
public func sin<X: UnsafeMemoryAccessible>(_ x: X) -> [Double] where X.Element == Double {
    return withUnsafeMemory(x) { xm in
        precondition(xm.stride == 1, "\(#function) does not support strided memory access")
        var results = [Double](repeating: 0.0, count: numericCast(xm.count))
        results.withUnsafeMutableBufferPointer { pointer in
            vvsin(pointer.baseAddress!, xm.pointer, [numericCast(xm.count)])
        }
        return results
    }
}

// MARK: Cosine

/// - Warning: does not support memory stride (assumes stride is 1).
public func cos<X: UnsafeMemoryAccessible>(_ x: X) -> [Float] where X.Element == Float {
    return withUnsafeMemory(x) { xm in
        precondition(xm.stride == 1, "\(#function) does not support strided memory access")
        var results = [Float](repeating: 0.0, count: numericCast(xm.count))
        results.withUnsafeMutableBufferPointer { pointer in
            vvcosf(pointer.baseAddress!, xm.pointer, [numericCast(xm.count)])
        }
        return results
    }
}

/// - Warning: does not support memory stride (assumes stride is 1).
public func cos<X: UnsafeMemoryAccessible>(_ x: X) -> [Double] where X.Element == Double {
    return withUnsafeMemory(x) { xm in
        precondition(xm.stride == 1, "\(#function) does not support strided memory access")
        var results = [Double](repeating: 0.0, count: numericCast(xm.count))
        results.withUnsafeMutableBufferPointer { pointer in
            vvcos(pointer.baseAddress!, xm.pointer, [numericCast(xm.count)])
        }
        return results
    }
}

// MARK: Tangent

/// - Warning: does not support memory stride (assumes stride is 1).
public func tan<X: UnsafeMemoryAccessible>(_ x: X) -> [Float] where X.Element == Float {
    return withUnsafeMemory(x) { xm in
        precondition(xm.stride == 1, "\(#function) does not support strided memory access")
    var results = [Float](repeating: 0.0, count: numericCast(xm.count))
        results.withUnsafeMutableBufferPointer { pointer in
            vvtanf(pointer.baseAddress!, xm.pointer, [numericCast(xm.count)])
        }
        return results
    }
}

/// - Warning: does not support memory stride (assumes stride is 1).
public func tan<X: UnsafeMemoryAccessible>(_ x: X) -> [Double] where X.Element == Double {
    return withUnsafeMemory(x) { xm in
        precondition(xm.stride == 1, "\(#function) does not support strided memory access")
        var results = [Double](repeating: 0.0, count: numericCast(xm.count))
        results.withUnsafeMutableBufferPointer { pointer in
            vvtan(pointer.baseAddress!, xm.pointer, [numericCast(xm.count)])
        }
        return results
    }
}

// MARK: Arcsine

/// - Warning: does not support memory stride (assumes stride is 1).
public func asin<X: UnsafeMemoryAccessible>(_ x: X) -> [Float] where X.Element == Float {
    return withUnsafeMemory(x) { xm in
        precondition(xm.stride == 1, "\(#function) does not support strided memory access")
        var results = [Float](repeating: 0.0, count: numericCast(xm.count))
        results.withUnsafeMutableBufferPointer { pointer in
            vvasinf(pointer.baseAddress!, xm.pointer, [numericCast(xm.count)])
        }
        return results
    }
}

/// - Warning: does not support memory stride (assumes stride is 1).
public func asin<X: UnsafeMemoryAccessible>(_ x: X) -> [Double] where X.Element == Double {
    return withUnsafeMemory(x) { xm in
        precondition(xm.stride == 1, "\(#function) does not support strided memory access")
        var results = [Double](repeating: 0.0, count: numericCast(xm.count))
        results.withUnsafeMutableBufferPointer { pointer in
            vvasin(pointer.baseAddress!, xm.pointer, [numericCast(xm.count)])
        }
        return results
    }
}

// MARK: Arccosine

/// - Warning: does not support memory stride (assumes stride is 1).
public func acos<X: UnsafeMemoryAccessible>(_ x: X) -> [Float] where X.Element == Float {
    return withUnsafeMemory(x) { xm in
        precondition(xm.stride == 1, "\(#function) does not support strided memory access")
        var results = [Float](repeating: 0.0, count: numericCast(xm.count))
        results.withUnsafeMutableBufferPointer { pointer in
            vvacosf(pointer.baseAddress!, xm.pointer, [numericCast(xm.count)])
        }
        return results
    }
}

/// - Warning: does not support memory stride (assumes stride is 1).
public func acos<X: UnsafeMemoryAccessible>(_ x: X) -> [Double] where X.Element == Double {
    return withUnsafeMemory(x) { xm in
        precondition(xm.stride == 1, "\(#function) does not support strided memory access")
        var results = [Double](repeating: 0.0, count: numericCast(xm.count))
        results.withUnsafeMutableBufferPointer { pointer in
            vvacos(pointer.baseAddress!, xm.pointer, [numericCast(xm.count)])
        }
        return results
    }
}

// MARK: Arctangent

/// - Warning: does not support memory stride (assumes stride is 1).
public func atan<X: UnsafeMemoryAccessible>(_ x: X) -> [Float] where X.Element == Float {
    return withUnsafeMemory(x) { xm in
        precondition(xm.stride == 1, "\(#function) does not support strided memory access")
        var results = [Float](repeating: 0.0, count: numericCast(xm.count))
        results.withUnsafeMutableBufferPointer { pointer in
            vvatanf(pointer.baseAddress!, xm.pointer, [numericCast(xm.count)])
        }
        return results
    }
}

/// - Warning: does not support memory stride (assumes stride is 1).
public func atan<X: UnsafeMemoryAccessible>(_ x: X) -> [Double] where X.Element == Double {
    return withUnsafeMemory(x) { xm in
        precondition(xm.stride == 1, "\(#function) does not support strided memory access")
        var results = [Double](repeating: 0.0, count: numericCast(xm.count))
        results.withUnsafeMutableBufferPointer { pointer in
            vvatan(pointer.baseAddress!, xm.pointer, [numericCast(xm.count)])
        }
        return results
    }
}

// MARK: -

// MARK: Radians to Degrees

/// - Warning: does not support memory stride (assumes stride is 1).
func rad2deg<X: UnsafeMemoryAccessible>(_ x: X) -> [Float] where X.Element == Float {
    return withUnsafeMemory(x) { xm in
        precondition(xm.stride == 1, "\(#function) does not support strided memory access")
        var results = [Float](repeating: 0.0, count: numericCast(xm.count))
        let divisor = [Float](repeating: Float.pi / 180.0, count: numericCast(xm.count))
        results.withUnsafeMutableBufferPointer { pointer in
            vvdivf(pointer.baseAddress!, xm.pointer, divisor, [numericCast(xm.count)])
        }
        return results
    }
}

/// - Warning: does not support memory stride (assumes stride is 1).
func rad2deg<X: UnsafeMemoryAccessible>(_ x: X) -> [Double] where X.Element == Double {
    return withUnsafeMemory(x) { xm in
        precondition(xm.stride == 1, "\(#function) does not support strided memory access")
        var results = [Double](repeating: 0.0, count: numericCast(xm.count))
        let divisor = [Double](repeating: Double.pi / 180.0, count: numericCast(xm.count))
        results.withUnsafeMutableBufferPointer { pointer in
            vvdiv(pointer.baseAddress!, xm.pointer, divisor, [numericCast(xm.count)])
        }
        return results
    }
}

// MARK: Degrees to Radians

/// - Warning: does not support memory stride (assumes stride is 1).
func deg2rad<X: UnsafeMemoryAccessible>(_ x: X) -> [Float] where X.Element == Float {
    return withUnsafeMemory(x) { xm in
        precondition(xm.stride == 1, "\(#function) does not support strided memory access")
        var results = [Float](repeating: 0.0, count: numericCast(xm.count))
        let divisor = [Float](repeating: 180.0 / Float.pi, count: numericCast(xm.count))
        results.withUnsafeMutableBufferPointer { pointer in
            vvdivf(pointer.baseAddress!, xm.pointer, divisor, [numericCast(xm.count)])
        }
        return results
    }
}

/// - Warning: does not support memory stride (assumes stride is 1).
func deg2rad<X: UnsafeMemoryAccessible>(_ x: X) -> [Double] where X.Element == Double {
    return withUnsafeMemory(x) { xm in
        precondition(xm.stride == 1, "\(#function) does not support strided memory access")
        var results = [Double](repeating: 0.0, count: numericCast(xm.count))
        let divisor = [Double](repeating: 180.0 / Double.pi, count: numericCast(xm.count))
        results.withUnsafeMutableBufferPointer { pointer in
            vvdiv(pointer.baseAddress!, xm.pointer, divisor, [numericCast(xm.count)])
        }
        return results
    }
}
