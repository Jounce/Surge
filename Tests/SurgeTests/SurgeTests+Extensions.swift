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

import Foundation
import XCTest

@testable import Surge

extension ExpressibleByFloatLiteral {
    static func identity() -> Self {
        return 1.0
    }

    static func constant() -> Self {
        return 0.42
    }
}

extension FloatingPoint {
    // Hack-ish, but but hey, … it works!
    // And it's just part of the test target.
    // We're not gonna ship it.
    static func randomNormalized() -> Self {
        switch self {
        case is Float.Type:
            let value = Float.random(in: (0.0)...(1.0))
            return unsafeBitCast(value, to: self)
        case is Double.Type:
            let value = Double.random(in: (0.0)...(1.0))
            return unsafeBitCast(value, to: self)
        case _:
            fatalError("Only supported by `Float` and `Double`")
        }
    }
}

extension Array where Element: FloatingPoint & ExpressibleByFloatLiteral {
    static var defaultCount: Int {
        return 1_000
    }

    static func randomNormalized() -> Array {
        return randomNormalized(to: 1.0, count: Array.defaultCount)
    }

    static func randomNormalized(to scale: Element) -> Array {
        return randomNormalized(to: scale, count: Array.defaultCount)
    }

    static func randomNormalized(to scale: Element = 1.0, count: Int) -> Array {
        return (1...count).map { _ in Element.randomNormalized() * scale }
    }

    static func monotonic() -> Array {
        return monotonic(count: Array.defaultCount)
    }

    static func monotonic(count: Int) -> Array {
        return (1...count).map { Element($0) }
    }

    static func monotonicNormalized() -> Array {
        return monotonicNormalized(to: 1.0, count: Array.defaultCount)
    }

    static func monotonicNormalized(to scale: Element) -> Array {
        return monotonicNormalized(to: scale, count: Array.defaultCount)
    }

    static func monotonicNormalized(to scale: Element = 1.0, count: Int) -> Array {
        let scalarCount = Element(count)
        return (1...count).map { (Element($0) / scalarCount) * scale }
    }

    static func constant() -> Array {
        return constant(of: 1.0)
    }

    static func constant(of scalar: Element) -> Array {
        return constant(of: scalar, count: Array.defaultCount)
    }

    static func constant(of scalar: Element, count: Int) -> Array {
        return Array(repeating: scalar, count: count)
    }
}

extension Vector where Scalar: FloatingPoint & ExpressibleByFloatLiteral {
    static var defaultDimensions: Int {
        return 100
    }

    static func randomNormalized() -> Vector {
        return randomNormalized(to: 1.0, dimensions: Vector.defaultDimensions)
    }

    static func randomNormalized(to scale: Element) -> Vector {
        return randomNormalized(to: scale, dimensions: Vector.defaultDimensions)
    }

    static func randomNormalized(to scale: Scalar = 1.0, dimensions: Int) -> Vector {
        return Vector([Scalar].randomNormalized(to: scale, count: dimensions))
    }

    static func monotonic() -> Vector {
        return monotonic(dimensions: Vector.defaultDimensions)
    }

    static func monotonic(dimensions: Int) -> Vector {
        return Vector([Scalar].monotonic(count: dimensions))
    }

    static func monotonicNormalized() -> Vector {
        return monotonicNormalized(to: 1.0, dimensions: Vector.defaultDimensions)
    }

    static func monotonicNormalized(to scale: Scalar) -> Vector {
        return monotonicNormalized(to: scale, dimensions: Vector.defaultDimensions)
    }

    static func monotonicNormalized(to scale: Scalar = 1.0, dimensions: Int) -> Vector {
        return Vector([Scalar].monotonicNormalized(to: scale, count: dimensions))
    }

    static func constant() -> Vector {
        return constant(of: 2.0)
    }

    static func constant(of scalar: Scalar) -> Vector {
        return constant(of: scalar, dimensions: Vector.defaultDimensions)
    }

    static func constant(of scalar: Scalar, dimensions: Int) -> Vector {
        return Vector([Scalar].constant(of: scalar, count: dimensions))
    }
}

extension Matrix where Scalar: FloatingPoint & ExpressibleByFloatLiteral {
    static var defaultRows: Int {
        return 100
    }

    static var defaultColumns: Int {
        return 100
    }

    static func randomNormalized() -> Matrix {
        return randomNormalized(to: 1.0, rows: Matrix.defaultRows, columns: Matrix.defaultColumns)
    }

    static func randomNormalized(to scale: Scalar) -> Matrix {
        return randomNormalized(to: scale, rows: Matrix.defaultRows, columns: Matrix.defaultColumns)
    }

    static func randomNormalized(to scale: Scalar = 1.0, rows: Int, columns: Int) -> Matrix {
        let count = rows * columns
        let grid = [Scalar].randomNormalized(to: scale, count: count)
        return Matrix(rows: rows, columns: columns, grid: grid)
    }

    static func monotonic() -> Matrix {
        return monotonic(rows: Matrix.defaultRows, columns: Matrix.defaultColumns)
    }

    static func monotonic(rows: Int, columns: Int) -> Matrix {
        let count = rows * columns
        let grid = [Scalar].monotonic(count: count)
        return Matrix(rows: rows, columns: columns, grid: grid)
    }

    static func monotonicNormalized() -> Matrix {
        return monotonicNormalized(to: 1.0, rows: Matrix.defaultRows, columns: Matrix.defaultColumns)
    }

    static func monotonicNormalized(to scale: Scalar = 1.0) -> Matrix {
        return monotonicNormalized(to: scale, rows: Matrix.defaultRows, columns: Matrix.defaultColumns)
    }

    static func monotonicNormalized(to scale: Scalar = 1.0, rows: Int, columns: Int) -> Matrix {
        let count = rows * columns
        let grid = [Scalar].monotonicNormalized(to: scale, count: count)
        return Matrix(rows: rows, columns: columns, grid: grid)
    }

    static func constant() -> Matrix {
        return constant(of: 2.0)
    }

    static func constant(of scalar: Scalar) -> Matrix {
        return constant(of: scalar, rows: Matrix.defaultRows, columns: Matrix.defaultColumns)
    }

    static func constant(of scalar: Scalar, rows: Int, columns: Int) -> Matrix {
        let count = rows * columns
        let grid = [Scalar].constant(of: scalar, count: count)
        return Matrix(rows: rows, columns: columns, grid: grid)
    }
}
