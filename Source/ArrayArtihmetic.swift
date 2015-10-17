// Copyright © 2015 Venture Media Labs.
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

public func realPointer<T: RealType>(array: [T]) -> UnsafePointer<Real> {
    return array.withUnsafeBufferPointer{ UnsafePointer<Real>(UnsafePointer<Void>($0.baseAddress)) }
}

public func mutableRealPointer<T: RealType>(inout array: [T]) -> UnsafeMutablePointer<Real> {
    return UnsafeMutablePointer<Real>(realPointer(array))
}

public func sum(x: [Real]) -> Real {
    return sum(x, range: 0..<x.count)
}

public func sum(x: [Real], range: Range<Int>) -> Real {
    var result: Real = 0.0
    vDSP_sveD(realPointer(x) + range.startIndex, 1, &result, vDSP_Length(range.count))
    return result
}

public func asum(x: [Real]) -> Real {
    return asum(x, range: 0..<x.count)
}

public func asum(x: [Real], range: Range<Int>) -> Real {
    let p = realPointer(x) + range.startIndex
    return cblas_dasum(Int32(range.count), p, 1)
}

public func max(x: [Real]) -> Real {
    return max(x, range: 0..<x.count)
}

public func max(x: [Real], range: Range<Int>) -> Real {
    var result: Real = 0.0
    vDSP_maxvD(realPointer(x) + range.startIndex, 1, &result, vDSP_Length(range.count))
    return result
}

public func min(x: [Real]) -> Real {
    return min(x, range: 0..<x.count)
}

public func min(x: [Real], range: Range<Int>) -> Real {
    var result: Real = 0.0
    vDSP_minvD(realPointer(x) + range.startIndex, 1, &result, vDSP_Length(range.count))
    return result
}

public func mean(x: [Real]) -> Real {
    return mean(x, range: 0..<x.count)
}

public func mean(x: [Real], range: Range<Int>) -> Real {
    var result: Real = 0.0
    vDSP_meanvD(realPointer(x) + range.startIndex, 1, &result, vDSP_Length(range.count))
    return result
}

public func meamg(x: [Real]) -> Real {
    return meamg(x, range: 0..<x.count)
}

public func meamg(x: [Real], range: Range<Int>) -> Real {
    var result: Real = 0.0
    vDSP_meamgvD(realPointer(x) + range.startIndex, 1, &result, vDSP_Length(range.count))
    return result
}

public func measq(x: [Real]) -> Real {
    return measq(x, range: 0..<x.count)
}

public func measq(x: [Real], range: Range<Int>) -> Real {
    var result: Real = 0.0
    vDSP_measqvD(realPointer(x) + range.startIndex, 1, &result, vDSP_Length(range.count))
    return result
}

public func rmsq(x: [Real]) -> Real {
    return rmsq(x, range: 0..<x.count)
}

public func rmsq(x: [Real], range: Range<Int>) -> Real {
    var result: Real = 0.0
    vDSP_rmsqvD(realPointer(x) + range.startIndex, 1, &result, vDSP_Length(range.count))
    return result
}

public func mod(x: [Real], _ y: [Real]) -> [Real] {
    var results = [Real](count: x.count, repeatedValue: 0.0)
    vvfmod(&results, x, y, [Int32(x.count)])
    return results
}

public func remainder(x: [Real], y: [Real]) -> [Real] {
    var results = [Real](count: x.count, repeatedValue: 0.0)
    vvremainder(&results, x, y, [Int32(x.count)])
    return results
}

public func sqrt(x: [Real]) -> [Real] {
    var results = [Real](count: x.count, repeatedValue: 0.0)
    vvsqrt(&results, x, [Int32(x.count)])
    return results
}
