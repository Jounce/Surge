// Arithmetic.swift
//
// Copyright (c) 2014 Mattt Thompson (http://mattt.me)
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

public func sum(x: [Double]) -> Double {
    return cblas_dasum(Int32(x.count), x, 1)
}

public func max(x: [Double]) -> Double {
    var result = 0.0
    vDSP_maxvD(x, 1, &result, vDSP_Length(x.count))

    return result
}

public func min(x: [Double]) -> Double {
    var result = 0.0
    vDSP_minvD(x, 1, &result, vDSP_Length(x.count))

    return result
}

public func add(x: [Double], y: [Double]) -> [Double] {
    var results = [Double](y)
    cblas_daxpy(Int32(x.count), 1.0, x, 1, &results, 1)

    return results
}

public func mul(x: [Double], y: [Double]) -> [Double] {
    var results = [Double](count: x.count, repeatedValue: 0.0)
    vDSP_vmulD(x, 1, y, 1, &results, 1, vDSP_Length(x.count))

    return results
}

public func div(x: [Double], y: [Double]) -> [Double] {
    var results = [Double](count: x.count, repeatedValue: 0.0)
    vvdiv(&results, x, y, [Int32(x.count)])

    return results
}

public func mod(x: [Double], y: [Double]) -> [Double] {
    var results = [Double](count: x.count, repeatedValue: 0.0)
    vvfmod(&results, x, y, [Int32(x.count)])

    return results
}

public func remainder(x: [Double], y: [Double]) -> [Double] {
    var results = [Double](count: x.count, repeatedValue: 0.0)
    vvremainder(&results, x, y, [Int32(x.count)])

    return results
}

public func sqrt(x: [Double]) -> [Double] {
    var results = [Double](count: x.count, repeatedValue: 0.0)
    vvsqrt(&results, x, [Int32(x.count)])

    return results
}

// MARK: Operators

/*
func + (left: [Double], right: [Double]) -> [Double] {
    return add(left, right)
}

func + (left: [Double], right: Double) -> [Double] {
    return add(left, [Double](count: left.count, repeatedValue: right))
}

func / (left: [Double], right: [Double]) -> [Double] {
    return div(left, right)
}

func / (left: [Double], right: Double) -> [Double] {
    return div(left, [Double](count: left.count, repeatedValue: right))
}

func * (left: [Double], right: [Double]) -> [Double] {
    return mul(left, right)
}

func * (left: [Double], right: Double) -> [Double] {
    return mul(left, [Double](count: left.count, repeatedValue: right))
}

func % (left: [Double], right: [Double]) -> [Double] {
    return mod(left, right)
}

func % (left: [Double], right: Double) -> [Double] {
    return mod(left, [Double](count: left.count, repeatedValue: right))
}
*/