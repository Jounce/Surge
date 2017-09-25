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

// MARK: Exponentiation

public func exp<X: ContinuousCollection>(_ x: X) -> [Float] where X.Iterator.Element == Float {
    var results = [Float](repeating: 0.0, count: numericCast(x.count))
    results.withUnsafeMutableBufferPointer { rbp in
        withUnsafePointersAndCountsTo(x) { xp, xc in
            vvexpf(rbp.baseAddress!, xp, [Int32(xc)])
        }
    }
    return results
}

public func exp<X: ContinuousCollection>(_ x: X) -> [Double] where X.Iterator.Element == Double {
    var results = [Double](repeating: 0.0, count: numericCast(x.count))
    results.withUnsafeMutableBufferPointer { rbp in
        withUnsafePointersAndCountsTo(x) { xp, xc in
            vvexp(rbp.baseAddress!, xp, [Int32(xc)])
        }
    }
    return results
}

// MARK: Square Exponentiation

public func exp2<X: ContinuousCollection>(_ x: X) -> [Float] where X.Iterator.Element == Float {
    var results = [Float](repeating: 0.0, count: numericCast(x.count))
    results.withUnsafeMutableBufferPointer { rbp in
        withUnsafePointersAndCountsTo(x) { xp, xc in
            vvexp2f(rbp.baseAddress!, xp, [Int32(xc)])
        }
    }
    return results
}

public func exp2<X: ContinuousCollection>(_ x: X) -> [Double] where X.Iterator.Element == Double {
    var results = [Double](repeating: 0.0, count: numericCast(x.count))
    results.withUnsafeMutableBufferPointer { rbp in
        withUnsafePointersAndCountsTo(x) { xp, xc in
            vvexp2(rbp.baseAddress!, xp, [Int32(xc)])
        }
    }
    return results
}

// MARK: Natural Logarithm

public func log<X: ContinuousCollection>(_ x: X) -> [Float] where X.Iterator.Element == Float {
    var results = [Float](x)
    results.withUnsafeMutableBufferPointer { rbp in
        withUnsafePointersAndCountsTo(x) { xp, xc in
            vvlogf(rbp.baseAddress!, xp, [Int32(xc)])
        }
    }
    return results
}

public func log<X: ContinuousCollection>(_ x: X) -> [Double] where X.Iterator.Element == Double {
    var results = [Double](x)
    results.withUnsafeMutableBufferPointer { rbp in
        withUnsafePointersAndCountsTo(x) { xp, xc in
            vvlog(rbp.baseAddress!, xp, [Int32(xc)])
        }
    }
    return results
}

// MARK: Base-2 Logarithm

public func log2<X: ContinuousCollection>(_ x: X) -> [Float] where X.Iterator.Element == Float {
    var results = [Float](x)
    results.withUnsafeMutableBufferPointer { rbp in
        withUnsafePointersAndCountsTo(x) { xp, xc in
            vvlog2f(rbp.baseAddress!, xp, [Int32(xc)])
        }
    }
    return results
}

public func log2<X: ContinuousCollection>(_ x: X) -> [Double] where X.Iterator.Element == Double {
    var results = [Double](x)
    results.withUnsafeMutableBufferPointer { rbp in
        withUnsafePointersAndCountsTo(x) { xp, xc in
            vvlog2(rbp.baseAddress!, xp, [Int32(xc)])
        }
    }
    return results
}

// MARK: Base-10 Logarithm

public func log10<X: ContinuousCollection>(_ x: X) -> [Float] where X.Iterator.Element == Float {
    var results = [Float](x)
    results.withUnsafeMutableBufferPointer { rbp in
        withUnsafePointersAndCountsTo(x) { xp, xc in
            vvlog10f(rbp.baseAddress!, xp, [Int32(xc)])
        }
    }
    return results
}

public func log10<X: ContinuousCollection>(_ x: X) -> [Double] where X.Iterator.Element == Double {
    var results = [Double](x)
    results.withUnsafeMutableBufferPointer { rbp in
        withUnsafePointersAndCountsTo(x) { xp, xc in
            vvlog10(rbp.baseAddress!, xp, [Int32(xc)])
        }
    }
    return results
}

// MARK: Logarithmic Exponentiation

public func logb<X: ContinuousCollection>(_ x: X) -> [Float] where X.Iterator.Element == Float {
    var results = [Float](x)
    results.withUnsafeMutableBufferPointer { rbp in
        withUnsafePointersAndCountsTo(x) { xp, xc in
            vvlogbf(rbp.baseAddress!, xp, [Int32(xc)])
        }
    }
    return results
}

public func logb<X: ContinuousCollection>(_ x: X) -> [Double] where X.Iterator.Element == Double {
    var results = [Double](x)
    results.withUnsafeMutableBufferPointer { rbp in
        withUnsafePointersAndCountsTo(x) { xp, xc in
            vvlogb(rbp.baseAddress!, xp, [Int32(xc)])
        }
    }
    return results
}
