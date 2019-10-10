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

// swiftlint:disable nesting type_body_length

class AuxiliaryTests: XCTestCase {
    // MARK: - Abs: In Place

    func test_abs_in_place_array_double() {
        typealias Scalar = Double

        let lhs: [Scalar] = .monotonicNormalized()

        var actual: [Scalar] = lhs
        Surge.absInPlace(&actual)

        let expected = lhs.map { abs($0) }

        XCTAssertEqual(actual, expected, accuracy: 1e-8)
    }

    func test_abs_in_place_array_float() {
        typealias Scalar = Float

        let lhs: [Scalar] = .monotonicNormalized()

        var actual: [Scalar] = lhs
        Surge.absInPlace(&actual)

        let expected = lhs.map { abs($0) }

        XCTAssertEqual(actual, expected, accuracy: 1e-8)
    }

    // MARK: - Floor: In Place

    func test_floor_in_place_array_double() {
        typealias Scalar = Double

        let lhs: [Scalar] = .monotonicNormalized()

        var actual: [Scalar] = lhs
        Surge.floorInPlace(&actual)

        let expected = lhs.map { floor($0) }

        XCTAssertEqual(actual, expected, accuracy: 1e-8)
    }

    func test_floor_in_place_array_float() {
        typealias Scalar = Float

        let lhs: [Scalar] = .monotonicNormalized()

        var actual: [Scalar] = lhs
        Surge.floorInPlace(&actual)

        let expected = lhs.map { floor($0) }

        XCTAssertEqual(actual, expected, accuracy: 1e-8)
    }

    // MARK: - Ceil: In Place

    func test_ceil_in_place_array_double() {
        typealias Scalar = Double

        let lhs: [Scalar] = .monotonicNormalized()

        var actual: [Scalar] = lhs
        Surge.ceilInPlace(&actual)

        let expected = lhs.map { ceil($0) }

        XCTAssertEqual(actual, expected, accuracy: 1e-8)
    }

    func test_ceil_in_place_array_float() {
        typealias Scalar = Float

        let lhs: [Scalar] = .monotonicNormalized()

        var actual: [Scalar] = lhs
        Surge.ceilInPlace(&actual)

        let expected = lhs.map { ceil($0) }

        XCTAssertEqual(actual, expected, accuracy: 1e-8)
    }

    // MARK: - Clip: In Place

    func test_clip_in_place_array_double() {
        typealias Scalar = Double

        let lhs: [Scalar] = .monotonicNormalized()
        let maxValue = lhs.max()!
        let low = maxValue * 0.25
        let high = maxValue * 0.75

        var actual: [Scalar] = lhs
        Surge.clipInPlace(&actual, low: low, high: high)

        let expected = lhs.map { max(low, min(high, $0)) }

        XCTAssertEqual(actual, expected, accuracy: 1e-8)
    }

    func test_clip_in_place_array_float() {
        typealias Scalar = Float

        let lhs: [Scalar] = .monotonicNormalized()
        let maxValue = lhs.max()!
        let low = maxValue * 0.25
        let high = maxValue * 0.75

        var actual: [Scalar] = lhs
        Surge.clipInPlace(&actual, low: low, high: high)

        let expected = lhs.map { max(low, min(high, $0)) }

        XCTAssertEqual(actual, expected, accuracy: 1e-8)
    }

    // MARK: - Copy Sign: In Place

    func test_copysign_in_place_array_double() {
        typealias Scalar = Double

        // FIXME: make sign/rhs contain both, positive and negative scalars
        let lhs: [Scalar] = .monotonicNormalized()
        let rhs: [Scalar] = .monotonicNormalized()

        var actual: [Scalar] = lhs
        Surge.copysignInPlace(&actual, rhs)

        let expected = zip(lhs, rhs).map { copysign($0, $1) }

        XCTAssertEqual(actual, expected, accuracy: 1e-8)
    }

    func test_copysign_in_place_array_float() {
        typealias Scalar = Float

        // FIXME: make sign/rhs contain both, positive and negative scalars
        let lhs: [Scalar] = .monotonicNormalized()
        let rhs: [Scalar] = .monotonicNormalized()

        var actual: [Scalar] = lhs
        Surge.copysignInPlace(&actual, rhs)

        let expected = zip(lhs, rhs).map { copysign($0, $1) }

        XCTAssertEqual(actual, expected, accuracy: 1e-8)
    }

    // MARK: - Negate: In Place

    func test_neg_in_place_array_double() {
        typealias Scalar = Double

        let lhs: [Scalar] = .monotonicNormalized()

        var actual: [Scalar] = lhs
        Surge.negInPlace(&actual)

        let expected = lhs.map { -$0 }

        XCTAssertEqual(actual, expected, accuracy: 1e-8)
    }

    func test_neg_in_place_array_float() {
        typealias Scalar = Float

        let lhs: [Scalar] = .monotonicNormalized()

        var actual: [Scalar] = lhs
        Surge.negInPlace(&actual)

        let expected = lhs.map { -$0 }

        XCTAssertEqual(actual, expected, accuracy: 1e-8)
    }

    // MARK: - Reciprocal: In Place

    func test_rec_in_place_array_double() {
        typealias Scalar = Double

        let lhs: [Scalar] = .monotonicNormalized()

        var actual: [Scalar] = lhs
        Surge.recInPlace(&actual)

        let expected = lhs.map { 1.0 / $0 }

        XCTAssertEqual(actual, expected, accuracy: 1e-8)
    }

    func test_rec_in_place_array_float() {
        typealias Scalar = Float

        let lhs: [Scalar] = .monotonicNormalized()

        var actual: [Scalar] = lhs
        Surge.recInPlace(&actual)

        let expected = lhs.map { 1.0 / $0 }

        XCTAssertEqual(actual, expected, accuracy: 1e-8)
    }

    // MARK: - Round: In Place

    func test_round_in_place_array_double() {
        typealias Scalar = Double

        let lhs: [Scalar] = .monotonicNormalized()

        var actual: [Scalar] = lhs
        Surge.roundInPlace(&actual)

        let expected = lhs.map { $0.rounded(.toNearestOrEven) }

        XCTAssertEqual(actual, expected, accuracy: 1e-8)
    }

    func test_round_in_place_array_float() {
        typealias Scalar = Float

        let lhs: [Scalar] = .monotonicNormalized()

        var actual: [Scalar] = lhs
        Surge.roundInPlace(&actual)

        let expected = lhs.map { $0.rounded(.toNearestOrEven) }

        XCTAssertEqual(actual, expected, accuracy: 1e-8)
    }

    // MARK: - Threshold: In Place

    func test_threshold_in_place_array_double() {
        typealias Scalar = Double

        let lhs: [Scalar] = .monotonicNormalized()
        let maxValue = lhs.max()!
        let low = maxValue * 0.5

        var actual: [Scalar] = lhs
        Surge.thresholdInPlace(&actual, low: low)

        let expected = lhs.map { max($0, low) }

        XCTAssertEqual(actual, expected, accuracy: 1e-8)
    }

    func test_threshold_in_place_array_float() {
        typealias Scalar = Float

        let lhs: [Scalar] = .monotonicNormalized()
        let maxValue = lhs.max()!
        let low = maxValue * 0.5

        var actual: [Scalar] = lhs
        Surge.thresholdInPlace(&actual, low: low)

        let expected = lhs.map { max($0, low) }

        XCTAssertEqual(actual, expected, accuracy: 1e-8)
    }

    // MARK: - Threshold: In Place

    func test_trunc_in_place_array_double() {
        typealias Scalar = Double

        let lhs: [Scalar] = .monotonicNormalized(to: -1.0)

        var actual: [Scalar] = lhs
        Surge.truncInPlace(&actual)

        let expected = lhs.map { $0.rounded(.towardZero) }

        XCTAssertEqual(actual, expected, accuracy: 1e-8)
    }

    func test_trunc_in_place_array_float() {
        typealias Scalar = Float

        let lhs: [Scalar] = .monotonicNormalized()

        var actual: [Scalar] = lhs
        Surge.truncInPlace(&actual)

        let expected = lhs.map { $0.rounded(.towardZero) }

        XCTAssertEqual(actual, expected, accuracy: 1e-8)
    }
}
