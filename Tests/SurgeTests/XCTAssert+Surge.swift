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

/// Allows comparing:
///
/// ```
/// T where
///     T: Collection,
///     T.Element == U,
///     U: FloatingPoint
/// ```
///
/// Useful for comparing:
/// - `[Float]`
/// - `[Double]`
@discardableResult
func XCTAssertEqual<T, U>(
    _ expression1: @autoclosure () throws -> T,
    _ expression2: @autoclosure () throws -> T,
    accuracy: U,
    _ message: @autoclosure () -> String = "",
    file: StaticString = #file,
    line: UInt = #line
) -> Bool
    where T: Collection, T.Element == U, U: FloatingPoint {
    let (actualValues, expectedValues): (T, T)

    do {
        (actualValues, expectedValues) = (try expression1(), try expression2())
    } catch let error {
        XCTFail("Error: \(error)", file: file, line: line)
        return false
    }

    XCTAssertEqual(actualValues.count, expectedValues.count, file: file, line: line)

    for (actual, expected) in Swift.zip(actualValues, expectedValues) {
        guard abs(actual - expected) > abs(accuracy) else {
            continue
        }

        let failureMessage = "XCTAssertEqualWithAccuracy failed: (\(actual)) is not equal to (\(expected)) +/- (\(accuracy))"
        let userMessage = message()
        let message = "\(failureMessage) - \(userMessage)"
        XCTFail(message, file: file, line: line)

        return false
    }

    return true
}

/// Allows comparing:
///
/// ```
/// T where
///     T: Collection,
///     U: Collection,
///     T.Element == U,
///     U.Element == V,
///     V: FloatingPoint
/// ```
///
/// Useful for comparing:
/// - `[[Float]]`
/// - `[[Double]]`
/// - `Matrix<Float>`
/// - `Matrix<Double>`
@discardableResult
func XCTAssertEqual<T, U, V>(
    _ expression1: @autoclosure () throws -> T,
    _ expression2: @autoclosure () throws -> T,
    accuracy: V,
    _ message: @autoclosure () -> String = "",
    file: StaticString = #file,
    line: UInt = #line
) -> Bool
where T: Collection, U: Collection, T.Element == U, U.Element == V, V: FloatingPoint {
    let (actualValues, expectedValues): (T, T)

    do {
        (actualValues, expectedValues) = (try expression1(), try expression2())
    } catch let error {
        XCTFail("Error: \(error)", file: file, line: line)
        return false
    }

    XCTAssertEqual(actualValues.count, expectedValues.count, file: file, line: line)

    for (actual, expected) in Swift.zip(actualValues, expectedValues) {
        guard XCTAssertEqual(actual, expected, accuracy: accuracy) else {
            return false
        }
    }
    return true
}
