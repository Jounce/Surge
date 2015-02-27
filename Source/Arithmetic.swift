// Arithmetic.swift
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

// MARK: Sum

public func sum(x: [Float]) -> Float {
    return cblas_sasum(Int32(x.count), x, 1)
}

public func sum(x: [Double]) -> Double {
    return cblas_dasum(Int32(x.count), x, 1)
}

// MARK: Maximum

public func max(x: [Float]) -> Float {
    var result: Float = 0.0
    vDSP_maxv(x, 1, &result, vDSP_Length(x.count))

    return result
}

public func max(x: [Double]) -> Double {
    var result: Double = 0.0
    vDSP_maxvD(x, 1, &result, vDSP_Length(x.count))

    return result
}

// MARK: Minimum

public func min(x: [Float]) -> Float {
    var result: Float = 0.0
    vDSP_minv(x, 1, &result, vDSP_Length(x.count))

    return result
}

public func min(x: [Double]) -> Double {
    var result: Double = 0.0
    vDSP_minvD(x, 1, &result, vDSP_Length(x.count))

    return result
}

// MARK: Add

public func add(x: [Float], y: [Float]) -> [Float] {
    var results = [Float](y)
    cblas_saxpy(Int32(x.count), 1.0, x, 1, &results, 1)

    return results
}

public func add(x: [Double], y: [Double]) -> [Double] {
    var results = [Double](y)
    cblas_daxpy(Int32(x.count), 1.0, x, 1, &results, 1)

    return results
}

// MARK: Multiply

public func mul(x: [Float], y: [Float]) -> [Float] {
    var results = [Float](count: x.count, repeatedValue: 0.0)
    vDSP_vmul(x, 1, y, 1, &results, 1, vDSP_Length(x.count))

    return results
}

public func mul(x: [Double], y: [Double]) -> [Double] {
    var results = [Double](count: x.count, repeatedValue: 0.0)
    vDSP_vmulD(x, 1, y, 1, &results, 1, vDSP_Length(x.count))

    return results
}

// MARK: Divide

public func div(x: [Float], y: [Float]) -> [Float] {
    var results = [Float](count: x.count, repeatedValue: 0.0)
    vvdivf(&results, x, y, [Int32(x.count)])

    return results
}

public func div(x: [Double], y: [Double]) -> [Double] {
    var results = [Double](count: x.count, repeatedValue: 0.0)
    vvdiv(&results, x, y, [Int32(x.count)])

    return results
}

// MARK: Modulo

public func mod(x: [Float], y: [Float]) -> [Float] {
    var results = [Float](count: x.count, repeatedValue: 0.0)
    vvfmodf(&results, x, y, [Int32(x.count)])

    return results
}

public func mod(x: [Double], y: [Double]) -> [Double] {
    var results = [Double](count: x.count, repeatedValue: 0.0)
    vvfmod(&results, x, y, [Int32(x.count)])

    return results
}

// MARK: Remainder

public func remainder(x: [Float], y: [Float]) -> [Float] {
    var results = [Float](count: x.count, repeatedValue: 0.0)
    vvremainderf(&results, x, y, [Int32(x.count)])

    return results
}

public func remainder(x: [Double], y: [Double]) -> [Double] {
    var results = [Double](count: x.count, repeatedValue: 0.0)
    vvremainder(&results, x, y, [Int32(x.count)])

    return results
}

// MARK: Square Root

public func sqrt(x: [Float]) -> [Float] {
    var results = [Float](count: x.count, repeatedValue: 0.0)
    vvsqrtf(&results, x, [Int32(x.count)])

    return results
}

public func sqrt(x: [Double]) -> [Double] {
    var results = [Double](count: x.count, repeatedValue: 0.0)
    vvsqrt(&results, x, [Int32(x.count)])

    return results
}

// MARK: Dot Product

public func dot(x: [Float], y: [Float]) -> Float {
    precondition(x.count == y.count, "Vectors must have equal count")

    var result: Float = 0.0
    vDSP_dotpr(x, 1, y, 1, &result, vDSP_Length(x.count))

    return result
}


public func dot(x: [Double], y: [Double]) -> Double {
    precondition(x.count == y.count, "Vectors must have equal count")

    var result: Double = 0.0
    vDSP_dotprD(x, 1, y, 1, &result, vDSP_Length(x.count))

    return result
}

// MARK: - Operators

func + (left: [Float], right: [Float]) -> [Float] {
    return add(left, right)
}

func + (left: [Double], right: [Double]) -> [Double] {
    return add(left, right)
}

func + (left: [Float], right: Float) -> [Float] {
    return add(left, [Float](count: left.count, repeatedValue: right))
}

func + (left: [Double], right: Double) -> [Double] {
    return add(left, [Double](count: left.count, repeatedValue: right))
}

func / (left: [Float], right: [Float]) -> [Float] {
    return div(left, right)
}

func / (left: [Double], right: [Double]) -> [Double] {
    return div(left, right)
}

func / (left: [Float], right: Float) -> [Float] {
    return div(left, [Float](count: left.count, repeatedValue: right))
}

func / (left: [Double], right: Double) -> [Double] {
    return div(left, [Double](count: left.count, repeatedValue: right))
}

func * (left: [Float], right: [Float]) -> [Float] {
    return mul(left, right)
}

func * (left: [Double], right: [Double]) -> [Double] {
    return mul(left, right)
}

func * (left: [Float], right: Float) -> [Float] {
    return mul(left, [Float](count: left.count, repeatedValue: right))
}

func * (left: [Double], right: Double) -> [Double] {
    return mul(left, [Double](count: left.count, repeatedValue: right))
}

func % (left: [Float], right: [Float]) -> [Float] {
    return mod(left, right)
}

func % (left: [Double], right: [Double]) -> [Double] {
    return mod(left, right)
}

func % (left: [Float], right: Float) -> [Float] {
    return mod(left, [Float](count: left.count, repeatedValue: right))
}

func % (left: [Double], right: Double) -> [Double] {
    return mod(left, [Double](count: left.count, repeatedValue: right))
}

infix operator • {}
func • (left: [Double], right: [Double]) -> Double {
    return dot(left, right)
}

func • (left: [Float], right: [Float]) -> Float {
    return dot(left, right)
}
