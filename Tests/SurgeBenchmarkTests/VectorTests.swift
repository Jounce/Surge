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

import XCTest

@testable import Surge

/// - Note: Most functions of `Vector<Scalar>` simply call arithmetic functions
///   directly modifying the vector's `[Scalar]` storage with minimal overhead.
///   As such we're only explicitly benchmarking those function that actually
///   are implemented on `Vector<Scalar>` itself, rather than `[Scalar]`
class VectorTests: XCTestCase {
    // MARK: - Multiplication: In Place

    func test_mul_vector_matrix_double() {
        measure_vector_matrix(of: Double.self) { measure in
            measureMetrics([.wallClockTime], automaticallyStartMeasuring: false) {
                measure(Surge.mul)
            }
        }
    }

    func test_mul_vector_matrix_float() {
        measure_vector_matrix(of: Float.self) { measure in
            measureMetrics([.wallClockTime], automaticallyStartMeasuring: false) {
                measure(Surge.mul)
            }
        }
    }
}
