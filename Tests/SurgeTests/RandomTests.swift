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

class RandomTests: XCTestCase {
    // MARK: - Box-Muller Transform

    func test_box_muller_transform_float() {
        typealias Scalar = Float

        let lhs: [Scalar] = .randomNormalized()
        let rhs: [Scalar] = .randomNormalized()

        let actual: [Scalar] = { lhs, rhs in
            var (lhs, rhs) = (lhs, rhs)
            boxMullerTransformInPlace(&lhs, &rhs)
            return lhs
        }(lhs, rhs)

        let expected: [Scalar] = zip(lhs, rhs).map { args in
            let (lhs, rhs) = args
            return sqrt(-2.0 * log(lhs)) * cos(2.0 * .pi * rhs)
        }

        XCTAssertEqual(actual, expected, accuracy: 1e-4)
    }

    func test_box_muller_transform_double() {
        typealias Scalar = Double

        let lhs: [Scalar] = .randomNormalized()
        let rhs: [Scalar] = .randomNormalized()

        let actual: [Scalar] = { lhs, rhs in
            var (lhs, rhs) = (lhs, rhs)
            boxMullerTransformInPlace(&lhs, &rhs)
            return lhs
        }(lhs, rhs)

        let expected: [Scalar] = zip(lhs, rhs).map { args in
            let (lhs, rhs) = args
            return sqrt(-2.0 * log(lhs)) * cos(2.0 * .pi * rhs)
        }

        XCTAssertEqual(actual, expected, accuracy: 1e-4)
    }
}
