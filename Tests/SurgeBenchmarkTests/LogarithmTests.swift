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

class LogarithmTests: XCTestCase {
    // MARK: - Base-e Logarithm: In Place

    func test_log_in_place_array_float() {
        measure_inout_array(of: Float.self) { measure in
            measureMetrics([.wallClockTime], automaticallyStartMeasuring: false) {
                measure(Surge.logInPlace)
            }
        }
    }

    func test_log_in_place_array_double() {
        measure_inout_array(of: Double.self) { measure in
            measureMetrics([.wallClockTime], automaticallyStartMeasuring: false) {
                measure(Surge.logInPlace)
            }
        }
    }

    // MARK: - Base-2 Logarithm: In Place

    func test_log2_in_place_array_float() {
        measure_inout_array(of: Float.self) { measure in
            measureMetrics([.wallClockTime], automaticallyStartMeasuring: false) {
                measure(Surge.log2InPlace)
            }
        }
    }

    func test_log2_in_place_array_double() {
        measure_inout_array(of: Double.self) { measure in
            measureMetrics([.wallClockTime], automaticallyStartMeasuring: false) {
                measure(Surge.log2InPlace)
            }
        }
    }

    // MARK: - Base-10 Logarithm: In Place

    func test_log10_in_place_array_float() {
        measure_inout_array(of: Float.self) { measure in
            measureMetrics([.wallClockTime], automaticallyStartMeasuring: false) {
                measure(Surge.log10InPlace)
            }
        }
    }

    func test_log10_in_place_array_double() {
        measure_inout_array(of: Double.self) { measure in
            measureMetrics([.wallClockTime], automaticallyStartMeasuring: false) {
                measure(Surge.log10InPlace)
            }
        }
    }

    // MARK: - Base-b Logarithm: In Place

    func test_logb_in_place_array_float() {
        measure_inout_array(of: Float.self) { measure in
            measureMetrics([.wallClockTime], automaticallyStartMeasuring: false) {
                measure(Surge.logbInPlace)
            }
        }
    }

    func test_logb_in_place_array_double() {
        measure_inout_array(of: Double.self) { measure in
            measureMetrics([.wallClockTime], automaticallyStartMeasuring: false) {
                measure(Surge.logbInPlace)
            }
        }
    }
}
