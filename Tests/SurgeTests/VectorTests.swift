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

@testable import Surge
import XCTest

// swiftlint:disable nesting

class VectorTests: XCTestCase {
    func makeVector() -> Vector<Double> {
        return [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
    }

    func makeVector() -> Vector<Float> {
        return [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
    }

    func testInit() {
        let v = Vector([1.0, 2.0])
        XCTAssertEqual(v.scalars, [1.0, 2.0])
    }

    func testSubscript() {
        typealias Scalar = Double

        let vector: Vector<Scalar> = self.makeVector()

        XCTAssertEqual(vector[0], 1)
        XCTAssertEqual(vector[2], 3)
        XCTAssertEqual(vector[9], 10)
    }

    func test_add_vector_vector_double() {
        typealias Scalar = Double

        let vector: Vector<Scalar> = self.makeVector()

        let actual = vector + vector
        let expected: Vector<Scalar> = [2, 4, 6, 8, 10, 12, 14, 16, 18, 20]

        XCTAssertEqual(actual, expected, accuracy: 1e-8)
    }

    func test_add_vector_vector_float() {
        typealias Scalar = Float

        let vector: Vector<Scalar> = self.makeVector()

        let actual = vector + vector
        let expected: Vector<Scalar> = [2, 4, 6, 8, 10, 12, 14, 16, 18, 20]

        XCTAssertEqual(actual, expected, accuracy: 1e-8)
    }

    func test_add_vector_scalar_double() {
        typealias Scalar = Double

        let vector: Vector<Scalar> = self.makeVector()
        let scalar: Scalar = 1.0

        let actual = vector + scalar
        let expected: Vector<Scalar> = [2, 3, 4, 5, 6, 7, 8, 9, 10, 11]

        XCTAssertEqual(actual, expected, accuracy: 1e-8)
    }

    func test_add_vector_scalar_float() {
        typealias Scalar = Float

        let vector: Vector<Scalar> = self.makeVector()
        let scalar: Scalar = 1.0

        let actual = vector + scalar
        let expected: Vector<Scalar> = [2, 3, 4, 5, 6, 7, 8, 9, 10, 11]

        XCTAssertEqual(actual, expected, accuracy: 1e-8)
    }

    func test_add_in_place_vector_vector_double() {
        typealias Scalar = Double

        var vector: Vector<Scalar> = self.makeVector()

        vector += vector

        let actual = vector
        let expected: Vector<Scalar> = [2, 4, 6, 8, 10, 12, 14, 16, 18, 20]

        XCTAssertEqual(actual, expected, accuracy: 1e-8)
    }

    func test_add_in_place_vector_vector_float() {
        typealias Scalar = Float

        var vector: Vector<Scalar> = self.makeVector()

        vector += vector

        let actual = vector
        let expected: Vector<Scalar> = [2, 4, 6, 8, 10, 12, 14, 16, 18, 20]

        XCTAssertEqual(actual, expected, accuracy: 1e-8)
    }

    func test_add_in_place_vector_scalar_double() {
        typealias Scalar = Double

        var vector: Vector<Scalar> = self.makeVector()
        let scalar: Scalar = 1.0

        vector += scalar

        let actual = vector
        let expected: Vector<Scalar> = [2, 3, 4, 5, 6, 7, 8, 9, 10, 11]

        XCTAssertEqual(actual, expected, accuracy: 1e-8)
    }

    func test_add_in_place_vector_scalar_float() {
        typealias Scalar = Float

        var vector: Vector<Scalar> = self.makeVector()
        let scalar: Scalar = 1.0

        vector += scalar

        let actual = vector
        let expected: Vector<Scalar> = [2, 3, 4, 5, 6, 7, 8, 9, 10, 11]

        XCTAssertEqual(actual, expected, accuracy: 1e-8)
    }

    func test_sub_vector_vector_double() {
        typealias Scalar = Double

        let vector: Vector<Scalar> = self.makeVector()

        let actual = vector - vector
        let expected: Vector<Scalar> = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0]

        XCTAssertEqual(actual, expected, accuracy: 1e-8)
    }

    func test_sub_vector_vector_float() {
        typealias Scalar = Float

        let vector: Vector<Scalar> = self.makeVector()

        let actual = vector - vector
        let expected: Vector<Scalar> = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0]

        XCTAssertEqual(actual, expected, accuracy: 1e-8)
    }

    func test_sub_vector_scalar_double() {
        typealias Scalar = Double

        let vector: Vector<Scalar> = self.makeVector()
        let scalar: Scalar = 1.0

        let actual = vector - scalar
        let expected: Vector<Scalar> = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9]

        XCTAssertEqual(actual, expected, accuracy: 1e-8)
    }

    func test_sub_vector_scalar_float() {
        typealias Scalar = Float

        let vector: Vector<Scalar> = self.makeVector()
        let scalar: Scalar = 1.0

        let actual = vector - scalar
        let expected: Vector<Scalar> = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9]

        XCTAssertEqual(actual, expected, accuracy: 1e-8)
    }

    func test_sub_in_place_vector_vector_double() {
        typealias Scalar = Double

        var vector: Vector<Scalar> = self.makeVector()

        vector -= vector

        let actual = vector
        let expected: Vector<Scalar> = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0]

        XCTAssertEqual(actual, expected, accuracy: 1e-8)
    }

    func test_sub_in_place_vector_vector_float() {
        typealias Scalar = Float

        var vector: Vector<Scalar> = self.makeVector()

        vector -= vector

        let actual = vector
        let expected: Vector<Scalar> = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0]

        XCTAssertEqual(actual, expected, accuracy: 1e-8)
    }

    func test_sub_in_place_vector_scalar_double() {
        typealias Scalar = Double

        var vector: Vector<Scalar> = self.makeVector()
        let scalar: Scalar = 1.0

        vector -= scalar

        let actual = vector
        let expected: Vector<Scalar> = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9]

        XCTAssertEqual(actual, expected, accuracy: 1e-8)
    }

    func test_sub_in_place_vector_scalar_float() {
        typealias Scalar = Float

        var vector: Vector<Scalar> = self.makeVector()
        let scalar: Scalar = 1.0

        vector -= scalar

        let actual = vector
        let expected: Vector<Scalar> = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9]

        XCTAssertEqual(actual, expected, accuracy: 1e-8)
    }

    func test_mul_scalar_vector_double() {
        typealias Scalar = Double

        let vector: Vector<Scalar> = self.makeVector()

        let actual = 2 * vector
        let expected: Vector<Scalar> = [2, 4, 6, 8, 10, 12, 14, 16, 18, 20]

        XCTAssertEqual(actual, expected, accuracy: 1e-8)
    }

    func test_mul_scalar_vector_float() {
        typealias Scalar = Float

        let vector: Vector<Scalar> = self.makeVector()
        let scalar: Scalar = 2.0

        let actual = scalar * vector
        let expected: Vector<Scalar> = [2, 4, 6, 8, 10, 12, 14, 16, 18, 20]

        XCTAssertEqual(actual, expected, accuracy: 1e-8)
    }

    func test_mul_vector_scalar_double() {
        typealias Scalar = Double

        let vector: Vector<Scalar> = self.makeVector()
        let scalar: Scalar = 2.0

        let actual = vector * scalar
        let expected: Vector<Scalar> = [2, 4, 6, 8, 10, 12, 14, 16, 18, 20]

        XCTAssertEqual(actual, expected, accuracy: 1e-8)
    }

    func test_mul_vector_scalar_float() {
        typealias Scalar = Float

        let vector: Vector<Scalar> = self.makeVector()
        let scalar: Scalar = 2.0

        let actual = vector * scalar
        let expected: Vector<Scalar> = [2, 4, 6, 8, 10, 12, 14, 16, 18, 20]

        XCTAssertEqual(actual, expected, accuracy: 1e-8)
    }

    func test_mul_in_place_vector_scalar_double() {
        typealias Scalar = Double

        var vector: Vector<Scalar> = self.makeVector()
        let scalar: Scalar = 2.0

        vector *= scalar

        let actual = vector
        let expected: Vector<Scalar> = [2, 4, 6, 8, 10, 12, 14, 16, 18, 20]

        XCTAssertEqual(actual, expected, accuracy: 1e-8)
    }

    func test_mul_in_place_vector_scalar_float() {
        typealias Scalar = Float

        var vector: Vector<Scalar> = self.makeVector()
        let scalar: Scalar = 2.0

        vector *= scalar

        let actual = vector
        let expected: Vector<Scalar> = [2, 4, 6, 8, 10, 12, 14, 16, 18, 20]

        XCTAssertEqual(actual, expected, accuracy: 1e-8)
    }

    func test_div_vector_scalar_double() {
        typealias Scalar = Double

        let vector: Vector<Scalar> = self.makeVector()
        let scalar: Scalar = 0.5

        let actual = vector / scalar
        let expected: Vector<Scalar> = [2, 4, 6, 8, 10, 12, 14, 16, 18, 20]

        XCTAssertEqual(actual, expected, accuracy: 1e-8)
    }

    func test_div_vector_scalar_float() {
        typealias Scalar = Float

        let vector: Vector<Scalar> = self.makeVector()
        let scalar: Scalar = 0.5

        let actual = vector / scalar
        let expected: Vector<Scalar> = [2, 4, 6, 8, 10, 12, 14, 16, 18, 20]

        XCTAssertEqual(actual, expected, accuracy: 1e-5)
    }

    func test_div_in_place_vector_scalar_double() {
        typealias Scalar = Double

        var vector: Vector<Scalar> = self.makeVector()
        let scalar: Scalar = 0.5

        vector /= scalar

        let actual = vector
        let expected: Vector<Scalar> = [2, 4, 6, 8, 10, 12, 14, 16, 18, 20]

        XCTAssertEqual(actual, expected, accuracy: 1e-8)
    }

    func test_div_in_place_vector_scalar_float() {
        typealias Scalar = Float

        var vector: Vector<Scalar> = self.makeVector()
        let scalar: Scalar = 0.5

        vector /= scalar

        let actual = vector
        let expected: Vector<Scalar> = [2, 4, 6, 8, 10, 12, 14, 16, 18, 20]

        XCTAssertEqual(actual, expected, accuracy: 1e-5)
    }

    func test_elmul_double() {
        typealias Scalar = Double

        let vector: Vector<Scalar> = self.makeVector()

        let actual = vector .* vector
        let expected: Vector<Scalar> = [1, 4, 9, 16, 25, 36, 49, 64, 81, 100]

        XCTAssertEqual(actual, expected, accuracy: 1e-8)
    }

    func test_elmul_float() {
        typealias Scalar = Float

        let vector: Vector<Scalar> = self.makeVector()

        let actual = vector .* vector
        let expected: Vector<Scalar> = [1, 4, 9, 16, 25, 36, 49, 64, 81, 100]

        XCTAssertEqual(actual, expected, accuracy: 1e-8)
    }

    func test_elmul_in_place_double() {
        typealias Scalar = Double

        var vector: Vector<Scalar> = self.makeVector()

        vector .*= vector

        let actual = vector
        let expected: Vector<Scalar> = [1, 4, 9, 16, 25, 36, 49, 64, 81, 100]

        XCTAssertEqual(actual, expected, accuracy: 1e-8)
    }

    func test_elmul_in_place_float() {
        typealias Scalar = Float

        var vector: Vector<Scalar> = self.makeVector()

        vector .*= vector

        let actual = vector
        let expected: Vector<Scalar> = [1, 4, 9, 16, 25, 36, 49, 64, 81, 100]

        XCTAssertEqual(actual, expected, accuracy: 1e-8)
    }

    func test_eldiv_double() {
        typealias Scalar = Double

        let vector: Vector<Scalar> = self.makeVector()

        let actual = vector ./ vector
        let expected: Vector<Scalar> = [1, 1, 1, 1, 1, 1, 1, 1, 1, 1]

        XCTAssertEqual(actual, expected, accuracy: 1e-8)
    }

    func test_eldiv_float() {
        typealias Scalar = Float

        let vector: Vector<Scalar> = self.makeVector()

        let actual = vector ./ vector
        let expected: Vector<Scalar> = [1, 1, 1, 1, 1, 1, 1, 1, 1, 1]

        XCTAssertEqual(actual, expected, accuracy: 1e-6)
    }

    func test_eldiv_in_place_double() {
        typealias Scalar = Double

        var vector: Vector<Scalar> = self.makeVector()

        vector ./= vector

        let actual = vector
        let expected: Vector<Scalar> = [1, 1, 1, 1, 1, 1, 1, 1, 1, 1]

        XCTAssertEqual(actual, expected, accuracy: 1e-8)
    }

    func test_eldiv_in_place_float() {
        typealias Scalar = Float

        var vector: Vector<Scalar> = self.makeVector()

        vector ./= vector

        let actual = vector
        let expected: Vector<Scalar> = [1, 1, 1, 1, 1, 1, 1, 1, 1, 1]

        XCTAssertEqual(actual, expected, accuracy: 1e-6)
    }

    func test_pow_vector_scalar_double() {
        typealias Scalar = Double

        let vector: Vector<Scalar> = self.makeVector()

        let actual = pow(vector, 2)
        let expected: Vector<Scalar> = [1, 4, 9, 16, 25, 36, 49, 64, 81, 100]

        XCTAssertEqual(actual, expected, accuracy: 1e-8)
    }

    func test_pow_vector_scalar_float() {
        typealias Scalar = Float

        let vector: Vector<Scalar> = self.makeVector()

        let actual = pow(vector, 2)
        let expected: Vector<Scalar> = [1, 4, 9, 16, 25, 36, 49, 64, 81, 100]

        XCTAssertEqual(actual, expected, accuracy: 1e-5)
    }

    func test_exp_vector_double() {
        typealias Scalar = Double

        let vector: Vector<Scalar> = self.makeVector()

        let actual = exp(vector)
        let expected: Vector<Scalar> = [
            2.718_282, 7.389_056, 20.085_537, 54.598_150, 148.413_159,
            403.428_793, 1_096.633_158, 2_980.957_987, 8_103.083_928, 22_026.465_795
        ]

        XCTAssertEqual(actual, expected, accuracy: 1e-6)
    }

    func test_exp_vector_float() {
        typealias Scalar = Float

        let vector: Vector<Scalar> = self.makeVector()

        let actual = exp(vector)
        let expected: Vector<Scalar> = [
            2.718_282, 7.389_056, 20.085_537, 54.598_150, 148.413_159,
            403.428_793, 1_096.633_158, 2_980.957_987, 8_103.083_928, 22_026.465_795
        ]

        XCTAssertEqual(actual, expected, accuracy: 1e-2)
    }

    func test_dist_vector_vector_double() {
        typealias Scalar = Double

        let lhs: Vector<Scalar> = [1, 2, 3]
        let rhs: Vector<Scalar> = [9, 8, 7]

        let actual = dist(lhs, rhs)
        let expected: Scalar = sqrt(Swift.zip(lhs, rhs).map({ $0 - $1 }).map({ $0 * $0 }).reduce(0.0, +))

        XCTAssertEqual(actual, expected, accuracy: 1e-6)
    }

    func test_dist_vector_vector_float() {
        typealias Scalar = Float

        let lhs: Vector<Scalar> = [1, 2, 3, 4]
        let rhs: Vector<Scalar> = [9, 8, 7, 6]

        let actual = dist(lhs, rhs)
        let expected: Scalar = sqrt(Swift.zip(lhs, rhs).map({ $0 - $1 }).map({ $0 * $0 }).reduce(0.0, +))

        XCTAssertEqual(actual, expected, accuracy: 1e-6)
    }

    func test_distsq_vector_vector_double() {
        typealias Scalar = Double

        let lhs: Vector<Scalar> = [1, 2, 3]
        let rhs: Vector<Scalar> = [9, 8, 7]

        let actual = distSq(lhs, rhs)

        let expected: Scalar = Swift.zip(lhs, rhs).map({ $0 - $1 }).map({ $0 * $0 }).reduce(0.0, +)

        XCTAssertEqual(actual, expected, accuracy: 1e-6)
    }

    func test_distsq_vector_vector_float() {
        typealias Scalar = Float

        let lhs: Vector<Scalar> = [1, 2, 3, 4]
        let rhs: Vector<Scalar> = [9, 8, 7, 6]

        let actual = distSq(lhs, rhs)
        let expected: Scalar = Swift.zip(lhs, rhs).map({ $0 - $1 }).map({ $0 * $0 }).reduce(0.0, +)

        XCTAssertEqual(actual, expected, accuracy: 1e-6)
    }
}
