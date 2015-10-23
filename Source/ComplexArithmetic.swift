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


public func sum(x: [Complex]) -> Complex {
    return sum(x, range: 0..<x.count)
}

public func sum(x: [Complex], range: Range<Int>) -> Complex {
    let reals = x.unsafePointer() + range.startIndex
    let imags = x.unsafePointer() + range.startIndex + 1
    
    var result = Complex()
    vDSP_sveD(reals, 2, &result.real, vDSP_Length(range.count))
    vDSP_sveD(imags, 2, &result.imag, vDSP_Length(range.count))
    
    return result
}

// MARK: - Operators

public func + (lhs: [Complex], rhs: [Complex]) -> [Complex] {
    var results = [Complex](count: lhs.count, repeatedValue: Complex())
    vDSP_vaddD(lhs.unsafePointer(), 1, rhs.unsafePointer(), 1, results.unsafeMutablePointer(), 1, vDSP_Length(lhs.count))
    
    return results
}

public func + (lhs: [Complex], var rhs: Complex) -> [Complex] {
    var result = [Complex](count: lhs.count, repeatedValue: Complex())
    vDSP_vsaddD(lhs.unsafePointer(), 2, &rhs.real, &(result[0].real), 2, vDSP_Length(lhs.count))
    vDSP_vsaddD(lhs.unsafePointer() + 1, 2, &rhs.imag, &(result[0].imag), 2, vDSP_Length(lhs.count))
    
    return result
}

public func - (lhs: [Complex], rhs: Complex) -> [Complex] {
    var result = [Complex](count: lhs.count, repeatedValue: Complex())
    var scalar: Complex = -1 * rhs
    vDSP_vsaddD(lhs.unsafePointer(), 2, &scalar.real, &(result[0].real), 2, vDSP_Length(lhs.count))
    vDSP_vsaddD(lhs.unsafePointer() + 1, 2, &scalar.imag, &(result[0].imag), 2, vDSP_Length(lhs.count))
    
    return result
}

public func / (lhs: [Complex], rhs: RealArray) -> [Complex] {
    var results = [Complex](count: lhs.count, repeatedValue: Complex())
    vDSP_vdivD(lhs.unsafePointer(), 2, rhs.pointer, 1, results.unsafeMutablePointer(), 2, vDSP_Length(lhs.count))
    vDSP_vdivD(lhs.unsafePointer() + 1, 2, rhs.pointer, 1, results.unsafeMutablePointer() + 1, 2, vDSP_Length(lhs.count))
    
    return results
}

public func / (lhs: [Complex], var rhs: Real) -> [Complex] {
    var results = [Complex](count: lhs.count, repeatedValue: Complex())
    vDSP_vsdivD(lhs.unsafePointer(), 1, &rhs, results.unsafeMutablePointer(), 1, vDSP_Length(2 * lhs.count))
    return results
}

public func * (lhs: [Complex], rhs: RealArray) -> [Complex] {
    var results = [Complex](count: lhs.count, repeatedValue: Complex())
    vDSP_vmulD(lhs.unsafePointer(), 2, rhs.pointer, 1, results.unsafeMutablePointer(), 2, vDSP_Length(lhs.count))
    vDSP_vmulD(lhs.unsafePointer() + 1, 2, rhs.pointer, 1, results.unsafeMutablePointer() + 1, 2, vDSP_Length(lhs.count))
    
    return results
}

public func * (lhs: [Complex], var rhs: Real) -> [Complex] {
    var result = [Complex](count: lhs.count, repeatedValue: Complex())
    vDSP_vsmulD(lhs.unsafePointer(), 1, &rhs, &(result[0].real), 1, vDSP_Length(lhs.count * 2))
    
    return result
}
