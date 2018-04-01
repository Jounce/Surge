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

// MARK: Exponentiation

/// - Warning: does not support memory stride (assumes stride is 1).
public func exp<X: UnsafeMemoryAccessible>(_ x: X) -> [Float] where X.Element == Float {
    return x.withUnsafeMemory { xm in
        precondition(xm.stride == 1, "\(#function) does not support strided memory access")
        var results = [Float](repeating: 0.0, count: numericCast(x.count))
        results.withUnsafeMutableBufferPointer { rbp in
            vvexpf(rbp.baseAddress!, xm.pointer, [numericCast(xm.count)])
        }
        return results
    }
}

/// - Warning: does not support memory stride (assumes stride is 1).
public func exp<X: UnsafeMemoryAccessible>(_ x: X) -> [Double] where X.Element == Double {
    return x.withUnsafeMemory { xm in
        precondition(xm.stride == 1, "\(#function) does not support strided memory access")
        var results = [Double](repeating: 0.0, count: numericCast(x.count))
        results.withUnsafeMutableBufferPointer { rbp in
            vvexp(rbp.baseAddress!, xm.pointer, [numericCast(xm.count)])
        }
        return results
    }
}

// MARK: Square Exponentiation

/// - Warning: does not support memory stride (assumes stride is 1).
public func exp2<X: UnsafeMemoryAccessible>(_ x: X) -> [Float] where X.Element == Float {
    return x.withUnsafeMemory { xm in
        precondition(xm.stride == 1, "\(#function) does not support strided memory access")
        var results = [Float](repeating: 0.0, count: numericCast(x.count))
        results.withUnsafeMutableBufferPointer { rbp in
            vvexp2f(rbp.baseAddress!, xm.pointer, [numericCast(xm.count)])
        }
        return results
    }
}

/// - Warning: does not support memory stride (assumes stride is 1).
public func exp2<X: UnsafeMemoryAccessible>(_ x: X) -> [Double] where X.Element == Double {
    return x.withUnsafeMemory { xm in
        precondition(xm.stride == 1, "\(#function) does not support strided memory access")
        var results = [Double](repeating: 0.0, count: numericCast(x.count))
        results.withUnsafeMutableBufferPointer { rbp in
            vvexp2(rbp.baseAddress!, xm.pointer, [numericCast(xm.count)])
        }
        return results
    }
}

// MARK: Natural Logarithm

/// - Warning: does not support memory stride (assumes stride is 1).
public func log<X: UnsafeMemoryAccessible>(_ x: X) -> [Float] where X.Element == Float {
    return x.withUnsafeMemory { xm in
        precondition(xm.stride == 1, "\(#function) does not support strided memory access")
        var results = [Float](x)
        results.withUnsafeMutableBufferPointer { rbp in
            vvlogf(rbp.baseAddress!, xm.pointer, [numericCast(xm.count)])
        }
        return results
    }
}

/// - Warning: does not support memory stride (assumes stride is 1).
public func log<X: UnsafeMemoryAccessible>(_ x: X) -> [Double] where X.Element == Double {
    return x.withUnsafeMemory { xm in
        precondition(xm.stride == 1, "\(#function) does not support strided memory access")
        var results = [Double](x)
        results.withUnsafeMutableBufferPointer { rbp in
            vvlog(rbp.baseAddress!, xm.pointer, [numericCast(xm.count)])
        }
        return results
    }
}

// MARK: Base-2 Logarithm

/// - Warning: does not support memory stride (assumes stride is 1).
public func log2<X: UnsafeMemoryAccessible>(_ x: X) -> [Float] where X.Element == Float {
    return x.withUnsafeMemory { xm in
        precondition(xm.stride == 1, "\(#function) does not support strided memory access")
        var results = [Float](x)
        results.withUnsafeMutableBufferPointer { rbp in
            vvlog2f(rbp.baseAddress!, xm.pointer, [numericCast(xm.count)])
        }
        return results
    }
}

/// - Warning: does not support memory stride (assumes stride is 1).
public func log2<X: UnsafeMemoryAccessible>(_ x: X) -> [Double] where X.Element == Double {
    return x.withUnsafeMemory { xm in
        precondition(xm.stride == 1, "\(#function) does not support strided memory access")
        var results = [Double](x)
        results.withUnsafeMutableBufferPointer { rbp in
            vvlog2(rbp.baseAddress!, xm.pointer, [numericCast(xm.count)])
        }
        return results
    }
}

// MARK: Base-10 Logarithm

/// - Warning: does not support memory stride (assumes stride is 1).
public func log10<X: UnsafeMemoryAccessible>(_ x: X) -> [Float] where X.Element == Float {
    return x.withUnsafeMemory { xm in
        precondition(xm.stride == 1, "\(#function) does not support strided memory access")
        var results = [Float](x)
        results.withUnsafeMutableBufferPointer { rbp in
            vvlog10f(rbp.baseAddress!, xm.pointer, [numericCast(xm.count)])
        }
        return results
    }
}

/// - Warning: does not support memory stride (assumes stride is 1).
public func log10<X: UnsafeMemoryAccessible>(_ x: X) -> [Double] where X.Element == Double {
    return x.withUnsafeMemory { xm in
        precondition(xm.stride == 1, "\(#function) does not support strided memory access")
        var results = [Double](x)
        results.withUnsafeMutableBufferPointer { rbp in
            vvlog10(rbp.baseAddress!, xm.pointer, [numericCast(xm.count)])
        }
        return results
    }
}

// MARK: Logarithmic Exponentiation

/// - Warning: does not support memory stride (assumes stride is 1).
public func logb<X: UnsafeMemoryAccessible>(_ x: X) -> [Float] where X.Element == Float {
    return x.withUnsafeMemory { xm in
        precondition(xm.stride == 1, "\(#function) does not support strided memory access")
        var results = [Float](x)
        results.withUnsafeMutableBufferPointer { rbp in
            vvlogbf(rbp.baseAddress!, xm.pointer, [numericCast(xm.count)])
        }
        return results
    }
}

/// - Warning: does not support memory stride (assumes stride is 1).
public func logb<X: UnsafeMemoryAccessible>(_ x: X) -> [Double] where X.Element == Double {
    return x.withUnsafeMemory { xm in
        precondition(xm.stride == 1, "\(#function) does not support strided memory access")
        var results = [Double](x)
        results.withUnsafeMutableBufferPointer { rbp in
            vvlogb(rbp.baseAddress!, xm.pointer, [numericCast(xm.count)])
        }
        return results
    }
}
