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

// MARK: Absolute Value

/// Elemen-wise absolute value.
///
/// - Warning: does not support memory stride (assumes stride is 1).
public func abs<C: UnsafeMemoryAccessible>(_ x: C) -> [Double] where C.Element == Double {
    var results = [Double](repeating: 0.0, count: numericCast(x.count))
    results.withUnsafeMutableBufferPointer { rbp in
        x.withUnsafeMemory { xm in
            precondition(xm.stride == 1, "\(#function) does not support strided memory access")
            vvfabs(rbp.baseAddress!, xm.pointer, [numericCast(xm.count)])
        }
    }
    return results
}

/// Elemen-wise absolute value.
///
/// - Warning: does not support memory stride (assumes stride is 1).
public func abs<C: UnsafeMemoryAccessible>(_ x: C) -> [Float] where C.Element == Float {
    var results = [Float](repeating: 0.0, count: numericCast(x.count))
    results.withUnsafeMutableBufferPointer { rbp in
        x.withUnsafeMemory { xm in
            precondition(xm.stride == 1, "\(#function) does not support strided memory access")
            vvfabsf(rbp.baseAddress!, xm.pointer, [numericCast(xm.count)])
        }
    }
    return results
}

// MARK: Ceiling

/// Elemen-wise ceiling.
///
/// - Warning: does not support memory stride (assumes stride is 1).
public func ceil<C: UnsafeMemoryAccessible>(_ x: C) -> [Float] where C.Element == Float {
    var results = [Float](repeating: 0.0, count: numericCast(x.count))
    results.withUnsafeMutableBufferPointer { rbp in
        x.withUnsafeMemory { xm in
            precondition(xm.stride == 1, "\(#function) does not support strided memory access")
            vvceilf(rbp.baseAddress!, xm.pointer, [numericCast(xm.count)])
        }
    }
    return results
}

/// Elemen-wise ceiling.
///
/// - Warning: does not support memory stride (assumes stride is 1).
public func ceil<C: UnsafeMemoryAccessible>(_ x: C) -> [Double] where C.Element == Double {
    var results = [Double](repeating: 0.0, count: numericCast(x.count))
    results.withUnsafeMutableBufferPointer { rbp in
        x.withUnsafeMemory { xm in
            precondition(xm.stride == 1, "\(#function) does not support strided memory access")
            vvceil(rbp.baseAddress!, xm.pointer, [numericCast(xm.count)])
        }
    }
    return results
}

// MARK: Clip

public func clip<C: UnsafeMemoryAccessible>(_ x: C, low: Float, high: Float) -> [Float] where C.Element == Float {
    var results = [Float](repeating: 0.0, count: numericCast(x.count))
    results.withUnsafeMutableBufferPointer { rbp in
        x.withUnsafeMemory { xm in
            var y = low
            var z = high
            withUnsafePointers(&y, &z) { y, z in
                vDSP_vclip(xm.pointer, xm.stride, y, z, rbp.baseAddress!, 1, numericCast(xm.count))
            }
        }
    }
    return results
}

public func clip<C: UnsafeMemoryAccessible>(_ x: C, low: Double, high: Double) -> [Double] where C.Element == Double {
    var results = [Double](repeating: 0.0, count: numericCast(x.count))
    results.withUnsafeMutableBufferPointer { rbp in
        x.withUnsafeMemory { xm in
            var y = low
            var z = high
            withUnsafePointers(&y, &z) { y, z in
                vDSP_vclipD(xm.pointer, xm.stride, y, z, rbp.baseAddress!, 1, numericCast(xm.count))
            }
        }
    }
    return results
}

// MARK: Copy Sign

/// - Warning: does not support memory stride (assumes stride is 1).
public func copysign<S: UnsafeMemoryAccessible, M: UnsafeMemoryAccessible>(sign: S, magnitude: M) -> [Float] where S.Element == Float, M.Element == Float {
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
public func copysign<S: UnsafeMemoryAccessible, M: UnsafeMemoryAccessible>(sign: S, magnitude: M) -> [Double] where S.Element == Double, M.Element == Double {
    var results = [Double](repeating: 0.0, count: numericCast(sign.count))
    results.withUnsafeMutableBufferPointer { rbp in
        withUnsafeMemory(sign, magnitude) { sm, mm in
            precondition(sm.stride == 1 && mm.stride == 1, "\(#function) does not support strided memory access")
            vvcopysign(rbp.baseAddress!, mm.pointer, sm.pointer, [numericCast(sm.count)])
        }
    }
    return results
}

// MARK: Floor

/// Elemen-wise floor.
///
/// - Warning: does not support memory stride (assumes stride is 1).
public func floor<C: UnsafeMemoryAccessible>(_ x: C) -> [Float] where C.Element == Float {
    var results = [Float](repeating: 0.0, count: numericCast(x.count))
    results.withUnsafeMutableBufferPointer { rbp in
        x.withUnsafeMemory { xm in
            precondition(xm.stride == 1, "\(#function) does not support strided memory access")
            vvfloorf(rbp.baseAddress!, xm.pointer, [numericCast(xm.count)])
        }
    }
    return results
}

/// Elemen-wise floor.
///
/// - Warning: does not support memory stride (assumes stride is 1).
public func floor<C: UnsafeMemoryAccessible>(_ x: C) -> [Double] where C.Element == Double {
    var results = [Double](repeating: 0.0, count: numericCast(x.count))
    results.withUnsafeMutableBufferPointer { rbp in
        x.withUnsafeMemory { xm in
            precondition(xm.stride == 1, "\(#function) does not support strided memory access")
            vvfloor(rbp.baseAddress!, xm.pointer, [numericCast(xm.count)])
        }
    }
    return results
}

// MARK: Negate

public func neg<C: UnsafeMemoryAccessible>(_ x: C) -> [Float] where C.Element == Float {
    var results = [Float](repeating: 0.0, count: numericCast(x.count))
    results.withUnsafeMutableBufferPointer { rbp in
        x.withUnsafeMemory { xm in
            vDSP_vneg(xm.pointer, xm.stride, rbp.baseAddress!, 1, numericCast(xm.count))
        }
    }
    return results
}

public func neg<C: UnsafeMemoryAccessible>(_ x: C) -> [Double] where C.Element == Double {
    var results = [Double](repeating: 0.0, count: numericCast(x.count))
    results.withUnsafeMutableBufferPointer { rbp in
        x.withUnsafeMemory { xm in
            vDSP_vnegD(xm.pointer, xm.stride, rbp.baseAddress!, 1, numericCast(xm.count))
        }
    }
    return results
}

// MARK: Reciprocal

/// - Warning: does not support memory stride (assumes stride is 1).
public func rec<C: UnsafeMemoryAccessible>(_ x: C) -> [Float] where C.Element == Float {
    var results = [Float](repeating: 0.0, count: numericCast(x.count))
    results.withUnsafeMutableBufferPointer { rbp in
        x.withUnsafeMemory { xm in
            precondition(xm.stride == 1, "\(#function) does not support strided memory access")
            vvrecf(rbp.baseAddress!, xm.pointer, [numericCast(xm.count)])
        }
    }
    return results
}

/// - Warning: does not support memory stride (assumes stride is 1).
public func rec<C: UnsafeMemoryAccessible>(_ x: C) -> [Double] where C.Element == Double {
    var results = [Double](repeating: 0.0, count: numericCast(x.count))
    results.withUnsafeMutableBufferPointer { rbp in
        x.withUnsafeMemory { xm in
            precondition(xm.stride == 1, "\(#function) does not support strided memory access")
            vvrec(rbp.baseAddress!, xm.pointer, [numericCast(xm.count)])
        }
    }
    return results
}

// MARK: Round

/// - Warning: does not support memory stride (assumes stride is 1).
public func round<C: UnsafeMemoryAccessible>(_ x: C) -> [Float] where C.Element == Float {
    var results = [Float](repeating: 0.0, count: numericCast(x.count))
    results.withUnsafeMutableBufferPointer { rbp in
        x.withUnsafeMemory { xm in
            precondition(xm.stride == 1, "\(#function) does not support strided memory access")
            vvnintf(rbp.baseAddress!, xm.pointer, [numericCast(xm.count)])
        }
    }
    return results
}

/// - Warning: does not support memory stride (assumes stride is 1).
public func round<C: UnsafeMemoryAccessible>(_ x: C) -> [Double] where C.Element == Double {
    var results = [Double](repeating: 0.0, count: numericCast(x.count))
    results.withUnsafeMutableBufferPointer { rbp in
        x.withUnsafeMemory { xm in
            precondition(xm.stride == 1, "\(#function) does not support strided memory access")
            vvnint(rbp.baseAddress!, xm.pointer, [numericCast(xm.count)])
        }
    }
    return results
}

// MARK: Threshold

public func threshold<C: UnsafeMemoryAccessible>(_ x: C, low: Float) -> [Float] where C.Element == Float {
    var results = [Float](repeating: 0.0, count: numericCast(x.count))
    results.withUnsafeMutableBufferPointer { rbp in
        x.withUnsafeMemory { xm in
            var y = low
            withUnsafePointer(to: &y) { y in
                vDSP_vthr(xm.pointer, xm.stride, y, rbp.baseAddress!, 1, numericCast(xm.count))
            }
        }
    }
    return results
}

public func threshold<C: UnsafeMemoryAccessible>(_ x: C, low: Double) -> [Double] where C.Element == Double {
    var results = [Double](repeating: 0.0, count: numericCast(x.count))
    results.withUnsafeMutableBufferPointer { rbp in
        x.withUnsafeMemory { xm in
            var y = low
            withUnsafePointer(to: &y) { y in
                vDSP_vthrD(xm.pointer, xm.stride, y, rbp.baseAddress!, 1, numericCast(xm.count))
            }
        }
    }
    return results
}

// MARK: Truncate

/// - Warning: does not support memory stride (assumes stride is 1).
public func trunc<C: UnsafeMemoryAccessible>(_ x: C) -> [Float] where C.Element == Float {
    var results = [Float](repeating: 0.0, count: numericCast(x.count))
    results.withUnsafeMutableBufferPointer { rbp in
        x.withUnsafeMemory { xm in
            precondition(xm.stride == 1, "\(#function) does not support strided memory access")
            vvintf(rbp.baseAddress!, xm.pointer, [numericCast(xm.count)])
        }
    }
    return results
}

/// - Warning: does not support memory stride (assumes stride is 1).
public func trunc<C: UnsafeMemoryAccessible>(_ x: C) -> [Double] where C.Element == Double {
    var results = [Double](repeating: 0.0, count: numericCast(x.count))
    results.withUnsafeMutableBufferPointer { rbp in
        x.withUnsafeMemory { xm in
            precondition(xm.stride == 1, "\(#function) does not support strided memory access")
            vvint(rbp.baseAddress!, xm.pointer, [numericCast(xm.count)])
        }
    }
    return results
}
