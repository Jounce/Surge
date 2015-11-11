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

public func sum<M: ContiguousMemory where M.Element == Double>(x: M) -> Double {
    var result = 0.0
    vDSP_sveD(x.pointer + x.startIndex, x.step, &result, vDSP_Length(x.count))
    return result
}

public func max<M: ContiguousMemory where M.Element == Double>(x: M) -> Double {
    var result: Double = 0.0
    vDSP_maxvD(x.pointer + x.startIndex, x.step, &result, vDSP_Length(x.count))
    return result
}

public func min<M: ContiguousMemory where M.Element == Double>(x: M) -> Double {
    var result: Double = 0.0
    vDSP_minvD(x.pointer + x.startIndex, x.step, &result, vDSP_Length(x.count))
    return result
}

public func mean<M: ContiguousMemory where M.Element == Double>(x: M) -> Double {
    var result: Double = 0.0
    vDSP_meanvD(x.pointer + x.startIndex, x.step, &result, vDSP_Length(x.count))
    return result
}

public func meamg<M: ContiguousMemory where M.Element == Double>(x: M) -> Double {
    var result: Double = 0.0
    vDSP_meamgvD(x.pointer + x.startIndex, x.step, &result, vDSP_Length(x.count))
    return result
}

public func measq<M: ContiguousMemory where M.Element == Double>(x: M) -> Double {
    var result: Double = 0.0
    vDSP_measqvD(x.pointer + x.startIndex, x.step, &result, vDSP_Length(x.count))
    return result
}

public func rmsq<M: ContiguousMemory where M.Element == Double>(x: M) -> Double {
    var result: Double = 0.0
    vDSP_rmsqvD(x.pointer + x.startIndex, x.step, &result, vDSP_Length(x.count))
    return result
}

// Return the standard deviation, a measure of the spread of deviation
public func std<M: ContiguousMemory where M.Element == Double>(x: M) -> Double {
    let diff = x - mean(x)
    let variance = measq(diff)
    return sqrt(variance)
}

public func mod<ML: ContiguousMemory, MR: ContiguousMemory where ML.Element == Double, MR.Element == Double>(lhs: ML, _ rhs: MR) -> ValueArray<Double> {
    precondition(lhs.step == 1, "mod doesn't support step values other than 1")
    let results = ValueArray<Double>(count: lhs.count)
    vvfmod(results.mutablePointer + results.startIndex, lhs.pointer + lhs.startIndex, rhs.pointer + rhs.startIndex, [Int32(lhs.count)])
    return results
}

public func remainder<ML: ContiguousMemory, MR: ContiguousMemory where ML.Element == Double, MR.Element == Double>(lhs: ML, rhs: MR) -> ValueArray<Double> {
    precondition(lhs.step == 1, "remainder doesn't support step values other than 1")
    let results = ValueArray<Double>(count: lhs.count)
    vvremainder(results.mutablePointer + results.startIndex, lhs.pointer + lhs.startIndex, rhs.pointer + rhs.startIndex, [Int32(lhs.count)])
    return results
}

public func sqrt<M: ContiguousMemory where M.Element == Double>(lhs: M) -> ValueArray<Double> {
    precondition(lhs.step == 1, "sqrt doesn't support step values other than 1")
    let results = ValueArray<Double>(count: lhs.count)
    vvsqrt(results.mutablePointer + results.startIndex, lhs.pointer + lhs.startIndex, [Int32(lhs.count)])
    return results
}

public func dot<ML: ContiguousMemory, MR: ContiguousMemory where ML.Element == Double, MR.Element == Double>(lhs: ML, _ rhs: MR) -> Double {
    precondition(lhs.count == rhs.count, "Vectors must have equal count")

    var result: Double = 0.0
    vDSP_dotprD(lhs.pointer + lhs.startIndex, lhs.step, rhs.pointer + rhs.startIndex, rhs.step, &result, vDSP_Length(lhs.count))
    return result
}

public func +=<ML: ContiguousMutableMemory, MR: ContiguousMemory where ML.Element == Double, MR.Element == Double>(inout lhs: ML, rhs: MR) {
    assert(lhs.count >= rhs.count)
    let count = min(lhs.count, rhs.count)
    vDSP_vaddD(lhs.pointer + lhs.startIndex, lhs.step, rhs.pointer + rhs.startIndex, rhs.step, lhs.mutablePointer, lhs.step, vDSP_Length(count))
}

public func +<ML: ContiguousMemory, MR: ContiguousMemory where ML.Element == Double, MR.Element == Double>(lhs: ML, rhs: MR) -> ValueArray<Double> {
    let count = min(lhs.count, rhs.count)
    let results = ValueArray<Double>(count: count)
    vDSP_vaddD(lhs.pointer + lhs.startIndex, lhs.step, rhs.pointer + rhs.startIndex, rhs.step, results.mutablePointer, results.step, vDSP_Length(count))
    return results
}

public func +=<ML: ContiguousMutableMemory where ML.Element == Double>(inout lhs: ML, var rhs: Double) {
    vDSP_vsaddD(lhs.pointer + lhs.startIndex, lhs.step, &rhs, lhs.mutablePointer + lhs.startIndex, lhs.step, vDSP_Length(lhs.count))
}

public func +<ML: ContiguousMemory where ML.Element == Double>(lhs: ML, var rhs: Double) -> ValueArray<Double> {
    let results = ValueArray<Double>(count: lhs.count)
    vDSP_vsaddD(lhs.pointer + lhs.startIndex, lhs.step, &rhs, results.mutablePointer + results.startIndex, results.step, vDSP_Length(lhs.count))
    return results
}

public func +<ML: ContiguousMemory, MR: ContiguousMemory where ML.Element == Double, MR.Element == Double>(lhs: Double, rhs: MR) -> ValueArray<Double> {
    return rhs + lhs
}

public func -=<ML: ContiguousMutableMemory, MR: ContiguousMemory where ML.Element == Double, MR.Element == Double>(inout lhs: ML, rhs: MR) {
    let count = min(lhs.count, rhs.count)
    vDSP_vsubD(rhs.pointer + rhs.startIndex, rhs.step, lhs.pointer + lhs.startIndex, lhs.step, lhs.mutablePointer + lhs.startIndex, lhs.step, vDSP_Length(count))
}

public func -<ML: ContiguousMemory, MR: ContiguousMemory where ML.Element == Double, MR.Element == Double>(lhs: ML, rhs: MR) -> ValueArray<Double> {
    let count = min(lhs.count, rhs.count)
    let results = ValueArray<Double>(count: count)
    vDSP_vsubD(rhs.pointer + rhs.startIndex, rhs.step, lhs.pointer + lhs.startIndex, lhs.step, results.mutablePointer + results.startIndex, results.step, vDSP_Length(count))
    return results
}

public func -=<ML: ContiguousMutableMemory where ML.Element == Double>(inout lhs: ML, rhs: Double) {
    var scalar: Double = -1 * rhs
    vDSP_vsaddD(lhs.pointer + lhs.startIndex, lhs.step, &scalar, lhs.mutablePointer + lhs.startIndex, lhs.step, vDSP_Length(lhs.count))
}

public func -<ML: ContiguousMemory where ML.Element == Double>(lhs: ML, rhs: Double) -> ValueArray<Double> {
    let results = ValueArray<Double>(count: lhs.count)
    var scalar: Double = -1 * rhs
    vDSP_vsaddD(lhs.pointer + lhs.startIndex, lhs.step, &scalar, results.mutablePointer + results.startIndex, results.step, vDSP_Length(lhs.count))
    return results
}

public func -<ML: ContiguousMemory where ML.Element == Double>(var lhs: Double, rhs: ML) -> ValueArray<Double> {
    let results = ValueArray<Double>(count: rhs.count)
    var scalar: Double = -1
    vDSP_vsmsaD(rhs.pointer + rhs.startIndex, rhs.step, &scalar, &lhs, results.mutablePointer + results.startIndex, results.step, vDSP_Length(rhs.count))
    return results
}

public func /=<ML: ContiguousMutableMemory, MR: ContiguousMemory where ML.Element == Double, MR.Element == Double>(inout lhs: ML, rhs: MR) {
    let count = min(lhs.count, rhs.count)
    vDSP_vdivD(rhs.pointer + rhs.startIndex, rhs.step, lhs.pointer + lhs.startIndex, lhs.step, lhs.mutablePointer + lhs.startIndex, lhs.step, vDSP_Length(count))
}

public func /<ML: ContiguousMemory, MR: ContiguousMemory where ML.Element == Double, MR.Element == Double>(lhs: ML, rhs: MR) -> ValueArray<Double> {
    let count = min(lhs.count, rhs.count)
    let results = ValueArray<Double>(count: lhs.count)
    vDSP_vdivD(rhs.pointer + rhs.startIndex, rhs.step, lhs.pointer + lhs.startIndex, lhs.step, results.mutablePointer + results.startIndex, results.step, vDSP_Length(count))
    return results
}

public func /=<ML: ContiguousMutableMemory where ML.Element == Double>(inout lhs: ML, var rhs: Double) {
    vDSP_vsdivD(lhs.pointer + lhs.startIndex, lhs.step, &rhs, lhs.mutablePointer + lhs.startIndex, lhs.step, vDSP_Length(lhs.count))
}

public func /<ML: ContiguousMemory where ML.Element == Double>(lhs: ML, var rhs: Double) -> ValueArray<Double> {
    let results = ValueArray<Double>(count: lhs.count)
    vDSP_vsdivD(lhs.pointer + lhs.startIndex, lhs.step, &rhs, results.mutablePointer + results.startIndex, results.step, vDSP_Length(lhs.count))
    return results
}

public func /<ML: ContiguousMemory where ML.Element == Double>(var lhs: Double, rhs: ML) -> ValueArray<Double> {
    let results = ValueArray<Double>(count: rhs.count)
    vDSP_svdivD(&lhs, rhs.pointer + rhs.startIndex, rhs.step, results.mutablePointer + results.startIndex, results.step, vDSP_Length(rhs.count))
    return results
}

public func *=<ML: ContiguousMutableMemory, MR: ContiguousMemory where ML.Element == Double, MR.Element == Double>(inout lhs: ML, rhs: MR) {
    vDSP_vmulD(lhs.pointer + lhs.startIndex, lhs.step, rhs.pointer + rhs.startIndex, rhs.step, lhs.mutablePointer + lhs.startIndex, lhs.step, vDSP_Length(lhs.count))
}

public func *<ML: ContiguousMemory, MR: ContiguousMemory where ML.Element == Double, MR.Element == Double>(lhs: ML, rhs: MR) -> ValueArray<Double> {
    let results = ValueArray<Double>(count: lhs.count)
    vDSP_vmulD(lhs.pointer + lhs.startIndex, lhs.step, rhs.pointer + rhs.startIndex, rhs.step, results.mutablePointer + results.startIndex, results.step, vDSP_Length(lhs.count))
    return results
}

public func *=<ML: ContiguousMutableMemory where ML.Element == Double>(inout lhs: ML, var rhs: Double) {
    vDSP_vsmulD(lhs.pointer + lhs.startIndex, lhs.step, &rhs, lhs.mutablePointer + lhs.startIndex, lhs.step, vDSP_Length(lhs.count))
}

public func *<ML: ContiguousMemory where ML.Element == Double>(lhs: ML, var rhs: Double) -> ValueArray<Double> {
    let results = ValueArray<Double>(count: lhs.count)
    vDSP_vsmulD(lhs.pointer + lhs.startIndex, lhs.step, &rhs, results.mutablePointer + results.startIndex, results.step, vDSP_Length(lhs.count))
    return results
}

public func *<ML: ContiguousMemory where ML.Element == Double>(lhs: Double, rhs: ML) -> ValueArray<Double> {
    return rhs * lhs
}

public func %<ML: ContiguousMemory, MR: ContiguousMemory where ML.Element == Double, MR.Element == Double>(lhs: ML, rhs: MR) -> ValueArray<Double> {
    return mod(lhs, rhs)
}

public func %<ML: ContiguousMemory where ML.Element == Double>(lhs: ML, rhs: Double) -> ValueArray<Double> {
    return mod(lhs, ValueArray<Double>(count: lhs.count, repeatedValue: rhs))
}

infix operator • {}
public func •<ML: ContiguousMemory, MR: ContiguousMemory where ML.Element == Double, MR.Element == Double>(lhs: ML, rhs: MR) -> Double {
    return dot(lhs, rhs)
}
