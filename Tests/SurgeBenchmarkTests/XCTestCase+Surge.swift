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

// swiftlint:disable nesting

// Why on earth do we need these abominations, you ask?
//
// Well, you see … XCTest is not —to put it mildly— the best unit testing framework out there.
// As such, while `XCTAssert` and its cousins have hidden `file: StaticString = #file, line: UInt = #line` parameters,
// which allow for Xcode to associate a particular failure with a different line than the actual invocation,
// its `measure(_:)` and the more elaborate `measureMetrics(_:automaticallyStartMeasuring:for:)` variant do not
// provide such hidden `file:line:` parameters. As such it's impossible to wrap the call to either of those functions
// in a convenience wrapper of some kind in order to reduce testing code bloat and redundancies.
//
// And due to the nature of Surge's `…InPlace` functions' use of `inout` invocations of such functions is not idempotent.
// So we need to make sure we're passing a freshly prepared test value to each invocation of the measure block.
// But at the same time we do not want to include such house-keeping things in our benchmarks, as it may involve
// quite costly memory allocations and copying.
//
// As such we are forced to make use of `measureMetrics(_:automaticallyStartMeasuring:for:)`, instead of the simpler `measure(_:)`
// and do some trampolin gymnastics to keep as much of the nasty and redundant stuff out of sight of the user.
//
// And this my dear friend is why we're having this conversion right now. I'm sorry.

extension XCTestCase {
    typealias LhsFunction<Lhs, T> = (Lhs) -> T
    typealias LhsFunctionWrapper<Lhs, T> = (LhsFunction<Lhs, T>) -> ()

    typealias LhsRhsFunction<Lhs, Rhs, T> = (Lhs, Rhs) -> T
    typealias LhsRhsFunctionWrapper<Lhs, Rhs, T> = (LhsRhsFunction<Lhs, Rhs, T>) -> ()

    typealias InOutLhsFunction<Lhs, T> = (inout Lhs) -> T
    typealias InOutLhsFunctionWrapper<Lhs, T> = (InOutLhsFunction<Lhs, T>) -> ()

    typealias InOutLhsRhsFunction<Lhs, Rhs, T> = (inout Lhs, Rhs) -> T
    typealias InOutLhsRhsFunctionWrapper<Lhs, Rhs, T> = (InOutLhsRhsFunction<Lhs, Rhs, T>) -> ()

    typealias Producer<T> = () -> T

    static func normalizedMonotonic<T>(n: Int = ArithmeticTests.n) -> Producer<[T]> where T: FloatingPoint {
        typealias Scalar = T

        return {
            (1...n).map { Scalar($0) / Scalar(n) }
        }
    }

    static func scalar<T>(constant: T = 2.0) -> Producer<T> where T: FloatingPoint & ExpressibleByFloatLiteral {
        return {
            constant
        }
    }

    func measure_array<T, U>(
        of: T.Type,
        lhs produceLhs: Producer<[T]> = ArithmeticTests.normalizedMonotonic(),
        _ closure: (LhsFunctionWrapper<[T], U>) -> ()
    ) where T: FloatingPoint & ExpressibleByFloatLiteral {
        typealias Scalar = T

        let lhs = produceLhs()

        closure({ innerClosure in
            startMeasuring()
            let _ = innerClosure(lhs)
            stopMeasuring()
        })
    }

    func measure_inout_array<T, U>(
        of: T.Type,
        lhs produceLhs: Producer<[T]> = ArithmeticTests.normalizedMonotonic(),
        _ closure: (InOutLhsFunctionWrapper<[T], U>) -> ()
    ) where T: FloatingPoint & ExpressibleByFloatLiteral {
        typealias Scalar = T

        let lhs = produceLhs()

        closure({ innerClosure in
            var lhs = lhs

            startMeasuring()
            let _ = innerClosure(&lhs)
            stopMeasuring()
        })
    }

    func measure_array_array<T, U>(
        of: T.Type,
        lhs produceLhs: Producer<[T]> = ArithmeticTests.normalizedMonotonic(),
        rhs produceRhs: Producer<[T]> = ArithmeticTests.normalizedMonotonic(),
        _ closure: (LhsRhsFunctionWrapper<[T], [T], U>) -> ()
    ) where T: FloatingPoint & ExpressibleByFloatLiteral {
        typealias Scalar = T

        let lhs = produceLhs()
        let rhs = produceRhs()

        closure({ innerClosure in
            startMeasuring()
            let _ = innerClosure(lhs, rhs)
            stopMeasuring()
        })
    }

    func measure_inout_array_array<T, U>(
        of: T.Type,
        lhs produceLhs: Producer<[T]> = ArithmeticTests.normalizedMonotonic(),
        rhs produceRhs: Producer<[T]> = ArithmeticTests.normalizedMonotonic(),
        _ closure: (InOutLhsRhsFunctionWrapper<[T], [T], U>) -> ()
    ) where T: FloatingPoint & ExpressibleByFloatLiteral {
        typealias Scalar = T

        let lhs = produceLhs()
        let rhs = produceRhs()

        closure({ innerClosure in
            var lhs = lhs

            startMeasuring()
            let _ = innerClosure(&lhs, rhs)
            stopMeasuring()
        })
    }

    func measure_array_scalar<T, U>(
        of: T.Type,
        lhs produceLhs: Producer<[T]> = ArithmeticTests.normalizedMonotonic(),
        rhs produceRhs: Producer<T> = ArithmeticTests.scalar(),
        _ closure: (LhsRhsFunctionWrapper<[T], T, U>) -> ()
    ) where T: FloatingPoint & ExpressibleByFloatLiteral {
        typealias Scalar = T

        let lhs = produceLhs()
        let rhs = produceRhs()

        closure({ innerClosure in
            startMeasuring()
            let _ = innerClosure(lhs, rhs)
            stopMeasuring()
        })
    }

    func measure_inout_array_scalar<T, U>(
        of: T.Type,
        lhs produceLhs: Producer<[T]> = ArithmeticTests.normalizedMonotonic(),
        rhs produceRhs: Producer<T> = ArithmeticTests.scalar(),
        _ closure: (InOutLhsRhsFunctionWrapper<[T], T, U>) -> ()
    ) where T: FloatingPoint & ExpressibleByFloatLiteral {
        typealias Scalar = T

        let lhs = produceLhs()
        let rhs = produceRhs()

        closure({ innerClosure in
            var lhs = lhs

            startMeasuring()
            let _ = innerClosure(&lhs, rhs)
            stopMeasuring()
        })
    }
}
