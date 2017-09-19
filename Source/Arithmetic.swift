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

public func sum(_ x: [Float]) -> Float {
    var result: Float = 0.0
    vDSP_sve(x, 1, &result, vDSP_Length(x.count))

    return result
}

public func sum(_ x: [Double]) -> Double {
    var result: Double = 0.0
    vDSP_sveD(x, 1, &result, vDSP_Length(x.count))

    return result
}

// MARK: Sum of Absolute Values

public func asum(_ x: [Float]) -> Float {
    return cblas_sasum(Int32(x.count), x, 1)
}

public func asum(_ x: [Double]) -> Double {
    return cblas_dasum(Int32(x.count), x, 1)
}

// MARK: Sum of Square Values

public func sumsq(_ x: [Float]) -> Float {
    var result: Float = 0
    vDSP_svesq(x, 1, &result, vDSP_Length(x.count))
    return result
}

public func sumsq(_ x: [Double]) -> Double {
    var result: Double = 0
    vDSP_svesqD(x, 1, &result, vDSP_Length(x.count))
    return result
}
// MARK: Maximum

public func max(_ x: [Float]) -> Float {
    var result: Float = 0.0
    vDSP_maxv(x, 1, &result, vDSP_Length(x.count))

    return result
}

public func max(_ x: [Double]) -> Double {
    var result: Double = 0.0
    vDSP_maxvD(x, 1, &result, vDSP_Length(x.count))

    return result
}

// MARK: Minimum

public func min(_ x: [Float]) -> Float {
    var result: Float = 0.0
    vDSP_minv(x, 1, &result, vDSP_Length(x.count))

    return result
}

public func min(_ x: [Double]) -> Double {
    var result: Double = 0.0
    vDSP_minvD(x, 1, &result, vDSP_Length(x.count))

    return result
}

// MARK: Mean

public func mean(_ x: [Float]) -> Float {
    var result: Float = 0.0
    vDSP_meanv(x, 1, &result, vDSP_Length(x.count))

    return result
}

public func mean(_ x: [Double]) -> Double {
    var result: Double = 0.0
    vDSP_meanvD(x, 1, &result, vDSP_Length(x.count))

    return result
}

// MARK: Mean Magnitude

public func meamg(_ x: [Float]) -> Float {
    var result: Float = 0.0
    vDSP_meamgv(x, 1, &result, vDSP_Length(x.count))

    return result
}

public func meamg(_ x: [Double]) -> Double {
    var result: Double = 0.0
    vDSP_meamgvD(x, 1, &result, vDSP_Length(x.count))

    return result
}

// MARK: Mean Square Value

public func measq(_ x: [Float]) -> Float {
    var result: Float = 0.0
    vDSP_measqv(x, 1, &result, vDSP_Length(x.count))

    return result
}

public func measq(_ x: [Double]) -> Double {
    var result: Double = 0.0
    vDSP_measqvD(x, 1, &result, vDSP_Length(x.count))

    return result
}

// MARK: Add

public func add(_ x: [Float], y: [Float]) -> [Float] {
    var results = [Float](y)
    cblas_saxpy(Int32(x.count), 1.0, x, 1, &results, 1)

    return results
}

public func add(_ x: [Double], y: [Double]) -> [Double] {
    var results = [Double](y)
    cblas_daxpy(Int32(x.count), 1.0, x, 1, &results, 1)

    return results
}

// MARK: Subtraction

public func sub(_ x: [Float], y: [Float]) -> [Float] {
    var results = [Float](y)
    catlas_saxpby(Int32(x.count), 1.0, x, 1, -1, &results, 1)
    
    return results
}

public func sub(_ x: [Double], y: [Double]) -> [Double] {
    var results = [Double](y)
    catlas_daxpby(Int32(x.count), 1.0, x, 1, -1, &results, 1)
    
    return results
}

// MARK: Multiply

public func mul(_ x: [Float], y: [Float]) -> [Float] {
    var results = [Float](repeating: 0.0, count: x.count)
    vDSP_vmul(x, 1, y, 1, &results, 1, vDSP_Length(x.count))

    return results
}

public func mul(_ x: [Double], y: [Double]) -> [Double] {
    var results = [Double](repeating: 0.0, count: x.count)
    vDSP_vmulD(x, 1, y, 1, &results, 1, vDSP_Length(x.count))

    return results
}

// MARK: Divide

public func div(_ x: [Float], y: [Float]) -> [Float] {
    var results = [Float](repeating: 0.0, count: x.count)
    vvdivf(&results, x, y, [Int32(x.count)])

    return results
}

public func div(_ x: [Double], y: [Double]) -> [Double] {
    var results = [Double](repeating: 0.0, count: x.count)
    vvdiv(&results, x, y, [Int32(x.count)])

    return results
}

// MARK: Modulo

public func mod(_ x: [Float], y: [Float]) -> [Float] {
    var results = [Float](repeating: 0.0, count: x.count)
    vvfmodf(&results, x, y, [Int32(x.count)])

    return results
}

public func mod(_ x: [Double], y: [Double]) -> [Double] {
    var results = [Double](repeating: 0.0, count: x.count)
    vvfmod(&results, x, y, [Int32(x.count)])

    return results
}

// MARK: Remainder

public func remainder(_ x: [Float], y: [Float]) -> [Float] {
    var results = [Float](repeating: 0.0, count: x.count)
    vvremainderf(&results, x, y, [Int32(x.count)])

    return results
}

public func remainder(_ x: [Double], y: [Double]) -> [Double] {
    var results = [Double](repeating: 0.0, count: x.count)
    vvremainder(&results, x, y, [Int32(x.count)])

    return results
}

// MARK: Square Root

public func sqrt(_ x: [Float]) -> [Float] {
    var results = [Float](repeating: 0.0, count: x.count)
    vvsqrtf(&results, x, [Int32(x.count)])

    return results
}

public func sqrt(_ x: [Double]) -> [Double] {
    var results = [Double](repeating: 0.0, count: x.count)
    vvsqrt(&results, x, [Int32(x.count)])

    return results
}

// MARK: Dot Product

public func dot(_ x: [Float], y: [Float]) -> Float {
    precondition(x.count == y.count, "Vectors must have equal count")

    var result: Float = 0.0
    vDSP_dotpr(x, 1, y, 1, &result, vDSP_Length(x.count))

    return result
}


public func dot(_ x: [Double], y: [Double]) -> Double {
    precondition(x.count == y.count, "Vectors must have equal count")

    var result: Double = 0.0
    vDSP_dotprD(x, 1, y, 1, &result, vDSP_Length(x.count))

    return result
}

// MARK: - Distance

public func dist(_ x: [Float], y: [Float]) -> Float {
    precondition(x.count == y.count, "Vectors must have equal count")
    let sub = x - y
    var squared = [Float](repeating: 0.0, count: x.count)
    vDSP_vsq(sub, 1, &squared, 1, vDSP_Length(x.count))
    
    return sqrt(sum(squared))
}

public func dist(_ x: [Double], y: [Double]) -> Double {
    precondition(x.count == y.count, "Vectors must have equal count")
    let sub = x - y
    var squared = [Double](repeating: 0.0, count: x.count)
    vDSP_vsqD(sub, 1, &squared, 1, vDSP_Length(x.count))
    
    return sqrt(sum(squared))
}

// MARK: - Operators

public func + (lhs: [Float], rhs: [Float]) -> [Float] {
    return add(lhs, y: rhs)
}

public func + (lhs: [Double], rhs: [Double]) -> [Double] {
    return add(lhs, y: rhs)
}

public func + (lhs: [Float], rhs: Float) -> [Float] {
    return add(lhs, y: [Float](repeating: rhs, count: lhs.count))
}

public func + (lhs: [Double], rhs: Double) -> [Double] {
    return add(lhs, y: [Double](repeating: rhs, count: lhs.count))
}

public func - (lhs: [Float], rhs: [Float]) -> [Float] {
    return sub(lhs, y: rhs)
}

public func - (lhs: [Double], rhs: [Double]) -> [Double] {
    return sub(lhs, y: rhs)
}

public func - (lhs: [Float], rhs: Float) -> [Float] {
    return sub(lhs, y: [Float](repeating: rhs, count: lhs.count))
}

public func - (lhs: [Double], rhs: Double) -> [Double] {
    return sub(lhs, y: [Double](repeating: rhs, count: lhs.count))
}

public func / (lhs: [Float], rhs: [Float]) -> [Float] {
    return div(lhs, y: rhs)
}

public func / (lhs: [Double], rhs: [Double]) -> [Double] {
    return div(lhs, y: rhs)
}

public func / (lhs: [Float], rhs: Float) -> [Float] {
    return div(lhs, y: [Float](repeating: rhs, count: lhs.count))
}

public func / (lhs: [Double], rhs: Double) -> [Double] {
    return div(lhs, y: [Double](repeating: rhs, count: lhs.count))
}

public func * (lhs: [Float], rhs: [Float]) -> [Float] {
    return mul(lhs, y: rhs)
}

public func * (lhs: [Double], rhs: [Double]) -> [Double] {
    return mul(lhs, y: rhs)
}

public func * (lhs: [Float], rhs: Float) -> [Float] {
    return mul(lhs, y: [Float](repeating: rhs, count: lhs.count))
}

public func * (lhs: [Double], rhs: Double) -> [Double] {
    return mul(lhs, y: [Double](repeating: rhs, count: lhs.count))
}

public func % (lhs: [Float], rhs: [Float]) -> [Float] {
    return mod(lhs, y: rhs)
}

public func % (lhs: [Double], rhs: [Double]) -> [Double] {
    return mod(lhs, y: rhs)
}

public func % (lhs: [Float], rhs: Float) -> [Float] {
    return mod(lhs, y: [Float](repeating: rhs, count: lhs.count))
}

public func % (lhs: [Double], rhs: Double) -> [Double] {
    return mod(lhs, y: [Double](repeating: rhs, count: lhs.count))
}

infix operator •
public func • (lhs: [Double], rhs: [Double]) -> Double {
    return dot(lhs, y: rhs)
}

public func • (lhs: [Float], rhs: [Float]) -> Float {
    return dot(lhs, y: rhs)
}
