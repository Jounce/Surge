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

    func test_add_array_array_float() {
        typealias Scalar = Float

        let lhs: [Scalar] = (0..<n).map { Scalar($0) }
        let rhs: [Scalar] = (0..<n).map { Scalar($0 * 3) }

        var actual: [Scalar] = []
        measure {
            actual = lhs .+ rhs
        }

        let expected = Swift.zip(lhs, rhs).map { $0 + $1 }

        XCTAssertEqual(actual, expected, accuracy: 1e-8)
    }

    func test_add_array_array_double() {
        typealias Scalar = Double

        let lhs: [Scalar] = (0..<n).map { Scalar($0) }
        let rhs: [Scalar] = (0..<n).map { Scalar($0 * 3) }

        var actual: [Scalar] = []
        measure {
            actual = lhs .+ rhs
        }

        let expected = Swift.zip(lhs, rhs).map { $0 + $1 }

        XCTAssertEqual(actual, expected, accuracy: 1e-8)
    }

    func test_sub_array_array_float() {
        typealias Scalar = Float

        let lhs: [Scalar] = (0..<n).map { Scalar($0) }
        let rhs: [Scalar] = (0..<n).map { Scalar($0 * 3) }

        var actual: [Scalar] = []
        measure {
            actual = lhs .- rhs
        }

        let expected = Swift.zip(lhs, rhs).map { $0 - $1 }

        XCTAssertEqual(actual, expected, accuracy: 1e-8)
    }

    func test_sub_array_array_double() {
        typealias Scalar = Double

        let lhs: [Scalar] = (0..<n).map { Scalar($0) }
        let rhs: [Scalar] = (0..<n).map { Scalar($0 * 3) }

        var actual: [Scalar] = []
        measure {
            actual = lhs .- rhs
        }

        let expected = Swift.zip(lhs, rhs).map { $0 - $1 }

        XCTAssertEqual(actual, expected, accuracy: 1e-8)
    }

    func test_mul_array_array_float() {
        typealias Scalar = Float

        let lhs: [Scalar] = (0..<n).map { Scalar($0) }
        let rhs: [Scalar] = (0..<n).map { Scalar($0 / 1_000) }

        var actual: [Scalar] = []
        measure {
            actual = lhs .* rhs
        }

        let expected = Swift.zip(lhs, rhs).map { $0 * $1 }

        XCTAssertEqual(actual, expected, accuracy: 1e-8)
    }

    func test_mul_array_array_double() {
        typealias Scalar = Double

        let lhs: [Scalar] = (0..<n).map { Scalar($0) }
        let rhs: [Scalar] = (0..<n).map { Scalar($0 / 1_000) }

        var actual: [Scalar] = []
        measure {
            actual = lhs .* rhs
        }

        let expected = Swift.zip(lhs, rhs).map { $0 * $1 }

        XCTAssertEqual(actual, expected, accuracy: 1e-8)
    }

    func test_div_array_array_float() {
        typealias Scalar = Float

        let lhs: [Scalar] = (0..<n).map { Scalar($0) }
        let rhs: [Scalar] = (0..<n).map { Scalar($0 + 1) }

        var actual: [Scalar] = []
        measure {
            actual = lhs ./ rhs
        }

        let expected = Swift.zip(lhs, rhs).map { $0 / $1 }

        XCTAssertEqual(actual, expected, accuracy: 1e-6)
    }

    func test_div_array_array_double() {
        typealias Scalar = Double

        let lhs: [Scalar] = (0..<n).map { Scalar($0) }
        let rhs: [Scalar] = (0..<n).map { Scalar($0 + 1) }

        var actual: [Scalar] = []
        measure {
            actual = lhs ./ rhs
        }

        let expected = Swift.zip(lhs, rhs).map { $0 / $1 }

        XCTAssertEqual(actual, expected, accuracy: 1e-8)
    }

    func test_mod_array_array_float() {
        typealias Scalar = Float

        let lhs: [Scalar] = (0..<n).map { Scalar($0) }
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

        let lhs: [Scalar] = (0..<n).map { Scalar($0) }
        let rhs: [Scalar] = Array(repeating: 42, count: n)

        var actual: [Scalar] = []
        measure {
            actual = lhs .% rhs
        }

        let expected = Swift.zip(lhs, rhs).map { fmod($0, $1) }

        XCTAssertEqual(actual, expected, accuracy: 1e-8)
    }

    func test_remainder_array_array_float() {
        typealias Scalar = Float

        let lhs: [Scalar] = (0..<n).map { Scalar($0) }
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

        let lhs: [Scalar] = (0..<n).map { Scalar($0) }
        let rhs: [Scalar] = Array(repeating: -42, count: n)

        var actual: [Scalar] = []
        measure {
            actual = Surge.remainder(lhs, rhs)
        }

        let expected = Swift.zip(lhs, rhs).map { remainder($0, $1) }

        XCTAssertEqual(actual, expected, accuracy: 1e-8)
    }

    func test_sqrt_array_array_float() {
        typealias Scalar = Float

        let lhs: [Scalar] = (0..<n).map { Scalar($0) }

        var actual: [Scalar] = []
        measure {
            actual = Surge.sqrt(lhs)
        }

        let expected = lhs.map { sqrt($0) }

        XCTAssertEqual(actual, expected, accuracy: 1e-8)
    }

    func test_sqrt_array_array_double() {
        typealias Scalar = Double

        let lhs: [Scalar] = (0..<n).map { Scalar($0) }

        var actual: [Scalar] = []
        measure {
            actual = Surge.sqrt(lhs)
        }

        let expected = lhs.map { sqrt($0) }

        XCTAssertEqual(actual, expected, accuracy: 1e-8)
    }

    func test_dot_array_array_float() {
        typealias Scalar = Float

        let lhs: [Scalar] = Array(repeating: 0.25, count: n)
        let rhs: [Scalar] = Array(repeating: 0.75, count: n)

        var actual: Scalar = 0
        measure {
            actual = lhs • rhs
        }

        let expected = Swift.zip(lhs, rhs).reduce(0) {
            $0 + $1.0 * $1.1
        }

        XCTAssertEqual(actual, expected, accuracy: 1e-8)
    }

    func test_dot_array_array_double() {
        typealias Scalar = Double

        let lhs: [Scalar] = Array(repeating: 0.25, count: n)
        let rhs: [Scalar] = Array(repeating: 0.75, count: n)

        var actual: Scalar = 0
        measure {
            actual = lhs • rhs
        }

        let expected = Swift.zip(lhs, rhs).reduce(0) {
            $0 + $1.0 * $1.1
        }

        XCTAssertEqual(actual, expected, accuracy: 1e-8)
    }

    func test_sum() {
        let values = (0...n).map { _ in Double(arc4random()) / Double(UInt32.max) }
        var actual = 0.0
        measure {
            actual = sum(values)
        }

        var expected = 0.0
        for value in values {
            expected += value
        }

        XCTAssertEqual(actual, expected, accuracy: 1e-8)
    }

    func test_sum_slice() {
        let values = (0...n).map { _ in Double(arc4random()) / Double(UInt32.max) }
        var actual = 0.0
        measure {
            actual = sum(values[0..<n / 2])
        }

        var expected = 0.0
        for value in values[0..<n / 2] {
            expected += value
        }

        XCTAssertEqual(actual, expected, accuracy: 1e-8)
    }

    func test_sqrt() {
        let values = (0...n).map { _ in Double(arc4random()) }
        measureAndValidateMappedFunctionWithAccuracy(source: values, member: sqrt, mapped: sqrt, accuracy: 1e-4)
    }

    func test_sqrt_empty() {
        let values = [Double]()
        XCTAssertEqual(sqrt(values), [])
    }

    func test_dist_array_array_double() {
        typealias Scalar = Double

        let lhs: [Scalar] = Array(repeating: 0.25, count: n)
        let rhs: [Scalar] = Array(repeating: 0.75, count: n)

        var actual: Scalar = 0.0
        measure {
            actual = dist(lhs, rhs)
        }

        let expected: Scalar = sqrt(Swift.zip(lhs, rhs).map({ $0 - $1 }).map({ $0 * $0 }).reduce(0.0, +))

        XCTAssertEqual(actual, expected, accuracy: 1e-6)
    }

    func test_dist_array_array_float() {
        typealias Scalar = Float

        let lhs: [Scalar] = Array(repeating: 0.25, count: n)
        let rhs: [Scalar] = Array(repeating: 0.75, count: n)

        var actual: Scalar = 0.0
        measure {
            actual = dist(lhs, rhs)
        }

        let expected: Scalar = sqrt(Swift.zip(lhs, rhs).map({ $0 - $1 }).map({ $0 * $0 }).reduce(0.0, +))

        XCTAssertEqual(actual, expected, accuracy: 1e-6)
    }

    func test_distsq_array_array_double() {
        typealias Scalar = Double

        let lhs: [Scalar] = Array(repeating: 0.25, count: n)
        let rhs: [Scalar] = Array(repeating: 0.75, count: n)

        var actual: Scalar = 0.0
        measure {
            actual = distSq(lhs, rhs)
        }

        let expected: Scalar = Swift.zip(lhs, rhs).map({ $0 - $1 }).map({ $0 * $0 }).reduce(0.0, +)

        XCTAssertEqual(actual, expected, accuracy: 1e-6)
    }

    func test_distsq_array_array_float() {
        typealias Scalar = Float

        let lhs: [Scalar] = Array(repeating: 0.25, count: n)
        let rhs: [Scalar] = Array(repeating: 0.75, count: n)

        var actual: Scalar = 0.0
        measure {
            actual = distSq(lhs, rhs)
        }

        let expected: Scalar = Swift.zip(lhs, rhs).map({ $0 - $1 }).map({ $0 * $0 }).reduce(0.0, +)

        XCTAssertEqual(actual, expected, accuracy: 1e-6)
    }
}
