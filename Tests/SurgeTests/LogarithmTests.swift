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

import Foundation
import XCTest

@testable import Surge

// swiftlint:disable nesting

class LogarithmTests: XCTestCase {
    // MARK: - Base-e Logarithm

    func test_log_in_place_array_float() {
        typealias Scalar = Float

        let lhs: [Scalar] = .monotonicNormalized()

        var actual: [Scalar] = lhs
        Surge.logInPlace(&actual)

        let expected = lhs.map { log($0) }

        XCTAssertEqual(actual, expected, accuracy: 1e-4)
    }

    func test_log_in_place_array_double() {
        typealias Scalar = Double

        let lhs: [Scalar] = .monotonicNormalized()

        var actual: [Scalar] = lhs
        Surge.logInPlace(&actual)

        let expected = lhs.map { log($0) }

        XCTAssertEqual(actual, expected, accuracy: 1e-8)
    }

    // MARK: - Base-2 Logarithm

    func test_log2_in_place_array_float() {
        typealias Scalar = Float

        let lhs: [Scalar] = .monotonicNormalized()

        var actual: [Scalar] = lhs
        Surge.log2InPlace(&actual)

        let expected = lhs.map { log2($0) }

        XCTAssertEqual(actual, expected, accuracy: 1e-4)
    }

    func test_log2_in_place_array_double() {
        typealias Scalar = Double

        let lhs: [Scalar] = .monotonicNormalized()

        var actual: [Scalar] = lhs
        Surge.log2InPlace(&actual)

        let expected = lhs.map { log2($0) }

        XCTAssertEqual(actual, expected, accuracy: 1e-8)
    }

    // MARK: - Base-10 Logarithm

    func test_log10_in_place_array_float() {
        typealias Scalar = Float

        let lhs: [Scalar] = .monotonicNormalized()

        var actual: [Scalar] = lhs
        Surge.log10InPlace(&actual)

        let expected = lhs.map { log10($0) }

        XCTAssertEqual(actual, expected, accuracy: 1e-4)
    }

    func test_log10_in_place_array_double() {
        typealias Scalar = Double

        let lhs: [Scalar] = .monotonicNormalized()

        var actual: [Scalar] = lhs
        Surge.log10InPlace(&actual)

        let expected = lhs.map { log10($0) }

        XCTAssertEqual(actual, expected, accuracy: 1e-8)
    }

    // MARK: - Base-b Logarithm

    func test_logb_in_place_array_float() {
        typealias Scalar = Float

        let lhs: [Scalar] = .monotonicNormalized()

        var actual: [Scalar] = lhs
        Surge.logbInPlace(&actual)

        let expected = lhs.map { logb($0) }

        XCTAssertEqual(actual, expected, accuracy: 1e-4)
    }

    func test_logb_in_place_array_double() {
        typealias Scalar = Double

        let lhs: [Scalar] = .monotonicNormalized()

        var actual: [Scalar] = lhs
        Surge.logbInPlace(&actual)

        let expected = lhs.map { logb($0) }

        XCTAssertEqual(actual, expected, accuracy: 1e-8)
    }
}
