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

// swiftlint:disable nesting

class LofarithmTests: XCTestCase {
    let n = 100_000

    // MARK: - Base-e Logarithm

    func test_log_array_float() {
        typealias Scalar = Float

        let lhs: [Scalar] = (1...n).map { Scalar($0) / Scalar(n) }

        var actual: [Scalar] = []
        measure {
            actual = Surge.log(lhs)
        }

        let expected = lhs.map { log($0) }

        XCTAssertEqual(actual, expected, accuracy: 1e-4)
    }

    func test_log_array_double() {
        typealias Scalar = Double

        let lhs: [Scalar] = (1...n).map { Scalar($0) / Scalar(n) }

        var actual: [Scalar] = []
        measure {
            actual = Surge.log(lhs)
        }

        let expected = lhs.map { log($0) }

        XCTAssertEqual(actual, expected, accuracy: 1e-8)
    }

    // MARK: - Base-2 Logarithm

    func test_log2_array_float() {
        typealias Scalar = Float

        let lhs: [Scalar] = (1...n).map { Scalar($0) / Scalar(n) }

        var actual: [Scalar] = []
        measure {
            actual = Surge.log2(lhs)
        }

        let expected = lhs.map { log2($0) }

        XCTAssertEqual(actual, expected, accuracy: 1e-4)
    }

    func test_log2_array_double() {
        typealias Scalar = Double

        let lhs: [Scalar] = (1...n).map { Scalar($0) / Scalar(n) }

        var actual: [Scalar] = []
        measure {
            actual = Surge.log2(lhs)
        }

        let expected = lhs.map { log2($0) }

        XCTAssertEqual(actual, expected, accuracy: 1e-8)
    }

    // MARK: - Base-10 Logarithm

    func test_log10_array_float() {
        typealias Scalar = Float

        let lhs: [Scalar] = (1...n).map { Scalar($0) / Scalar(n) }

        var actual: [Scalar] = []
        measure {
            actual = Surge.log10(lhs)
        }

        let expected = lhs.map { log10($0) }

        XCTAssertEqual(actual, expected, accuracy: 1e-4)
    }

    func test_log10_array_double() {
        typealias Scalar = Double

        let lhs: [Scalar] = (1...n).map { Scalar($0) / Scalar(n) }

        var actual: [Scalar] = []
        measure {
            actual = Surge.log10(lhs)
        }

        let expected = lhs.map { log10($0) }

        XCTAssertEqual(actual, expected, accuracy: 1e-8)
    }

    // MARK: - Base-b Logarithm

    func test_logb_array_float() {
        typealias Scalar = Float

        let lhs: [Scalar] = (1...n).map { Scalar($0) / Scalar(n) }

        var actual: [Scalar] = []
        measure {
            actual = Surge.logb(lhs)
        }

        let expected = lhs.map { logb($0) }

        XCTAssertEqual(actual, expected, accuracy: 1e-4)
    }

    func test_logb_array_double() {
        typealias Scalar = Double

        let lhs: [Scalar] = (1...n).map { Scalar($0) / Scalar(n) }

        var actual: [Scalar] = []
        measure {
            actual = Surge.logb(lhs)
        }

        let expected = lhs.map { logb($0) }

        XCTAssertEqual(actual, expected, accuracy: 1e-8)
    }
}
