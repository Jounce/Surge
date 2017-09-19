// Copyright (c) 2014–2015 Mattt Thompson (http://mattt.me)
// Copyright (c) 2015-2016 Remy Prechelt
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

// MARK: Convolution

// Convolution of a signal [x], with a kernel [k]. The signal must be at least as long as the kernel.
public func conv(_ x: [Float], _ k: [Float]) -> [Float] {
    precondition(x.count >= k.count, "Input vector [x] must have at least as many elements as the kernel,  [k]")
    
    let resultSize = x.count + k.count - 1
    var result = [Float](repeating: 0, count: resultSize)
    let kEnd = UnsafePointer<Float>(k).advanced(by: k.count - 1)
    let xPad = repeatElement(Float(0.0), count: k.count-1)
    let xPadded = xPad + x + xPad
    vDSP_conv(xPadded, 1, kEnd, -1, &result, 1, vDSP_Length(resultSize), vDSP_Length(k.count))

    return result
}

// Convolution of a signal [x], with a kernel [k]. The signal must be at least as long as the kernel.
public func conv(_ x: [Double], _ k: [Double]) -> [Double] {
    precondition(x.count >= k.count, "Input vector [x] must have at least as many elements as the kernel,  [k]")
    
    let resultSize = x.count + k.count - 1
    var result = [Double](repeating: 0, count: resultSize)
    let kEnd = UnsafePointer<Double>(k).advanced(by: k.count - 1)
    let xPad = repeatElement(Double(0.0), count: k.count-1)
    let xPadded = xPad + x + xPad
    vDSP_convD(xPadded, 1, kEnd, -1, &result, 1, vDSP_Length(resultSize), vDSP_Length(k.count))
    
    return result
}

// MARK: Cross-Correlation

// Cross-correlation of a signal [x], with another signal [y]. The signal [y]
// is padded so that it is the same length as [x].
public func xcorr(_ x: [Float], _ y: [Float]) -> [Float] {
    precondition(x.count >= y.count, "Input vector [x] must have at least as many elements as [y]")
    var yPadded = y
    if x.count > y.count {
        let padding = repeatElement(Float(0.0), count: x.count - y.count)
        yPadded = y + padding
    }
    
    let resultSize = x.count + yPadded.count - 1
    var result = [Float](repeating: 0, count: resultSize)
    let xPad = repeatElement(Float(0.0), count: yPadded.count-1)
    let xPadded = xPad + x + xPad
    vDSP_conv(xPadded, 1, yPadded, 1, &result, 1, vDSP_Length(resultSize), vDSP_Length(yPadded.count))
    
    return result
}

// Cross-correlation of a signal [x], with another signal [y]. The signal [y]
// is padded so that it is the same length as [x].
public func xcorr(_ x: [Double], _ y: [Double]) -> [Double] {
    precondition(x.count >= y.count, "Input vector [x] must have at least as many elements as [y]")
    var yPadded = y
    if x.count > y.count {
        let padding = repeatElement(Double(0.0), count: x.count - y.count)
        yPadded = y + padding
    }
    
    let resultSize = x.count + yPadded.count - 1
    var result = [Double](repeating: 0, count: resultSize)
    let xPad = repeatElement(Double(0.0), count: yPadded.count-1)
    let xPadded = xPad + x + xPad
    vDSP_convD(xPadded, 1, yPadded, 1, &result, 1, vDSP_Length(resultSize), vDSP_Length(yPadded.count))
    
    return result
}

// MARK: Auto-correlation

// Auto-correlation of a signal [x]
public func xcorr(_ x: [Float]) -> [Float] {
    let resultSize = 2*x.count - 1
    var result = [Float](repeating: 0, count: resultSize)
    let xPad = repeatElement(Float(0.0), count: x.count-1)
    let xPadded = xPad + x + xPad
    vDSP_conv(xPadded, 1, x, 1, &result, 1, vDSP_Length(resultSize), vDSP_Length(x.count))
    
    return result
}

// Auto-correlation of a signal [x]
public func xcorr(_ x: [Double]) -> [Double] {
    let resultSize = 2*x.count - 1
    var result = [Double](repeating: 0, count: resultSize)
    let xPad = repeatElement(Double(0.0), count: x.count-1)
    let xPadded = xPad + x + xPad
    vDSP_convD(xPadded, 1, x, 1, &result, 1, vDSP_Length(resultSize), vDSP_Length(x.count))
    
    return result
}
