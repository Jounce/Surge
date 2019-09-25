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

// MARK: - Base-e Logarithm

/// - Warning: does not support memory stride (assumes stride is 1).
public func log<L: UnsafeMemoryAccessible>(_ lhs: L) -> [Float] where L.Element == Float {
    var results = Array(lhs)
    logInPlace(&results)
    return results
}

/// - Warning: does not support memory stride (assumes stride is 1).
public func log<L: UnsafeMemoryAccessible>(_ lhs: L) -> [Double] where L.Element == Double {
    var results = Array(lhs)
    logInPlace(&results)
    return results
}

// MARK: - Base-e Logarithm: In Place

/// - Warning: does not support memory stride (assumes stride is 1).
func logInPlace<L: UnsafeMutableMemoryAccessible>(_ lhs: inout L) where L.Element == Float {
    withUnsafeMutableMemory(&lhs) { lm in
        precondition(lm.stride == 1, "\(#function) does not support strided memory access")
        var elementCount: Int32 = numericCast(lm.count)
        vvlogf(lm.pointer, lm.pointer, &elementCount)
    }
}

/// - Warning: does not support memory stride (assumes stride is 1).
func logInPlace<L: UnsafeMutableMemoryAccessible>(_ lhs: inout L) where L.Element == Double {
    withUnsafeMutableMemory(&lhs) { lm in
        precondition(lm.stride == 1, "\(#function) does not support strided memory access")
        var elementCount: Int32 = numericCast(lm.count)
        vvlog(lm.pointer, lm.pointer, &elementCount)
    }
}

// MARK: - Base-2 Logarithm

/// - Warning: does not support memory stride (assumes stride is 1).
public func log2<L: UnsafeMemoryAccessible>(_ lhs: L) -> [Float] where L.Element == Float {
    var results = Array(lhs)
    log2InPlace(&results)
    return results
}

/// - Warning: does not support memory stride (assumes stride is 1).
public func log2<L: UnsafeMemoryAccessible>(_ lhs: L) -> [Double] where L.Element == Double {
    var results = Array(lhs)
    log2InPlace(&results)
    return results
}

// MARK: - Base-2 Logarithm: In Place

/// - Warning: does not support memory stride (assumes stride is 1).
func log2InPlace<L: UnsafeMutableMemoryAccessible>(_ lhs: inout L) where L.Element == Float {
    withUnsafeMutableMemory(&lhs) { lm in
        precondition(lm.stride == 1, "\(#function) does not support strided memory access")
        var elementCount: Int32 = numericCast(lm.count)
        vvlog2f(lm.pointer, lm.pointer, &elementCount)
    }
}

/// - Warning: does not support memory stride (assumes stride is 1).
func log2InPlace<L: UnsafeMutableMemoryAccessible>(_ lhs: inout L) where L.Element == Double {
    withUnsafeMutableMemory(&lhs) { lm in
        precondition(lm.stride == 1, "\(#function) does not support strided memory access")
        var elementCount: Int32 = numericCast(lm.count)
        vvlog2(lm.pointer, lm.pointer, &elementCount)
    }
}

// MARK: - Base-10 Logarithm

/// - Warning: does not support memory stride (assumes stride is 1).
public func log10<L: UnsafeMemoryAccessible>(_ lhs: L) -> [Float] where L.Element == Float {
    var results = Array(lhs)
    log10InPlace(&results)
    return results
}

/// - Warning: does not support memory stride (assumes stride is 1).
public func log10<L: UnsafeMemoryAccessible>(_ lhs: L) -> [Double] where L.Element == Double {
    var results = Array(lhs)
    log10InPlace(&results)
    return results
}

// MARK: - Base-10 Logarithm: In Place

/// - Warning: does not support memory stride (assumes stride is 1).
func log10InPlace<L: UnsafeMutableMemoryAccessible>(_ lhs: inout L) where L.Element == Float {
    withUnsafeMutableMemory(&lhs) { lm in
        precondition(lm.stride == 1, "\(#function) does not support strided memory access")
        var elementCount: Int32 = numericCast(lm.count)
        vvlog10f(lm.pointer, lm.pointer, &elementCount)
    }
}

/// - Warning: does not support memory stride (assumes stride is 1).
func log10InPlace<L: UnsafeMutableMemoryAccessible>(_ lhs: inout L) where L.Element == Double {
    withUnsafeMutableMemory(&lhs) { lm in
        precondition(lm.stride == 1, "\(#function) does not support strided memory access")
        var elementCount: Int32 = numericCast(lm.count)
        vvlog10(lm.pointer, lm.pointer, &elementCount)
    }
}

// MARK: - Logarithmic Exponentiation

/// - Warning: does not support memory stride (assumes stride is 1).
public func logb<L: UnsafeMemoryAccessible>(_ lhs: L) -> [Float] where L.Element == Float {
    var results = Array(lhs)
    logbInPlace(&results)
    return results
}

/// - Warning: does not support memory stride (assumes stride is 1).
public func logb<L: UnsafeMemoryAccessible>(_ lhs: L) -> [Double] where L.Element == Double {
    var results = Array(lhs)
    logbInPlace(&results)
    return results
}

// MARK: - Base-B Logarithm: In Place

/// - Warning: does not support memory stride (assumes stride is 1).
func logbInPlace<L: UnsafeMutableMemoryAccessible>(_ lhs: inout L) where L.Element == Float {
    withUnsafeMutableMemory(&lhs) { lm in
        precondition(lm.stride == 1, "\(#function) does not support strided memory access")
        var elementCount: Int32 = numericCast(lm.count)
        vvlogbf(lm.pointer, lm.pointer, &elementCount)
    }
}

/// - Warning: does not support memory stride (assumes stride is 1).
func logbInPlace<L: UnsafeMutableMemoryAccessible>(_ lhs: inout L) where L.Element == Double {
    withUnsafeMutableMemory(&lhs) { lm in
        precondition(lm.stride == 1, "\(#function) does not support strided memory access")
        var elementCount: Int32 = numericCast(lm.count)
        vvlogb(lm.pointer, lm.pointer, &elementCount)
    }
}
