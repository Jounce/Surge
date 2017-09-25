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

// MARK: Power

public func pow<X: ContinuousCollection, Y: ContinuousCollection>(_ x: X, _ y: Y) -> [Float] where X.Iterator.Element == Float, Y.Iterator.Element == Float {
    var results = [Float](repeating: 0.0, count: numericCast(x.count))
    results.withUnsafeMutableBufferPointer { pointer in
        withUnsafePointersAndCountsTo(x, y) { xp, xc, yp, _ in
            vvpowf(pointer.baseAddress!, xp, yp, [Int32(xc)])
        }
    }
    return results
}

public func pow<X: ContinuousCollection, Y: ContinuousCollection>(_ x: X, _ y: Y) -> [Double] where X.Iterator.Element == Double, Y.Iterator.Element == Double {
    var results = [Double](repeating: 0.0, count: numericCast(x.count))
    results.withUnsafeMutableBufferPointer { pointer in
        withUnsafePointersAndCountsTo(x, y) { xp, xc, yp, _ in
            vvpow(pointer.baseAddress!, xp, yp, [Int32(xc)])
        }
    }
    return results
}

public func pow<X: ContinuousCollection>(_ x: X, _ y: Float) -> [Float] where X.Iterator.Element == Float {
    let yVec = [Float](repeating: y, count: numericCast(x.count))
    return pow(yVec, x)
}

public func pow<X: ContinuousCollection>(_ x: X, _ y: Double) -> [Double] where X.Iterator.Element == Double {
    let yVec = [Double](repeating: y, count: numericCast(x.count))
    return pow(yVec, x)
}
