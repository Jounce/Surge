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

// swiftlint:disable nesting type_body_length

class ArithmeticTests: XCTestCase {
    static let n = 1_000

    func monotonic<Scalar>(count: Int = ArithmeticTests.n) -> [Scalar] where Scalar: FloatingPoint {
        return (1...count).map { Scalar($0) }
    }

    func monotonicNormalized<Scalar>(count: Int = ArithmeticTests.n) -> [Scalar] where Scalar: FloatingPoint {
        let scalarCount = Scalar(count)
        return (1...count).map { Scalar($0) / scalarCount }
    }

    func constant<Scalar>(_ value: Scalar, count: Int = ArithmeticTests.n) -> [Scalar] where Scalar: FloatingPoint {
        return Array(repeating: value, count: count)
    }

    // MARK: - Addition: In Place

    func test_add_in_place_array_array_float() {
        typealias Scalar = Float

        let lhs: [Scalar] = monotonicNormalized()
        let rhs: [Scalar] = monotonicNormalized()

        var actual: [Scalar] = lhs
        Surge.addInPlace(&actual, rhs)

        let expected = Swift.zip(lhs, rhs).map { $0 + $1 }

        XCTAssertEqual(actual, expected, accuracy: 1e-8)
    }

    func test_add_in_place_array_array_double() {
        typealias Scalar = Double

        let lhs: [Scalar] = monotonicNormalized()
        let rhs: [Scalar] = monotonicNormalized()

        var actual: [Scalar] = lhs
        Surge.addInPlace(&actual, rhs)

        let expected = Swift.zip(lhs, rhs).map { $0 + $1 }

        XCTAssertEqual(actual, expected, accuracy: 1e-8)
    }

    // MARK: - Subtraction: In Place

    func test_sub_in_place_array_array_float() {
        typealias Scalar = Float

        let lhs: [Scalar] = monotonicNormalized()
        let rhs: [Scalar] = monotonicNormalized()

        var actual: [Scalar] = lhs
        Surge.subInPlace(&actual, rhs)

        let expected = Swift.zip(lhs, rhs).map { $0 - $1 }

        XCTAssertEqual(actual, expected, accuracy: 1e-8)
    }

    func test_sub_in_place_array_array_double() {
        typealias Scalar = Double

        let lhs: [Scalar] = monotonicNormalized()
        let rhs: [Scalar] = monotonicNormalized()

        var actual: [Scalar] = lhs
        Surge.subInPlace(&actual, rhs)

        let expected = Swift.zip(lhs, rhs).map { $0 - $1 }

        XCTAssertEqual(actual, expected, accuracy: 1e-8)
    }

    // MARK: - Multiplication: In Place

    func test_mul_in_place_array_array_float() {
        typealias Scalar = Float

        let lhs: [Scalar] = monotonicNormalized()
        let rhs: [Scalar] = monotonicNormalized()

        var actual: [Scalar] = lhs
        Surge.mulInPlace(&actual, rhs)

        let expected = Swift.zip(lhs, rhs).map { $0 * $1 }

        XCTAssertEqual(actual, expected, accuracy: 1e-8)
    }

    func test_mul_in_place_array_array_double() {
        typealias Scalar = Double

        let lhs: [Scalar] = monotonicNormalized()
        let rhs: [Scalar] = monotonicNormalized()

        var actual: [Scalar] = lhs
        Surge.mulInPlace(&actual, rhs)

        let expected = Swift.zip(lhs, rhs).map { $0 * $1 }

        XCTAssertEqual(actual, expected, accuracy: 1e-8)
    }

    // MARK: - Division: In Place

    func test_div_in_place_array_array_float() {
        typealias Scalar = Float

        let lhs: [Scalar] = monotonicNormalized()
        let rhs: [Scalar] = monotonicNormalized()

        var actual: [Scalar] = lhs
        Surge.divInPlace(&actual, rhs)

        let expected = Swift.zip(lhs, rhs).map { $0 / $1 }

        XCTAssertEqual(actual, expected, accuracy: 1e-6)
    }

    func test_div_in_place_array_array_double() {
        typealias Scalar = Double

        let lhs: [Scalar] = monotonicNormalized()
        let rhs: [Scalar] = monotonicNormalized()

        var actual: [Scalar] = lhs
        Surge.divInPlace(&actual, rhs)

        let expected = Swift.zip(lhs, rhs).map { $0 / $1 }

        XCTAssertEqual(actual, expected, accuracy: 1e-8)
    }

    // MARK: - Modulo: In Place

    func test_mod_in_place_array_array_float() {
        typealias Scalar = Float

        let lhs: [Scalar] = monotonicNormalized()
        let rhs: [Scalar] = constant(2.0)

        var actual: [Scalar] = lhs
        Surge.modInPlace(&actual, rhs)

        let expected = Swift.zip(lhs, rhs).map { fmod($0, $1) }

        XCTAssertEqual(actual, expected, accuracy: 1e-8)
    }

    func test_mod_in_place_array_array_double() {
        typealias Scalar = Double

        let lhs: [Scalar] = monotonicNormalized()
        let rhs: [Scalar] = constant(2.0)

        var actual: [Scalar] = lhs
        Surge.modInPlace(&actual, rhs)

        let expected = Swift.zip(lhs, rhs).map { fmod($0, $1) }

        XCTAssertEqual(actual, expected, accuracy: 1e-8)
    }

    // MARK: - Remainder: In Place

    func test_remainder_in_place_array_array_float() {
        typealias Scalar = Float

        let lhs: [Scalar] = monotonicNormalized()
        let rhs: [Scalar] = constant(-2.0)

        var actual: [Scalar] = lhs
        Surge.remainderInPlace(&actual, rhs)

        let expected = Swift.zip(lhs, rhs).map { remainder($0, $1) }

        XCTAssertEqual(actual, expected, accuracy: 1e-8)
    }

    func test_remainder_in_place_array_array_double() {
        typealias Scalar = Double

        let lhs: [Scalar] = monotonicNormalized()
        let rhs: [Scalar] = constant(-2.0)

        var actual: [Scalar] = lhs
        Surge.remainderInPlace(&actual, rhs)

        let expected = Swift.zip(lhs, rhs).map { remainder($0, $1) }

        XCTAssertEqual(actual, expected, accuracy: 1e-8)
    }

    // MARK: - Exponential: In Place

    func test_exp_in_place_array_float() {
        typealias Scalar = Float

        let lhs: [Scalar] = monotonicNormalized()

        var actual: [Scalar] = lhs
        Surge.expInPlace(&actual)

        let expected = lhs.map { exp($0) }

        XCTAssertEqual(actual, expected, accuracy: 1e-6)
    }

    func test_exp_in_place_array_double() {
        typealias Scalar = Double

        let lhs: [Scalar] = monotonicNormalized()

        var actual: [Scalar] = lhs
        Surge.expInPlace(&actual)

        let expected = lhs.map { exp($0) }

        XCTAssertEqual(actual, expected, accuracy: 1e-8)
    }

    // MARK: - Square Exponential: In Place

    func test_exp2_in_place_array_float() {
        typealias Scalar = Float

        let lhs: [Scalar] = monotonicNormalized()

        var actual: [Scalar] = lhs
        Surge.exp2InPlace(&actual)

        let expected = lhs.map { exp2($0) }

        XCTAssertEqual(actual, expected, accuracy: 1e-6)
    }

    func test_exp2_in_place_array_double() {
        typealias Scalar = Double

        let lhs: [Scalar] = monotonicNormalized()

        var actual: [Scalar] = lhs
        Surge.exp2InPlace(&actual)

        let expected = lhs.map { exp2($0) }

        XCTAssertEqual(actual, expected, accuracy: 1e-8)
    }

    // MARK: - Power: In Place

    func test_pow_in_place_array_array_float() {
        typealias Scalar = Float

        let lhs: [Scalar] = monotonicNormalized()
        let rhs: [Scalar] = constant(2.0)

        var actual: [Scalar] = lhs
        Surge.powInPlace(&actual, rhs)

        let expected = Swift.zip(lhs, rhs).map { pow($0, $1) }

        XCTAssertEqual(actual, expected, accuracy: 1e-5)
    }

    func test_pow_in_place_array_array_double() {
        typealias Scalar = Double

        let lhs: [Scalar] = monotonicNormalized()
        let rhs: [Scalar] = constant(2.0)

        var actual: [Scalar] = lhs
        Surge.powInPlace(&actual, rhs)

        let expected = Swift.zip(lhs, rhs).map { pow($0, $1) }

        XCTAssertEqual(actual, expected, accuracy: 1e-8)
    }

    func test_pow_in_place_array_scalar_float() {
        typealias Scalar = Float

        let lhs: [Scalar] = monotonicNormalized()
        let rhs: Scalar = 2.0

        var actual: [Scalar] = lhs
        Surge.powInPlace(&actual, rhs)

        let expected = lhs.map { pow($0, rhs) }

        XCTAssertEqual(actual, expected, accuracy: 1e-5)
    }

    func test_pow_in_place_array_scalar_double() {
        typealias Scalar = Double

        let lhs: [Scalar] = monotonicNormalized()
        let rhs: Scalar = 2.0

        var actual: [Scalar] = lhs
        Surge.powInPlace(&actual, rhs)

        let expected = lhs.map { pow($0, rhs) }

        XCTAssertEqual(actual, expected, accuracy: 1e-8)
    }

    // MARK: - Square: In Place

    func test_sq_in_place_array_float() {
        typealias Scalar = Float

        let lhs: [Scalar] = monotonicNormalized()

        var actual: [Scalar] = lhs
        Surge.sqInPlace(&actual)

        let expected = lhs.map { pow($0, 2.0) }

        XCTAssertEqual(actual, expected, accuracy: 1e-5)
    }

    func test_sq_in_place_array_double() {
        typealias Scalar = Double

        let lhs: [Scalar] = monotonicNormalized()

        var actual: [Scalar] = lhs
        Surge.sqInPlace(&actual)

        let expected = lhs.map { pow($0, 2.0) }

        XCTAssertEqual(actual, expected, accuracy: 1e-8)
    }

    // MARK: - Square Root: In Place

    func test_sqrt_in_place_array_array_float() {
        typealias Scalar = Float

        let lhs: [Scalar] = monotonicNormalized()

        var actual: [Scalar] = lhs
        Surge.sqrtInPlace(&actual)

        let expected = lhs.map { sqrt($0) }

        XCTAssertEqual(actual, expected, accuracy: 1e-8)
    }

    func test_sqrt_in_place_array_array_double() {
        typealias Scalar = Double

        let lhs: [Scalar] = monotonicNormalized()

        var actual: [Scalar] = lhs
        Surge.sqrtInPlace(&actual)

        let expected = lhs.map { sqrt($0) }

        XCTAssertEqual(actual, expected, accuracy: 1e-8)
    }

    // MARK: - Dot Product

    func test_dot_array_array_float() {
        typealias Scalar = Float

        let lhs: [Scalar] = monotonicNormalized()
        let rhs: [Scalar] = monotonicNormalized()

        let actual: Scalar = Surge.dot(lhs, rhs)

        let expected = Swift.zip(lhs, rhs).reduce(0) { $0 + ($1.0 * $1.1) }

        XCTAssertEqual(actual, expected, accuracy: 1e-1)
    }

    func test_dot_array_array_double() {
        typealias Scalar = Double

        let lhs: [Scalar] = monotonicNormalized()
        let rhs: [Scalar] = monotonicNormalized()

        let actual: Scalar = Surge.dot(lhs, rhs)

        let expected = Swift.zip(lhs, rhs).reduce(0) { $0 + ($1.0 * $1.1) }

        XCTAssertEqual(actual, expected, accuracy: 1e-8)
    }

    // MARK: - Summation

    func test_sum_array_float() {
        typealias Scalar = Float

        let lhs: [Scalar] = monotonicNormalized()

        let actual: Scalar = Surge.sum(lhs)

        let expected: Scalar = lhs.reduce(0, +)

        XCTAssertEqual(actual, expected, accuracy: 1e-1)
    }

    func test_sum_array_double() {
        typealias Scalar = Double

        let lhs: [Scalar] = monotonicNormalized()

        let actual: Scalar = Surge.sum(lhs)

        let expected: Scalar = lhs.reduce(0, +)

        XCTAssertEqual(actual, expected, accuracy: 1e-8)
    }

    // MARK: - Distance

    func test_dist_array_array_float() {
        typealias Scalar = Float

        let lhs: [Scalar] = monotonicNormalized()
        let rhs: [Scalar] = monotonicNormalized()

        let actual: Scalar = Surge.dist(lhs, rhs)

        let expected: Scalar = sqrt(Swift.zip(lhs, rhs).map({ $0 - $1 }).map({ $0 * $0 }).reduce(0.0, +))

        XCTAssertEqual(actual, expected, accuracy: 1e-6)
    }

    func test_dist_array_array_double() {
        typealias Scalar = Double

        let lhs: [Scalar] = monotonicNormalized()
        let rhs: [Scalar] = monotonicNormalized()

        let actual: Scalar = Surge.dist(lhs, rhs)

        let expected: Scalar = sqrt(Swift.zip(lhs, rhs).map({ $0 - $1 }).map({ $0 * $0 }).reduce(0.0, +))

        XCTAssertEqual(actual, expected, accuracy: 1e-6)
    }

    // MARK: - Distance Squared

    func test_distsq_array_array_float() {
        typealias Scalar = Float

        let lhs: [Scalar] = monotonicNormalized()
        let rhs: [Scalar] = monotonicNormalized()

        let actual: Scalar = Surge.distSq(lhs, rhs)

        let partialDistances: [Scalar] = Swift.zip(lhs, rhs).map { $0 - $1 }
        let partialDistancesSquared: [Scalar] = partialDistances.map { $0 * $0 }
        let expected: Scalar = partialDistancesSquared.reduce(0.0, +)

        XCTAssertEqual(actual, expected, accuracy: 1e-6)
    }

    func test_distsq_array_array_double() {
        typealias Scalar = Double

        let lhs: [Scalar] = monotonicNormalized()
        let rhs: [Scalar] = monotonicNormalized()

        let actual: Scalar = Surge.distSq(lhs, rhs)

        let partialDistances: [Scalar] = Swift.zip(lhs, rhs).map { $0 - $1 }
        let partialDistancesSquared: [Scalar] = partialDistances.map { $0 * $0 }
        let expected: Scalar = partialDistancesSquared.reduce(0.0, +)

        XCTAssertEqual(actual, expected, accuracy: 1e-6)
    }
}
