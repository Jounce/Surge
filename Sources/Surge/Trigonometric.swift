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

public func sincos(_ x: [Float]) -> (sin: [Float], cos: [Float]) {
    var sin = [Float](repeating: 0.0, count: x.count)
    var cos = [Float](repeating: 0.0, count: x.count)
    withUnsafeMutableBufferPointersTo(&sin, &cos) { sin, cos in
        vvsincosf(sin.baseAddress!, cos.baseAddress!, x, [Int32(x.count)])
    }
    return (sin, cos)
}

public func sincos(_ x: [Double]) -> (sin: [Double], cos: [Double]) {
    var sin = [Double](repeating: 0.0, count: x.count)
    var cos = [Double](repeating: 0.0, count: x.count)
    withUnsafeMutableBufferPointersTo(&sin, &cos) { sin, cos in
        vvsincos(sin.baseAddress!, cos.baseAddress!, x, [Int32(x.count)])
    }
    return (sin, cos)
}

// MARK: Sine

public func sin(_ x: [Float]) -> [Float] {
    var results = [Float](repeating: 0.0, count: x.count)
    results.withUnsafeMutableBufferPointer { pointer in
        vvsinf(pointer.baseAddress!, x, [Int32(x.count)])
    }

    return results
}

public func sin(_ x: [Double]) -> [Double] {
    var results = [Double](repeating: 0.0, count: x.count)
    results.withUnsafeMutableBufferPointer { pointer in
        vvsin(pointer.baseAddress!, x, [Int32(x.count)])
    }

    return results
}

// MARK: Cosine

public func cos(_ x: [Float]) -> [Float] {
    var results = [Float](repeating: 0.0, count: x.count)
    results.withUnsafeMutableBufferPointer { pointer in
        vvcosf(pointer.baseAddress!, x, [Int32(x.count)])
    }

    return results
}

public func cos(_ x: [Double]) -> [Double] {
    var results = [Double](repeating: 0.0, count: x.count)
    results.withUnsafeMutableBufferPointer { pointer in
        vvcos(pointer.baseAddress!, x, [Int32(x.count)])
    }

    return results
}

// MARK: Tangent

public func tan(_ x: [Float]) -> [Float] {
    var results = [Float](repeating: 0.0, count: x.count)
    results.withUnsafeMutableBufferPointer { pointer in
        vvtanf(pointer.baseAddress!, x, [Int32(x.count)])
    }

    return results
}

public func tan(_ x: [Double]) -> [Double] {
    var results = [Double](repeating: 0.0, count: x.count)
    results.withUnsafeMutableBufferPointer { pointer in
        vvtan(pointer.baseAddress!, x, [Int32(x.count)])
    }

    return results
}

// MARK: Arcsine

public func asin(_ x: [Float]) -> [Float] {
    var results = [Float](repeating: 0.0, count: x.count)
    results.withUnsafeMutableBufferPointer { pointer in
        vvasinf(pointer.baseAddress!, x, [Int32(x.count)])
    }

    return results
}

public func asin(_ x: [Double]) -> [Double] {
    var results = [Double](repeating: 0.0, count: x.count)
    results.withUnsafeMutableBufferPointer { pointer in
        vvasin(pointer.baseAddress!, x, [Int32(x.count)])
    }

    return results
}

// MARK: Arccosine

public func acos(_ x: [Float]) -> [Float] {
    var results = [Float](repeating: 0.0, count: x.count)
    results.withUnsafeMutableBufferPointer { pointer in
        vvacosf(pointer.baseAddress!, x, [Int32(x.count)])
    }

    return results
}

public func acos(_ x: [Double]) -> [Double] {
    var results = [Double](repeating: 0.0, count: x.count)
    results.withUnsafeMutableBufferPointer { pointer in
        vvacos(pointer.baseAddress!, x, [Int32(x.count)])
    }

    return results
}

// MARK: Arctangent

public func atan(_ x: [Float]) -> [Float] {
    var results = [Float](repeating: 0.0, count: x.count)
    results.withUnsafeMutableBufferPointer { pointer in
        vvatanf(pointer.baseAddress!, x, [Int32(x.count)])
    }

    return results
}

public func atan(_ x: [Double]) -> [Double] {
    var results = [Double](repeating: 0.0, count: x.count)
    results.withUnsafeMutableBufferPointer { pointer in
        vvatan(pointer.baseAddress!, x, [Int32(x.count)])
    }

    return results
}

// MARK: -

// MARK: Radians to Degrees

func rad2deg(_ x: [Float]) -> [Float] {
    var results = [Float](repeating: 0.0, count: x.count)
    let divisor = [Float](repeating: Float.pi / 180.0, count: x.count)
    results.withUnsafeMutableBufferPointer { pointer in
        vvdivf(pointer.baseAddress!, x, divisor, [Int32(x.count)])
    }

    return results
}

func rad2deg(_ x: [Double]) -> [Double] {
    var results = [Double](repeating: 0.0, count: x.count)
    let divisor = [Double](repeating: Double.pi / 180.0, count: x.count)
    results.withUnsafeMutableBufferPointer { pointer in
        vvdiv(pointer.baseAddress!, x, divisor, [Int32(x.count)])
    }

    return results
}

// MARK: Degrees to Radians

func deg2rad(_ x: [Float]) -> [Float] {
    var results = [Float](repeating: 0.0, count: x.count)
    let divisor = [Float](repeating: 180.0 / Float.pi, count: x.count)
    results.withUnsafeMutableBufferPointer { pointer in
        vvdivf(pointer.baseAddress!, x, divisor, [Int32(x.count)])
    }

    return results
}

func deg2rad(_ x: [Double]) -> [Double] {
    var results = [Double](repeating: 0.0, count: x.count)
    let divisor = [Double](repeating: 180.0 / Double.pi, count: x.count)
    results.withUnsafeMutableBufferPointer { pointer in
        vvdiv(pointer.baseAddress!, x, divisor, [Int32(x.count)])
    }

    return results
}
