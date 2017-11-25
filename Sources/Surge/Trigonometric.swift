// Copyright © 2014–2015 Mattt Thompson (http://mattt.me)
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

public func sincos<X: ContinuousCollection>(_ x: X) -> (sin: [Float], cos: [Float]) where X.Iterator.Element == Float {
    var sin = [Float](repeating: 0.0, count: numericCast(x.count))
    var cos = [Float](repeating: 0.0, count: numericCast(x.count))
    withUnsafeMutableBufferPointersTo(&sin, &cos) { sin, cos in
        withUnsafePointersAndCountsTo(x) { xp, xc in
            vvsincosf(sin.baseAddress!, cos.baseAddress!, xp, [Int32(xc)])
        }
    }
    return (sin, cos)
}

public func sincos<X: ContinuousCollection>(_ x: X) -> (sin: [Double], cos: [Double]) where X.Iterator.Element == Double {
    var sin = [Double](repeating: 0.0, count: numericCast(x.count))
    var cos = [Double](repeating: 0.0, count: numericCast(x.count))
    withUnsafeMutableBufferPointersTo(&sin, &cos) { sin, cos in
        withUnsafePointersAndCountsTo(x) { xp, xc in
            vvsincos(sin.baseAddress!, cos.baseAddress!, xp, [Int32(xc)])
        }
    }
    return (sin, cos)
}

// MARK: Sine

public func sin<X: ContinuousCollection>(_ x: X) -> [Float] where X.Iterator.Element == Float {
    var results = [Float](repeating: 0.0, count: numericCast(x.count))
    results.withUnsafeMutableBufferPointer { pointer in
        withUnsafePointersAndCountsTo(x) { xp, xc in
            vvsinf(pointer.baseAddress!, xp, [Int32(xc)])
        }
    }
    return results
}

public func sin<X: ContinuousCollection>(_ x: X) -> [Double] where X.Iterator.Element == Double {
    var results = [Double](repeating: 0.0, count: numericCast(x.count))
    results.withUnsafeMutableBufferPointer { pointer in
        withUnsafePointersAndCountsTo(x) { xp, xc in
            vvsin(pointer.baseAddress!, xp, [Int32(xc)])
        }
    }
    return results
}

// MARK: Cosine

public func cos<X: ContinuousCollection>(_ x: X) -> [Float] where X.Iterator.Element == Float {
    var results = [Float](repeating: 0.0, count: numericCast(x.count))
    results.withUnsafeMutableBufferPointer { pointer in
        withUnsafePointersAndCountsTo(x) { xp, xc in
            vvcosf(pointer.baseAddress!, xp, [Int32(xc)])
        }
    }
    return results
}

public func cos<X: ContinuousCollection>(_ x: X) -> [Double] where X.Iterator.Element == Double {
    var results = [Double](repeating: 0.0, count: numericCast(x.count))
    results.withUnsafeMutableBufferPointer { pointer in
        withUnsafePointersAndCountsTo(x) { xp, xc in
            vvcos(pointer.baseAddress!, xp, [Int32(xc)])
        }
    }
    return results
}

// MARK: Tangent

public func tan<X: ContinuousCollection>(_ x: X) -> [Float] where X.Iterator.Element == Float {
    var results = [Float](repeating: 0.0, count: numericCast(x.count))
    results.withUnsafeMutableBufferPointer { pointer in
        withUnsafePointersAndCountsTo(x) { xp, xc in
            vvtanf(pointer.baseAddress!, xp, [Int32(xc)])
        }
    }
    return results
}

public func tan<X: ContinuousCollection>(_ x: X) -> [Double] where X.Iterator.Element == Double {
    var results = [Double](repeating: 0.0, count: numericCast(x.count))
    results.withUnsafeMutableBufferPointer { pointer in
        withUnsafePointersAndCountsTo(x) { xp, xc in
            vvtan(pointer.baseAddress!, xp, [Int32(xc)])
        }
    }
    return results
}

// MARK: Arcsine

public func asin<X: ContinuousCollection>(_ x: X) -> [Float] where X.Iterator.Element == Float {
    var results = [Float](repeating: 0.0, count: numericCast(x.count))
    results.withUnsafeMutableBufferPointer { pointer in
        withUnsafePointersAndCountsTo(x) { xp, xc in
            vvasinf(pointer.baseAddress!, xp, [Int32(xc)])
        }
    }
    return results
}

public func asin<X: ContinuousCollection>(_ x: X) -> [Double] where X.Iterator.Element == Double {
    var results = [Double](repeating: 0.0, count: numericCast(x.count))
    results.withUnsafeMutableBufferPointer { pointer in
        withUnsafePointersAndCountsTo(x) { xp, xc in
            vvasin(pointer.baseAddress!, xp, [Int32(xc)])
        }
    }
    return results
}

// MARK: Arccosine

public func acos<X: ContinuousCollection>(_ x: X) -> [Float] where X.Iterator.Element == Float {
    var results = [Float](repeating: 0.0, count: numericCast(x.count))
    results.withUnsafeMutableBufferPointer { pointer in
        withUnsafePointersAndCountsTo(x) { xp, xc in
            vvacosf(pointer.baseAddress!, xp, [Int32(xc)])
        }
    }
    return results
}

public func acos<X: ContinuousCollection>(_ x: X) -> [Double] where X.Iterator.Element == Double {
    var results = [Double](repeating: 0.0, count: numericCast(x.count))
    results.withUnsafeMutableBufferPointer { pointer in
        withUnsafePointersAndCountsTo(x) { xp, xc in
            vvacos(pointer.baseAddress!, xp, [Int32(xc)])
        }
    }
    return results
}

// MARK: Arctangent

public func atan<X: ContinuousCollection>(_ x: X) -> [Float] where X.Iterator.Element == Float {
    var results = [Float](repeating: 0.0, count: numericCast(x.count))
    results.withUnsafeMutableBufferPointer { pointer in
        withUnsafePointersAndCountsTo(x) { xp, xc in
            vvatanf(pointer.baseAddress!, xp, [Int32(xc)])
        }
    }
    return results
}

public func atan<X: ContinuousCollection>(_ x: X) -> [Double] where X.Iterator.Element == Double {
    var results = [Double](repeating: 0.0, count: numericCast(x.count))
    results.withUnsafeMutableBufferPointer { pointer in
        withUnsafePointersAndCountsTo(x) { xp, xc in
            vvatan(pointer.baseAddress!, xp, [Int32(xc)])
        }
    }
    return results
}

// MARK: -

// MARK: Radians to Degrees

func rad2deg<X: ContinuousCollection>(_ x: X) -> [Float] where X.Iterator.Element == Float {
    var results = [Float](repeating: 0.0, count: numericCast(x.count))
    let divisor = [Float](repeating: Float.pi / 180.0, count: numericCast(x.count))
    results.withUnsafeMutableBufferPointer { pointer in
        withUnsafePointersAndCountsTo(x) { xp, xc in
            vvdivf(pointer.baseAddress!, xp, divisor, [Int32(xc)])
        }
    }
    return results
}

func rad2deg<X: ContinuousCollection>(_ x: X) -> [Double] where X.Iterator.Element == Double {
    var results = [Double](repeating: 0.0, count: numericCast(x.count))
    let divisor = [Double](repeating: Double.pi / 180.0, count: numericCast(x.count))
    results.withUnsafeMutableBufferPointer { pointer in
        withUnsafePointersAndCountsTo(x) { xp, xc in
            vvdiv(pointer.baseAddress!, xp, divisor, [Int32(xc)])
        }
    }
    return results
}

// MARK: Degrees to Radians

func deg2rad<X: ContinuousCollection>(_ x: X) -> [Float] where X.Iterator.Element == Float {
    var results = [Float](repeating: 0.0, count: numericCast(x.count))
    let divisor = [Float](repeating: 180.0 / Float.pi, count: numericCast(x.count))
    results.withUnsafeMutableBufferPointer { pointer in
        withUnsafePointersAndCountsTo(x) { xp, xc in
            vvdivf(pointer.baseAddress!, xp, divisor, [Int32(xc)])
        }
    }
    return results
}

func deg2rad<X: ContinuousCollection>(_ x: X) -> [Double] where X.Iterator.Element == Double {
    var results = [Double](repeating: 0.0, count: numericCast(x.count))
    let divisor = [Double](repeating: 180.0 / Double.pi, count: numericCast(x.count))
    results.withUnsafeMutableBufferPointer { pointer in
        withUnsafePointersAndCountsTo(x) { xp, xc in
            vvdiv(pointer.baseAddress!, xp, divisor, [Int32(xc)])
        }
    }
    return results
}
