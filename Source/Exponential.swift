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

/// Exponentiation
public func exp<M: ContiguousMemory where M.Element == Double>(x: M) -> ValueArray<Double> {
    precondition(x.step == 1, "exp doesn't support step values other than 1")

    let results = ValueArray<Double>(count: x.count)
    vvexp(results.mutablePointer, x.pointer + x.startIndex, [Int32(x.count)])

    return results
}

/// Square Exponentiation
public func exp2<M: ContiguousMemory where M.Element == Double>(x: M) -> ValueArray<Double> {
    precondition(x.step == 1, "exp2 doesn't support step values other than 1")

    let results = ValueArray<Double>(count: x.count)
    vvexp2(results.mutablePointer, x.pointer + x.startIndex, [Int32(x.count)])

    return results
}

/// Natural Logarithm
public func log<M: ContiguousMemory where M.Element == Double>(x: M) -> ValueArray<Double> {
    precondition(x.step == 1, "log doesn't support step values other than 1")

    let results = ValueArray<Double>(count: x.count)
    vvlog(results.mutablePointer, x.pointer + x.startIndex, [Int32(x.count)])

    return results
}

/// Base-2 Logarithm
public func log2<M: ContiguousMemory where M.Element == Double>(x: M) -> ValueArray<Double> {
    precondition(x.step == 1, "log2 doesn't support step values other than 1")

    let results = ValueArray<Double>(count: x.count)
    vvlog2(results.mutablePointer, x.pointer + x.startIndex, [Int32(x.count)])

    return results
}

/// Base-10 Logarithm
public func log10<M: ContiguousMemory where M.Element == Double>(x: M) -> ValueArray<Double> {
    precondition(x.step == 1, "log10 doesn't support step values other than 1")

    let results = ValueArray<Double>(count: x.count)
    vvlog10(results.mutablePointer, x.pointer + x.startIndex, [Int32(x.count)])

    return results
}

/// Logarithmic Exponentiation
public func logb<M: ContiguousMemory where M.Element == Double>(x: M) -> ValueArray<Double> {
    precondition(x.step == 1, "logb doesn't support step values other than 1")

    let results = ValueArray<Double>(count: x.count)
    vvlogb(results.mutablePointer, x.pointer + x.startIndex, [Int32(x.count)])

    return results
}
