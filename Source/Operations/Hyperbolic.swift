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

/// Hyperbolic Sine
public func sinh<C: ContiguousMemory where C.Element == Double>(x: C) -> ValueArray<Double> {
    precondition(x.step == 1, "sinh doesn't support step values other than 1")

    let results = ValueArray<Double>(count: x.count)
    vvsinh(results.mutablePointer + results.startIndex, x.pointer + x.startIndex, [Int32(x.count)])

    return results
}

/// Hyperbolic Cosine
public func cosh<C: ContiguousMemory where C.Element == Double>(x: C) -> ValueArray<Double> {
    precondition(x.step == 1, "cosh doesn't support step values other than 1")

    let results = ValueArray<Double>(count: x.count)
    vvcosh(results.mutablePointer + results.startIndex, x.pointer + x.startIndex, [Int32(x.count)])

    return results
}

/// Hyperbolic Tangent
public func tanh<C: ContiguousMemory where C.Element == Double>(x: C) -> ValueArray<Double> {
    precondition(x.step == 1, "tanh doesn't support step values other than 1")

    let results = ValueArray<Double>(count: x.count)
    vvtanh(results.mutablePointer + results.startIndex, x.pointer + x.startIndex, [Int32(x.count)])

    return results
}

/// Inverse Hyperbolic Sine
public func asinh<C: ContiguousMemory where C.Element == Double>(x: C) -> ValueArray<Double> {
    precondition(x.step == 1, "asinh doesn't support step values other than 1")

    let results = ValueArray<Double>(count: x.count)
    vvasinh(results.mutablePointer + results.startIndex, x.pointer + x.startIndex, [Int32(x.count)])

    return results
}

/// Inverse Hyperbolic Cosine
public func acosh<C: ContiguousMemory where C.Element == Double>(x: C) -> ValueArray<Double> {
    precondition(x.step == 1, "acosh doesn't support step values other than 1")

    let results = ValueArray<Double>(count: x.count)
    vvacosh(results.mutablePointer + results.startIndex, x.pointer + x.startIndex, [Int32(x.count)])

    return results
}

/// Inverse Hyperbolic Tangent
public func atanh<C: ContiguousMemory where C.Element == Double>(x: C) -> ValueArray<Double> {
    precondition(x.step == 1, "atanh doesn't support step values other than 1")

    let results = ValueArray<Double>(count: x.count)
    vvatanh(results.mutablePointer + results.startIndex, x.pointer + x.startIndex, [Int32(x.count)])

    return results
}
