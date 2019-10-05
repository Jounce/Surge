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

// MARK: - Convolution

/// Convolution of a signal [lhs], with a kernel [k]. The signal must be at least as long as the kernel.
public func conv<L, K>(_ lhs: L, _ k: K) -> [Float] where L: UnsafeMemoryAccessible, K: UnsafeMemoryAccessible, L.Element == Float, K.Element == Float {
    precondition(lhs.count >= k.count, "Input vector [lhs] must have at least as many elements as the kernel,  [k]")

    let resultSize = numericCast(lhs.count) + numericCast(k.count) - 1
    var result = [Float](repeating: 0, count: resultSize)
    result.withUnsafeMutableBufferPointer { rbp in
        k.withUnsafeMemory { km in
            let kEnd = km.pointer.advanced(by: km.count * km.stride - 1)
            let xPad = repeatElement(0 as Float, count: km.count - 1)

            var xPadded = [Float]()
            xPadded.reserveCapacity(xPad.count + numericCast(lhs.count) + xPad.count)
            xPadded.append(contentsOf: xPad)
            xPadded.append(contentsOf: lhs)
            xPadded.append(contentsOf: xPad)

            vDSP_conv(xPadded, 1, kEnd, -numericCast(km.stride), rbp.baseAddress!, 1, numericCast(resultSize), numericCast(km.count))
        }
    }
    return result
}

/// Convolution of a signal [lhs], with a kernel [k]. The signal must be at least as long as the kernel.
public func conv<L, K>(_ lhs: L, _ k: K) -> [Double] where L: UnsafeMemoryAccessible, K: UnsafeMemoryAccessible, L.Element == Double, K.Element == Double {
    precondition(lhs.count >= k.count, "Input vector [lhs] must have at least as many elements as the kernel,  [k]")

    let resultSize = numericCast(lhs.count) + numericCast(k.count) - 1
    var result = [Double](repeating: 0, count: resultSize)
    result.withUnsafeMutableBufferPointer { rbp in
        k.withUnsafeMemory { km in
            let kEnd = km.pointer.advanced(by: km.count * km.stride - 1)
            let xPad = repeatElement(0 as Double, count: km.count - 1)

            var xPadded = [Double]()
            xPadded.reserveCapacity(xPad.count + numericCast(lhs.count) + xPad.count)
            xPadded.append(contentsOf: xPad)
            xPadded.append(contentsOf: lhs)
            xPadded.append(contentsOf: xPad)

            vDSP_convD(xPadded, 1, kEnd, -numericCast(km.stride), rbp.baseAddress!, 1, numericCast(resultSize), numericCast(km.count))
        }
    }
    return result
}

// MARK: - Cross-Correlation

/// Cross-correlation of a signal [lhs], with another signal [rhs]. The signal [rhs]
/// is padded so that it is the same length as [lhs].
public func xcorr<L, R>(_ lhs: L, _ rhs: R) -> [Float] where L: UnsafeMemoryAccessible, R: UnsafeMemoryAccessible, L.Element == Float, R.Element == Float {
    precondition(lhs.count >= rhs.count, "Input vector [lhs] must have at least as many elements as [rhs]")
    var yPadded = [Float](rhs)
    if lhs.count > rhs.count {
        let padding = repeatElement(0 as Float, count: numericCast(lhs.count) - numericCast(rhs.count))
        yPadded.append(contentsOf: padding)
    }

    let resultSize = numericCast(lhs.count) + yPadded.count - 1
    var result = [Float](repeating: 0, count: resultSize)
    let xPad = repeatElement(0 as Float, count: yPadded.count - 1)

    var xPadded = [Float]()
    xPadded.reserveCapacity(xPad.count + numericCast(lhs.count) + xPad.count)
    xPadded.append(contentsOf: xPad)
    xPadded.append(contentsOf: lhs)
    xPadded.append(contentsOf: xPad)

    result.withUnsafeMutableBufferPointer { rbp in
        vDSP_conv(xPadded, 1, yPadded, 1, rbp.baseAddress!, 1, numericCast(resultSize), numericCast(yPadded.count))
    }

    return result
}

/// Cross-correlation of a signal [lhs], with another signal [rhs]. The signal [rhs]
/// is padded so that it is the same length as [lhs].
public func xcorr<L, R>(_ lhs: L, _ rhs: R) -> [Double] where L: UnsafeMemoryAccessible, R: UnsafeMemoryAccessible, L.Element == Double, R.Element == Double {
    precondition(lhs.count >= rhs.count, "Input vector [lhs] must have at least as many elements as [rhs]")
    var yPadded = [Double](rhs)
    if lhs.count > rhs.count {
        let padding = repeatElement(0 as Double, count: numericCast(lhs.count) - numericCast(rhs.count))
        yPadded.append(contentsOf: padding)
    }

    let resultSize = numericCast(lhs.count) + yPadded.count - 1
    var result = [Double](repeating: 0, count: resultSize)
    let xPad = repeatElement(0 as Double, count: yPadded.count - 1)

    var xPadded = [Double]()
    xPadded.reserveCapacity(xPad.count + numericCast(lhs.count) + xPad.count)
    xPadded.append(contentsOf: xPad)
    xPadded.append(contentsOf: lhs)
    xPadded.append(contentsOf: xPad)

    result.withUnsafeMutableBufferPointer { rbp in
        vDSP_convD(xPadded, 1, yPadded, 1, rbp.baseAddress!, 1, numericCast(resultSize), numericCast(yPadded.count))
    }

    return result
}

// MARK: - Auto-correlation

/// Auto-correlation of a signal [lhs]
public func xcorr<L>(_ lhs: L) -> [Float] where L: UnsafeMemoryAccessible, L.Element == Float {
    let resultSize = 2 * numericCast(lhs.count) - 1
    var result = [Float](repeating: 0, count: resultSize)
    let xPad = repeatElement(0 as Float, count: numericCast(lhs.count) - 1)

    var xPadded = [Float]()
    xPadded.reserveCapacity(xPad.count + numericCast(lhs.count) + xPad.count)
    xPadded.append(contentsOf: xPad)
    xPadded.append(contentsOf: lhs)
    xPadded.append(contentsOf: xPad)

    lhs.withUnsafeMemory { lm in
        result.withUnsafeMutableBufferPointer { rbp in
            vDSP_conv(xPadded, 1, lm.pointer, numericCast(lm.stride), rbp.baseAddress!, 1, numericCast(resultSize), numericCast(lm.count))
        }
    }

    return result
}

/// Auto-correlation of a signal [lhs]
public func xcorr<L>(_ lhs: L) -> [Double] where L: UnsafeMemoryAccessible, L.Element == Double {
    let resultSize = 2 * numericCast(lhs.count) - 1
    var result = [Double](repeating: 0, count: resultSize)
    let xPad = repeatElement(0 as Double, count: numericCast(lhs.count) - 1)

    var xPadded = [Double]()
    xPadded.reserveCapacity(xPad.count + numericCast(lhs.count) + xPad.count)
    xPadded.append(contentsOf: xPad)
    xPadded.append(contentsOf: lhs)
    xPadded.append(contentsOf: xPad)

    lhs.withUnsafeMemory { lm in
        result.withUnsafeMutableBufferPointer { rbp in
            vDSP_convD(xPadded, 1, lm.pointer, numericCast(lm.stride), rbp.baseAddress!, 1, numericCast(resultSize), numericCast(lm.count))
        }
    }

    return result
}
