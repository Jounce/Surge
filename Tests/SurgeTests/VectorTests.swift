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

import XCTest

@testable import Surge

// swiftlint:disable nesting type_body_length

class VectorTests: XCTestCase {
    // MARK: - Initialization

    func test_init() {
        typealias Scalar = Double

        let values: [Scalar] = .monotonicNormalized()
        let lhs: Vector<Scalar> = Vector(values)

        XCTAssertEqual(lhs.scalars, values)
    }

    // MARK: - Subscript

    func test_subscript() {
        typealias Scalar = Double

        let values: [Scalar] = .monotonicNormalized()
        let lhs: Vector<Scalar> = Vector(values)

        for (index, expected) in values.enumerated() {
            XCTAssertEqual(lhs[index], expected)
        }
    }

    // MARK: - Addition: In Place

    func test_add_in_place_vector_vector_double() {
        typealias Scalar = Double

        let lhs: Vector<Scalar> = .monotonicNormalized()
        let rhs: Vector<Scalar> = .monotonicNormalized()

        var actual: Vector<Scalar> = lhs
        Surge.addInPlace(&actual, rhs)

        let expected: Vector<Scalar> = Vector(zip(lhs, rhs).map { $0 + $1 })

        XCTAssertEqual(actual, expected, accuracy: 1e-8)
    }

    func test_add_in_place_vector_vector_float() {
        typealias Scalar = Float

        let lhs: Vector<Scalar> = .monotonicNormalized()
        let rhs: Vector<Scalar> = .monotonicNormalized()

        var actual: Vector<Scalar> = lhs
        Surge.addInPlace(&actual, rhs)

        let expected: Vector<Scalar> = Vector(zip(lhs, rhs).map { $0 + $1 })

        XCTAssertEqual(actual, expected, accuracy: 1e-8)
    }

    func test_add_in_place_vector_scalar_double() {
        typealias Scalar = Double

        let lhs: Vector<Scalar> = .monotonicNormalized()
        let rhs: Scalar = .constant()

        var actual: Vector<Scalar> = lhs
        Surge.addInPlace(&actual, rhs)

        let expected: Vector<Scalar> = Vector(lhs.map { $0 + rhs })

        XCTAssertEqual(actual, expected, accuracy: 1e-8)
    }

    func test_add_in_place_vector_scalar_float() {
        typealias Scalar = Float

        let lhs: Vector<Scalar> = .monotonicNormalized()
        let rhs: Scalar = .constant()

        var actual: Vector<Scalar> = lhs
        Surge.addInPlace(&actual, rhs)

        let expected: Vector<Scalar> = Vector(lhs.map { $0 + rhs })

        XCTAssertEqual(actual, expected, accuracy: 1e-8)
    }

    // MARK: - Subtraction: In Place

    func test_sub_in_place_vector_vector_double() {
        typealias Scalar = Double

        let lhs: Vector<Scalar> = .monotonicNormalized()
        let rhs: Vector<Scalar> = .monotonicNormalized()

        var actual: Vector<Scalar> = lhs
        Surge.subInPlace(&actual, rhs)

        let expected: Vector<Scalar> = Vector(zip(lhs, rhs).map { $0 - $1 })

        XCTAssertEqual(actual, expected, accuracy: 1e-8)
    }

    func test_sub_in_place_vector_vector_float() {
        typealias Scalar = Float

        let lhs: Vector<Scalar> = .monotonicNormalized()
        let rhs: Vector<Scalar> = .monotonicNormalized()

        var actual: Vector<Scalar> = lhs
        Surge.subInPlace(&actual, rhs)

        let expected: Vector<Scalar> = Vector(zip(lhs, rhs).map { $0 - $1 })

        XCTAssertEqual(actual, expected, accuracy: 1e-8)
    }

    func test_sub_in_place_vector_scalar_double() {
        typealias Scalar = Double

        let lhs: Vector<Scalar> = .monotonicNormalized()
        let rhs: Scalar = .constant()

        var actual: Vector<Scalar> = lhs
        Surge.subInPlace(&actual, rhs)

        let expected: Vector<Scalar> = Vector(lhs.map { $0 - rhs })

        XCTAssertEqual(actual, expected, accuracy: 1e-8)
    }

    func test_sub_in_place_vector_scalar_float() {
        typealias Scalar = Float

        let lhs: Vector<Scalar> = .monotonicNormalized()
        let rhs: Scalar = .constant()

        var actual: Vector<Scalar> = lhs
        Surge.subInPlace(&actual, rhs)

        let expected: Vector<Scalar> = Vector(lhs.map { $0 - rhs })

        XCTAssertEqual(actual, expected, accuracy: 1e-8)
    }

    // MARK: - Multiply Addition: In Place

    func test_muladd_in_place_vector_vector_double() {
        typealias Scalar = Double

        let lhs: Vector<Scalar> = .monotonicNormalized()
        let rhs: Vector<Scalar> = .monotonicNormalized()
        let alpha: Scalar = .constant()

        var actual: Vector<Scalar> = lhs
        Surge.muladdInPlace(&actual, rhs, alpha)

        let expected: Vector<Scalar> = Vector(zip(lhs.scalars, rhs.scalars).map { $0 + ($1 * alpha) })

        XCTAssertEqual(actual, expected, accuracy: 1e-8)
    }

    func test_muladd_in_place_vector_vector_float() {
        typealias Scalar = Float

        let lhs: Vector<Scalar> = .monotonicNormalized()
        let rhs: Vector<Scalar> = .monotonicNormalized()
        let alpha: Scalar = .constant()

        var actual: Vector<Scalar> = lhs
        Surge.muladdInPlace(&actual, rhs, alpha)

        let expected: Vector<Scalar> = Vector(zip(lhs.scalars, rhs.scalars).map { $0 + ($1 * alpha) })

        XCTAssertEqual(actual, expected, accuracy: 1e-6)
    }

    // MARK: - Multiplication: In Place

    func test_mul_in_place_vector_scalar_double() {
        typealias Scalar = Double

        let lhs: Vector<Scalar> = .monotonicNormalized()
        let rhs: Scalar = .constant()

        var actual: Vector<Scalar> = lhs
        Surge.mulInPlace(&actual, rhs)

        let expected: Vector<Scalar> = Vector(lhs.map { $0 * rhs })

        XCTAssertEqual(actual, expected, accuracy: 1e-8)
    }

    func test_mul_in_place_vector_scalar_float() {
        typealias Scalar = Float

        let lhs: Vector<Scalar> = .monotonicNormalized()
        let rhs: Scalar = .constant()

        var actual: Vector<Scalar> = lhs
        Surge.mulInPlace(&actual, rhs)

        let expected: Vector<Scalar> = Vector(lhs.map { $0 * rhs })

        XCTAssertEqual(actual, expected, accuracy: 1e-8)
    }

    func test_mul_vector_matrix_double() {
        typealias Scalar = Double

        let lhs: Vector<Scalar> = .monotonicNormalized()
        let rhs: Matrix<Scalar> = .monotonicNormalized()

        let actual: Vector<Scalar> = Surge.mul(lhs, rhs)

        let transposed: Matrix<Scalar> = Surge.transpose(rhs)
        let columns: [Vector<Scalar>] = transposed.map { Vector($0) }
        let expected: Vector<Scalar> = Vector(columns.map { rhs in
            let squares: [Scalar] = zip(lhs, rhs).map { $0 * $1 }
            return squares.reduce(0.0, +)
        })

        XCTAssertEqual(actual, expected, accuracy: 1e-8)
    }

    func test_mul_vector_matrix_float() {
        typealias Scalar = Float

        let lhs: Vector<Scalar> = .monotonicNormalized()
        let rhs: Matrix<Scalar> = .monotonicNormalized()

        let actual: Vector<Scalar> = Surge.mul(lhs, rhs)

        let transposed: Matrix<Scalar> = Surge.transpose(rhs)
        let columns: [Vector<Scalar>] = transposed.map { Vector($0) }
        let expected: Vector<Scalar> = Vector(columns.map { rhs in
            let squares: [Scalar] = zip(lhs, rhs).map { $0 * $1 }
            return squares.reduce(0.0, +)
        })

        XCTAssertEqual(actual, expected, accuracy: 1e-3)
    }

    // MARK: - Division: In Place

    func test_div_in_place_vector_scalar_double() {
        typealias Scalar = Double

        let lhs: Vector<Scalar> = .monotonicNormalized()
        let rhs: Scalar = .constant()

        var actual: Vector<Scalar> = lhs
        Surge.divInPlace(&actual, rhs)

        let expected: Vector<Scalar> = Vector(lhs.map { $0 / rhs })

        XCTAssertEqual(actual, expected, accuracy: 1e-8)
    }

    func test_div_in_place_vector_scalar_float() {
        typealias Scalar = Float

        let lhs: Vector<Scalar> = .monotonicNormalized()
        let rhs: Scalar = .constant()

        var actual: Vector<Scalar> = lhs
        Surge.divInPlace(&actual, rhs)

        let expected: Vector<Scalar> = Vector(lhs.map { $0 / rhs })

        XCTAssertEqual(actual, expected, accuracy: 1e-5)
    }

    // MARK: - Element-wise Multiplication: In Place

    func test_elmul_in_place_double() {
        typealias Scalar = Double

        let lhs: Vector<Scalar> = .monotonicNormalized()
        let rhs: Vector<Scalar> = .monotonicNormalized()

        var actual: Vector<Scalar> = lhs
        Surge.elmulInPlace(&actual, rhs)

        let expected: Vector<Scalar> = Vector(zip(lhs, rhs).map { $0 * $1 })

        XCTAssertEqual(actual, expected, accuracy: 1e-8)
    }

    func test_elmul_in_place_float() {
        typealias Scalar = Float

        let lhs: Vector<Scalar> = .monotonicNormalized()
        let rhs: Vector<Scalar> = .monotonicNormalized()

        var actual: Vector<Scalar> = lhs
        Surge.elmulInPlace(&actual, rhs)

        let expected: Vector<Scalar> = Vector(zip(lhs, rhs).map { $0 * $1 })

        XCTAssertEqual(actual, expected, accuracy: 1e-8)
    }

    // MARK: - Element-wise Division: In Place

    func test_eldiv_in_place_double() {
        typealias Scalar = Double

        let lhs: Vector<Scalar> = .monotonicNormalized()
        let rhs: Vector<Scalar> = .monotonicNormalized()

        var actual: Vector<Scalar> = lhs
        Surge.eldivInPlace(&actual, rhs)

        let expected: Vector<Scalar> = Vector(zip(lhs, rhs).map { $0 / $1 })

        XCTAssertEqual(actual, expected, accuracy: 1e-8)
    }

    func test_eldiv_in_place_float() {
        typealias Scalar = Float

        let lhs: Vector<Scalar> = .monotonicNormalized()
        let rhs: Vector<Scalar> = .monotonicNormalized()

        var actual: Vector<Scalar> = lhs
        Surge.eldivInPlace(&actual, rhs)

        let expected: Vector<Scalar> = Vector(zip(lhs, rhs).map { $0 / $1 })

        XCTAssertEqual(actual, expected, accuracy: 1e-6)
    }

    // MARK: - Dot Product: In Place

    func test_dot_vector_vector_double() {
        typealias Scalar = Double

        let lhs: Vector<Scalar> = .monotonicNormalized()
        let rhs: Vector<Scalar> = .monotonicNormalized()

        let actual: Scalar = Surge.dot(lhs, rhs)

        let squares: [Scalar] = zip(lhs, rhs).map { $0 * $1 }
        let expected: Scalar = squares.reduce(0.0, +)

        XCTAssertEqual(actual, expected, accuracy: 1e-8)
    }

    func test_dot_vector_vector_float() {
        typealias Scalar = Float

        let lhs: Vector<Scalar> = .monotonicNormalized()
        let rhs: Vector<Scalar> = .monotonicNormalized()

        let actual: Scalar = Surge.dot(lhs, rhs)

        let squares: [Scalar] = zip(lhs, rhs).map { $0 * $1 }
        let expected: Scalar = squares.reduce(0.0, +)

        XCTAssertEqual(actual, expected, accuracy: 1e-3)
    }

    // MARK: - Power

    func test_pow_in_place_vector_scalar_double() {
        typealias Scalar = Double

        let lhs: Vector<Scalar> = .monotonicNormalized()
        let rhs: Scalar = .constant()

        var actual: Vector<Scalar> = lhs
        Surge.powInPlace(&actual, rhs)

        let expected: Vector<Scalar> = Vector(lhs.map { pow($0, rhs) })

        XCTAssertEqual(actual, expected, accuracy: 1e-8)
    }

    func test_pow_in_place_vector_scalar_float() {
        typealias Scalar = Float

        let lhs: Vector<Scalar> = .monotonicNormalized()
        let rhs: Scalar = .constant()

        var actual: Vector<Scalar> = lhs
        Surge.powInPlace(&actual, rhs)

        let expected: Vector<Scalar> = Vector(lhs.map { pow($0, rhs) })

        XCTAssertEqual(actual, expected, accuracy: 1e-5)
    }

    // MARK: - Exponential

    func test_exp_in_place_vector_double() {
        typealias Scalar = Double

        let lhs: Vector<Scalar> = .monotonicNormalized()

        var actual: Vector<Scalar> = lhs
        Surge.expInPlace(&actual)

        let expected: Vector<Scalar> = Vector(lhs.map { exp($0) })

        XCTAssertEqual(actual, expected, accuracy: 1e-6)
    }

    func test_exp_in_place_vector_float() {
        typealias Scalar = Float

        let lhs: Vector<Scalar> = .monotonicNormalized()

        var actual: Vector<Scalar> = lhs
        Surge.expInPlace(&actual)

        let expected: Vector<Scalar> = Vector(lhs.map { exp($0) })

        XCTAssertEqual(actual, expected, accuracy: 1e-2)
    }

    // MARK: - Distance

    func test_dist_vector_vector_double() {
        typealias Scalar = Double

        let lhs: Vector<Scalar> = .monotonicNormalized()
        let rhs: Vector<Scalar> = .monotonicNormalized()

        let actual: Scalar = Surge.dist(lhs, rhs)

        let partialDistances: [Scalar] = zip(lhs, rhs).map { $0 - $1 }
        let partialDistancesSquared: [Scalar] = partialDistances.map { $0 * $0 }
        let sumOfPartialDistancesSquared: Scalar = partialDistancesSquared.reduce(0.0, +)
        let expected: Scalar = sqrt(sumOfPartialDistancesSquared)

        XCTAssertEqual(actual, expected, accuracy: 1e-6)
    }

    func test_dist_vector_vector_float() {
        typealias Scalar = Float

        let lhs: Vector<Scalar> = .monotonicNormalized()
        let rhs: Vector<Scalar> = .monotonicNormalized()

        let actual: Scalar = Surge.dist(lhs, rhs)

        let partialDistances: [Scalar] = zip(lhs, rhs).map { $0 - $1 }
        let partialDistancesSquared: [Scalar] = partialDistances.map { $0 * $0 }
        let sumOfPartialDistancesSquared: Scalar = partialDistancesSquared.reduce(0.0, +)
        let expected: Scalar = sqrt(sumOfPartialDistancesSquared)

        XCTAssertEqual(actual, expected, accuracy: 1e-6)
    }

    // MARK: - Distance Squared

    func test_distsq_vector_vector_double() {
        typealias Scalar = Double

        let lhs: Vector<Scalar> = .monotonicNormalized()
        let rhs: Vector<Scalar> = .monotonicNormalized()

        let actual: Scalar = Surge.dist(lhs, rhs)

        let partialDistances: [Scalar] = zip(lhs, rhs).map { $0 - $1 }
        let partialDistancesSquared: [Scalar] = partialDistances.map { $0 * $0 }
        let expected: Scalar = partialDistancesSquared.reduce(0.0, +)

        XCTAssertEqual(actual, expected, accuracy: 1e-6)
    }

    func test_distsq_vector_vector_float() {
        typealias Scalar = Float

        let lhs: Vector<Scalar> = .monotonicNormalized()
        let rhs: Vector<Scalar> = .monotonicNormalized()

        let actual: Scalar = Surge.dist(lhs, rhs)

        let partialDistances: [Scalar] = zip(lhs, rhs).map { $0 - $1 }
        let partialDistancesSquared: [Scalar] = partialDistances.map { $0 * $0 }
        let expected: Scalar = partialDistancesSquared.reduce(0.0, +)

        XCTAssertEqual(actual, expected, accuracy: 1e-6)
    }
}
