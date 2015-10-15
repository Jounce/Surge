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
    return sum(x, range: 0..<x.count)
}

public func sum(x: [Float], range: Range<Int> ) -> Float {
    var result: Float = 0.0
    let p = floatPointer(x) + range.startIndex
    vDSP_sve(p, 1, &result, vDSP_Length(range.count))

    return result
}

public func sum(x: [Double]) -> Double {
    return sum(x, range: 0..<x.count)
}

public func sum(x: [Double], range: Range<Int>) -> Double {
    var result: Double = 0.0
    let p = doublePointer(x) + range.startIndex
    vDSP_sveD(p, 1, &result, vDSP_Length(range.count))

    return result
}

public func sum(x: [Complex]) -> Complex {
    return sum(x, range: 0..<x.count)
}

public func sum(x: [Complex], range: Range<Int>) -> Complex {
    let reals = doublePointer(x) + range.startIndex
    let imags = doublePointer(x) + range.startIndex + 1

    var result = Complex()
    vDSP_sveD(reals, 2, &result.real, vDSP_Length(range.count))
    vDSP_sveD(imags, 2, &result.imag, vDSP_Length(range.count))

    return result
}

// MARK: Sum of Absolute Values

public func asum(x: [Float]) -> Float {
    return asum(x, range: 0..<x.count)
}

public func asum(x: [Float], range: Range<Int>) -> Float {
    let p = floatPointer(x) + range.startIndex
    return cblas_sasum(Int32(range.count), p, 1)
}

public func asum(x: [Double]) -> Double {
    return asum(x, range: 0..<x.count)
}

public func asum(x: [Double], range: Range<Int>) -> Double {
    let p = doublePointer(x) + range.startIndex
    return cblas_dasum(Int32(range.count), p, 1)
}

// MARK: Maximum

public func max(x: [Float]) -> Float {
    return max(x, range: 0..<x.count)
}

public func max(x: [Float], range: Range<Int>) -> Float {
    let p = floatPointer(x) + range.startIndex

    var result: Float = 0.0
    vDSP_maxv(p, 1, &result, vDSP_Length(range.count))

    return result
}

public func max(x: [Double]) -> Double {
    return max(x, range: 0..<x.count)
}

public func max(x: [Double], range: Range<Int>) -> Double {
    let p = doublePointer(x) + range.startIndex

    var result: Double = 0.0
    vDSP_maxvD(p, 1, &result, vDSP_Length(range.count))

    return result
}

// MARK: Minimum

public func min(x: [Float]) -> Float {
    return min(x, range: 0..<x.count)
}

public func min(x: [Float], range: Range<Int>) -> Float {
    let p = floatPointer(x) + range.startIndex

    var result: Float = 0.0
    vDSP_minv(p, 1, &result, vDSP_Length(range.count))

    return result
}

public func min(x: [Double]) -> Double {
    return min(x, range: 0..<x.count)
}

public func min(x: [Double], range: Range<Int>) -> Double {
    let p = doublePointer(x) + range.startIndex

    var result: Double = 0.0
    vDSP_minvD(p, 1, &result, vDSP_Length(range.count))

    return result
}

// MARK: Mean

public func mean(x: [Float]) -> Float {
    return mean(x, range: 0..<x.count)
}

public func mean(x: [Float], range: Range<Int>) -> Float {
    let p = floatPointer(x) + range.startIndex

    var result: Float = 0.0
    vDSP_meanv(p, 1, &result, vDSP_Length(range.count))

    return result
}

public func mean(x: [Double]) -> Double {
    return mean(x, range: 0..<x.count)
}

public func mean(x: [Double], range: Range<Int>) -> Double {
    let p = doublePointer(x) + range.startIndex

    var result: Double = 0.0
    vDSP_meanvD(p, 1, &result, vDSP_Length(range.count))

    return result
}

// MARK: Mean Magnitude

public func meamg(x: [Float]) -> Float {
    return meamg(x, range: 0..<x.count)
}

public func meamg(x: [Float], range: Range<Int>) -> Float {
    let p = floatPointer(x) + range.startIndex

    var result: Float = 0.0
    vDSP_meamgv(p, 1, &result, vDSP_Length(range.count))

    return result
}

public func meamg(x: [Double]) -> Double {
    return meamg(x, range: 0..<x.count)
}

public func meamg(x: [Double], range: Range<Int>) -> Double {
    let p = doublePointer(x) + range.startIndex

    var result: Double = 0.0
    vDSP_meamgvD(p, 1, &result, vDSP_Length(range.count))

    return result
}

// MARK: Mean Square Value

public func measq(x: [Float]) -> Float {
    return measq(x, range: 0..<x.count)
}

public func measq(x: [Float], range: Range<Int>) -> Float {
    let p = floatPointer(x) + range.startIndex

    var result: Float = 0.0
    vDSP_measqv(p, 1, &result, vDSP_Length(range.count))

    return result
}

public func measq(x: [Double]) -> Double {
    return measq(x, range: 0..<x.count)
}

public func measq(x: [Double], range: Range<Int>) -> Double {
    let p = doublePointer(x) + range.startIndex

    var result: Double = 0.0
    vDSP_measqvD(p, 1, &result, vDSP_Length(range.count))

    return result
}

// MARK: RMS

public func rmsq(x: [Float]) -> Float {
    return rmsq(x, range: 0..<x.count)
}

public func rmsq(x: [Float], range: Range<Int>) -> Float {
    let p = floatPointer(x) + range.startIndex

    var result: Float = 0.0
    vDSP_rmsqv(p, 1, &result, vDSP_Length(range.count))

    return result
}

public func rmsq(x: [Double]) -> Double {
    return rmsq(x, range: 0..<x.count)
}

public func rmsq(x: [Double], range: Range<Int>) -> Double {
    let p = doublePointer(x) + range.startIndex

    var result: Double = 0.0
    vDSP_rmsqvD(p, 1, &result, vDSP_Length(range.count))

    return result
}

// MARK: Modulo

public func mod(x: [Float], _ y: [Float]) -> [Float] {
    var results = [Float](count: x.count, repeatedValue: 0.0)
    vvfmodf(&results, x, y, [Int32(x.count)])

    return results
}

public func mod(x: [Double], _ y: [Double]) -> [Double] {
    var results = [Double](count: x.count, repeatedValue: 0.0)
    vvfmod(&results, x, y, [Int32(x.count)])

    return results
}

// MARK: Remainder

public func remainder(x: [Float], _ y: [Float]) -> [Float] {
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

public func dot(x: [Float], _ y: [Float]) -> Float {
    precondition(x.count == y.count, "Vectors must have equal count")

    var result: Float = 0.0
    vDSP_dotpr(x, 1, y, 1, &result, vDSP_Length(x.count))

    return result
}

public func dot(x: [Double], _ y: [Double]) -> Double {
    precondition(x.count == y.count, "Vectors must have equal count")

    var result: Double = 0.0
    vDSP_dotprD(x, 1, y, 1, &result, vDSP_Length(x.count))

    return result
}

// MARK: - Operators

public func + (lhs: [Float], rhs: [Float]) -> [Float] {
    var results = [Float](rhs)
    cblas_saxpy(Int32(lhs.count), 1.0, lhs, 1, &results, 1)
    
    return results
}

public func + (lhs: [Double], rhs: [Double]) -> [Double] {
    var results = [Double](rhs)
    cblas_daxpy(Int32(lhs.count), 1.0, lhs, 1, &results, 1)
    
    return results
}

public func + (lhs: [Complex], rhs: [Complex]) -> [Complex] {
    var results = [Complex](count: lhs.count, repeatedValue: Complex())
    vDSP_vaddD(doublePointer(lhs), 1, doublePointer(rhs), 1, mutableDoublePointer(&results), 1, vDSP_Length(lhs.count))
    
    return results
}

public func + (lhs: [Float], var rhs: Float) -> [Float] {
    var result = [Float](count: lhs.count, repeatedValue: 0.0)
    vDSP_vsadd(lhs, 1, &rhs, &result, 1, vDSP_Length(lhs.count))
    
    return result
}

public func + (lhs: [Double], var rhs: Double) -> [Double] {
    var result = [Double](count: lhs.count, repeatedValue: 0.0)
    vDSP_vsaddD(lhs, 1, &rhs, &result, 1, vDSP_Length(lhs.count))
    
    return result
}

public func + (lhs: [Complex], var rhs: Complex) -> [Complex] {
    var result = [Complex](count: lhs.count, repeatedValue: Complex())
    vDSP_vsaddD(doublePointer(lhs), 2, &rhs.real, &(result[0].real), 2, vDSP_Length(lhs.count))
    vDSP_vsaddD(doublePointer(lhs) + 1, 2, &rhs.imag, &(result[0].imag), 2, vDSP_Length(lhs.count))
    
    return result
}

public func - (lhs: [Float], rhs: [Float]) -> [Float] {
    var results = [Float](count: lhs.count, repeatedValue: 0.0)
    vDSP_vsub(rhs, 1, lhs, 1, &results, 1, vDSP_Length(lhs.count))
    
    return results
}

public func - (lhs: [Double], rhs: [Double]) -> [Double] {
    var results = [Double](count: lhs.count, repeatedValue: 0.0)
    vDSP_vsubD(rhs, 1, lhs, 1, &results, 1, vDSP_Length(lhs.count))
    
    return results
}

public func - (var lhs: [Complex], var rhs: [Complex]) -> [Complex] {
    var results = [Complex](count: lhs.count / 2, repeatedValue: Complex())
    vDSP_vsubD(&(rhs[0].real), 2, &(lhs[0].real), 2, &(results[0].real), 2, vDSP_Length(lhs.count / 2))
    vDSP_vsubD(&(rhs[0].imag), 2, &(lhs[0].imag), 2, &(results[0].imag), 2, vDSP_Length(lhs.count / 2))
    
    return results
}

public func - (lhs: [Float], rhs: Float) -> [Float] {
    var result = [Float](count: lhs.count, repeatedValue: 0.0)
    var scalar: Float = -1 * rhs
    vDSP_vsadd(lhs, 1, &scalar, &result, 1, vDSP_Length(lhs.count))
    
    return result
}

public func - (lhs: [Double], rhs: Double) -> [Double] {
    var result = [Double](count: lhs.count, repeatedValue: 0.0)
    var scalar: Double = -1 * rhs
    vDSP_vsaddD(lhs, 1, &scalar, &result, 1, vDSP_Length(lhs.count))
    
    return result
}

public func - (lhs: [Complex], rhs: Complex) -> [Complex] {
    var result = [Complex](count: lhs.count, repeatedValue: Complex())
    var scalar: Complex = -1 * rhs
    vDSP_vsaddD(doublePointer(lhs), 2, &scalar.real, &(result[0].real), 2, vDSP_Length(lhs.count))
    vDSP_vsaddD(doublePointer(lhs) + 1, 2, &scalar.imag, &(result[0].imag), 2, vDSP_Length(lhs.count))
    
    return result
}

public func / (lhs: [Float], rhs: [Float]) -> [Float] {
    var results = [Float](count: lhs.count, repeatedValue: 0.0)
    vvdivf(&results, lhs, rhs, [Int32(lhs.count)])

    return results
}

public func / (lhs: [Double], rhs: [Double]) -> [Double] {
    var results = [Double](count: lhs.count, repeatedValue: 0.0)
    vvdiv(&results, lhs, rhs, [Int32(lhs.count)])

    return results
}

public func / (lhs: [Complex], rhs: [Double]) -> [Complex] {
    var results = [Complex](count: lhs.count, repeatedValue: Complex())
    vDSP_vdivD(doublePointer(lhs), 2, rhs, 1, mutableDoublePointer(&results), 2, vDSP_Length(lhs.count))
    vDSP_vdivD(doublePointer(lhs) + 1, 2, rhs, 1, mutableDoublePointer(&results) + 1, 2, vDSP_Length(lhs.count))

    return results
}

public func / (lhs: [Float], var rhs: Float) -> [Float] {
    var results = [Float](count: lhs.count, repeatedValue: 0.0)
    vDSP_vsdiv(floatPointer(lhs), 1, &rhs, mutableFloatPointer(&results), 1, vDSP_Length(lhs.count))
    return results
}

public func / (lhs: [Double], var rhs: Double) -> [Double] {
    var results = [Double](count: lhs.count, repeatedValue: 0.0)
    vDSP_vsdivD(doublePointer(lhs), 1, &rhs, mutableDoublePointer(&results), 1, vDSP_Length(lhs.count))
    return results
}

public func / (lhs: [Complex], var rhs: Double) -> [Complex] {
    var results = [Complex](count: lhs.count, repeatedValue: Complex())
    vDSP_vsdivD(doublePointer(lhs), 1, &rhs, mutableDoublePointer(&results), 1, vDSP_Length(2 * lhs.count))
    return results
}

public func * (lhs: [Float], rhs: [Float]) -> [Float] {
    var results = [Float](count: lhs.count, repeatedValue: 0.0)
    vDSP_vmul(lhs, 1, rhs, 1, &results, 1, vDSP_Length(lhs.count))

    return results
}

public func * (lhs: [Double], rhs: [Double]) -> [Double] {
    var results = [Double](count: lhs.count, repeatedValue: 0.0)
    vDSP_vmulD(lhs, 1, rhs, 1, &results, 1, vDSP_Length(lhs.count))

    return results
}

public func * (lhs: [Complex], rhs: [Double]) -> [Complex] {
    var results = [Complex](count: lhs.count, repeatedValue: Complex())
    vDSP_vmulD(doublePointer(lhs), 2, rhs, 1, mutableDoublePointer(&results), 2, vDSP_Length(lhs.count))
    vDSP_vmulD(doublePointer(lhs) + 1, 2, rhs, 1, mutableDoublePointer(&results) + 1, 2, vDSP_Length(lhs.count))

    return results
}

public func * (lhs: [Double], rhs: [Complex]) -> [Complex] {
    return rhs * lhs
}

public func * (lhs: [Float], var rhs: Float) -> [Float] {
    var result = [Float](count: lhs.count, repeatedValue: 0.0)
    vDSP_vsmul(lhs, 1, &rhs, &result, 1, vDSP_Length(lhs.count))

    return result
}

public func * (lhs: Float, rhs: [Float]) -> [Float] {
    return rhs * lhs
}

public func * (lhs: [Double], var rhs: Double) -> [Double] {
    var result = [Double](count: lhs.count, repeatedValue: 0.0)
    vDSP_vsmulD(lhs, 1, &rhs, &result, 1, vDSP_Length(lhs.count))

    return result
}

public func * (lhs: Double, rhs: [Double]) -> [Double] {
    return rhs * lhs
}

public func * (lhs: [Complex], var rhs: Double) -> [Complex] {
    var result = [Complex](count: lhs.count, repeatedValue: Complex())
    vDSP_vsmulD(doublePointer(lhs), 1, &rhs, &(result[0].real), 1, vDSP_Length(lhs.count * 2))

    return result
}

public func % (lhs: [Float], rhs: [Float]) -> [Float] {
    return mod(lhs, rhs)
}

public func % (lhs: [Double], rhs: [Double]) -> [Double] {
    return mod(lhs, rhs)
}

public func % (lhs: [Float], rhs: Float) -> [Float] {
    return mod(lhs, [Float](count: lhs.count, repeatedValue: rhs))
}

public func % (lhs: [Double], rhs: Double) -> [Double] {
    return mod(lhs, [Double](count: lhs.count, repeatedValue: rhs))
}

infix operator • {}
public func • (lhs: [Double], rhs: [Double]) -> Double {
    return dot(lhs, rhs)
}

public func • (lhs: [Float], rhs: [Float]) -> Float {
    return dot(lhs, rhs)
}
