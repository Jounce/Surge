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

// MARK: Absolute Value

public func abs(x: RealArray) -> RealArray {
    let results = RealArray(count: x.count)
    vvfabs(results.pointer, x.pointer, [Int32(x.count)])

    return results
}

// MARK: Ceiling

public func ceil(x: RealArray) -> RealArray {
    let results = RealArray(count: x.count)
    vvceil(results.pointer, x.pointer, [Int32(x.count)])

    return results
}

// MARK: Clip

public func clip(x: RealArray, low: Double, high: Double) -> RealArray {
    var results = RealArray(count: x.count), y = low, z = high
    vDSP_vclipD(x.pointer, 1, &y, &z, results.pointer, 1, vDSP_Length(x.count))

    return results
}

// MARK: Copy Sign

public func copysign(sign: RealArray, magnitude: RealArray) -> RealArray {
    let results = RealArray(count: sign.count)
    vvcopysign(results.pointer, magnitude.pointer, sign.pointer, [Int32(sign.count)])

    return results
}

// MARK: Floor

public func floor(x: RealArray) -> RealArray {
    let results = RealArray(count: x.count)
    vvfloor(results.pointer, x.pointer, [Int32(x.count)])

    return results
}

// MARK: Negate

public func neg(x: RealArray) -> RealArray {
    let results = RealArray(count: x.count)
    vDSP_vnegD(x.pointer, 1, results.pointer, 1, vDSP_Length(x.count))

    return results
}

public func neg(x: [Complex]) -> [Complex] {
    var results = [Complex](count: x.count, repeatedValue: Complex())
    vDSP_vnegD(x.unsafePointer(), 1, results.unsafeMutablePointer(), 1, vDSP_Length(2*x.count))
    return results
}

// MARK: Reciprocal

public func rec(x: RealArray) -> RealArray {
    let results = RealArray(count: x.count)
    vvrec(results.pointer, x.pointer, [Int32(x.count)])

    return results
}

// MARK: Round

public func round(x: RealArray) -> RealArray {
    let results = RealArray(count: x.count)
    vvnint(results.pointer, x.pointer, [Int32(x.count)])

    return results
}

// MARK: Threshold

public func threshold(x: RealArray, low: Double) -> RealArray {
    var results = RealArray(count: x.count), y = low
    vDSP_vthrD(x.pointer, 1, &y, results.pointer, 1, vDSP_Length(x.count))

    return results
}

// MARK: Truncate

public func trunc(x: RealArray) -> RealArray {
    let results = RealArray(count: x.count)
    vvint(results.pointer, x.pointer, [Int32(x.count)])

    return results
}

// MARK: Power

public func pow(x: RealArray, y: RealArray) -> RealArray {
    let results = RealArray(count: x.count)
    vvpow(results.pointer, x.pointer, y.pointer, [Int32(x.count)])

    return results
}
