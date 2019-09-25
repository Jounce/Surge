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

class TrigonometricTests: XCTestCase {
    // MARK: - Sine

    func test_sin_float() {
        measure_inout_array(of: Float.self) { measure in
            measureMetrics([.wallClockTime], automaticallyStartMeasuring: false) {
                measure(Surge.sinInPlace)
            }
        }
    }

    func test_sin_double() {
        measure_inout_array(of: Double.self) { measure in
            measureMetrics([.wallClockTime], automaticallyStartMeasuring: false) {
                measure(Surge.sinInPlace)
            }
        }
    }

    // MARK: - Cosine

    func test_cos_float() {
        measure_inout_array(of: Float.self) { measure in
            measureMetrics([.wallClockTime], automaticallyStartMeasuring: false) {
                measure(Surge.cosInPlace)
            }
        }
    }

    func test_cos_double() {
        measure_inout_array(of: Double.self) { measure in
            measureMetrics([.wallClockTime], automaticallyStartMeasuring: false) {
                measure(Surge.cosInPlace)
            }
        }
    }

    // MARK: - Tangent

    func test_tan_float() {
        measure_inout_array(of: Float.self) { measure in
            measureMetrics([.wallClockTime], automaticallyStartMeasuring: false) {
                measure(Surge.tanInPlace)
            }
        }
    }

    func test_tan_double() {
        measure_inout_array(of: Double.self) { measure in
            measureMetrics([.wallClockTime], automaticallyStartMeasuring: false) {
                measure(Surge.tanInPlace)
            }
        }
    }

    // MARK: - Arc Sine

    func test_asin_float() {
        measure_inout_array(of: Float.self) { measure in
            measureMetrics([.wallClockTime], automaticallyStartMeasuring: false) {
                measure(Surge.asinInPlace)
            }
        }
    }

    func test_asin_double() {
        measure_inout_array(of: Double.self) { measure in
            measureMetrics([.wallClockTime], automaticallyStartMeasuring: false) {
                measure(Surge.asinInPlace)
            }
        }
    }

    // MARK: - Arc Cosine

    func test_acos_float() {
        measure_inout_array(of: Float.self) { measure in
            measureMetrics([.wallClockTime], automaticallyStartMeasuring: false) {
                measure(Surge.acosInPlace)
            }
        }
    }

    func test_acos_double() {
        measure_inout_array(of: Double.self) { measure in
            measureMetrics([.wallClockTime], automaticallyStartMeasuring: false) {
                measure(Surge.acosInPlace)
            }
        }
    }

    // MARK: - Arc Tangent

    func test_atan_float() {
        measure_inout_array(of: Float.self) { measure in
            measureMetrics([.wallClockTime], automaticallyStartMeasuring: false) {
                measure(Surge.atanInPlace)
            }
        }
    }

    func test_atan_double() {
        measure_inout_array(of: Double.self) { measure in
            measureMetrics([.wallClockTime], automaticallyStartMeasuring: false) {
                measure(Surge.atanInPlace)
            }
        }
    }

    // MARK: - Hyperbolic Sine/Cosine/Tangent

    func test_sinh_float() {
        measure_inout_array(of: Float.self) { measure in
            measureMetrics([.wallClockTime], automaticallyStartMeasuring: false) {
                measure(Surge.sinhInPlace)
            }
        }
    }

    func test_sinh_double() {
        measure_inout_array(of: Double.self) { measure in
            measureMetrics([.wallClockTime], automaticallyStartMeasuring: false) {
                measure(Surge.sinhInPlace)
            }
        }
    }

    // MARK: - Hyperbolic Cosine

    func test_cosh_float() {
        measure_inout_array(of: Float.self) { measure in
            measureMetrics([.wallClockTime], automaticallyStartMeasuring: false) {
                measure(Surge.coshInPlace)
            }
        }
    }

    func test_cosh_double() {
        measure_inout_array(of: Double.self) { measure in
            measureMetrics([.wallClockTime], automaticallyStartMeasuring: false) {
                measure(Surge.coshInPlace)
            }
        }
    }

    // MARK: - Hyperbolic Tangent

    func test_tanh_float() {
        measure_inout_array(of: Float.self) { measure in
            measureMetrics([.wallClockTime], automaticallyStartMeasuring: false) {
                measure(Surge.tanhInPlace)
            }
        }
    }

    func test_tanh_double() {
        measure_inout_array(of: Double.self) { measure in
            measureMetrics([.wallClockTime], automaticallyStartMeasuring: false) {
                measure(Surge.tanhInPlace)
            }
        }
    }

    // MARK: - Inverse Hyperbolic Sine/Cosine/Tangent

    func test_asinh_float() {
        measure_inout_array(of: Float.self) { measure in
            measureMetrics([.wallClockTime], automaticallyStartMeasuring: false) {
                measure(Surge.asinhInPlace)
            }
        }
    }

    func test_asinh_double() {
        measure_inout_array(of: Double.self) { measure in
            measureMetrics([.wallClockTime], automaticallyStartMeasuring: false) {
                measure(Surge.asinhInPlace)
            }
        }
    }

    // MARK: - Inverse Hyperbolic Cosine

    func test_acosh_float() {
        measure_inout_array(of: Float.self) { measure in
            measureMetrics([.wallClockTime], automaticallyStartMeasuring: false) {
                measure(Surge.acoshInPlace)
            }
        }
    }

    func test_acosh_double() {
        measure_inout_array(of: Double.self) { measure in
            measureMetrics([.wallClockTime], automaticallyStartMeasuring: false) {
                measure(Surge.acoshInPlace)
            }
        }
    }

    // MARK: - Inverse Hyperbolic Tangent

    func test_atanh_float() {
        measure_inout_array(of: Float.self) { measure in
            measureMetrics([.wallClockTime], automaticallyStartMeasuring: false) {
                measure(Surge.atanhInPlace)
            }
        }
    }

    func test_atanh_double() {
        measure_inout_array(of: Double.self) { measure in
            measureMetrics([.wallClockTime], automaticallyStartMeasuring: false) {
                measure(Surge.atanhInPlace)
            }
        }
    }
}
