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

private struct ValueError: Swift.Error, CustomStringConvertible {
    let message: String

    var description: String {
        return self.message
    }
}

private enum ArrayError: Swift.Error, CustomStringConvertible {
    case size(message: String)
    case content(index: Int, content: ValueError)

    var description: String {
        switch self {
        case let .size(message):
            return message
        case let .content(index, error):
            return "Failure at index [\(index)]: \(error)"
        }
    }
}

private enum GridError: Swift.Error, CustomStringConvertible {
    case size(message: String)
    case content(index: Int, content: ArrayError)

    var description: String {
        switch self {
        case let .size(message):
            return message
        case let .content(gridIndex, arrayError):
            switch arrayError {
            case let .size(message):
                return "Failure at index [\(gridIndex), ..]: \(message)"
            case let .content(arrayIndex, valueError):
                return "Failure at index [\(gridIndex), \(arrayIndex)]: \(valueError)"
            }
        }
    }
}

private func checkValue<T>(
    _ actualValue: T,
    _ expectedValue: T,
    accuracy: T
) -> Result<(), ValueError> where T: FloatingPoint {
    guard abs(actualValue - expectedValue) <= abs(accuracy) else {
        let (actual, expected) = (actualValue, expectedValue)
        let message = "(\(actual)) is not equal to (\(expected)) +/- (\(accuracy))"
        return .failure(ValueError(message: message))
    }

    return .success(())
}

private func checkArray<T, U>(
    _ actualArray: T,
    _ expectedArray: T,
    accuracy: U
) -> Result<(), ArrayError> where T: Collection, T.Element == U, U: FloatingPoint {
    guard actualArray.count == expectedArray.count else {
        let (actual, expected) = (actualArray.count, expectedArray.count)
        let message = "Values have different size: (\(actual)) is not equal to (\(expected))"
        return .failure(.size(message: message))
    }

    for (index, (actualValue, expectedValue)) in Swift.zip(actualArray, expectedArray).enumerated() {
        switch checkValue(actualValue, expectedValue, accuracy: accuracy) {
        case .success:
            continue
        case .failure(let error):
            return .failure(.content(index: index, content: error))
        }
    }

    return .success(())
}

private func checkGrid<T, U, V>(
    _ actualGrid: T,
    _ expectedGrid: T,
    accuracy: V
) -> Result<(), GridError> where T: Collection, U: Collection, T.Element == U, U.Element == V, V: FloatingPoint {
    guard actualGrid.count == expectedGrid.count else {
        let (actual, expected) = (actualGrid.count, expectedGrid.count)
        let message = "Values have different size: (\(actual) × _) is not equal to (\(expected) × _)"
        return .failure(.size(message: message))
    }

    for (index, (actualArray, expectedArray)) in Swift.zip(actualGrid, expectedGrid).enumerated() {
        switch checkArray(actualArray, expectedArray, accuracy: accuracy) {
        case .success:
            continue
        case .failure(let error):
            return .failure(.content(index: index, content: error))
        }
    }

    return .success(())
}

private enum Prefix: String {
    case assertEqual = "XCTAssertEqual"
    case assertEqualWithAccuracy = "XCTAssertEqualWithAccuracy"
}

private func fail(
    prefix: Prefix,
    failureMessage: String,
    userMessage: String? = nil,
    file: StaticString,
    line: UInt
) {
    let prefix = "\(prefix.rawValue) failed: "
    let suffix = userMessage.map { " - \($0)" } ?? ""
    let message = "\(prefix)\(failureMessage)\(suffix)"
    XCTFail(message, file: file, line: line)
}

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
func XCTAssertEqual<T, U>(
    _ expression1: @autoclosure () throws -> T,
    _ expression2: @autoclosure () throws -> T,
    accuracy: U? = nil,
    _ message: @autoclosure () -> String = "",
    file: StaticString = #file,
    line: UInt = #line
) where T: Collection, T.Element == U, U: FloatingPoint & ExpressibleByFloatLiteral {
    XCTAssertEqual1D(
        try expression1(),
        try expression2(),
        accuracy: accuracy,
        message(),
        file: file,
        line: line
    )
}

func XCTAssertEqual1D<T, U>(
    _ expression1: @autoclosure () throws -> T,
    _ expression2: @autoclosure () throws -> T,
    accuracy: U? = nil,
    _ message: @autoclosure () -> String = "",
    file: StaticString = #file,
    line: UInt = #line
) where T: Collection, T.Element == U, U: FloatingPoint & ExpressibleByFloatLiteral {
    let prefix: Prefix = (accuracy == nil) ? .assertEqual : .assertEqualWithAccuracy

    let (actual, expected): (T, T)

    do {
        (actual, expected) = (try expression1(), try expression2())
    } catch let error {
        let message = String(describing: error)
        return fail(prefix: prefix, failureMessage: message, file: file, line: line)
    }

    let result = checkArray(actual, expected, accuracy: accuracy ?? 0.0)

    guard case .failure(let error) = result else {
        return
    }

    return fail(prefix: prefix, failureMessage: error.description, file: file, line: line)
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
func XCTAssertEqual<T, U, V>(
    _ expression1: @autoclosure () throws -> T,
    _ expression2: @autoclosure () throws -> T,
    accuracy: V? = nil,
    _ message: @autoclosure () -> String = "",
    file: StaticString = #file,
    line: UInt = #line
) where T: Collection, U: Collection, T.Element == U, U.Element == V, V: FloatingPoint & ExpressibleByFloatLiteral {
    XCTAssertEqual2D(
        try expression1(),
        try expression2(),
        accuracy: accuracy,
        message(),
        file: file,
        line: line
    )
}

func XCTAssertEqual2D<T, U, V>(
    _ expression1: @autoclosure () throws -> T,
    _ expression2: @autoclosure () throws -> T,
    accuracy: V? = nil,
    _ message: @autoclosure () -> String = "",
    file: StaticString = #file,
    line: UInt = #line
) where T: Collection, U: Collection, T.Element == U, U.Element == V, V: FloatingPoint & ExpressibleByFloatLiteral {
    let prefix: Prefix = (accuracy == nil) ? .assertEqual : .assertEqualWithAccuracy

    let (actual, expected): (T, T)

    do {
        (actual, expected) = (try expression1(), try expression2())
    } catch let error {
        let message = String(describing: error)
        return fail(prefix: prefix, failureMessage: message, file: file, line: line)
    }

    let result = checkGrid(actual, expected, accuracy: accuracy ?? 0.0)

    guard case .failure(let error) = result else {
        return
    }

    return fail(prefix: prefix, failureMessage: error.description, file: file, line: line)
}
