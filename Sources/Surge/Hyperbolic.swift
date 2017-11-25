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

// MARK: Hyperbolic Sine

public func sinh<X: ContinuousCollection>(_ x: X) -> [Float] where X.Iterator.Element == Float {
    var results = [Float](repeating: 0.0, count: numericCast(x.count))
    results.withUnsafeMutableBufferPointer { rbp in
        withUnsafePointersAndCountsTo(x) { xp, xc in
            vvsinhf(rbp.baseAddress!, xp, [Int32(xc)])
        }
    }

    return results
}

public func sinh<X: ContinuousCollection>(_ x: X) -> [Double] where X.Iterator.Element == Double {
    var results = [Double](repeating: 0.0, count: numericCast(x.count))
    results.withUnsafeMutableBufferPointer { rbp in
        withUnsafePointersAndCountsTo(x) { xp, xc in
            vvsinh(rbp.baseAddress!, xp, [Int32(xc)])
        }
    }

    return results
}

// MARK: Hyperbolic Cosine

public func cosh<X: ContinuousCollection>(_ x: X) -> [Float] where X.Iterator.Element == Float {
    var results = [Float](repeating: 0.0, count: numericCast(x.count))
    results.withUnsafeMutableBufferPointer { rbp in
        withUnsafePointersAndCountsTo(x) { xp, xc in
            vvcoshf(rbp.baseAddress!, xp, [Int32(xc)])
        }
    }

    return results
}

public func cosh<X: ContinuousCollection>(_ x: X) -> [Double] where X.Iterator.Element == Double {
    var results = [Double](repeating: 0.0, count: numericCast(x.count))
    results.withUnsafeMutableBufferPointer { rbp in
        withUnsafePointersAndCountsTo(x) { xp, xc in
            vvcosh(rbp.baseAddress!, xp, [Int32(xc)])
        }
    }

    return results
}

// MARK: Hyperbolic Tangent

public func tanh<X: ContinuousCollection>(_ x: X) -> [Float] where X.Iterator.Element == Float {
    var results = [Float](repeating: 0.0, count: numericCast(x.count))
    results.withUnsafeMutableBufferPointer { rbp in
        withUnsafePointersAndCountsTo(x) { xp, xc in
            vvtanhf(rbp.baseAddress!, xp, [Int32(xc)])
        }
    }

    return results
}

public func tanh<X: ContinuousCollection>(_ x: X) -> [Double] where X.Iterator.Element == Double {
    var results = [Double](repeating: 0.0, count: numericCast(x.count))
    results.withUnsafeMutableBufferPointer { rbp in
        withUnsafePointersAndCountsTo(x) { xp, xc in
            vvtanh(rbp.baseAddress!, xp, [Int32(xc)])
        }
    }

    return results
}

// MARK: Inverse Hyperbolic Sine

public func asinh<X: ContinuousCollection>(_ x: X) -> [Float] where X.Iterator.Element == Float {
    var results = [Float](repeating: 0.0, count: numericCast(x.count))
    results.withUnsafeMutableBufferPointer { rbp in
        withUnsafePointersAndCountsTo(x) { xp, xc in
            vvasinhf(rbp.baseAddress!, xp, [Int32(xc)])
        }
    }

    return results
}

public func asinh<X: ContinuousCollection>(_ x: X) -> [Double] where X.Iterator.Element == Double {
    var results = [Double](repeating: 0.0, count: numericCast(x.count))
    results.withUnsafeMutableBufferPointer { rbp in
        withUnsafePointersAndCountsTo(x) { xp, xc in
            vvasinh(rbp.baseAddress!, xp, [Int32(xc)])
        }
    }

    return results
}

// MARK: Inverse Hyperbolic Cosine

public func acosh<X: ContinuousCollection>(_ x: X) -> [Float] where X.Iterator.Element == Float {
    var results = [Float](repeating: 0.0, count: numericCast(x.count))
    results.withUnsafeMutableBufferPointer { rbp in
        withUnsafePointersAndCountsTo(x) { xp, xc in
            vvacoshf(rbp.baseAddress!, xp, [Int32(xc)])
        }
    }

    return results
}

public func acosh<X: ContinuousCollection>(_ x: X) -> [Double] where X.Iterator.Element == Double {
    var results = [Double](repeating: 0.0, count: numericCast(x.count))
    results.withUnsafeMutableBufferPointer { rbp in
        withUnsafePointersAndCountsTo(x) { xp, xc in
            vvacosh(rbp.baseAddress!, xp, [Int32(xc)])
        }
    }

    return results
}

// MARK: Inverse Hyperbolic Tangent

public func atanh<X: ContinuousCollection>(_ x: X) -> [Float] where X.Iterator.Element == Float {
    var results = [Float](repeating: 0.0, count: numericCast(x.count))
    results.withUnsafeMutableBufferPointer { rbp in
        withUnsafePointersAndCountsTo(x) { xp, xc in
            vvatanhf(rbp.baseAddress!, xp, [Int32(xc)])
        }
    }

    return results
}

public func atanh<X: ContinuousCollection>(_ x: X) -> [Double] where X.Iterator.Element == Double {
    var results = [Double](repeating: 0.0, count: numericCast(x.count))
    results.withUnsafeMutableBufferPointer { rbp in
        withUnsafePointersAndCountsTo(x) { xp, xc in
            vvatanh(rbp.baseAddress!, xp, [Int32(xc)])
        }
    }

    return results
}
