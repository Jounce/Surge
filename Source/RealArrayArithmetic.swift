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

public func sum(x: RealArray) -> Real {
    return sum(x, range: 0..<x.count)
}

public func sum(x: RealArray, range: Range<Int>) -> Real {
    var result: Real = 0.0
    vDSP_sveD(x.pointer + range.startIndex, 1, &result, vDSP_Length(range.count))
    return result
}

public func asum(x: RealArray) -> Real {
    return asum(x, range: 0..<x.count)
}

public func asum(x: RealArray, range: Range<Int>) -> Real {
    let p = x.pointer + range.startIndex
    return cblas_dasum(Int32(range.count), p, 1)
}

public func max(x: RealArray) -> Real {
    return max(x, range: 0..<x.count)
}

public func max(x: RealArray, range: Range<Int>) -> Real {
    var result: Real = 0.0
    vDSP_maxvD(x.pointer + range.startIndex, 1, &result, vDSP_Length(range.count))
    return result
}

public func min(x: RealArray) -> Real {
    return min(x, range: 0..<x.count)
}

public func min(x: RealArray, range: Range<Int>) -> Real {
    var result: Real = 0.0
    vDSP_minvD(x.pointer + range.startIndex, 1, &result, vDSP_Length(range.count))
    return result
}

public func mean(x: RealArray) -> Real {
    return mean(x, range: 0..<x.count)
}

public func mean(x: RealArray, range: Range<Int>) -> Real {
    var result: Real = 0.0
    vDSP_meanvD(x.pointer + range.startIndex, 1, &result, vDSP_Length(range.count))
    return result
}

public func meamg(x: RealArray) -> Real {
    return meamg(x, range: 0..<x.count)
}

public func meamg(x: RealArray, range: Range<Int>) -> Real {
    var result: Real = 0.0
    vDSP_meamgvD(x.pointer + range.startIndex, 1, &result, vDSP_Length(range.count))
    return result
}

public func measq(x: RealArray) -> Real {
    return measq(x, range: 0..<x.count)
}

public func measq(x: RealArray, range: Range<Int>) -> Real {
    var result: Real = 0.0
    vDSP_measqvD(x.pointer + range.startIndex, 1, &result, vDSP_Length(range.count))
    return result
}

public func rmsq(x: RealArray) -> Real {
    return rmsq(x, range: 0..<x.count)
}

public func rmsq(x: RealArray, range: Range<Int>) -> Real {
    var result: Real = 0.0
    vDSP_rmsqvD(x.pointer + range.startIndex, 1, &result, vDSP_Length(range.count))
    return result
}

public func mod(x: RealArray, _ y: RealArray) -> RealArray {
    let results = RealArray(count: x.count)
    vvfmod(results.pointer, x.pointer, y.pointer, [Int32(x.count)])
    return results
}

public func remainder(x: RealArray, y: RealArray) -> RealArray {
    let results = RealArray(count: x.count)
    vvremainder(results.pointer, x.pointer, y.pointer, [Int32(x.count)])
    return results
}

public func sqrt(x: RealArray) -> RealArray {
    let results = RealArray(count: x.count)
    vvsqrt(results.pointer, x.pointer, [Int32(x.count)])
    return results
}

public func dot(x: RealArray, _ y: RealArray) -> Real {
    precondition(x.count == y.count, "Vectors must have equal count")

    var result: Real = 0.0
    vDSP_dotprD(x.pointer, 1, y.pointer, 1, &result, vDSP_Length(x.count))
    return result
}

public func + (lhs: RealArray, rhs: RealArray) -> RealArray {
    let count = min(lhs.count, rhs.count)
    let results = RealArray(count: count)
    vDSP_vaddD(lhs.pointer, 1, rhs.pointer, 1, results.pointer, 1, vDSP_Length(count))
    return results
}

public func + (lhs: RealArray, var rhs: Real) -> RealArray {
    let results = RealArray(count: lhs.count)
    vDSP_vsaddD(lhs.pointer, 1, &rhs, results.pointer, 1, vDSP_Length(lhs.count))
    return results
}

public func + (lhs: Real, rhs: RealArray) -> RealArray {
    return rhs + lhs
}

public func += (inout lhs: RealArray, rhs: RealArray) {
    let count = min(lhs.count, rhs.count)
    vDSP_vaddD(lhs.pointer, 1, rhs.pointer, 1, lhs.pointer, 1, vDSP_Length(count))
}

public func += (inout lhs: RealArray, var rhs: Real) {
    vDSP_vsaddD(lhs.pointer, 1, &rhs, lhs.pointer, 1, vDSP_Length(lhs.count))
}

public func - (lhs: RealArray, rhs: RealArray) -> RealArray {
    let count = min(lhs.count, rhs.count)
    let results = RealArray(count: count)
    vDSP_vsubD(rhs.pointer, 1, lhs.pointer, 1, results.pointer, 1, vDSP_Length(count))
    return results
}

public func - (lhs: RealArray, rhs: Real) -> RealArray {
    let results = RealArray(count: lhs.count)
    var scalar: Real = -1 * rhs
    vDSP_vsaddD(lhs.pointer, 1, &scalar, results.pointer, 1, vDSP_Length(lhs.count))
    return results
}

public func - (var lhs: Real, rhs: RealArray) -> RealArray {
    let results = RealArray(count: rhs.count)
    var scalar: Real = -1
    vDSP_vsmsaD(rhs.pointer, 1, &scalar, &lhs, results.pointer, 1, vDSP_Length(rhs.count))
    return results
}

public func -= (inout lhs: RealArray, rhs: RealArray) {
    let count = min(lhs.count, rhs.count)
    vDSP_vsubD(rhs.pointer, 1, lhs.pointer, 1, lhs.pointer, 1, vDSP_Length(count))
}

public func -= (inout lhs: RealArray, rhs: Real) {
    var scalar: Real = -1 * rhs
    vDSP_vsaddD(lhs.pointer, 1, &scalar, lhs.pointer, 1, vDSP_Length(lhs.count))
}

public func / (lhs: RealArray, rhs: RealArray) -> RealArray {
    let count = min(lhs.count, rhs.count)
    let results = RealArray(count: lhs.count)
    vDSP_vdivD(rhs.pointer, 1, lhs.pointer, 1, results.pointer, 1, vDSP_Length(count))
    return results
}

public func / (lhs: RealArray, var rhs: Real) -> RealArray {
    let results = RealArray(count: lhs.count)
    vDSP_vsdivD(lhs.pointer, 1, &rhs, results.pointer, 1, vDSP_Length(lhs.count))
    return results
}

public func / (var lhs: Real, rhs: RealArray) -> RealArray {
    let results = RealArray(count: rhs.count)
    vDSP_svdivD(&lhs, rhs.pointer, 1, results.pointer, 1, vDSP_Length(rhs.count))
    return results
}

public func /= (inout lhs: RealArray, rhs: RealArray) {
    let count = min(lhs.count, rhs.count)
    vDSP_vdivD(rhs.pointer, 1, lhs.pointer, 1, lhs.pointer, 1, vDSP_Length(count))
}

public func /= (inout lhs: RealArray, var rhs: Real) {
    vDSP_vsdivD(lhs.pointer, 1, &rhs, lhs.pointer, 1, vDSP_Length(lhs.count))
}

public func * (lhs: RealArray, rhs: RealArray) -> RealArray {
    let results = RealArray(count: lhs.count)
    vDSP_vmulD(lhs.pointer, 1, rhs.pointer, 1, results.pointer, 1, vDSP_Length(lhs.count))
    return results
}

public func * (lhs: RealArray, var rhs: Real) -> RealArray {
    let results = RealArray(count: lhs.count)
    vDSP_vsmulD(lhs.pointer, 1, &rhs, results.pointer, 1, vDSP_Length(lhs.count))
    return results
}

public func * (lhs: Real, rhs: RealArray) -> RealArray {
    return rhs * lhs
}

public func *= (inout lhs: RealArray, rhs: RealArray) {
    vDSP_vmulD(lhs.pointer, 1, rhs.pointer, 1, lhs.pointer, 1, vDSP_Length(lhs.count))
}

public func *= (inout lhs: RealArray, var rhs: Real) {
    vDSP_vsmulD(lhs.pointer, 1, &rhs, lhs.pointer, 1, vDSP_Length(lhs.count))
}

public func % (lhs: RealArray, rhs: RealArray) -> RealArray {
    return mod(lhs, rhs)
}

public func % (lhs: RealArray, rhs: Real) -> RealArray {
    return mod(lhs, RealArray(count: lhs.count, repeatedValue: rhs))
}

infix operator • {}
public func • (lhs: RealArray, rhs: RealArray) -> Real {
    return dot(lhs, rhs)
}
