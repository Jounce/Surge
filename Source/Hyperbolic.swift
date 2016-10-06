// Hyperbolic.swift
//
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

// MARK: Hyperbolic Sine

public func sinh(_ x: [Float]) -> [Float] {
    var results = [Float](repeating: 0.0, count: x.count)
    vvsinhf(&results, x, [Int32(x.count)])

    return results
}

public func sinh(_ x: [Double]) -> [Double] {
    var results = [Double](repeating: 0.0, count: x.count)
    vvsinh(&results, x, [Int32(x.count)])

    return results
}

// MARK: Hyperbolic Cosine

public func cosh(_ x: [Float]) -> [Float] {
    var results = [Float](repeating: 0.0, count: x.count)
    vvcoshf(&results, x, [Int32(x.count)])

    return results
}

public func cosh(_ x: [Double]) -> [Double] {
    var results = [Double](repeating: 0.0, count: x.count)
    vvcosh(&results, x, [Int32(x.count)])

    return results
}

// MARK: Hyperbolic Tangent

public func tanh(_ x: [Float]) -> [Float] {
    var results = [Float](repeating: 0.0, count: x.count)
    vvtanhf(&results, x, [Int32(x.count)])

    return results
}

public func tanh(_ x: [Double]) -> [Double] {
    var results = [Double](repeating: 0.0, count: x.count)
    vvtanh(&results, x, [Int32(x.count)])

    return results
}

// MARK: Inverse Hyperbolic Sine

public func asinh(_ x: [Float]) -> [Float] {
    var results = [Float](repeating: 0.0, count: x.count)
    vvasinhf(&results, x, [Int32(x.count)])

    return results
}

public func asinh(_ x: [Double]) -> [Double] {
    var results = [Double](repeating: 0.0, count: x.count)
    vvasinh(&results, x, [Int32(x.count)])

    return results
}

// MARK: Inverse Hyperbolic Cosine

public func acosh(_ x: [Float]) -> [Float] {
    var results = [Float](repeating: 0.0, count: x.count)
    vvacoshf(&results, x, [Int32(x.count)])

    return results
}

public func acosh(_ x: [Double]) -> [Double] {
    var results = [Double](repeating: 0.0, count: x.count)
    vvacosh(&results, x, [Int32(x.count)])

    return results
}

// MARK: Inverse Hyperbolic Tangent

public func atanh(_ x: [Float]) -> [Float] {
    var results = [Float](repeating: 0.0, count: x.count)
    vvatanhf(&results, x, [Int32(x.count)])

    return results
}

public func atanh(_ x: [Double]) -> [Double] {
    var results = [Double](repeating: 0.0, count: x.count)
    vvatanh(&results, x, [Int32(x.count)])

    return results
}
