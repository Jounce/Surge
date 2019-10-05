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

// MARK: - Absolute Value

/// Elemen-wise absolute value.
///
/// - Warning: does not support memory stride (assumes stride is 1).
public func abs<L>(_ lhs: L) -> [Double] where L: UnsafeMemoryAccessible, L.Element == Double {
    var results = [Double](repeating: 0.0, count: numericCast(lhs.count))
    results.withUnsafeMutableBufferPointer { rbp in
        lhs.withUnsafeMemory { lm in
            precondition(lm.stride == 1, "\(#function) does not support strided memory access")
            vvfabs(rbp.baseAddress!, lm.pointer, [numericCast(lm.count)])
        }
    }
    return results
}

/// Elemen-wise absolute value.
///
/// - Warning: does not support memory stride (assumes stride is 1).
public func abs<L>(_ lhs: L) -> [Float] where L: UnsafeMemoryAccessible, L.Element == Float {
    var results = [Float](repeating: 0.0, count: numericCast(lhs.count))
    results.withUnsafeMutableBufferPointer { rbp in
        lhs.withUnsafeMemory { lm in
            precondition(lm.stride == 1, "\(#function) does not support strided memory access")
            vvfabsf(rbp.baseAddress!, lm.pointer, [numericCast(lm.count)])
        }
    }
    return results
}

// MARK: - Ceiling

/// Elemen-wise ceiling.
///
/// - Warning: does not support memory stride (assumes stride is 1).
public func ceil<L>(_ lhs: L) -> [Float] where L: UnsafeMemoryAccessible, L.Element == Float {
    var results = [Float](repeating: 0.0, count: numericCast(lhs.count))
    results.withUnsafeMutableBufferPointer { rbp in
        lhs.withUnsafeMemory { lm in
            precondition(lm.stride == 1, "\(#function) does not support strided memory access")
            vvceilf(rbp.baseAddress!, lm.pointer, [numericCast(lm.count)])
        }
    }
    return results
}

/// Elemen-wise ceiling.
///
/// - Warning: does not support memory stride (assumes stride is 1).
public func ceil<L>(_ lhs: L) -> [Double] where L: UnsafeMemoryAccessible, L.Element == Double {
    var results = [Double](repeating: 0.0, count: numericCast(lhs.count))
    results.withUnsafeMutableBufferPointer { rbp in
        lhs.withUnsafeMemory { lm in
            precondition(lm.stride == 1, "\(#function) does not support strided memory access")
            vvceil(rbp.baseAddress!, lm.pointer, [numericCast(lm.count)])
        }
    }
    return results
}

// MARK: - Clip

public func clip<L>(_ lhs: L, low: Float, high: Float) -> [Float] where L: UnsafeMemoryAccessible, L.Element == Float {
    var results = [Float](repeating: 0.0, count: numericCast(lhs.count))
    results.withUnsafeMutableBufferPointer { rbp in
        lhs.withUnsafeMemory { lm in
            var y = low
            var z = high
            withUnsafePointers(&y, &z) { y, z in
                vDSP_vclip(lm.pointer, numericCast(lm.stride), y, z, rbp.baseAddress!, 1, numericCast(lm.count))
            }
        }
    }
    return results
}

public func clip<L>(_ lhs: L, low: Double, high: Double) -> [Double] where L: UnsafeMemoryAccessible, L.Element == Double {
    var results = [Double](repeating: 0.0, count: numericCast(lhs.count))
    results.withUnsafeMutableBufferPointer { rbp in
        lhs.withUnsafeMemory { lm in
            var y = low
            var z = high
            withUnsafePointers(&y, &z) { y, z in
                vDSP_vclipD(lm.pointer, numericCast(lm.stride), y, z, rbp.baseAddress!, 1, numericCast(lm.count))
            }
        }
    }
    return results
}

// MARK: - Copy Sign

/// - Warning: does not support memory stride (assumes stride is 1).
public func copysign<S, M>(sign: S, magnitude: M) -> [Float] where S: UnsafeMemoryAccessible, M: UnsafeMemoryAccessible, S.Element == Float, M.Element == Float {
    var results = [Float](repeating: 0.0, count: numericCast(sign.count))
    results.withUnsafeMutableBufferPointer { rbp in
        withUnsafeMemory(sign, magnitude) { sm, mm in
            precondition(sm.stride == 1 && mm.stride == 1, "\(#function) does not support strided memory access")
            vvcopysignf(rbp.baseAddress!, mm.pointer, sm.pointer, [numericCast(sm.count)])
        }
    }
    return results
}

/// - Warning: does not support memory stride (assumes stride is 1).
public func copysign<S, M>(sign: S, magnitude: M) -> [Double] where S: UnsafeMemoryAccessible, M: UnsafeMemoryAccessible, S.Element == Double, M.Element == Double {
    var results = [Double](repeating: 0.0, count: numericCast(sign.count))
    results.withUnsafeMutableBufferPointer { rbp in
        withUnsafeMemory(sign, magnitude) { sm, mm in
            precondition(sm.stride == 1 && mm.stride == 1, "\(#function) does not support strided memory access")
            vvcopysign(rbp.baseAddress!, mm.pointer, sm.pointer, [numericCast(sm.count)])
        }
    }
    return results
}

// MARK: - Floor

/// Elemen-wise floor.
///
/// - Warning: does not support memory stride (assumes stride is 1).
public func floor<L>(_ lhs: L) -> [Float] where L: UnsafeMemoryAccessible, L.Element == Float {
    var results = [Float](repeating: 0.0, count: numericCast(lhs.count))
    results.withUnsafeMutableBufferPointer { rbp in
        lhs.withUnsafeMemory { lm in
            precondition(lm.stride == 1, "\(#function) does not support strided memory access")
            vvfloorf(rbp.baseAddress!, lm.pointer, [numericCast(lm.count)])
        }
    }
    return results
}

/// Elemen-wise floor.
///
/// - Warning: does not support memory stride (assumes stride is 1).
public func floor<L>(_ lhs: L) -> [Double] where L: UnsafeMemoryAccessible, L.Element == Double {
    var results = [Double](repeating: 0.0, count: numericCast(lhs.count))
    results.withUnsafeMutableBufferPointer { rbp in
        lhs.withUnsafeMemory { lm in
            precondition(lm.stride == 1, "\(#function) does not support strided memory access")
            vvfloor(rbp.baseAddress!, lm.pointer, [numericCast(lm.count)])
        }
    }
    return results
}

// MARK: - Negate

public func neg<L>(_ lhs: L) -> [Float] where L: UnsafeMemoryAccessible, L.Element == Float {
    var results = [Float](repeating: 0.0, count: numericCast(lhs.count))
    results.withUnsafeMutableBufferPointer { rbp in
        lhs.withUnsafeMemory { lm in
            vDSP_vneg(lm.pointer, numericCast(lm.stride), rbp.baseAddress!, 1, numericCast(lm.count))
        }
    }
    return results
}

public func neg<L>(_ lhs: L) -> [Double] where L: UnsafeMemoryAccessible, L.Element == Double {
    var results = [Double](repeating: 0.0, count: numericCast(lhs.count))
    results.withUnsafeMutableBufferPointer { rbp in
        lhs.withUnsafeMemory { lm in
            vDSP_vnegD(lm.pointer, numericCast(lm.stride), rbp.baseAddress!, 1, numericCast(lm.count))
        }
    }
    return results
}

// MARK: - Reciprocal

/// - Warning: does not support memory stride (assumes stride is 1).
public func rec<L>(_ lhs: L) -> [Float] where L: UnsafeMemoryAccessible, L.Element == Float {
    var results = [Float](repeating: 0.0, count: numericCast(lhs.count))
    results.withUnsafeMutableBufferPointer { rbp in
        lhs.withUnsafeMemory { lm in
            precondition(lm.stride == 1, "\(#function) does not support strided memory access")
            vvrecf(rbp.baseAddress!, lm.pointer, [numericCast(lm.count)])
        }
    }
    return results
}

/// - Warning: does not support memory stride (assumes stride is 1).
public func rec<L>(_ lhs: L) -> [Double] where L: UnsafeMemoryAccessible, L.Element == Double {
    var results = [Double](repeating: 0.0, count: numericCast(lhs.count))
    results.withUnsafeMutableBufferPointer { rbp in
        lhs.withUnsafeMemory { lm in
            precondition(lm.stride == 1, "\(#function) does not support strided memory access")
            vvrec(rbp.baseAddress!, lm.pointer, [numericCast(lm.count)])
        }
    }
    return results
}

// MARK: - Round

/// - Warning: does not support memory stride (assumes stride is 1).
public func round<L>(_ lhs: L) -> [Float] where L: UnsafeMemoryAccessible, L.Element == Float {
    var results = [Float](repeating: 0.0, count: numericCast(lhs.count))
    results.withUnsafeMutableBufferPointer { rbp in
        lhs.withUnsafeMemory { lm in
            precondition(lm.stride == 1, "\(#function) does not support strided memory access")
            vvnintf(rbp.baseAddress!, lm.pointer, [numericCast(lm.count)])
        }
    }
    return results
}

/// - Warning: does not support memory stride (assumes stride is 1).
public func round<L>(_ lhs: L) -> [Double] where L: UnsafeMemoryAccessible, L.Element == Double {
    var results = [Double](repeating: 0.0, count: numericCast(lhs.count))
    results.withUnsafeMutableBufferPointer { rbp in
        lhs.withUnsafeMemory { lm in
            precondition(lm.stride == 1, "\(#function) does not support strided memory access")
            vvnint(rbp.baseAddress!, lm.pointer, [numericCast(lm.count)])
        }
    }
    return results
}

// MARK: - Threshold

public func threshold<L>(_ lhs: L, low: Float) -> [Float] where L: UnsafeMemoryAccessible, L.Element == Float {
    var results = [Float](repeating: 0.0, count: numericCast(lhs.count))
    results.withUnsafeMutableBufferPointer { rbp in
        lhs.withUnsafeMemory { lm in
            var y = low
            withUnsafePointer(to: &y) { y in
                vDSP_vthr(lm.pointer, numericCast(lm.stride), y, rbp.baseAddress!, 1, numericCast(lm.count))
            }
        }
    }
    return results
}

public func threshold<L>(_ lhs: L, low: Double) -> [Double] where L: UnsafeMemoryAccessible, L.Element == Double {
    var results = [Double](repeating: 0.0, count: numericCast(lhs.count))
    results.withUnsafeMutableBufferPointer { rbp in
        lhs.withUnsafeMemory { lm in
            var y = low
            withUnsafePointer(to: &y) { y in
                vDSP_vthrD(lm.pointer, numericCast(lm.stride), y, rbp.baseAddress!, 1, numericCast(lm.count))
            }
        }
    }
    return results
}

// MARK: - Truncate

/// - Warning: does not support memory stride (assumes stride is 1).
public func trunc<L>(_ lhs: L) -> [Float] where L: UnsafeMemoryAccessible, L.Element == Float {
    var results = [Float](repeating: 0.0, count: numericCast(lhs.count))
    results.withUnsafeMutableBufferPointer { rbp in
        lhs.withUnsafeMemory { lm in
            precondition(lm.stride == 1, "\(#function) does not support strided memory access")
            vvintf(rbp.baseAddress!, lm.pointer, [numericCast(lm.count)])
        }
    }
    return results
}

/// - Warning: does not support memory stride (assumes stride is 1).
public func trunc<L>(_ lhs: L) -> [Double] where L: UnsafeMemoryAccessible, L.Element == Double {
    var results = [Double](repeating: 0.0, count: numericCast(lhs.count))
    results.withUnsafeMutableBufferPointer { rbp in
        lhs.withUnsafeMemory { lm in
            precondition(lm.stride == 1, "\(#function) does not support strided memory access")
            vvint(rbp.baseAddress!, lm.pointer, [numericCast(lm.count)])
        }
    }
    return results
}
