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

class ArithmeticTests: XCTestCase {
    // MARK: - Addition: In Place

    func test_add_in_place_array_array_float() {
        measure_inout_array_array(of: Float.self) { measure in
            measureMetrics([.wallClockTime], automaticallyStartMeasuring: false) {
                measure(Surge.eladdInPlace)
            }
        }
    }

    func test_add_in_place_array_array_double() {
        measure_inout_array_array(of: Double.self) { measure in
            measureMetrics([.wallClockTime], automaticallyStartMeasuring: false) {
                measure(Surge.eladdInPlace)
            }
        }
    }

    // MARK: - Subtraction: In Place

    func test_sub_in_place_array_array_float() {
        measure_inout_array_array(of: Float.self) { measure in
            measureMetrics([.wallClockTime], automaticallyStartMeasuring: false) {
                measure(Surge.elsubInPlace)
            }
        }
    }

    func test_sub_in_place_array_array_double() {
        measure_inout_array_array(of: Double.self) { measure in
            measureMetrics([.wallClockTime], automaticallyStartMeasuring: false) {
                measure(Surge.elsubInPlace)
            }
        }
    }

    // MARK: - Multiplication: In Place

    func test_mul_in_place_array_array_float() {
        measure_inout_array_array(of: Float.self) { measure in
            measureMetrics([.wallClockTime], automaticallyStartMeasuring: false) {
                measure(Surge.elmulInPlace)
            }
        }
    }

    func test_mul_in_place_array_array_double() {
        measure_inout_array_array(of: Double.self) { measure in
            measureMetrics([.wallClockTime], automaticallyStartMeasuring: false) {
                measure(Surge.elmulInPlace)
            }
        }
    }

    // MARK: - Division: In Place

    func test_div_in_place_array_array_float() {
        measure_inout_array_array(of: Float.self) { measure in
            measureMetrics([.wallClockTime], automaticallyStartMeasuring: false) {
                measure(Surge.eldivInPlace)
            }
        }
    }

    func test_div_in_place_array_array_double() {
        measure_inout_array_array(of: Double.self) { measure in
            measureMetrics([.wallClockTime], automaticallyStartMeasuring: false) {
                measure(Surge.eldivInPlace)
            }
        }
    }

    // MARK: - Modulo: In Place

    func test_mod_in_place_array_array_float() {
        measure_inout_array_array(of: Float.self) { measure in
            measureMetrics([.wallClockTime], automaticallyStartMeasuring: false) {
                measure(Surge.modInPlace)
            }
        }
    }

    func test_mod_in_place_array_array_double() {
        measure_inout_array_array(of: Double.self) { measure in
            measureMetrics([.wallClockTime], automaticallyStartMeasuring: false) {
                measure(Surge.modInPlace)
            }
        }
    }

    // MARK: - Remainder

    func test_remainder_in_place_array_array_float() {
        measure_inout_array_array(of: Float.self) { measure in
            measureMetrics([.wallClockTime], automaticallyStartMeasuring: false) {
                measure(Surge.remainderInPlace)
            }
        }
    }

    func test_remainder_in_place_array_array_double() {
        measure_inout_array_array(of: Double.self) { measure in
            measureMetrics([.wallClockTime], automaticallyStartMeasuring: false) {
                measure(Surge.remainderInPlace)
            }
        }
    }

    // MARK: - Exponential

    func test_exp_in_place_array_float() {
        measure_inout_array(of: Float.self) { measure in
            measureMetrics([.wallClockTime], automaticallyStartMeasuring: false) {
                measure(Surge.expInPlace)
            }
        }
    }

    func test_exp_in_place_array_double() {
        measure_inout_array(of: Double.self) { measure in
            measureMetrics([.wallClockTime], automaticallyStartMeasuring: false) {
                measure(Surge.expInPlace)
            }
        }
    }

    // MARK: - Square Exponentiation

    func test_exp2_in_place_array_float() {
        measure_inout_array(of: Double.self) { measure in
            measureMetrics([.wallClockTime], automaticallyStartMeasuring: false) {
                measure(Surge.exp2InPlace)
            }
        }
    }

    func test_exp2_in_place_array_double() {
        measure_inout_array(of: Float.self) { measure in
            measureMetrics([.wallClockTime], automaticallyStartMeasuring: false) {
                measure(Surge.exp2InPlace)
            }
        }
    }

    // MARK: - Power

    func test_pow_in_place_array_array_float() {
        measure_inout_array_array(of: Float.self) { measure in
            measureMetrics([.wallClockTime], automaticallyStartMeasuring: false) {
                measure(Surge.powInPlace)
            }
        }
    }

    func test_pow_in_place_array_array_double() {
        measure_inout_array_array(of: Double.self) { measure in
            measureMetrics([.wallClockTime], automaticallyStartMeasuring: false) {
                measure(Surge.powInPlace)
            }
        }
    }

    func test_pow_in_place_array_scalar_float() {
        measure_inout_array_scalar(of: Float.self) { measure in
            measureMetrics([.wallClockTime], automaticallyStartMeasuring: false) {
                measure(Surge.powInPlace)
            }
        }
    }

    func test_pow_in_place_array_scalar_double() {
        measure_inout_array_scalar(of: Double.self) { measure in
            measureMetrics([.wallClockTime], automaticallyStartMeasuring: false) {
                measure(Surge.powInPlace)
            }
        }
    }

    // MARK: - Square

    func test_sq_array_float() {
        measure_inout_array(of: Float.self) { measure in
            measureMetrics([.wallClockTime], automaticallyStartMeasuring: false) {
                measure(Surge.sqInPlace)
            }
        }
    }

    func test_sq_array_double() {
        measure_inout_array(of: Double.self) { measure in
            measureMetrics([.wallClockTime], automaticallyStartMeasuring: false) {
                measure(Surge.sqInPlace)
            }
        }
    }

    // MARK: - Square Root

    func test_sqrt_array_array_float() {
        measure_inout_array(of: Float.self) { measure in
            measureMetrics([.wallClockTime], automaticallyStartMeasuring: false) {
                measure(Surge.sqrtInPlace)
            }
        }
    }

    func test_sqrt_array_array_double() {
        measure_inout_array(of: Double.self) { measure in
            measureMetrics([.wallClockTime], automaticallyStartMeasuring: false) {
                measure(Surge.sqrtInPlace)
            }
        }
    }

    // MARK: - Dot Product

    func test_dot_array_array_float() {
        measure_array_array(of: Float.self) { measure in
            measureMetrics([.wallClockTime], automaticallyStartMeasuring: false) {
                measure(Surge.dot)
            }
        }
    }

    func test_dot_array_array_double() {
        measure_array_array(of: Float.self) { measure in
            measureMetrics([.wallClockTime], automaticallyStartMeasuring: false) {
                measure(Surge.dot)
            }
        }
    }

    // MARK: - Summation

    func test_sum_array_float() {
        measure_array(of: Float.self) { measure in
            measureMetrics([.wallClockTime], automaticallyStartMeasuring: false) {
                measure(Surge.sum)
            }
        }
    }

    func test_sum_array_double() {
        measure_array(of: Double.self) { measure in
            measureMetrics([.wallClockTime], automaticallyStartMeasuring: false) {
                measure(Surge.sum)
            }
        }
    }

    // MARK: - Distance

    func test_dist_array_array_float() {
        measure_array_array(of: Float.self) { measure in
            measureMetrics([.wallClockTime], automaticallyStartMeasuring: false) {
                measure(Surge.dist)
            }
        }
    }

    func test_dist_array_array_double() {
        measure_array_array(of: Double.self) { measure in
            measureMetrics([.wallClockTime], automaticallyStartMeasuring: false) {
                measure(Surge.dist)
            }
        }
    }

    // MARK: - Distance Squared

    func test_distsq_array_array_float() {
        measure_array_array(of: Float.self) { measure in
            measureMetrics([.wallClockTime], automaticallyStartMeasuring: false) {
                measure(Surge.distSq)
            }
        }
    }

    func test_distsq_array_array_double() {
        measure_array_array(of: Double.self) { measure in
            measureMetrics([.wallClockTime], automaticallyStartMeasuring: false) {
                measure(Surge.distSq)
            }
        }
    }
}
