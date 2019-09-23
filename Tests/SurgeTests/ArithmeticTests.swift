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
import Surge
import XCTest

// swiftlint:disable nesting type_body_length

class ArithmeticTests: XCTestCase {
    let n = 100_000

    // MARK: - Addition

    func test_add_array_array_float() {
        typealias Scalar = Float

        let lhs: [Scalar] = (1...n).map { Scalar($0) / Scalar(n) }
        let rhs: [Scalar] = (1...n).map { Scalar($0) / Scalar(n) }

        var actual: [Scalar] = []
        measure {
            actual = lhs .+ rhs
        }

        let expected = Swift.zip(lhs, rhs).map { $0 + $1 }

        XCTAssertEqual(actual, expected, accuracy: 1e-8)
    }

    func test_add_array_array_double() {
        typealias Scalar = Double

        let lhs: [Scalar] = (1...n).map { Scalar($0) / Scalar(n) }
        let rhs: [Scalar] = (1...n).map { Scalar($0) / Scalar(n) }

        var actual: [Scalar] = []
        measure {
            actual = lhs .+ rhs
        }

        let expected = Swift.zip(lhs, rhs).map { $0 + $1 }

        XCTAssertEqual(actual, expected, accuracy: 1e-8)
    }

    // MARK: - Addition: In Place

    // FIXME: missing tests

    // MARK: - Subtraction

    func test_sub_array_array_float() {
        typealias Scalar = Float

        let lhs: [Scalar] = (1...n).map { Scalar($0) / Scalar(n) }
        let rhs: [Scalar] = (1...n).map { Scalar($0) / Scalar(n) }

        var actual: [Scalar] = []
        measure {
            actual = lhs .- rhs
        }

        let expected = Swift.zip(lhs, rhs).map { $0 - $1 }

        XCTAssertEqual(actual, expected, accuracy: 1e-8)
    }

    func test_sub_array_array_double() {
        typealias Scalar = Double

        let lhs: [Scalar] = (1...n).map { Scalar($0) / Scalar(n) }
        let rhs: [Scalar] = (1...n).map { Scalar($0) / Scalar(n) }

        var actual: [Scalar] = []
        measure {
            actual = lhs .- rhs
        }

        let expected = Swift.zip(lhs, rhs).map { $0 - $1 }

        XCTAssertEqual(actual, expected, accuracy: 1e-8)
    }

    // MARK: - Subtraction: In Place

    // FIXME: missing tests

    // MARK: - Multiplication

    func test_mul_array_array_float() {
        typealias Scalar = Float

        let lhs: [Scalar] = (1...n).map { Scalar($0) / Scalar(n) }
        let rhs: [Scalar] = (1...n).map { Scalar($0) / Scalar(n) }

        var actual: [Scalar] = []
        measure {
            actual = lhs .* rhs
        }

        let expected = Swift.zip(lhs, rhs).map { $0 * $1 }

        XCTAssertEqual(actual, expected, accuracy: 1e-8)
    }

    func test_mul_array_array_double() {
        typealias Scalar = Double

        let lhs: [Scalar] = (1...n).map { Scalar($0) / Scalar(n) }
        let rhs: [Scalar] = (1...n).map { Scalar($0) / Scalar(n) }

        var actual: [Scalar] = []
        measure {
            actual = lhs .* rhs
        }

        let expected = Swift.zip(lhs, rhs).map { $0 * $1 }

        XCTAssertEqual(actual, expected, accuracy: 1e-8)
    }

    // MARK: - Multiplication: In Place

    // FIXME: missing tests

    // MARK: - Division

    func test_div_array_array_float() {
        typealias Scalar = Float

        let lhs: [Scalar] = (1...n).map { Scalar($0) / Scalar(n) }
        let rhs: [Scalar] = (1...n).map { Scalar($0) / Scalar(n) }

        var actual: [Scalar] = []
        measure {
            actual = lhs ./ rhs
        }

        let expected = Swift.zip(lhs, rhs).map { $0 / $1 }

        XCTAssertEqual(actual, expected, accuracy: 1e-6)
    }

    func test_div_array_array_double() {
        typealias Scalar = Double

        let lhs: [Scalar] = (1...n).map { Scalar($0) / Scalar(n) }
        let rhs: [Scalar] = (1...n).map { Scalar($0) / Scalar(n) }

        var actual: [Scalar] = []
        measure {
            actual = lhs ./ rhs
        }

        let expected = Swift.zip(lhs, rhs).map { $0 / $1 }

        XCTAssertEqual(actual, expected, accuracy: 1e-8)
    }

    // MARK: - Division: In Place

    // FIXME: missing tests

    // MARK: - Modulo

    func test_mod_array_array_float() {
        typealias Scalar = Float

        let lhs: [Scalar] = (1...n).map { Scalar($0) }
        let rhs: [Scalar] = Array(repeating: 42, count: n)

        var actual: [Scalar] = []
        measure {
            actual = lhs .% rhs
        }

        let expected = Swift.zip(lhs, rhs).map { fmod($0, $1) }

        XCTAssertEqual(actual, expected, accuracy: 1e-8)
    }

    func test_mod_array_array_double() {
        typealias Scalar = Double

        let lhs: [Scalar] = (1...n).map { Scalar($0) }
        let rhs: [Scalar] = Array(repeating: 42, count: n)

        var actual: [Scalar] = []
        measure {
            actual = lhs .% rhs
        }

        let expected = Swift.zip(lhs, rhs).map { fmod($0, $1) }

        XCTAssertEqual(actual, expected, accuracy: 1e-8)
    }

    // MARK: - Remainder

    func test_remainder_array_array_float() {
        typealias Scalar = Float

        let lhs: [Scalar] = (1...n).map { Scalar($0) }
        let rhs: [Scalar] = Array(repeating: -42, count: n)

        var actual: [Scalar] = []
        measure {
            actual = Surge.remainder(lhs, rhs)
        }

        let expected = Swift.zip(lhs, rhs).map { remainder($0, $1) }

        XCTAssertEqual(actual, expected, accuracy: 1e-8)
    }

    func test_remainder_array_array_double() {
        typealias Scalar = Double

        let lhs: [Scalar] = (1...n).map { Scalar($0) }
        let rhs: [Scalar] = Array(repeating: -42, count: n)

        var actual: [Scalar] = []
        measure {
            actual = Surge.remainder(lhs, rhs)
        }

        let expected = Swift.zip(lhs, rhs).map { remainder($0, $1) }

        XCTAssertEqual(actual, expected, accuracy: 1e-8)
    }

    // MARK: - Exponential

    func test_exp_array_float() {
        typealias Scalar = Float

        let values: [Scalar] = (1...n).map { Scalar($0) / Scalar(n) }

        var actual: [Scalar] = []
        measure {
            actual = Surge.exp(values)
        }

        let expected = values.map { exp($0) }

        XCTAssertEqual(actual, expected, accuracy: 1e-6)
    }

    func test_exp_array_double() {
        typealias Scalar = Double

        let values: [Scalar] = (1...n).map { Scalar($0) / Scalar(n) }

        var actual: [Scalar] = []
        measure {
            actual = Surge.exp(values)
        }

        let expected = values.map { exp($0) }

        XCTAssertEqual(actual, expected, accuracy: 1e-8)
    }

    // MARK: - Square Exponentiation

    func test_exp2_array_float() {
        typealias Scalar = Float

        let values: [Scalar] = (1...n).map { Scalar($0) / Scalar(n) }

        var actual: [Scalar] = []
        measure {
            actual = Surge.exp2(values)
        }

        let expected = values.map { exp2($0) }

        XCTAssertEqual(actual, expected, accuracy: 1e-6)
    }

    func test_exp2_array_double() {
        typealias Scalar = Double

        let values: [Scalar] = (1...n).map { Scalar($0) / Scalar(n) }

        var actual: [Scalar] = []
        measure {
            actual = Surge.exp2(values)
        }

        let expected = values.map { exp2($0) }

        XCTAssertEqual(actual, expected, accuracy: 1e-8)
    }

    // MARK: - Power

    func test_pow_array_array_float() {
        typealias Scalar = Float

        let lhs: [Scalar] = (1...n).map { Scalar($0) / Scalar(n) }
        let rhs: [Scalar] = Array(repeating: 2.0, count: n)

        var actual: [Scalar] = []
        measure {
            actual = Surge.pow(lhs, rhs)
        }

        let expected = Swift.zip(lhs, rhs).map { pow($0, $1) }

        XCTAssertEqual(actual, expected, accuracy: 1e-5)
    }

    func test_pow_array_array_double() {
        typealias Scalar = Double

        let lhs: [Scalar] = (1...n).map { Scalar($0) / Scalar(n) }
        let rhs: [Scalar] = Array(repeating: 2.0, count: n)

        var actual: [Scalar] = []
        measure {
            actual = Surge.pow(lhs, rhs)
        }

        let expected = Swift.zip(lhs, rhs).map { pow($0, $1) }

        XCTAssertEqual(actual, expected, accuracy: 1e-8)
    }

    func test_pow_array_scalar_float() {
        typealias Scalar = Float

        let lhs: [Scalar] = (1...n).map { Scalar($0) / Scalar(n) }
        let rhs: Scalar = 2.0

        var actual: [Scalar] = []
        measure {
            actual = Surge.pow(lhs, rhs)
        }

        let expected = lhs.map { pow($0, rhs) }

        XCTAssertEqual(actual, expected, accuracy: 1e-5)
    }

    func test_pow_array_scalar_double() {
        typealias Scalar = Double

        let lhs: [Scalar] = (1...n).map { Scalar($0) / Scalar(n) }
        let rhs: Scalar = 2.0

        var actual: [Scalar] = []
        measure {
            actual = Surge.pow(lhs, rhs)
        }

        let expected = lhs.map { pow($0, rhs) }

        XCTAssertEqual(actual, expected, accuracy: 1e-8)
    }

    // MARK: - Square Root

    func test_sqrt_array_array_float() {
        typealias Scalar = Float

        let lhs: [Scalar] = (1...n).map { Scalar($0) }

        var actual: [Scalar] = []
        measure {
            actual = Surge.sqrt(lhs)
        }

        let expected = lhs.map { sqrt($0) }

        XCTAssertEqual(actual, expected, accuracy: 1e-8)
    }

    func test_sqrt_array_array_double() {
        typealias Scalar = Double

        let lhs: [Scalar] = (1...n).map { Scalar($0) }

        var actual: [Scalar] = []
        measure {
            actual = Surge.sqrt(lhs)
        }

        let expected = lhs.map { sqrt($0) }

        XCTAssertEqual(actual, expected, accuracy: 1e-8)
    }

    // MARK: - Dot Product

    func test_dot_array_array_float() {
        typealias Scalar = Float

        let lhs: [Scalar] = (1...n).map { Scalar($0) / Scalar(n) }
        let rhs: [Scalar] = (1...n).map { Scalar($0) / Scalar(n) }

        var actual: Scalar = 0
        measure {
            actual = lhs • rhs
        }

        let expected = Swift.zip(lhs, rhs).reduce(0) {
            $0 + $1.0 * $1.1
        }

        XCTAssertEqual(actual, expected, accuracy: 1e-1)
    }

    func test_dot_array_array_double() {
        typealias Scalar = Double

        let lhs: [Scalar] = (1...n).map { Scalar($0) / Scalar(n) }
        let rhs: [Scalar] = (1...n).map { Scalar($0) / Scalar(n) }

        var actual: Scalar = 0
        measure {
            actual = lhs • rhs
        }

        let expected = Swift.zip(lhs, rhs).reduce(0) {
            $0 + $1.0 * $1.1
        }

        XCTAssertEqual(actual, expected, accuracy: 1e-8)
    }

    // MARK: - Summation

    func test_sum_array_double() {
        typealias Scalar = Double

        let values: [Scalar] = (1...n).map { Scalar($0) / Scalar(n) }

        var actual: Scalar = 0.0
        measure {
            actual = sum(values)
        }

        let expected: Scalar = values.reduce(0, +)

        XCTAssertEqual(actual, expected, accuracy: 1e-8)
    }

    func test_sum_array_float() {
        typealias Scalar = Float

        let values: [Scalar] = (1...n).map { Scalar($0) / Scalar(n) }

        var actual: Scalar = 0.0
        measure {
            actual = sum(values)
        }

        let expected: Scalar = values.reduce(0, +)

        XCTAssertEqual(actual, expected, accuracy: 1e-1)
    }

    // MARK: - Distance

    func test_dist_array_array_double() {
        typealias Scalar = Double

        let lhs: [Scalar] = (1...n).map { Scalar($0) / Scalar(n) }
        let rhs: [Scalar] = (1...n).map { Scalar($0) / Scalar(n) }

        var actual: Scalar = 0.0
        measure {
            actual = dist(lhs, rhs)
        }

        let expected: Scalar = sqrt(Swift.zip(lhs, rhs).map({ $0 - $1 }).map({ $0 * $0 }).reduce(0.0, +))

        XCTAssertEqual(actual, expected, accuracy: 1e-6)
    }

    func test_dist_array_array_float() {
        typealias Scalar = Float

        let lhs: [Scalar] = (1...n).map { Scalar($0) / Scalar(n) }
        let rhs: [Scalar] = (1...n).map { Scalar($0) / Scalar(n) }

        var actual: Scalar = 0.0
        measure {
            actual = dist(lhs, rhs)
        }

        let expected: Scalar = sqrt(Swift.zip(lhs, rhs).map({ $0 - $1 }).map({ $0 * $0 }).reduce(0.0, +))

        XCTAssertEqual(actual, expected, accuracy: 1e-6)
    }

    // MARK: - Distance Squared

    func test_distsq_array_array_double() {
        typealias Scalar = Double

        let lhs: [Scalar] = (1...n).map { Scalar($0) / Scalar(n) }
        let rhs: [Scalar] = (1...n).map { Scalar($0) / Scalar(n) }

        var actual: Scalar = 0.0
        measure {
            actual = distSq(lhs, rhs)
        }

        let expected: Scalar = Swift.zip(lhs, rhs).map({ $0 - $1 }).map({ $0 * $0 }).reduce(0.0, +)

        XCTAssertEqual(actual, expected, accuracy: 1e-6)
    }

    func test_distsq_array_array_float() {
        typealias Scalar = Float

        let lhs: [Scalar] = (1...n).map { Scalar($0) / Scalar(n) }
        let rhs: [Scalar] = (1...n).map { Scalar($0) / Scalar(n) }

        var actual: Scalar = 0.0
        measure {
            actual = distSq(lhs, rhs)
        }

        let expected: Scalar = Swift.zip(lhs, rhs).map({ $0 - $1 }).map({ $0 * $0 }).reduce(0.0, +)

        XCTAssertEqual(actual, expected, accuracy: 1e-6)
    }
}
