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

class StatisticsTests: XCTestCase {
    // MARK: - Sum

    func test_sum_array_float() {
        typealias Scalar = Float

        let lhs: [Scalar] = .monotonicNormalized()

        let actual: Scalar = Surge.sum(lhs)

        let expected: Scalar = lhs.reduce(0) { $0 + $1 }

        XCTAssertEqual(actual, expected, accuracy: 1e-4)
    }

    func test_sum_array_double() {
        typealias Scalar = Double

        let lhs: [Scalar] = .monotonicNormalized()

        let actual: Scalar = Surge.sum(lhs)

        let expected: Scalar = lhs.reduce(0) { $0 + $1 }

        XCTAssertEqual(actual, expected, accuracy: 1e-8)
    }

    // MARK: - Sum of Absolute Values

    func test_asum_array_float() {
        typealias Scalar = Float

        let lhs: [Scalar] = .monotonicNormalized()

        let actual: Scalar = Surge.asum(lhs)

        let expected: Scalar = lhs.reduce(0) { $0 + abs($1) }

        XCTAssertEqual(actual, expected, accuracy: 1e-4)
    }

    func test_asum_array_double() {
        typealias Scalar = Double

        let lhs: [Scalar] = .monotonicNormalized()

        let actual: Scalar = Surge.asum(lhs)

        let expected: Scalar = lhs.reduce(0) { $0 + abs($1) }

        XCTAssertEqual(actual, expected, accuracy: 1e-8)
    }

    // MARK: - Sum of Absolute Values

    func test_sumsq_array_float() {
        typealias Scalar = Float

        let lhs: [Scalar] = .monotonicNormalized()

        let actual: Scalar = Surge.sumsq(lhs)

        let expected: Scalar = lhs.reduce(0) { $0 + ($1 * $1) }

        XCTAssertEqual(actual, expected, accuracy: 1e-4)
    }

    func test_sumsq_array_double() {
        typealias Scalar = Double

        let lhs: [Scalar] = .monotonicNormalized()

        let actual: Scalar = Surge.sumsq(lhs)

        let expected: Scalar = lhs.reduce(0) { $0 + ($1 * $1) }

        XCTAssertEqual(actual, expected, accuracy: 1e-8)
    }

    // MARK: - Maximum

    func test_max_array_float() {
        typealias Scalar = Float

        let lhs: [Scalar] = .monotonicNormalized()

        let actual: Scalar = Surge.max(lhs)

        let expected: Scalar = lhs.max()!

        XCTAssertEqual(actual, expected, accuracy: 1e-4)
    }

    func test_max_array_double() {
        typealias Scalar = Double

        let lhs: [Scalar] = .monotonicNormalized()

        let actual: Scalar = Surge.max(lhs)

        let expected: Scalar = lhs.max()!

        XCTAssertEqual(actual, expected, accuracy: 1e-8)
    }

    // MARK: - Minimum

    func test_min_array_float() {
        typealias Scalar = Float

        let lhs: [Scalar] = .monotonicNormalized()

        let actual: Scalar = Surge.min(lhs)

        let expected: Scalar = lhs.min()!

        XCTAssertEqual(actual, expected, accuracy: 1e-4)
    }

    func test_min_array_double() {
        typealias Scalar = Double

        let lhs: [Scalar] = .monotonicNormalized()

        let actual: Scalar = Surge.min(lhs)

        let expected: Scalar = lhs.min()!

        XCTAssertEqual(actual, expected, accuracy: 1e-8)
    }

    // MARK: - Mean

    func test_mean_array_float() {
        typealias Scalar = Float

        let lhs: [Scalar] = .monotonicNormalized()

        let actual: Scalar = Surge.mean(lhs)

        let expected: Scalar = {
            let sum = lhs.reduce(0) { $0 + $1 }
            return sum / Scalar(lhs.count)
        }()

        XCTAssertEqual(actual, expected, accuracy: 1e-4)
    }

    func test_mean_array_double() {
        typealias Scalar = Double

        let lhs: [Scalar] = .monotonicNormalized()

        let actual: Scalar = Surge.mean(lhs)

        let expected: Scalar = {
            let sum = lhs.reduce(0) { $0 + $1 }
            return sum / Scalar(lhs.count)
        }()

        XCTAssertEqual(actual, expected, accuracy: 1e-8)
    }

    // MARK: - Mean of Magnitudes

    func test_meamg_array_float() {
        typealias Scalar = Float

        let lhs: [Scalar] = .monotonicNormalized()

        let actual: Scalar = Surge.meamg(lhs)

        let expected: Scalar = {
            let sum = lhs.reduce(0) { $0 + abs($1) }
            return sum / Scalar(lhs.count)
        }()

        XCTAssertEqual(actual, expected, accuracy: 1e-4)
    }

    func test_meamg_array_double() {
        typealias Scalar = Double

        let lhs: [Scalar] = .monotonicNormalized()

        let actual: Scalar = Surge.meamg(lhs)

        let expected: Scalar = {
            let sum = lhs.reduce(0) { $0 + abs($1) }
            return sum / Scalar(lhs.count)
        }()

        XCTAssertEqual(actual, expected, accuracy: 1e-8)
    }

    // MARK: - Mean of Squares

    func test_measq_array_float() {
        typealias Scalar = Float

        let lhs: [Scalar] = .monotonicNormalized()

        let actual: Scalar = Surge.measq(lhs)

        let expected: Scalar = {
            let sum = lhs.reduce(0) { $0 + ($1 * $1) }
            return sum / Scalar(lhs.count)
        }()

        XCTAssertEqual(actual, expected, accuracy: 1e-4)
    }

    func test_measq_array_double() {
        typealias Scalar = Double

        let lhs: [Scalar] = .monotonicNormalized()

        let actual: Scalar = Surge.measq(lhs)

        let expected: Scalar = {
            let sum = lhs.reduce(0) { $0 + ($1 * $1) }
            return sum / Scalar(lhs.count)
        }()

        XCTAssertEqual(actual, expected, accuracy: 1e-8)
    }

    // MARK: - Root Mean of Squares

    func test_rmsq_array_float() {
        typealias Scalar = Float

        let lhs: [Scalar] = .monotonicNormalized()

        let actual: Scalar = Surge.rmsq(lhs)

        let expected: Scalar = {
            let sum = lhs.reduce(0) { $0 + ($1 * $1) }
            let mean = sum / Scalar(lhs.count)
            return sqrt(mean)
        }()

        XCTAssertEqual(actual, expected, accuracy: 1e-4)
    }

    func test_rmsq_array_double() {
        typealias Scalar = Double

        let lhs: [Scalar] = .monotonicNormalized()

        let actual: Scalar = Surge.rmsq(lhs)

        let expected: Scalar = {
            let sum = lhs.reduce(0) { $0 + ($1 * $1) }
            let mean = sum / Scalar(lhs.count)
            return sqrt(mean)
        }()

        XCTAssertEqual(actual, expected, accuracy: 1e-8)
    }

    // MARK: - Variance

    func test_variance_array_float() {
        typealias Scalar = Float

        let lhs: [Scalar] = .monotonicNormalized()

        let actual: Scalar = Surge.variance(lhs)

        let expected: Scalar = {
            let mean = lhs.reduce(0) { $0 + $1 } / Scalar(lhs.count)
            let diff = lhs.map { $0 - mean }
            let diffSq = diff.map { $0 * $0 }
            let sumDiffSq = diffSq.reduce(0.0) { $0 + $1 }
            return sumDiffSq / Scalar(lhs.count - 1)
        }()

        XCTAssertEqual(actual, expected, accuracy: 1e-4)
    }

    func test_variance_array_double() {
        typealias Scalar = Double

        let lhs: [Scalar] = .monotonicNormalized()

        let actual: Scalar = Surge.variance(lhs)

        let expected: Scalar = {
            let mean = lhs.reduce(0) { $0 + $1 } / Scalar(lhs.count)
            let diff = lhs.map { $0 - mean }
            let diffSq = diff.map { $0 * $0 }
            let sumDiffSq = diffSq.reduce(0.0) { $0 + $1 }
            return sumDiffSq / Scalar(lhs.count - 1)
        }()

        XCTAssertEqual(actual, expected, accuracy: 1e-4)
    }

    // MARK: - Standard Deviation

    func test_std_array_float() {
        typealias Scalar = Float

        let lhs: [Scalar] = .monotonicNormalized()

        let actual: Scalar = Surge.std(lhs)

        let expected: Scalar = {
            let mean = lhs.reduce(0) { $0 + $1 } / Scalar(lhs.count)
            let diff = lhs.map { $0 - mean }
            let diffSq = diff.map { $0 * $0 }
            let sumDiffSq = diffSq.reduce(0.0) { $0 + $1 }
            let variance = sumDiffSq / Scalar(lhs.count - 1)
            return sqrt(variance)
        }()

        XCTAssertEqual(actual, expected, accuracy: 1e-3)
    }

    func test_std_array_double() {
        typealias Scalar = Double

        let lhs: [Scalar] = .monotonicNormalized()

        let actual: Scalar = Surge.std(lhs)

        let expected: Scalar = {
            let mean = lhs.reduce(0) { $0 + $1 } / Scalar(lhs.count)
            let diff = lhs.map { $0 - mean }
            let diffSq = diff.map { $0 * $0 }
            let sumDiffSq = diffSq.reduce(0.0) { $0 + $1 }
            let variance = sumDiffSq / Scalar(lhs.count - 1)
            return sqrt(variance)
        }()

        XCTAssertEqual(actual, expected, accuracy: 1e-3)
    }
}
