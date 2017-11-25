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

// MARK: Absolute Value

public func abs<C: ContinuousCollection>(_ x: C) -> [Double] where C.Iterator.Element == Double {
    var results = [Double](repeating: 0.0, count: numericCast(x.count))
    results.withUnsafeMutableBufferPointer { rbp in
        x.withUnsafeBufferPointer { xbp in
            guard let xp = xbp.baseAddress else {
                return
            }
            vvfabs(rbp.baseAddress!, xp, [Int32(xbp.count)])
        }
    }
    return results
}

public func abs<C: ContinuousCollection>(_ x: C) -> [Float] where C.Iterator.Element == Float {
    var results = [Float](repeating: 0.0, count: numericCast(x.count))
    results.withUnsafeMutableBufferPointer { rbp in
        x.withUnsafeBufferPointer { xbp in
            guard let xp = xbp.baseAddress else {
                return
            }
            vvfabsf(rbp.baseAddress!, xp, [Int32(xbp.count)])
        }
    }
    return results
}

// MARK: Ceiling

public func ceil<C: ContinuousCollection>(_ x: C) -> [Float] where C.Iterator.Element == Float {
    var results = [Float](repeating: 0.0, count: numericCast(x.count))
    results.withUnsafeMutableBufferPointer { rbp in
        x.withUnsafeBufferPointer { xbp in
            guard let xp = xbp.baseAddress else {
                return
            }
            vvceilf(rbp.baseAddress!, xp, [Int32(xbp.count)])
        }
    }
    return results
}

public func ceil<C: ContinuousCollection>(_ x: C) -> [Double] where C.Iterator.Element == Double {
    var results = [Double](repeating: 0.0, count: numericCast(x.count))
    results.withUnsafeMutableBufferPointer { rbp in
        x.withUnsafeBufferPointer { xbp in
            guard let xp = xbp.baseAddress else {
                return
            }
            vvceil(rbp.baseAddress!, xp, [Int32(xbp.count)])
        }
    }
    return results
}

// MARK: Clip

public func clip<C: ContinuousCollection>(_ x: C, low: Float, high: Float) -> [Float] where C.Iterator.Element == Float {
    var results = [Float](repeating: 0.0, count: numericCast(x.count))
    results.withUnsafeMutableBufferPointer { rbp in
        x.withUnsafeBufferPointer { xbp in
            guard let xp = xbp.baseAddress else {
                return
            }
            var y = low
            var z = high
            withUnsafePointersTo(&y, &z) { y, z in
                vDSP_vclip(xp, 1, y, z, rbp.baseAddress!, 1, vDSP_Length(xbp.count))
            }
        }
    }
    return results
}

public func clip<C: ContinuousCollection>(_ x: C, low: Double, high: Double) -> [Double] where C.Iterator.Element == Double {
    var results = [Double](repeating: 0.0, count: numericCast(x.count))
    results.withUnsafeMutableBufferPointer { rbp in
        x.withUnsafeBufferPointer { xbp in
            guard let xp = xbp.baseAddress else {
                return
            }
            var y = low
            var z = high
            withUnsafePointersTo(&y, &z) { y, z in
                vDSP_vclipD(xp, 1, y, z, rbp.baseAddress!, 1, vDSP_Length(xbp.count))
            }
        }
    }
    return results
}

// MARK: Copy Sign

public func copysign<S: ContinuousCollection, M: ContinuousCollection>(sign: S, magnitude: M) -> [Float] where S.Iterator.Element == Float, M.Iterator.Element == Float {
    var results = [Float](repeating: 0.0, count: numericCast(sign.count))
    results.withUnsafeMutableBufferPointer { rbp in
        withUnsafeBufferPointersTo(sign, magnitude) { sbp, mbp in
            guard let sp = sbp.baseAddress, let mp = mbp.baseAddress else {
                return
            }
            vvcopysignf(rbp.baseAddress!, mp, sp, [Int32(sbp.count)])
        }
    }
    return results
}

public func copysign<S: ContinuousCollection, M: ContinuousCollection>(sign: S, magnitude: M) -> [Double] where S.Iterator.Element == Double, M.Iterator.Element == Double {
    var results = [Double](repeating: 0.0, count: numericCast(sign.count))
    results.withUnsafeMutableBufferPointer { rbp in
        withUnsafeBufferPointersTo(sign, magnitude) { sbp, mbp in
            guard let sp = sbp.baseAddress, let mp = mbp.baseAddress else {
                return
            }
            vvcopysign(rbp.baseAddress!, mp, sp, [Int32(sbp.count)])
        }
    }
    return results
}

// MARK: Floor

public func floor<C: ContinuousCollection>(_ x: C) -> [Float] where C.Iterator.Element == Float {
    var results = [Float](repeating: 0.0, count: numericCast(x.count))
    results.withUnsafeMutableBufferPointer { rbp in
        x.withUnsafeBufferPointer { xbp in
            guard let xp = xbp.baseAddress else {
                return
            }
            vvfloorf(rbp.baseAddress!, xp, [Int32(xbp.count)])
        }
    }
    return results
}

public func floor<C: ContinuousCollection>(_ x: C) -> [Double] where C.Iterator.Element == Double {
    var results = [Double](repeating: 0.0, count: numericCast(x.count))
    results.withUnsafeMutableBufferPointer { rbp in
        x.withUnsafeBufferPointer { xbp in
            guard let xp = xbp.baseAddress else {
                return
            }
            vvfloor(rbp.baseAddress!, xp, [Int32(xbp.count)])
        }
    }
    return results
}

// MARK: Negate

public func neg<C: ContinuousCollection>(_ x: C) -> [Float] where C.Iterator.Element == Float {
    var results = [Float](repeating: 0.0, count: numericCast(x.count))
    results.withUnsafeMutableBufferPointer { rbp in
        x.withUnsafeBufferPointer { xbp in
            guard let xp = xbp.baseAddress else {
                return
            }
            vDSP_vneg(xp, 1, rbp.baseAddress!, 1, vDSP_Length(xbp.count))
        }
    }
    return results
}

public func neg<C: ContinuousCollection>(_ x: C) -> [Double] where C.Iterator.Element == Double {
    var results = [Double](repeating: 0.0, count: numericCast(x.count))
    results.withUnsafeMutableBufferPointer { rbp in
        x.withUnsafeBufferPointer { xbp in
            guard let xp = xbp.baseAddress else {
                return
            }
            vDSP_vnegD(xp, 1, rbp.baseAddress!, 1, vDSP_Length(xbp.count))
        }
    }
    return results
}

// MARK: Reciprocal

public func rec<C: ContinuousCollection>(_ x: C) -> [Float] where C.Iterator.Element == Float {
    var results = [Float](repeating: 0.0, count: numericCast(x.count))
    results.withUnsafeMutableBufferPointer { rbp in
        x.withUnsafeBufferPointer { xbp in
            guard let xp = xbp.baseAddress else {
                return
            }
            vvrecf(rbp.baseAddress!, xp, [Int32(xbp.count)])
        }
    }
    return results
}

public func rec<C: ContinuousCollection>(_ x: C) -> [Double] where C.Iterator.Element == Double {
    var results = [Double](repeating: 0.0, count: numericCast(x.count))
    results.withUnsafeMutableBufferPointer { rbp in
        x.withUnsafeBufferPointer { xbp in
            guard let xp = xbp.baseAddress else {
                return
            }
            vvrec(rbp.baseAddress!, xp, [Int32(xbp.count)])
        }
    }
    return results
}

// MARK: Round

public func round<C: ContinuousCollection>(_ x: C) -> [Float] where C.Iterator.Element == Float {
    var results = [Float](repeating: 0.0, count: numericCast(x.count))
    results.withUnsafeMutableBufferPointer { rbp in
        x.withUnsafeBufferPointer { xbp in
            guard let xp = xbp.baseAddress else {
                return
            }
            vvnintf(rbp.baseAddress!, xp, [Int32(xbp.count)])
        }
    }
    return results
}

public func round<C: ContinuousCollection>(_ x: C) -> [Double] where C.Iterator.Element == Double {
    var results = [Double](repeating: 0.0, count: numericCast(x.count))
    results.withUnsafeMutableBufferPointer { rbp in
        x.withUnsafeBufferPointer { xbp in
            guard let xp = xbp.baseAddress else {
                return
            }
            vvnint(rbp.baseAddress!, xp, [Int32(xbp.count)])
        }
    }
    return results
}

// MARK: Threshold

public func threshold<C: ContinuousCollection>(_ x: C, low: Float) -> [Float] where C.Iterator.Element == Float {
    var results = [Float](repeating: 0.0, count: numericCast(x.count))
    results.withUnsafeMutableBufferPointer { rbp in
        x.withUnsafeBufferPointer { xbp in
            guard let xp = xbp.baseAddress else {
                return
            }
            var y = low
            withUnsafePointer(to: &y) { y in
                vDSP_vthr(xp, 1, y, rbp.baseAddress!, 1, vDSP_Length(xbp.count))
            }
        }
    }
    return results
}

public func threshold<C: ContinuousCollection>(_ x: C, low: Double) -> [Double] where C.Iterator.Element == Double {
    var results = [Double](repeating: 0.0, count: numericCast(x.count))
    results.withUnsafeMutableBufferPointer { rbp in
        x.withUnsafeBufferPointer { xbp in
            guard let xp = xbp.baseAddress else {
                return
            }
            var y = low
            withUnsafePointer(to: &y) { y in
                vDSP_vthrD(xp, 1, y, rbp.baseAddress!, 1, vDSP_Length(xbp.count))
            }
        }
    }
    return results
}

// MARK: Truncate

public func trunc<C: ContinuousCollection>(_ x: C) -> [Float] where C.Iterator.Element == Float {
    var results = [Float](repeating: 0.0, count: numericCast(x.count))
    results.withUnsafeMutableBufferPointer { rbp in
        x.withUnsafeBufferPointer { xbp in
            guard let xp = xbp.baseAddress else {
                return
            }
            vvintf(rbp.baseAddress!, xp, [Int32(xbp.count)])
        }
    }
    return results
}

public func trunc<C: ContinuousCollection>(_ x: C) -> [Double] where C.Iterator.Element == Double {
    var results = [Double](repeating: 0.0, count: numericCast(x.count))
    results.withUnsafeMutableBufferPointer { rbp in
        x.withUnsafeBufferPointer { xbp in
            guard let xp = xbp.baseAddress else {
                return
            }
            vvint(rbp.baseAddress!, xp, [Int32(xbp.count)])
        }
    }
    return results
}
