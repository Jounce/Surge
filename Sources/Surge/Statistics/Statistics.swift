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

public func sum<L>(_ lhs: L) -> Float where L: UnsafeMemoryAccessible, L.Element == Float {
    var result: Float = 0.0
    lhs.withUnsafeMemory { xm in
        withUnsafeMutablePointer(to: &result) { pointer in
            vDSP_sve(xm.pointer, numericCast(xm.stride), pointer, numericCast(xm.count))
        }
    }
    return result
}

public func sum<L>(_ lhs: L) -> Double where L: UnsafeMemoryAccessible, L.Element == Double {
    var result: Double = 0.0
    lhs.withUnsafeMemory { xm in
        withUnsafeMutablePointer(to: &result) { pointer in
            vDSP_sveD(xm.pointer, numericCast(xm.stride), pointer, numericCast(xm.count))
        }
    }
    return result
}

// MARK: - Sum of Absolute Values

public func asum<L>(_ lhs: L) -> Float where L: UnsafeMemoryAccessible, L.Element == Float {
    return lhs.withUnsafeMemory { xm in
        cblas_sasum(numericCast(xm.count), xm.pointer, numericCast(xm.stride))
    }
}

public func asum<L>(_ lhs: L) -> Double where L: UnsafeMemoryAccessible, L.Element == Double {
    return lhs.withUnsafeMemory { xm in
        cblas_dasum(numericCast(xm.count), xm.pointer, numericCast(xm.stride))
    }
}

// MARK: - Sum of Square Values

public func sumsq<L>(_ lhs: L) -> Float where L: UnsafeMemoryAccessible, L.Element == Float {
    var result: Float = 0
    lhs.withUnsafeMemory { xm in
        withUnsafeMutablePointer(to: &result) { pointer in
            vDSP_svesq(xm.pointer, numericCast(xm.stride), pointer, numericCast(xm.count))
        }
    }
    return result
}

public func sumsq<L>(_ lhs: L) -> Double where L: UnsafeMemoryAccessible, L.Element == Double {
    var result: Double = 0
    lhs.withUnsafeMemory { xm in
        withUnsafeMutablePointer(to: &result) { pointer in
            vDSP_svesqD(xm.pointer, numericCast(xm.stride), pointer, numericCast(xm.count))
        }
    }
    return result
}

// MARK: - Maximum

public func max<L>(_ lhs: L) -> Float where L: UnsafeMemoryAccessible, L.Element == Float {
    var result: Float = 0.0
    lhs.withUnsafeMemory { xm in
        withUnsafeMutablePointer(to: &result) { pointer in
            vDSP_maxv(xm.pointer, numericCast(xm.stride), pointer, numericCast(xm.count))
        }
    }
    return result
}

public func max<L>(_ lhs: L) -> Double where L: UnsafeMemoryAccessible, L.Element == Double {
    var result: Double = 0.0
    lhs.withUnsafeMemory { xm in
        withUnsafeMutablePointer(to: &result) { pointer in
            vDSP_maxvD(xm.pointer, numericCast(xm.stride), pointer, numericCast(xm.count))
        }
    }
    return result
}

// MARK: - Minimum

public func min<L>(_ lhs: L) -> Float where L: UnsafeMemoryAccessible, L.Element == Float {
    var result: Float = 0.0
    lhs.withUnsafeMemory { xm in
        withUnsafeMutablePointer(to: &result) { pointer in
            vDSP_minv(xm.pointer, numericCast(xm.stride), pointer, numericCast(xm.count))
        }
    }
    return result
}

public func min<L>(_ lhs: L) -> Double where L: UnsafeMemoryAccessible, L.Element == Double {
    var result: Double = 0.0
    lhs.withUnsafeMemory { xm in
        withUnsafeMutablePointer(to: &result) { pointer in
            vDSP_minvD(xm.pointer, numericCast(xm.stride), pointer, numericCast(xm.count))
        }
    }
    return result
}

// MARK: - Mean

public func mean<L>(_ lhs: L) -> Float where L: UnsafeMemoryAccessible, L.Element == Float {
    var result: Float = 0.0
    lhs.withUnsafeMemory { xm in
        withUnsafeMutablePointer(to: &result) { pointer in
            vDSP_meanv(xm.pointer, numericCast(xm.stride), pointer, numericCast(xm.count))
        }
    }
    return result
}

public func mean<L>(_ lhs: L) -> Double where L: UnsafeMemoryAccessible, L.Element == Double {
    var result: Double = 0.0
    lhs.withUnsafeMemory { xm in
        withUnsafeMutablePointer(to: &result) { pointer in
            vDSP_meanvD(xm.pointer, numericCast(xm.stride), pointer, numericCast(xm.count))
        }
    }
    return result
}

// MARK: - Mean of Magnitudes

public func meamg<L>(_ lhs: L) -> Float where L: UnsafeMemoryAccessible, L.Element == Float {
    var result: Float = 0.0
    lhs.withUnsafeMemory { xm in
        withUnsafeMutablePointer(to: &result) { pointer in
            vDSP_meamgv(xm.pointer, numericCast(xm.stride), pointer, numericCast(xm.count))
        }
    }
    return result
}

public func meamg<L>(_ lhs: L) -> Double where L: UnsafeMemoryAccessible, L.Element == Double {
    var result: Double = 0.0
    lhs.withUnsafeMemory { xm in
        withUnsafeMutablePointer(to: &result) { pointer in
            vDSP_meamgvD(xm.pointer, numericCast(xm.stride), pointer, numericCast(xm.count))
        }
    }
    return result
}

// MARK: - Mean of Squares

public func measq<L>(_ lhs: L) -> Float where L: UnsafeMemoryAccessible, L.Element == Float {
    var result: Float = 0.0
    lhs.withUnsafeMemory { xm in
        withUnsafeMutablePointer(to: &result) { pointer in
            vDSP_measqv(xm.pointer, numericCast(xm.stride), pointer, numericCast(xm.count))
        }
    }
    return result
}

public func measq<L>(_ lhs: L) -> Double where L: UnsafeMemoryAccessible, L.Element == Double {
    var result: Double = 0.0
    lhs.withUnsafeMemory { xm in
        withUnsafeMutablePointer(to: &result) { pointer in
            vDSP_measqvD(xm.pointer, numericCast(xm.stride), pointer, numericCast(xm.count))
        }
    }
    return result
}

// MARK: - Root Mean of Squares

public func rmsq<L>(_ lhs: L) -> Float where L: UnsafeMemoryAccessible, L.Element == Float {
    var result: Float = 0.0
    lhs.withUnsafeMemory { xm in
        withUnsafeMutablePointer(to: &result) { pointer in
            vDSP_rmsqv(xm.pointer, numericCast(xm.stride), pointer, numericCast(xm.count))
        }
    }
    return result
}

public func rmsq<L>(_ lhs: L) -> Double where L: UnsafeMemoryAccessible, L.Element == Double {
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
public func variance<L>(_ lhs: L) -> Float where L: UnsafeMemoryAccessible, L.Element == Float {
    return variance(lhs, mean: mean(lhs))
}

/// Computes the variance, a measure of the spread of deviation.
public func variance<L>(_ lhs: L) -> Double where L: UnsafeMemoryAccessible, L.Element == Double {
    return variance(lhs, mean: mean(lhs))
}

/// Computes the variance, a measure of the spread of deviation.
///
/// - Note: For the calculation to produce a correct result `mean` needs to be the actual mean of `lhs`.
public func variance<L>(_ lhs: L, mean: Float) -> Float where L: UnsafeMemoryAccessible, L.Element == Float {
    let diff = sub(lhs, mean)
    return measq(diff)
}

/// Computes the variance, a measure of the spread of deviation.
///
/// - Note: For the calculation to produce a correct result `mean` needs to be the actual mean of `lhs`.
public func variance<L>(_ lhs: L, mean: Double) -> Double where L: UnsafeMemoryAccessible, L.Element == Double {
    let diff = sub(lhs, mean)
    return measq(diff)
}

// MARK: - Standard Deviation

/// Computes the standard deviation, a measure of the spread of deviation.
public func std<L>(_ lhs: L) -> Float where L: UnsafeMemoryAccessible, L.Element == Float {
    return sqrt(variance(lhs))
}

/// Computes the standard deviation, a measure of the spread of deviation.
public func std<L>(_ lhs: L) -> Double where L: UnsafeMemoryAccessible, L.Element == Double {
    return sqrt(variance(lhs))
}

/// Computes the standard deviation, a measure of the spread of deviation.
///
/// - Note: For the calculation to produce a correct result `mean` needs to be the actual mean of `lhs`.
public func std<L>(_ lhs: L, mean: Float) -> Float where L: UnsafeMemoryAccessible, L.Element == Float {
    return sqrt(variance(lhs, mean: mean))
}

/// Computes the standard deviation, a measure of the spread of deviation.
///
/// - Note: For the calculation to produce a correct result `mean` needs to be the actual mean of `lhs`.
public func std<L>(_ lhs: L, mean: Double) -> Double where L: UnsafeMemoryAccessible, L.Element == Double {
    return sqrt(variance(lhs, mean: mean))
}

// MARK: - Linear Regression

/// Performs linear regression
///
/// - Parameters:
///   - lhs: Array of lhs-values
///   - rhs: Array of rhs-values
/// - Returns: The slope and intercept of the regression line
public func linregress<L, R>(_ lhs: L, _ rhs: R) -> (slope: Float, intercept: Float) where L: UnsafeMemoryAccessible, R: UnsafeMemoryAccessible, L.Element == Float, R.Element == Float {
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
public func linregress<L, R>(_ lhs: L, _ rhs: R) -> (slope: Double, intercept: Double) where L: UnsafeMemoryAccessible, R: UnsafeMemoryAccessible, L.Element == Double, R.Element == Double {
    precondition(lhs.count == rhs.count, "Vectors must have equal count")
    let meanx = mean(lhs)
    let meany = mean(rhs)
    let meanxy = mean(lhs .* rhs)
    let meanx_sqr = measq(lhs)

    let slope = (meanx * meany - meanxy) / (meanx * meanx - meanx_sqr)
    let intercept = meany - slope * meanx
    return (slope, intercept)
}
