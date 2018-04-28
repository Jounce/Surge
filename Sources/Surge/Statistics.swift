// Copyright © 2014-2018 the Surge contributors
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

public func sum<C: UnsafeMemoryAccessible>(_ x: C) -> Float where C.Element == Float {
    var result: Float = 0.0
    x.withUnsafeMemory { xm in
        withUnsafeMutablePointer(to: &result) { pointer in
            vDSP_sve(xm.pointer, xm.stride, pointer, numericCast(xm.count))
        }
    }
    return result
}

public func sum<C: UnsafeMemoryAccessible>(_ x: C) -> Double where C.Element == Double {
    var result: Double = 0.0
    x.withUnsafeMemory { xm in
        withUnsafeMutablePointer(to: &result) { pointer in
            vDSP_sveD(xm.pointer, xm.stride, pointer, numericCast(xm.count))
        }
    }
    return result
}

// MARK: Sum of Absolute Values

public func asum<C: UnsafeMemoryAccessible>(_ x: C) -> Float where C.Element == Float {
    return x.withUnsafeMemory { xm in
        cblas_sasum(numericCast(xm.count), xm.pointer, numericCast(xm.stride))
    }
}

public func asum<C: UnsafeMemoryAccessible>(_ x: C) -> Double where C.Element == Double {
    return x.withUnsafeMemory { xm in
        cblas_dasum(numericCast(xm.count), xm.pointer, numericCast(xm.stride))
    }
}

// MARK: Sum of Square Values

public func sumsq<C: UnsafeMemoryAccessible>(_ x: C) -> Float where C.Element == Float {
    var result: Float = 0
    x.withUnsafeMemory { xm in
        withUnsafeMutablePointer(to: &result) { pointer in
            vDSP_svesq(xm.pointer, xm.stride, pointer, numericCast(xm.count))
        }
    }
    return result
}

public func sumsq<C: UnsafeMemoryAccessible>(_ x: C) -> Double where C.Element == Double {
    var result: Double = 0
    x.withUnsafeMemory { xm in
        withUnsafeMutablePointer(to: &result) { pointer in
            vDSP_svesqD(xm.pointer, xm.stride, pointer, numericCast(xm.count))
        }
    }
    return result
}

// MARK: Maximum

public func max<C: UnsafeMemoryAccessible>(_ x: C) -> Float where C.Element == Float {
    var result: Float = 0.0
    x.withUnsafeMemory { xm in
        withUnsafeMutablePointer(to: &result) { pointer in
            vDSP_maxv(xm.pointer, xm.stride, pointer, numericCast(xm.count))
        }
    }
    return result
}

public func max<C: UnsafeMemoryAccessible>(_ x: C) -> Double where C.Element == Double {
    var result: Double = 0.0
    x.withUnsafeMemory { xm in
        withUnsafeMutablePointer(to: &result) { pointer in
            vDSP_maxvD(xm.pointer, xm.stride, pointer, numericCast(xm.count))
        }
    }
    return result
}

// MARK: Minimum

public func min<C: UnsafeMemoryAccessible>(_ x: C) -> Float where C.Element == Float {
    var result: Float = 0.0
    x.withUnsafeMemory { xm in
        withUnsafeMutablePointer(to: &result) { pointer in
            vDSP_minv(xm.pointer, xm.stride, pointer, numericCast(xm.count))
        }
    }
    return result
}

public func min<C: UnsafeMemoryAccessible>(_ x: C) -> Double where C.Element == Double {
    var result: Double = 0.0
    x.withUnsafeMemory { xm in
        withUnsafeMutablePointer(to: &result) { pointer in
            vDSP_minvD(xm.pointer, xm.stride, pointer, numericCast(xm.count))
        }
    }
    return result
}

// MARK: Mean

public func mean<C: UnsafeMemoryAccessible>(_ x: C) -> Float where C.Element == Float {
    var result: Float = 0.0
    x.withUnsafeMemory { xm in
        withUnsafeMutablePointer(to: &result) { pointer in
            vDSP_meanv(xm.pointer, xm.stride, pointer, numericCast(xm.count))
        }
    }
    return result
}

public func mean<C: UnsafeMemoryAccessible>(_ x: C) -> Double where C.Element == Double {
    var result: Double = 0.0
    x.withUnsafeMemory { xm in
        withUnsafeMutablePointer(to: &result) { pointer in
            vDSP_meanvD(xm.pointer, xm.stride, pointer, numericCast(xm.count))
        }
    }
    return result
}

// MARK: Mean Magnitude

public func meamg<C: UnsafeMemoryAccessible>(_ x: C) -> Float where C.Element == Float {
    var result: Float = 0.0
    x.withUnsafeMemory { xm in
        withUnsafeMutablePointer(to: &result) { pointer in
            vDSP_meamgv(xm.pointer, xm.stride, pointer, numericCast(xm.count))
        }
    }
    return result
}

public func meamg<C: UnsafeMemoryAccessible>(_ x: C) -> Double where C.Element == Double {
    var result: Double = 0.0
    x.withUnsafeMemory { xm in
        withUnsafeMutablePointer(to: &result) { pointer in
            vDSP_meamgvD(xm.pointer, xm.stride, pointer, numericCast(xm.count))
        }
    }
    return result
}

// MARK: Mean Square Value

public func measq<C: UnsafeMemoryAccessible>(_ x: C) -> Float where C.Element == Float {
    var result: Float = 0.0
    x.withUnsafeMemory { xm in
        withUnsafeMutablePointer(to: &result) { pointer in
            vDSP_measqv(xm.pointer, xm.stride, pointer, numericCast(xm.count))
        }
    }
    return result
}

public func measq<C: UnsafeMemoryAccessible>(_ x: C) -> Double where C.Element == Double {
    var result: Double = 0.0
    x.withUnsafeMemory { xm in
        withUnsafeMutablePointer(to: &result) { pointer in
            vDSP_measqvD(xm.pointer, xm.stride, pointer, numericCast(xm.count))
        }
    }
    return result
}

// MARK: Root Mean Square Value

public func rmsq<C: UnsafeMemoryAccessible>(_ x: C) -> Float where C.Element == Float {
    var result: Float = 0.0
    x.withUnsafeMemory { xm in
        withUnsafeMutablePointer(to: &result) { pointer in
            vDSP_rmsqv(xm.pointer, xm.stride, pointer, numericCast(xm.count))
        }
    }
    return result
}

public func rmsq<C: UnsafeMemoryAccessible>(_ x: C) -> Double where C.Element == Double {
    var result: Double = 0.0
    x.withUnsafeMemory { xm in
        withUnsafeMutablePointer(to: &result) { pointer in
            vDSP_rmsqvD(xm.pointer, xm.stride, pointer, numericCast(xm.count))
        }
    }
    return result
}

// MARK: Standard deviation

/// Computes the standard deviation, a measure of the spread of deviation.
public func std<X: UnsafeMemoryAccessible>(_ x: X) -> Float where X.Element == Float {
    let diff = x - mean(x)
    let variance = measq(diff)
    return sqrt(variance)
}

/// Computes the standard deviation, a measure of the spread of deviation.
public func std<X: UnsafeMemoryAccessible>(_ x: X) -> Double where X.Element == Double {
    let diff = x - mean(x)
    let variance = measq(diff)
    return sqrt(variance)
}

// MARK: Linear regression

/// Performs linear regression
///
/// - Parameters:
///   - x: Array of x-values
///   - y: Array of y-values
/// - Returns: The slope and intercept of the regression line
public func linregress<X: UnsafeMemoryAccessible, Y: UnsafeMemoryAccessible>(_ x: X, _ y: Y) -> (slope: Float, intercept: Float) where X.Element == Float, Y.Element == Float {
    precondition(x.count == y.count, "Vectors must have equal count")
    let meanx = mean(x)
    let meany = mean(y)
    let meanxy = mean(x .* y)
    let meanx_sqr = measq(x)

    let slope = (meanx * meany - meanxy) / (meanx * meanx - meanx_sqr)
    let intercept = meany - slope * meanx
    return (slope, intercept)
}

/// Performs linear regression
///
/// - Parameters:
///   - x: Array of x-values
///   - y: Array of y-values
/// - Returns: The slope and intercept of the regression line
public func linregress<X: UnsafeMemoryAccessible, Y: UnsafeMemoryAccessible>(_ x: X, _ y: Y) -> (slope: Double, intercept: Double) where X.Element == Double, Y.Element == Double {
    precondition(x.count == y.count, "Vectors must have equal count")
    let meanx = mean(x)
    let meany = mean(y)
    let meanxy = mean(x .* y)
    let meanx_sqr = measq(x)

    let slope = (meanx * meany - meanxy) / (meanx * meanx - meanx_sqr)
    let intercept = meany - slope * meanx
    return (slope, intercept)
}
