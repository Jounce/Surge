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

// swiftlint:disable nesting

class ScalarTests: XCTestCase {
    func makeVector() -> Vector<Double> {
        return [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
    }

    func makeVector() -> Vector<Float> {
        return [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
    }

    // MARK: - Multiplication

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

    func test_mul_scalar_matrix_float() {
        typealias Scalar = Float

        let lhs: Scalar = 2

        let rhs: Matrix<Scalar> = [
            [2, 4, 6],
            [10, 12, 14],
        ]

        let actual = lhs * rhs
        let expected: Matrix<Scalar> = [
            [4, 8, 12],
            [20, 24, 28],
        ]

        XCTAssertEqual(actual, expected)
    }

    func test_mul_scalar_matrix_double() {
        typealias Scalar = Double

        let lhs: Scalar = 2

        let rhs: Matrix<Scalar> = [
            [2, 4, 6],
            [10, 12, 14],
        ]

        let actual = lhs * rhs
        let expected: Matrix<Scalar> = [
            [4, 8, 12],
            [20, 24, 28],
        ]

        XCTAssertEqual(actual, expected)
    }
}
