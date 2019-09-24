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

import Foundation
import XCTest

@testable import Surge

extension XCTestCase {
    func measureAndValidateMappedFunctionWithAccuracy<C: Collection>(source: C, member: (C.Iterator.Element) -> (C.Iterator.Element), mapped: @escaping (C) -> ([C.Iterator.Element]), accuracy: C.Iterator.Element) where C.Iterator.Element: ExpressibleByFloatLiteral & FloatingPoint {
        let expected = source.map(member)

        var actual: [C.Iterator.Element] = []
        self.measure {
            actual = mapped(source)
        }

        for (i, j) in zip(actual.indices, expected.indices) {
            XCTAssertEqual(actual[i], expected[j], accuracy: accuracy)
        }
    }
}

extension ExpressibleByFloatLiteral {
    static func identity() -> Self {
        return 1.0
    }

    static func constant() -> Self {
        return 0.42
    }
}

extension Array where Element: FloatingPoint & ExpressibleByFloatLiteral {
    static var defaultCount: Int {
        return 1_000
    }

    static func monotonic() -> Array {
        return monotonic(count: Array.defaultCount)
    }

    static func monotonic(count: Int) -> Array {
        return (1...count).map { Element($0) }
    }

    static func monotonicNormalized() -> Array {
        return monotonicNormalized(count: Array.defaultCount)
    }

    static func monotonicNormalized(count: Int) -> Array {
        let scalarCount = Element(count)
        return (1...count).map { Element($0) / scalarCount }
    }

    static func constant() -> Array {
        return constant(1.0)
    }

    static func constant(_ scalar: Element) -> Array {
        return constant(scalar, count: Array.defaultCount)
    }

    static func constant(_ scalar: Element, count: Int) -> Array {
        return Array(repeating: scalar, count: count)
    }
}

extension Vector where Scalar: FloatingPoint & ExpressibleByFloatLiteral {
    static var defaultDimensions: Int {
        return 100
    }

    static func monotonic() -> Vector {
        return monotonic(dimensions: Vector.defaultDimensions)
    }

    static func monotonic(dimensions: Int) -> Vector {
        return Vector([Scalar].monotonic(count: dimensions))
    }

    static func monotonicNormalized() -> Vector {
        return monotonicNormalized(dimensions: Vector.defaultDimensions)
    }

    static func monotonicNormalized(dimensions: Int) -> Vector {
        return Vector([Scalar].monotonicNormalized(count: dimensions))
    }

    static func constant() -> Vector {
        return constant(2.0)
    }

    static func constant(_ scalar: Scalar) -> Vector {
        return constant(scalar, dimensions: Vector.defaultDimensions)
    }

    static func constant(_ scalar: Scalar, dimensions: Int) -> Vector {
        return Vector([Scalar].constant(scalar, count: dimensions))
    }
}

extension Matrix where Scalar: FloatingPoint & ExpressibleByFloatLiteral {
    static var defaultRows: Int {
        return 100
    }

    static var defaultColumns: Int {
        return 100
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
        return monotonicNormalized(rows: Matrix.defaultRows, columns: Matrix.defaultColumns)
    }

    static func monotonicNormalized(rows: Int, columns: Int) -> Matrix {
        let count = rows * columns
        let grid = [Scalar].monotonicNormalized(count: count)
        return Matrix(rows: rows, columns: columns, grid: grid)
    }

    static func constant() -> Matrix {
        return constant(2.0)
    }

    static func constant(_ scalar: Scalar) -> Matrix {
        return constant(scalar, rows: Matrix.defaultRows, columns: Matrix.defaultColumns)
    }

    static func constant(_ scalar: Scalar, rows: Int, columns: Int) -> Matrix {
        let count = rows * columns
        let grid = [Scalar].constant(scalar, count: count)
        return Matrix(rows: rows, columns: columns, grid: grid)
    }
}
