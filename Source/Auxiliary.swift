// Copyright (c) 2014–2015 Mattt Thompson (http://mattt.me)
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

/// Absolute Value
public func abs<M: ContiguousMemory where M.Element == Double>(x: M) -> ValueArray<Double> {
    let results = ValueArray<Double>(count: x.count)
    vDSP_vabsD(x.pointer, x.step, results.mutablePointer, results.step, vDSP_Length(x.count))
    return results
}

/// Ceiling
public func ceil<M: ContiguousMemory where M.Element == Double>(x: M) -> ValueArray<Double> {
    precondition(x.step == 1, "ceil doesn't support step values other than 1")
    let results = ValueArray<Double>(count: x.count)
    vvceil(results.mutablePointer, x.pointer, [Int32(x.count)])
    return results
}

/// Clip
public func clip<M: ContiguousMemory where M.Element == Double>(x: M, low: Double, high: Double) -> ValueArray<Double> {
    var results = ValueArray<Double>(count: x.count), y = low, z = high
    vDSP_vclipD(x.pointer, x.step, &y, &z, results.mutablePointer, results.step, vDSP_Length(x.count))
    return results
}

// Copy Sign
public func copysign<M: ContiguousMemory where M.Element == Double>(sign: M, magnitude: M) -> ValueArray<Double> {
    precondition(sign.step == 1 && magnitude.step == 1, "copysign doesn't support step values other than 1")
    let results = ValueArray<Double>(count: sign.count)
    vvcopysign(results.mutablePointer, magnitude.pointer, sign.pointer, [Int32(sign.count)])
    return results
}

/// Floor
public func floor<M: ContiguousMemory where M.Element == Double>(x: M) -> ValueArray<Double> {
    precondition(x.step == 1, "floor doesn't support step values other than 1")
    let results = ValueArray<Double>(count: x.count)
    vvfloor(results.mutablePointer, x.pointer, [Int32(x.count)])
    return results
}

/// Negate
public func neg<M: ContiguousMemory where M.Element == Double>(x: M) -> ValueArray<Double> {
    let results = ValueArray<Double>(count: x.count)
    vDSP_vnegD(x.pointer, x.step, results.mutablePointer, results.step, vDSP_Length(x.count))

    return results
}

/// Reciprocal
public func rec<M: ContiguousMemory where M.Element == Double>(x: M) -> ValueArray<Double> {
    precondition(x.step == 1, "rec doesn't support step values other than 1")
    let results = ValueArray<Double>(count: x.count)
    vvrec(results.mutablePointer, x.pointer, [Int32(x.count)])
    return results
}

/// Round
public func round<M: ContiguousMemory where M.Element == Double>(x: M) -> ValueArray<Double> {
    precondition(x.step == 1, "round doesn't support step values other than 1")
    let results = ValueArray<Double>(count: x.count)
    vvnint(results.mutablePointer, x.pointer, [Int32(x.count)])
    return results
}

/// Threshold
public func threshold<M: ContiguousMemory where M.Element == Double>(x: M, low: Double) -> ValueArray<Double> {
    var results = ValueArray<Double>(count: x.count), y = low
    vDSP_vthrD(x.pointer, x.step, &y, results.mutablePointer, results.step, vDSP_Length(x.count))
    return results
}

/// Truncate
public func trunc<M: ContiguousMemory where M.Element == Double>(x: M) -> ValueArray<Double> {
    precondition(x.step == 1, "trunc doesn't support step values other than 1")
    let results = ValueArray<Double>(count: x.count)
    vvint(results.mutablePointer, x.pointer, [Int32(x.count)])
    return results
}

/// Power
public func pow<M: ContiguousMemory where M.Element == Double>(x: M, y: M) -> ValueArray<Double> {
    precondition(x.step == 1, "pow doesn't support step values other than 1")
    let results = ValueArray<Double>(count: x.count)
    vvpow(results.mutablePointer, x.pointer, y.pointer, [Int32(x.count)])
    return results
}
