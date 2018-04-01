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

class ArithmeticTests: XCTestCase {
    let n = 100_000

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
            actual = sum(values[0..<n/2])
        }

        var expected = 0.0
        for value in values[0..<n/2] {
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
}
