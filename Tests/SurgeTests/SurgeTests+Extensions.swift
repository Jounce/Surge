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

extension XCTestCase {
    func measureAndValidateMappedFunctionWithAccuracy<C: Collection>(source: C, member: (C.Iterator.Element) -> (C.Iterator.Element), mapped: @escaping (C) -> ([C.Iterator.Element]), accuracy: C.Iterator.Element) where C.Iterator.Element: ExpressibleByFloatLiteral & FloatingPoint {
        let expected = source.map(member)

        var actual: [C.Iterator.Element] = []
        self.measure {
            actual = mapped(source)
        }

        for (i, j) in zip(actual.indices, expected.indices) {
            XCTAssertEqual(actual[i], expected[j], accuracy: accuracy)
        }
    }
}

extension ExpressibleByFloatLiteral {
    static func constant() -> Self {
        return 1.0
    }
}

extension Array {
    static var defaultCount: Int {
        return 1_000
    }

    static func monotonic<Scalar>() -> [Scalar] where Scalar: FloatingPoint & ExpressibleByFloatLiteral {
        return monotonic(count: Array.defaultCount)
    }

    static func monotonic<Scalar>(count: Int) -> [Scalar] where Scalar: FloatingPoint & ExpressibleByFloatLiteral {
        return (1...count).map { Scalar($0) }
    }

    static func monotonicNormalized<Scalar>() -> [Scalar] where Scalar: FloatingPoint & ExpressibleByFloatLiteral {
        return monotonicNormalized(count: Array.defaultCount)
    }

    static func monotonicNormalized<Scalar>(count: Int) -> [Scalar] where Scalar: FloatingPoint & ExpressibleByFloatLiteral {
        let scalarCount = Scalar(count)
        return (1...count).map { Scalar($0) / scalarCount }
    }

    static func constant<Scalar>() -> [Scalar] where Scalar: FloatingPoint & ExpressibleByFloatLiteral {
        return constant(1.0)
    }

    static func constant<Scalar>(_ scalar: Scalar) -> [Scalar] where Scalar: FloatingPoint & ExpressibleByFloatLiteral {
        return constant(scalar, count: Array.defaultCount)
    }

    static func constant<Scalar>(_ scalar: Scalar, count: Int) -> [Scalar] where Scalar: FloatingPoint & ExpressibleByFloatLiteral {
        return [Scalar](repeating: scalar, count: count)
    }
}
