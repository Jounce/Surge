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

/// Sine-Cosine
public func sincos<M: ContiguousMemory where M.Element == Double>(x: M) -> (sin: ValueArray<Double>, cos: ValueArray<Double>) {
    precondition(x.step == 1, "sincos doesn't support step values other than 1")

    let sin = ValueArray<Double>(count: x.count)
    let cos = ValueArray<Double>(count: x.count)
    vvsincos(sin.mutablePointer + sin.startIndex, cos.mutablePointer + cos.startIndex, x.pointer + x.startIndex, [Int32(x.count)])

    return (sin, cos)
}

/// Sine
public func sin<M: ContiguousMemory where M.Element == Double>(x: M) -> ValueArray<Double> {
    precondition(x.step == 1, "sin doesn't support step values other than 1")

    let results = ValueArray<Double>(count: x.count)
    vvsin(results.mutablePointer + results.startIndex, x.pointer + x.startIndex, [Int32(x.count)])

    return results
}

/// Cosine
public func cos<M: ContiguousMemory where M.Element == Double>(x: M) -> ValueArray<Double> {
    precondition(x.step == 1, "cos doesn't support step values other than 1")

    let results = ValueArray<Double>(count: x.count)
    vvcos(results.mutablePointer + results.startIndex, x.pointer + x.startIndex, [Int32(x.count)])

    return results
}

/// Tangent
public func tan<M: ContiguousMemory where M.Element == Double>(x: M) -> ValueArray<Double> {
    precondition(x.step == 1, "tan doesn't support step values other than 1")

    let results = ValueArray<Double>(count: x.count)
    vvtan(results.mutablePointer + results.startIndex, x.pointer + x.startIndex, [Int32(x.count)])

    return results
}

/// Arcsine
public func asin<M: ContiguousMemory where M.Element == Double>(x: M) -> ValueArray<Double> {
    precondition(x.step == 1, "asin doesn't support step values other than 1")

    let results = ValueArray<Double>(count: x.count)
    vvasin(results.mutablePointer + results.startIndex, x.pointer + x.startIndex, [Int32(x.count)])

    return results
}

/// Arccosine
public func acos<M: ContiguousMemory where M.Element == Double>(x: M) -> ValueArray<Double> {
    precondition(x.step == 1, "acos doesn't support step values other than 1")

    let results = ValueArray<Double>(count: x.count)
    vvacos(results.mutablePointer + results.startIndex, x.pointer + x.startIndex, [Int32(x.count)])

    return results
}

/// Arctangent
public func atan<M: ContiguousMemory where M.Element == Double>(x: M) -> ValueArray<Double> {
    precondition(x.step == 1, "atan doesn't support step values other than 1")

    let results = ValueArray<Double>(count: x.count)
    vvatan(results.mutablePointer + results.startIndex, x.pointer + x.startIndex, [Int32(x.count)])

    return results
}

// MARK: -

/// Radians to Degrees
func rad2deg<M: ContiguousMemory where M.Element == Double>(x: M) -> ValueArray<Double> {
    precondition(x.step == 1, "rad2deg doesn't support step values other than 1")

    let results = ValueArray<Double>(count: x.count)
    let divisor = ValueArray(count: x.count, repeatedValue: M_PI / 180.0)
    vvdiv(results.mutablePointer + results.startIndex, x.pointer + x.startIndex, divisor.pointer, [Int32(x.count)])

    return results
}

/// Degrees to Radians
func deg2rad<M: ContiguousMemory where M.Element == Double>(x: M) -> ValueArray<Double> {
    precondition(x.step == 1, "deg2rad doesn't support step values other than 1")

    let results = ValueArray<Double>(count: x.count)
    let divisor = ValueArray(count: x.count, repeatedValue: 180.0 / M_PI)
    vvdiv(results.mutablePointer + results.startIndex, x.pointer + x.startIndex, divisor.pointer, [Int32(x.count)])

    return results
}
