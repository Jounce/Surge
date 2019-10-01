// Copyright © 2014-2019 the Surge contributors
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

// MARK: - Sum

public func sum<C: UnsafeMemoryAccessible>(_ lhs: C) -> Float where C.Element == Float {
    var result: Float = 0.0
    lhs.withUnsafeMemory { xm in
        withUnsafeMutablePointer(to: &result) { pointer in
            vDSP_sve(xm.pointer, numericCast(xm.stride), pointer, numericCast(xm.count))
        }
    }
    return result
}

public func sum<C: UnsafeMemoryAccessible>(_ lhs: C) -> Double where C.Element == Double {
    var result: Double = 0.0
    lhs.withUnsafeMemory { xm in
        withUnsafeMutablePointer(to: &result) { pointer in
            vDSP_sveD(xm.pointer, numericCast(xm.stride), pointer, numericCast(xm.count))
        }
    }
    return result
}

// MARK: - Sum of Absolute Values

public func asum<C: UnsafeMemoryAccessible>(_ lhs: C) -> Float where C.Element == Float {
    return lhs.withUnsafeMemory { xm in
        cblas_sasum(numericCast(xm.count), xm.pointer, numericCast(xm.stride))
    }
}

public func asum<C: UnsafeMemoryAccessible>(_ lhs: C) -> Double where C.Element == Double {
    return lhs.withUnsafeMemory { xm in
        cblas_dasum(numericCast(xm.count), xm.pointer, numericCast(xm.stride))
    }
}

// MARK: - Sum of Square Values

public func sumsq<C: UnsafeMemoryAccessible>(_ lhs: C) -> Float where C.Element == Float {
    var result: Float = 0
    lhs.withUnsafeMemory { xm in
        withUnsafeMutablePointer(to: &result) { pointer in
            vDSP_svesq(xm.pointer, numericCast(xm.stride), pointer, numericCast(xm.count))
        }
    }
    return result
}

public func sumsq<C: UnsafeMemoryAccessible>(_ lhs: C) -> Double where C.Element == Double {
    var result: Double = 0
    lhs.withUnsafeMemory { xm in
        withUnsafeMutablePointer(to: &result) { pointer in
            vDSP_svesqD(xm.pointer, numericCast(xm.stride), pointer, numericCast(xm.count))
        }
    }
    return result
}

// MARK: - Maximum

public func max<C: UnsafeMemoryAccessible>(_ lhs: C) -> Float where C.Element == Float {
    var result: Float = 0.0
    lhs.withUnsafeMemory { xm in
        withUnsafeMutablePointer(to: &result) { pointer in
            vDSP_maxv(xm.pointer, numericCast(xm.stride), pointer, numericCast(xm.count))
        }
    }
    return result
}

public func max<C: UnsafeMemoryAccessible>(_ lhs: C) -> Double where C.Element == Double {
    var result: Double = 0.0
    lhs.withUnsafeMemory { xm in
        withUnsafeMutablePointer(to: &result) { pointer in
            vDSP_maxvD(xm.pointer, numericCast(xm.stride), pointer, numericCast(xm.count))
        }
    }
    return result
}

// MARK: - Minimum

public func min<C: UnsafeMemoryAccessible>(_ lhs: C) -> Float where C.Element == Float {
    var result: Float = 0.0
    lhs.withUnsafeMemory { xm in
        withUnsafeMutablePointer(to: &result) { pointer in
            vDSP_minv(xm.pointer, numericCast(xm.stride), pointer, numericCast(xm.count))
        }
    }
    return result
}

public func min<C: UnsafeMemoryAccessible>(_ lhs: C) -> Double where C.Element == Double {
    var result: Double = 0.0
    lhs.withUnsafeMemory { xm in
        withUnsafeMutablePointer(to: &result) { pointer in
            vDSP_minvD(xm.pointer, numericCast(xm.stride), pointer, numericCast(xm.count))
        }
    }
    return result
}

// MARK: - Mean

public func mean<C: UnsafeMemoryAccessible>(_ lhs: C) -> Float where C.Element == Float {
    var result: Float = 0.0
    lhs.withUnsafeMemory { xm in
        withUnsafeMutablePointer(to: &result) { pointer in
            vDSP_meanv(xm.pointer, numericCast(xm.stride), pointer, numericCast(xm.count))
        }
    }
    return result
}

public func mean<C: UnsafeMemoryAccessible>(_ lhs: C) -> Double where C.Element == Double {
    var result: Double = 0.0
    lhs.withUnsafeMemory { xm in
        withUnsafeMutablePointer(to: &result) { pointer in
            vDSP_meanvD(xm.pointer, numericCast(xm.stride), pointer, numericCast(xm.count))
        }
    }
    return result
}

// MARK: - Mean Magnitude

public func meamg<C: UnsafeMemoryAccessible>(_ lhs: C) -> Float where C.Element == Float {
    var result: Float = 0.0
    lhs.withUnsafeMemory { xm in
        withUnsafeMutablePointer(to: &result) { pointer in
            vDSP_meamgv(xm.pointer, numericCast(xm.stride), pointer, numericCast(xm.count))
        }
    }
    return result
}

public func meamg<C: UnsafeMemoryAccessible>(_ lhs: C) -> Double where C.Element == Double {
    var result: Double = 0.0
    lhs.withUnsafeMemory { xm in
        withUnsafeMutablePointer(to: &result) { pointer in
            vDSP_meamgvD(xm.pointer, numericCast(xm.stride), pointer, numericCast(xm.count))
        }
    }
    return result
}

// MARK: - Mean Square Value

public func measq<C: UnsafeMemoryAccessible>(_ lhs: C) -> Float where C.Element == Float {
    var result: Float = 0.0
    lhs.withUnsafeMemory { xm in
        withUnsafeMutablePointer(to: &result) { pointer in
            vDSP_measqv(xm.pointer, numericCast(xm.stride), pointer, numericCast(xm.count))
        }
    }
    return result
}

public func measq<C: UnsafeMemoryAccessible>(_ lhs: C) -> Double where C.Element == Double {
    var result: Double = 0.0
    lhs.withUnsafeMemory { xm in
        withUnsafeMutablePointer(to: &result) { pointer in
            vDSP_measqvD(xm.pointer, numericCast(xm.stride), pointer, numericCast(xm.count))
        }
    }
    return result
}

// MARK: - Root Mean Square Value

public func rmsq<C: UnsafeMemoryAccessible>(_ lhs: C) -> Float where C.Element == Float {
    var result: Float = 0.0
    lhs.withUnsafeMemory { xm in
        withUnsafeMutablePointer(to: &result) { pointer in
            vDSP_rmsqv(xm.pointer, numericCast(xm.stride), pointer, numericCast(xm.count))
        }
    }
    return result
}

public func rmsq<C: UnsafeMemoryAccessible>(_ lhs: C) -> Double where C.Element == Double {
    var result: Double = 0.0
    lhs.withUnsafeMemory { xm in
        withUnsafeMutablePointer(to: &result) { pointer in
            vDSP_rmsqvD(xm.pointer, numericCast(xm.stride), pointer, numericCast(xm.count))
        }
    }
    return result
}

// MARK: - Variance

/// Computes the variance, a measure of the spread of deviation.
public func variance<L: UnsafeMemoryAccessible>(_ lhs: L) -> Float where L.Element == Float {
    return variance(lhs, mean: mean(lhs))
}

/// Computes the variance, a measure of the spread of deviation.
public func variance<L: UnsafeMemoryAccessible>(_ lhs: L) -> Double where L.Element == Double {
    return variance(lhs, mean: mean(lhs))
}

/// Computes the variance, a measure of the spread of deviation.
public func variance<L: UnsafeMemoryAccessible>(_ lhs: L, mean: Float) -> Float where L.Element == Float {
    let diff = sub(lhs, mean)
    return measq(diff)
}

/// Computes the variance, a measure of the spread of deviation.
public func variance<L: UnsafeMemoryAccessible>(_ lhs: L, mean: Double) -> Double where L.Element == Double {
    let diff = sub(lhs, mean)
    return measq(diff)
}

// MARK: - Standard deviation

/// Computes the standard deviation, a measure of the spread of deviation.
public func std<L: UnsafeMemoryAccessible>(_ lhs: L) -> Float where L.Element == Float {
    let diff = lhs - mean(lhs)
    let variance = measq(diff)
    return sqrt(variance)
}

/// Computes the standard deviation, a measure of the spread of deviation.
public func std<L: UnsafeMemoryAccessible>(_ lhs: L) -> Double where L.Element == Double {
    let diff = lhs - mean(lhs)
    let variance = measq(diff)
    return sqrt(variance)
}

// MARK: - Linear regression

/// Performs linear regression
///
/// - Parameters:
///   - lhs: Array of lhs-values
///   - rhs: Array of rhs-values
/// - Returns: The slope and intercept of the regression line
public func linregress<L: UnsafeMemoryAccessible, R: UnsafeMemoryAccessible>(_ lhs: L, _ rhs: R) -> (slope: Float, intercept: Float) where L.Element == Float, R.Element == Float {
    precondition(lhs.count == rhs.count, "Vectors must have equal count")
    let meanx = mean(lhs)
    let meany = mean(rhs)
    let meanxy = mean(lhs .* rhs)
    let meanx_sqr = measq(lhs)

    let slope = (meanx * meany - meanxy) / (meanx * meanx - meanx_sqr)
    let intercept = meany - slope * meanx
    return (slope, intercept)
}

/// Performs linear regression
///
/// - Parameters:
///   - lhs: Array of lhs-values
///   - rhs: Array of rhs-values
/// - Returns: The slope and intercept of the regression line
public func linregress<L: UnsafeMemoryAccessible, R: UnsafeMemoryAccessible>(_ lhs: L, _ rhs: R) -> (slope: Double, intercept: Double) where L.Element == Double, R.Element == Double {
    precondition(lhs.count == rhs.count, "Vectors must have equal count")
    let meanx = mean(lhs)
    let meany = mean(rhs)
    let meanxy = mean(lhs .* rhs)
    let meanx_sqr = measq(lhs)

    let slope = (meanx * meany - meanxy) / (meanx * meanx - meanx_sqr)
    let intercept = meany - slope * meanx
    return (slope, intercept)
}
