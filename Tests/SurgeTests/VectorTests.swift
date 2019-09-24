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

import XCTest

@testable import Surge

// swiftlint:disable nesting type_body_length

class VectorTests: XCTestCase {
    // MARK: - Initialization

    func test_init() {
        let v = Vector([1.0, 2.0])
        XCTAssertEqual(v.scalars, [1.0, 2.0])
    }

    // MARK: - Addition: In Place

    func test_add_in_place_vector_vector_double() {
        typealias Scalar = Double

        let vector: Vector<Scalar> = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]

        var actual: Vector<Scalar> = []
        measureMetrics([.wallClockTime], automaticallyStartMeasuring: false) {
            actual = vector

            startMeasuring()
            actual += vector
            stopMeasuring()
        }

        let expected: Vector<Scalar> = [2, 4, 6, 8, 10, 12, 14, 16, 18, 20]

        XCTAssertEqual(actual, expected, accuracy: 1e-8)
    }

    func test_add_in_place_vector_vector_float() {
        typealias Scalar = Float

        let vector: Vector<Scalar> = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]

        var actual: Vector<Scalar> = []
        measureMetrics([.wallClockTime], automaticallyStartMeasuring: false) {
            actual = vector

            startMeasuring()
            actual += vector
            stopMeasuring()
        }

        let expected: Vector<Scalar> = [2, 4, 6, 8, 10, 12, 14, 16, 18, 20]

        XCTAssertEqual(actual, expected, accuracy: 1e-8)
    }

    func test_add_in_place_vector_scalar_double() {
        typealias Scalar = Double

        let vector: Vector<Scalar> = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
        let scalar: Scalar = 1.0

        var actual: Vector<Scalar> = []
        measureMetrics([.wallClockTime], automaticallyStartMeasuring: false) {
            actual = vector

            startMeasuring()
            actual += scalar
            stopMeasuring()
        }

        let expected: Vector<Scalar> = [2, 3, 4, 5, 6, 7, 8, 9, 10, 11]

        XCTAssertEqual(actual, expected, accuracy: 1e-8)
    }

    func test_add_in_place_vector_scalar_float() {
        typealias Scalar = Float

        let vector: Vector<Scalar> = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
        let scalar: Scalar = 1.0

        var actual: Vector<Scalar> = []
        measureMetrics([.wallClockTime], automaticallyStartMeasuring: false) {
            actual = vector

            startMeasuring()
            actual += scalar
            stopMeasuring()
        }

        let expected: Vector<Scalar> = [2, 3, 4, 5, 6, 7, 8, 9, 10, 11]

        XCTAssertEqual(actual, expected, accuracy: 1e-8)
    }

    // MARK: - Subtraction: In Place

    func test_sub_in_place_vector_vector_double() {
        typealias Scalar = Double

        let vector: Vector<Scalar> = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]

        var actual: Vector<Scalar> = []
        measureMetrics([.wallClockTime], automaticallyStartMeasuring: false) {
            actual = vector

            startMeasuring()
            actual -= vector
            stopMeasuring()
        }

        let expected: Vector<Scalar> = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0]

        XCTAssertEqual(actual, expected, accuracy: 1e-8)
    }

    func test_sub_in_place_vector_vector_float() {
        typealias Scalar = Float

        let vector: Vector<Scalar> = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]

        var actual: Vector<Scalar> = []
        measureMetrics([.wallClockTime], automaticallyStartMeasuring: false) {
            actual = vector

            startMeasuring()
            actual -= vector
            stopMeasuring()
        }

        let expected: Vector<Scalar> = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0]

        XCTAssertEqual(actual, expected, accuracy: 1e-8)
    }

    func test_sub_in_place_vector_scalar_double() {
        typealias Scalar = Double

        let vector: Vector<Scalar> = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
        let scalar: Scalar = 1.0

        var actual: Vector<Scalar> = []
        measureMetrics([.wallClockTime], automaticallyStartMeasuring: false) {
            actual = vector

            startMeasuring()
            actual -= scalar
            stopMeasuring()
        }

        let expected: Vector<Scalar> = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9]

        XCTAssertEqual(actual, expected, accuracy: 1e-8)
    }

    func test_sub_in_place_vector_scalar_float() {
        typealias Scalar = Float

        let vector: Vector<Scalar> = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
        let scalar: Scalar = 1.0

        var actual: Vector<Scalar> = []
        measureMetrics([.wallClockTime], automaticallyStartMeasuring: false) {
            actual = vector

            startMeasuring()
            actual -= scalar
            stopMeasuring()
        }

        let expected: Vector<Scalar> = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9]

        XCTAssertEqual(actual, expected, accuracy: 1e-8)
    }

    // MARK: - Multiply Addition: In Place

    func test_muladd_in_place_vector_vector_double() {
        typealias Scalar = Double

        let vector: Vector<Scalar> = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
        let scalar: Scalar = 2.0

        var actual: Vector<Scalar> = []
        measureMetrics([.wallClockTime], automaticallyStartMeasuring: false) {
            actual = vector

            startMeasuring()
            Surge.muladdInPlace(&actual, vector, scalar)
            stopMeasuring()
        }

        let expected: Vector<Scalar> = [3, 6, 9, 12, 15, 18, 21, 24, 27, 30]

        XCTAssertEqual(actual, expected, accuracy: 1e-8)
    }

    func test_muladd_in_place_vector_vector_float() {
        typealias Scalar = Float

        let vector: Vector<Scalar> = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
        let scalar: Scalar = 2.0

        var actual: Vector<Scalar> = []
        measureMetrics([.wallClockTime], automaticallyStartMeasuring: false) {
            actual = vector

            startMeasuring()
            Surge.muladdInPlace(&actual, vector, scalar)
            stopMeasuring()
        }

        let expected: Vector<Scalar> = [3, 6, 9, 12, 15, 18, 21, 24, 27, 30]

        XCTAssertEqual(actual, expected, accuracy: 1e-8)
    }

    // MARK: - Multiplication: In Place

    func test_mul_in_place_vector_scalar_double() {
        typealias Scalar = Double

        let vector: Vector<Scalar> = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
        let scalar: Scalar = 2.0

        var actual: Vector<Scalar> = []
        measureMetrics([.wallClockTime], automaticallyStartMeasuring: false) {
            actual = vector

            startMeasuring()
            actual *= scalar
            stopMeasuring()
        }

        let expected: Vector<Scalar> = [2, 4, 6, 8, 10, 12, 14, 16, 18, 20]

        XCTAssertEqual(actual, expected, accuracy: 1e-8)
    }

    func test_mul_in_place_vector_scalar_float() {
        typealias Scalar = Float

        let vector: Vector<Scalar> = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
        let scalar: Scalar = 2.0

        var actual: Vector<Scalar> = []
        measureMetrics([.wallClockTime], automaticallyStartMeasuring: false) {
            actual = vector

            startMeasuring()
            actual *= scalar
            stopMeasuring()
        }

        let expected: Vector<Scalar> = [2, 4, 6, 8, 10, 12, 14, 16, 18, 20]

        XCTAssertEqual(actual, expected, accuracy: 1e-8)
    }

    // MARK: - Division: In Place

    func test_div_in_place_vector_scalar_double() {
        typealias Scalar = Double

        let vector: Vector<Scalar> = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
        let scalar: Scalar = 0.5

        var actual: Vector<Scalar> = []
        measureMetrics([.wallClockTime], automaticallyStartMeasuring: false) {
            actual = vector

            startMeasuring()
            actual /= scalar
            stopMeasuring()
        }

        let expected: Vector<Scalar> = [2, 4, 6, 8, 10, 12, 14, 16, 18, 20]

        XCTAssertEqual(actual, expected, accuracy: 1e-8)
    }

    func test_div_in_place_vector_scalar_float() {
        typealias Scalar = Float

        let vector: Vector<Scalar> = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
        let scalar: Scalar = 0.5

        var actual: Vector<Scalar> = []
        measureMetrics([.wallClockTime], automaticallyStartMeasuring: false) {
            actual = vector

            startMeasuring()
            actual /= scalar
            stopMeasuring()
        }

        let expected: Vector<Scalar> = [2, 4, 6, 8, 10, 12, 14, 16, 18, 20]

        XCTAssertEqual(actual, expected, accuracy: 1e-5)
    }

    // MARK: - Element-wise Multiplication: In Place

    func test_elmul_in_place_double() {
        typealias Scalar = Double

        let vector: Vector<Scalar> = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]

        var actual: Vector<Scalar> = []
        measureMetrics([.wallClockTime], automaticallyStartMeasuring: false) {
            actual = vector

            startMeasuring()
            actual .*= vector
            stopMeasuring()
        }

        let expected: Vector<Scalar> = [1, 4, 9, 16, 25, 36, 49, 64, 81, 100]

        XCTAssertEqual(actual, expected, accuracy: 1e-8)
    }

    func test_elmul_in_place_float() {
        typealias Scalar = Float

        let vector: Vector<Scalar> = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]

        var actual: Vector<Scalar> = []
        measureMetrics([.wallClockTime], automaticallyStartMeasuring: false) {
            actual = vector

            startMeasuring()
            actual .*= vector
            stopMeasuring()
        }

        let expected: Vector<Scalar> = [1, 4, 9, 16, 25, 36, 49, 64, 81, 100]

        XCTAssertEqual(actual, expected, accuracy: 1e-8)
    }

    // MARK: - Element-wise Division: In Place

    func test_eldiv_in_place_double() {
        typealias Scalar = Double

        let vector: Vector<Scalar> = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]

        var actual: Vector<Scalar> = []
        measureMetrics([.wallClockTime], automaticallyStartMeasuring: false) {
            actual = vector

            startMeasuring()
            actual ./= vector
            stopMeasuring()
        }

        let expected: Vector<Scalar> = [1, 1, 1, 1, 1, 1, 1, 1, 1, 1]

        XCTAssertEqual(actual, expected, accuracy: 1e-8)
    }

    func test_eldiv_in_place_float() {
        typealias Scalar = Float

        let vector: Vector<Scalar> = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]

        var actual: Vector<Scalar> = []
        measureMetrics([.wallClockTime], automaticallyStartMeasuring: false) {
            actual = vector

            startMeasuring()
            actual ./= vector
            stopMeasuring()
        }

        let expected: Vector<Scalar> = [1, 1, 1, 1, 1, 1, 1, 1, 1, 1]

        XCTAssertEqual(actual, expected, accuracy: 1e-6)
    }

    // MARK: - Dot Product

    func test_dot_vector_vector_double() {
        typealias Scalar = Double

        let vector: Vector<Scalar> = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]

        let actual = dot(vector, vector)
        let expected: Scalar = 385

        XCTAssertEqual(actual, expected, accuracy: 1e-8)
    }

    func test_dot_vector_vector_float() {
        typealias Scalar = Float

        let vector: Vector<Scalar> = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]

        let actual = dot(vector, vector)
        let expected: Scalar = 385

        XCTAssertEqual(actual, expected, accuracy: 1e-5)
    }

    // MARK: - Power

    func test_pow_in_place_vector_scalar_double() {
        typealias Scalar = Double

        let vector: Vector<Scalar> = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
        let scalar: Scalar = 2.0

        var actual: Vector<Scalar> = []
        measureMetrics([.wallClockTime], automaticallyStartMeasuring: false) {
            actual = vector

            startMeasuring()
            powInPlace(&actual, scalar)
            stopMeasuring()
        }
        let expected: Vector<Scalar> = [1, 4, 9, 16, 25, 36, 49, 64, 81, 100]

        XCTAssertEqual(actual, expected, accuracy: 1e-8)
    }

    func test_pow_in_place_vector_scalar_float() {
        typealias Scalar = Float

        let vector: Vector<Scalar> = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
        let scalar: Scalar = 2.0

        var actual: Vector<Scalar> = []
        measureMetrics([.wallClockTime], automaticallyStartMeasuring: false) {
            actual = vector

            startMeasuring()
            powInPlace(&actual, scalar)
            stopMeasuring()
        }
        let expected: Vector<Scalar> = [1, 4, 9, 16, 25, 36, 49, 64, 81, 100]

        XCTAssertEqual(actual, expected, accuracy: 1e-5)
    }

    // MARK: - Exponential

    func test_exp_in_place_vector_double() {
        typealias Scalar = Double

        let vector: Vector<Scalar> = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]

        var actual: Vector<Scalar> = []
        measureMetrics([.wallClockTime], automaticallyStartMeasuring: false) {
            actual = vector

            startMeasuring()
            expInPlace(&actual)
            stopMeasuring()
        }
        let expected: Vector<Scalar> = [
            2.718_282, 7.389_056, 20.085_537, 54.598_150, 148.413_159,
            403.428_793, 1_096.633_158, 2_980.957_987, 8_103.083_928, 22_026.465_795
        ]

        XCTAssertEqual(actual, expected, accuracy: 1e-6)
    }

    func test_exp_in_place_vector_float() {
        typealias Scalar = Float

        let vector: Vector<Scalar> = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]

        var actual: Vector<Scalar> = []
        measureMetrics([.wallClockTime], automaticallyStartMeasuring: false) {
            actual = vector

            startMeasuring()
            expInPlace(&actual)
            stopMeasuring()
        }
        let expected: Vector<Scalar> = [
            2.718_282, 7.389_056, 20.085_537, 54.598_150, 148.413_159,
            403.428_793, 1_096.633_158, 2_980.957_987, 8_103.083_928, 22_026.465_795
        ]

        XCTAssertEqual(actual, expected, accuracy: 1e-2)
    }

    // MARK: - Distance

    func test_dist_vector_vector_double() {
        typealias Scalar = Double

        let lhs: Vector<Scalar> = [1, 2, 3]
        let rhs: Vector<Scalar> = [9, 8, 7]

        var actual: Scalar = 0
        measure {
            actual = dist(lhs, rhs)
        }
        let expected: Scalar = sqrt(Swift.zip(lhs, rhs).map({ $0 - $1 }).map({ $0 * $0 }).reduce(0.0, +))

        XCTAssertEqual(actual, expected, accuracy: 1e-6)
    }

    func test_dist_vector_vector_float() {
        typealias Scalar = Float

        let lhs: Vector<Scalar> = [1, 2, 3, 4]
        let rhs: Vector<Scalar> = [9, 8, 7, 6]

        var actual: Scalar = 0
        measure {
            actual = dist(lhs, rhs)
        }
        let expected: Scalar = sqrt(Swift.zip(lhs, rhs).map({ $0 - $1 }).map({ $0 * $0 }).reduce(0.0, +))

        XCTAssertEqual(actual, expected, accuracy: 1e-6)
    }

    // MARK: - Distance Squared

    func test_distsq_vector_vector_double() {
        typealias Scalar = Double

        let lhs: Vector<Scalar> = [1, 2, 3]
        let rhs: Vector<Scalar> = [9, 8, 7]

        var actual: Scalar = 0
        measure {
            actual = distSq(lhs, rhs)
        }

        let expected: Scalar = Swift.zip(lhs, rhs).map({ $0 - $1 }).map({ $0 * $0 }).reduce(0.0, +)

        XCTAssertEqual(actual, expected, accuracy: 1e-6)
    }

    func test_distsq_vector_vector_float() {
        typealias Scalar = Float

        let lhs: Vector<Scalar> = [1, 2, 3, 4]
        let rhs: Vector<Scalar> = [9, 8, 7, 6]

        var actual: Scalar = 0
        measure {
            actual = distSq(lhs, rhs)
        }
        let expected: Scalar = Swift.zip(lhs, rhs).map({ $0 - $1 }).map({ $0 * $0 }).reduce(0.0, +)

        XCTAssertEqual(actual, expected, accuracy: 1e-6)
    }
}
