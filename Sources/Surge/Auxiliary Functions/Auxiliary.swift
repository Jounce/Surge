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
public func abs<L>(_ lhs: L) -> [Float] where L: UnsafeMemoryAccessible, L.Element == Float {
    return withArray(from: lhs) { absInPlace(&$0) }
}

func absInPlace<L>(_ lhs: inout L) where L: UnsafeMutableMemoryAccessible, L.Element == Float {
    withUnsafeMutableMemory(&lhs) { lm in
        precondition(lm.stride == 1, "\(#function) does not support strided memory access")
        vvfabsf(lm.pointer, lm.pointer, [numericCast(lm.count)])
    }
}

/// Elemen-wise absolute value.
///
/// - Warning: does not support memory stride (assumes stride is 1).
public func abs<L>(_ lhs: L) -> [Double] where L: UnsafeMemoryAccessible, L.Element == Double {
    return withArray(from: lhs) { absInPlace(&$0) }
}

func absInPlace<L>(_ lhs: inout L) where L: UnsafeMutableMemoryAccessible, L.Element == Double {
    withUnsafeMutableMemory(&lhs) { lm in
        precondition(lm.stride == 1, "\(#function) does not support strided memory access")
        vvfabs(lm.pointer, lm.pointer, [numericCast(lm.count)])
    }
}

// MARK: - Floor

/// Elemen-wise floor.
///
/// - Warning: does not support memory stride (assumes stride is 1).
public func floor<L>(_ lhs: L) -> [Float] where L: UnsafeMemoryAccessible, L.Element == Float {
    return withArray(from: lhs) { ceilInPlace(&$0) }
}

func floorInPlace<L>(_ lhs: inout L) where L: UnsafeMutableMemoryAccessible, L.Element == Float {
    withUnsafeMutableMemory(&lhs) { lm in
        precondition(lm.stride == 1, "\(#function) does not support strided memory access")
        vvfloorf(lm.pointer, lm.pointer, [numericCast(lm.count)])
    }
}

/// Elemen-wise floor.
///
/// - Warning: does not support memory stride (assumes stride is 1).
public func floor<L>(_ lhs: L) -> [Double] where L: UnsafeMemoryAccessible, L.Element == Double {
    return withArray(from: lhs) { ceilInPlace(&$0) }
}

func floorInPlace<L>(_ lhs: inout L) where L: UnsafeMutableMemoryAccessible, L.Element == Double {
    withUnsafeMutableMemory(&lhs) { lm in
        precondition(lm.stride == 1, "\(#function) does not support strided memory access")
        vvfloor(lm.pointer, lm.pointer, [numericCast(lm.count)])
    }
}

// MARK: - Ceiling

/// Elemen-wise ceiling.
///
/// - Warning: does not support memory stride (assumes stride is 1).
public func ceil<L>(_ lhs: L) -> [Float] where L: UnsafeMemoryAccessible, L.Element == Float {
    return withArray(from: lhs) { ceilInPlace(&$0) }
}

func ceilInPlace<L>(_ lhs: inout L) where L: UnsafeMutableMemoryAccessible, L.Element == Float {
    withUnsafeMutableMemory(&lhs) { lm in
        precondition(lm.stride == 1, "\(#function) does not support strided memory access")
        vvceilf(lm.pointer, lm.pointer, [numericCast(lm.count)])
    }
}

/// Elemen-wise ceiling.
///
/// - Warning: does not support memory stride (assumes stride is 1).
public func ceil<L>(_ lhs: L) -> [Double] where L: UnsafeMemoryAccessible, L.Element == Double {
    return withArray(from: lhs) { ceilInPlace(&$0) }
}

func ceilInPlace<L>(_ lhs: inout L) where L: UnsafeMutableMemoryAccessible, L.Element == Double {
    withUnsafeMutableMemory(&lhs) { lm in
        precondition(lm.stride == 1, "\(#function) does not support strided memory access")
        vvceil(lm.pointer, lm.pointer, [numericCast(lm.count)])
    }
}

// MARK: - Clip

public func clip<L>(_ lhs: L, low: Float, high: Float) -> [Float] where L: UnsafeMemoryAccessible, L.Element == Float {
    return withArray(from: lhs) { clipInPlace(&$0, low: low, high: high) }
}

func clipInPlace<L>(_ lhs: inout L, low: Float, high: Float) where L: UnsafeMutableMemoryAccessible, L.Element == Float {
    withUnsafeMutableMemory(&lhs) { lm in
        precondition(lm.stride == 1, "\(#function) does not support strided memory access")

        var y = low
        var z = high

        vDSP_vclip(lm.pointer, numericCast(lm.stride), &y, &z, lm.pointer, 1, numericCast(lm.count))
    }
}

public func clip<L>(_ lhs: L, low: Double, high: Double) -> [Double] where L: UnsafeMemoryAccessible, L.Element == Double {
    return withArray(from: lhs) { clipInPlace(&$0, low: low, high: high) }
}

func clipInPlace<L>(_ lhs: inout L, low: Double, high: Double) where L: UnsafeMutableMemoryAccessible, L.Element == Double {
    withUnsafeMutableMemory(&lhs) { lm in
        precondition(lm.stride == 1, "\(#function) does not support strided memory access")

        var y = low
        var z = high

        vDSP_vclipD(lm.pointer, numericCast(lm.stride), &y, &z, lm.pointer, 1, numericCast(lm.count))
    }
}

// MARK: - Copy Sign

/// - Warning: does not support memory stride (assumes stride is 1).
public func copysign<S, M>(sign: S, magnitude: M) -> [Float] where S: UnsafeMemoryAccessible, M: UnsafeMemoryAccessible, S.Element == Float, M.Element == Float {
    return withArray(from: magnitude) { copysignInPlace(&$0, sign) }
}

func copysignInPlace<L, R>(_ lhs: inout L, _ rhs: R) where L: UnsafeMutableMemoryAccessible, R: UnsafeMemoryAccessible, L.Element == Float, R.Element == Float {
    withUnsafeMutableMemory(&lhs) { lm in
        withUnsafeMemory(rhs) { rm in
            precondition(lm.stride == 1, "\(#function) does not support strided memory access")
            vvcopysignf(lm.pointer, lm.pointer, rm.pointer, [numericCast(lm.count)])
        }
    }
}

/// - Warning: does not support memory stride (assumes stride is 1).
public func copysign<S, M>(sign: S, magnitude: M) -> [Double] where S: UnsafeMemoryAccessible, M: UnsafeMemoryAccessible, S.Element == Double, M.Element == Double {
    return withArray(from: magnitude) { copysignInPlace(&$0, sign) }
}

func copysignInPlace<L, R>(_ lhs: inout L, _ rhs: R) where L: UnsafeMutableMemoryAccessible, R: UnsafeMemoryAccessible, L.Element == Double, R.Element == Double {
    withUnsafeMutableMemory(&lhs) { lm in
        withUnsafeMemory(rhs) { rm in
            precondition(lm.stride == 1, "\(#function) does not support strided memory access")
            vvcopysign(lm.pointer, lm.pointer, rm.pointer, [numericCast(lm.count)])
        }
    }
}

// MARK: - Negate

public func neg<L>(_ lhs: L) -> [Float] where L: UnsafeMemoryAccessible, L.Element == Float {
    return withArray(from: lhs) { negInPlace(&$0) }
}

func negInPlace<L>(_ lhs: inout L) where L: UnsafeMutableMemoryAccessible, L.Element == Float {
    withUnsafeMutableMemory(&lhs) { lm in
        precondition(lm.stride == 1, "\(#function) does not support strided memory access")
        vDSP_vneg(lm.pointer, numericCast(lm.stride), lm.pointer, 1, numericCast(lm.count))
    }
}

public func neg<L>(_ lhs: L) -> [Double] where L: UnsafeMemoryAccessible, L.Element == Double {
    return withArray(from: lhs) { negInPlace(&$0) }
}

func negInPlace<L>(_ lhs: inout L) where L: UnsafeMutableMemoryAccessible, L.Element == Double {
    withUnsafeMutableMemory(&lhs) { lm in
        precondition(lm.stride == 1, "\(#function) does not support strided memory access")
        vDSP_vnegD(lm.pointer, numericCast(lm.stride), lm.pointer, 1, numericCast(lm.count))
    }
}

// MARK: - Reciprocal

/// - Warning: does not support memory stride (assumes stride is 1).
public func rec<L>(_ lhs: L) -> [Float] where L: UnsafeMemoryAccessible, L.Element == Float {
    return withArray(from: lhs) { recInPlace(&$0) }
}

func recInPlace<L>(_ lhs: inout L) where L: UnsafeMutableMemoryAccessible, L.Element == Float {
    withUnsafeMutableMemory(&lhs) { lm in
        precondition(lm.stride == 1, "\(#function) does not support strided memory access")
        vvrecf(lm.pointer, lm.pointer, [numericCast(lm.count)])
    }
}

/// - Warning: does not support memory stride (assumes stride is 1).
public func rec<L>(_ lhs: L) -> [Double] where L: UnsafeMemoryAccessible, L.Element == Double {
    return withArray(from: lhs) { recInPlace(&$0) }
}

func recInPlace<L>(_ lhs: inout L) where L: UnsafeMutableMemoryAccessible, L.Element == Double {
    withUnsafeMutableMemory(&lhs) { lm in
        precondition(lm.stride == 1, "\(#function) does not support strided memory access")
        vvrec(lm.pointer, lm.pointer, [numericCast(lm.count)])
    }
}

// MARK: - Round

/// - Warning: does not support memory stride (assumes stride is 1).
public func round<L>(_ lhs: L) -> [Float] where L: UnsafeMemoryAccessible, L.Element == Float {
    return withArray(from: lhs) { roundInPlace(&$0) }
}

func roundInPlace<L>(_ lhs: inout L) where L: UnsafeMutableMemoryAccessible, L.Element == Float {
    withUnsafeMutableMemory(&lhs) { lm in
        precondition(lm.stride == 1, "\(#function) does not support strided memory access")
        vvnintf(lm.pointer, lm.pointer, [numericCast(lm.count)])
    }
}

/// - Warning: does not support memory stride (assumes stride is 1).
public func round<L>(_ lhs: L) -> [Double] where L: UnsafeMemoryAccessible, L.Element == Double {
    return withArray(from: lhs) { roundInPlace(&$0) }
}

func roundInPlace<L>(_ lhs: inout L) where L: UnsafeMutableMemoryAccessible, L.Element == Double {
    withUnsafeMutableMemory(&lhs) { lm in
        precondition(lm.stride == 1, "\(#function) does not support strided memory access")
        vvnint(lm.pointer, lm.pointer, [numericCast(lm.count)])
    }
}

// MARK: - Threshold

public func threshold<L>(_ lhs: L, low: Float) -> [Float] where L: UnsafeMemoryAccessible, L.Element == Float {
    return withArray(from: lhs) { roundInPlace(&$0) }
}

func thresholdInPlace<L>(_ lhs: inout L, low: Float) where L: UnsafeMutableMemoryAccessible, L.Element == Float {
    withUnsafeMutableMemory(&lhs) { lm in
        precondition(lm.stride == 1, "\(#function) does not support strided memory access")
        var low = low
        vDSP_vthr(lm.pointer, numericCast(lm.stride), &low, lm.pointer, numericCast(lm.stride), numericCast(lm.count))
    }
}

public func threshold<L>(_ lhs: L, low: Double) -> [Double] where L: UnsafeMemoryAccessible, L.Element == Double {
    return withArray(from: lhs) { roundInPlace(&$0) }
}

func thresholdInPlace<L>(_ lhs: inout L, low: Double) where L: UnsafeMutableMemoryAccessible, L.Element == Double {
    withUnsafeMutableMemory(&lhs) { lm in
        precondition(lm.stride == 1, "\(#function) does not support strided memory access")
        var low = low
        vDSP_vthrD(lm.pointer, numericCast(lm.stride), &low, lm.pointer, numericCast(lm.stride), numericCast(lm.count))
    }
}

// MARK: - Truncate

/// - Warning: does not support memory stride (assumes stride is 1).
public func trunc<L>(_ lhs: L) -> [Float] where L: UnsafeMemoryAccessible, L.Element == Float {
    return withArray(from: lhs) { truncInPlace(&$0) }
}

func truncInPlace<L>(_ lhs: inout L) where L: UnsafeMutableMemoryAccessible, L.Element == Float {
    withUnsafeMutableMemory(&lhs) { lm in
        precondition(lm.stride == 1, "\(#function) does not support strided memory access")
        vvintf(lm.pointer, lm.pointer, [numericCast(lm.count)])
    }
}

/// - Warning: does not support memory stride (assumes stride is 1).
public func trunc<L>(_ lhs: L) -> [Double] where L: UnsafeMemoryAccessible, L.Element == Double {
    return withArray(from: lhs) { truncInPlace(&$0) }
}

func truncInPlace<L>(_ lhs: inout L) where L: UnsafeMutableMemoryAccessible, L.Element == Double {
    withUnsafeMutableMemory(&lhs) { lm in
        precondition(lm.stride == 1, "\(#function) does not support strided memory access")
        vvint(lm.pointer, lm.pointer, [numericCast(lm.count)])
    }
}
