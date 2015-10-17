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

// MARK: Sine-Cosine

public func sincos(x: RealArray) -> (sin: RealArray, cos: RealArray) {
    let sin = RealArray(count: x.count, repeatedValue: 0.0)
    let cos = RealArray(count: x.count, repeatedValue: 0.0)
    vvsincos(sin.pointer, cos.pointer, x.pointer, [Int32(x.count)])

    return (sin, cos)
}

// MARK: Sine

public func sin(x: RealArray) -> RealArray {
    let results = RealArray(count: x.count, repeatedValue: 0.0)
    vvsin(results.pointer, x.pointer, [Int32(x.count)])

    return results
}

// MARK: Cosine

public func cos(x: RealArray) -> RealArray {
    let results = RealArray(count: x.count, repeatedValue: 0.0)
    vvcos(results.pointer, x.pointer, [Int32(x.count)])

    return results
}

// MARK: Tangent

public func tan(x: RealArray) -> RealArray {
    let results = RealArray(count: x.count, repeatedValue: 0.0)
    vvtan(results.pointer, x.pointer, [Int32(x.count)])

    return results
}

// MARK: Arcsine

public func asin(x: RealArray) -> RealArray {
    let results = RealArray(count: x.count, repeatedValue: 0.0)
    vvasin(results.pointer, x.pointer, [Int32(x.count)])

    return results
}

// MARK: Arccosine

public func acos(x: RealArray) -> RealArray {
    let results = RealArray(count: x.count, repeatedValue: 0.0)
    vvacos(results.pointer, x.pointer, [Int32(x.count)])

    return results
}

// MARK: Arctangent

public func atan(x: RealArray) -> RealArray {
    let results = RealArray(count: x.count, repeatedValue: 0.0)
    vvatan(results.pointer, x.pointer, [Int32(x.count)])

    return results
}

// MARK: -

// MARK: Radians to Degrees

func rad2deg(x: RealArray) -> RealArray {
    let results = RealArray(count: x.count, repeatedValue: 0.0)
    let divisor = RealArray(count: x.count, repeatedValue: M_PI / 180.0)
    vvdiv(results.pointer, x.pointer, divisor.pointer, [Int32(x.count)])

    return results
}

// MARK: Degrees to Radians

func deg2rad(x: RealArray) -> RealArray {
    let results = RealArray(count: x.count, repeatedValue: 0.0)
    let divisor = RealArray(count: x.count, repeatedValue: 180.0 / M_PI)
    vvdiv(results.pointer, x.pointer, divisor.pointer, [Int32(x.count)])

    return results
}
