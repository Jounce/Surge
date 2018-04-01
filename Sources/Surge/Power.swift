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

// MARK: Power

/// - Warning: does not support memory stride (assumes stride is 1).
public func pow<X: UnsafeMemoryAccessible, Y: UnsafeMemoryAccessible>(_ x: X, _ y: Y) -> [Float] where X.Element == Float, Y.Element == Float {
    return withUnsafeMemory(x, y) { xm, ym in
        precondition(xm.stride == 1 && ym.stride == 1, "\(#function) does not support strided memory access")
        var results = [Float](repeating: 0.0, count: numericCast(xm.count))
        results.withUnsafeMutableBufferPointer { pointer in
            vvpowf(pointer.baseAddress!, xm.pointer, ym.pointer, [numericCast(xm.count)])
        }
        return results
    }
}

/// - Warning: does not support memory stride (assumes stride is 1).
public func pow<X: UnsafeMemoryAccessible, Y: UnsafeMemoryAccessible>(_ x: X, _ y: Y) -> [Double] where X.Element == Double, Y.Element == Double {
    return withUnsafeMemory(x, y) { xm, ym in
        precondition(xm.stride == 1 && ym.stride == 1, "\(#function) does not support strided memory access")
        var results = [Double](repeating: 0.0, count: numericCast(xm.count))
        results.withUnsafeMutableBufferPointer { pointer in
            vvpow(pointer.baseAddress!, xm.pointer, ym.pointer, [numericCast(xm.count)])
        }
        return results
    }
}

public func pow<X: UnsafeMemoryAccessible>(_ x: X, _ y: Float) -> [Float] where X.Element == Float {
    let yVec = [Float](repeating: y, count: numericCast(x.count))
    return pow(yVec, x)
}

public func pow<X: UnsafeMemoryAccessible>(_ x: X, _ y: Double) -> [Double] where X.Element == Double {
    let yVec = [Double](repeating: y, count: numericCast(x.count))
    return pow(yVec, x)
}
