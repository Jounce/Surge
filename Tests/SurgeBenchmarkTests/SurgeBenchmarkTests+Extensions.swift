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

// swiftlint:disable nesting

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
        return 100_000
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
        return 1_000
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
        return 1_000
    }

    static var defaultColumns: Int {
        return 1_000
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

// Why on earth do we need these abominations, you ask?
//
// Well, you see … XCTest is not —to put it mildly— the best unit testing framework out there.
// As such, while `XCTAssert` and its cousins have hidden `file: StaticString = #file, line: UInt = #line` parameters,
// which allow for Xcode to associate a particular failure with a different line than the actual invocation,
// its `measure(_:)` and the more elaborate `measureMetrics(_:automaticallyStartMeasuring:for:)` variant do not
// provide such hidden `file:line:` parameters. As such it's impossible to wrap the call to either of those functions
// in a convenience wrapper of some kind in order to reduce testing code bloat and redundancies.
//
// And due to the nature of Surge's `…InPlace` functions' use of `inout` invocations of such functions is not idempotent.
// So we need to make sure we're passing a freshly prepared test value to each invocation of the measure block.
// But at the same time we do not want to include such house-keeping things in our benchmarks, as it may involve
// quite costly memory allocations and copying.
//
// As such we are forced to make use of `measureMetrics(_:automaticallyStartMeasuring:for:)`, instead of the simpler `measure(_:)`
// and do some trampolin gymnastics to keep as much of the nasty and redundant stuff out of sight of the user.
//
// And this my dear friend is why we're having this conversion right now. I'm sorry.

extension XCTestCase {
    typealias LhsFunction<Lhs, T> = (Lhs) -> T
    typealias LhsFunctionWrapper<Lhs, T> = (LhsFunction<Lhs, T>) -> ()

    typealias LhsRhsFunction<Lhs, Rhs, T> = (Lhs, Rhs) -> T
    typealias LhsRhsFunctionWrapper<Lhs, Rhs, T> = (LhsRhsFunction<Lhs, Rhs, T>) -> ()

    typealias InOutLhsFunction<Lhs, T> = (inout Lhs) -> T
    typealias InOutLhsFunctionWrapper<Lhs, T> = (InOutLhsFunction<Lhs, T>) -> ()

    typealias InOutLhsRhsFunction<Lhs, Rhs, T> = (inout Lhs, Rhs) -> T
    typealias InOutLhsRhsFunctionWrapper<Lhs, Rhs, T> = (InOutLhsRhsFunction<Lhs, Rhs, T>) -> ()

    typealias Producer<T> = () -> T

    func measure_array<T, U>(
        of: T.Type,
        lhs produceLhs: Producer<[T]> = [T].monotonicNormalized,
        _ closure: (LhsFunctionWrapper<[T], U>) -> ()
    ) where T: FloatingPoint & ExpressibleByFloatLiteral {
        typealias Scalar = T

        let lhs = produceLhs()

        closure({ innerClosure in
            startMeasuring()
            let _ = innerClosure(lhs)
            stopMeasuring()
        })
    }

    func measure_inout_array<T, U>(
        of: T.Type,
        lhs produceLhs: Producer<[T]> = [T].monotonicNormalized,
        _ closure: (InOutLhsFunctionWrapper<[T], U>) -> ()
    ) where T: FloatingPoint & ExpressibleByFloatLiteral {
        typealias Scalar = T

        let lhs = produceLhs()

        closure({ innerClosure in
            var lhs = lhs

            startMeasuring()
            let _ = innerClosure(&lhs)
            stopMeasuring()
        })
    }

    func measure_array_array<T, U>(
        of: T.Type,
        lhs produceLhs: Producer<[T]> = [T].monotonicNormalized,
        rhs produceRhs: Producer<[T]> = [T].monotonicNormalized,
        _ closure: (LhsRhsFunctionWrapper<[T], [T], U>) -> ()
    ) where T: FloatingPoint & ExpressibleByFloatLiteral {
        typealias Scalar = T

        let lhs = produceLhs()
        let rhs = produceRhs()

        closure({ innerClosure in
            startMeasuring()
            let _ = innerClosure(lhs, rhs)
            stopMeasuring()
        })
    }

    func measure_inout_array_array<T, U>(
        of: T.Type,
        lhs produceLhs: Producer<[T]> = [T].monotonicNormalized,
        rhs produceRhs: Producer<[T]> = [T].monotonicNormalized,
        _ closure: (InOutLhsRhsFunctionWrapper<[T], [T], U>) -> ()
    ) where T: FloatingPoint & ExpressibleByFloatLiteral {
        typealias Scalar = T

        let lhs = produceLhs()
        let rhs = produceRhs()

        closure({ innerClosure in
            var lhs = lhs

            startMeasuring()
            let _ = innerClosure(&lhs, rhs)
            stopMeasuring()
        })
    }

    func measure_array_scalar<T, U>(
        of: T.Type,
        lhs produceLhs: Producer<[T]> = [T].monotonicNormalized,
        rhs produceRhs: Producer<T> = T.constant,
        _ closure: (LhsRhsFunctionWrapper<[T], T, U>) -> ()
    ) where T: FloatingPoint & ExpressibleByFloatLiteral {
        typealias Scalar = T

        let lhs = produceLhs()
        let rhs = produceRhs()

        closure({ innerClosure in
            startMeasuring()
            let _ = innerClosure(lhs, rhs)
            stopMeasuring()
        })
    }

    func measure_inout_array_scalar<T, U>(
        of: T.Type,
        lhs produceLhs: Producer<[T]> = [T].monotonicNormalized,
        rhs produceRhs: Producer<T> = T.constant,
        _ closure: (InOutLhsRhsFunctionWrapper<[T], T, U>) -> ()
    ) where T: FloatingPoint & ExpressibleByFloatLiteral {
        typealias Scalar = T

        let lhs = produceLhs()
        let rhs = produceRhs()

        closure({ innerClosure in
            var lhs = lhs

            startMeasuring()
            let _ = innerClosure(&lhs, rhs)
            stopMeasuring()
        })
    }

    func measure_vector_matrix<T, U>(
        of: T.Type,
        lhs produceLhs: Producer<Vector<T>> = Vector<T>.monotonicNormalized,
        rhs produceRhs: Producer<Matrix<T>> = Matrix<T>.monotonicNormalized,
        _ closure: (LhsRhsFunctionWrapper<Vector<T>, Matrix<T>, U>) -> ()
    ) where T: FloatingPoint & ExpressibleByFloatLiteral {
        typealias Scalar = T

        let lhs = produceLhs()
        let rhs = produceRhs()

        closure({ innerClosure in
            startMeasuring()
            let _ = innerClosure(lhs, rhs)
            stopMeasuring()
        })
    }
}
