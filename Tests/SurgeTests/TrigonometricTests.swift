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
    let n = 10_000

    // MARK: - Sine

    func test_sin_in_place_float() {
        validate_inout_array(
            of: Float.self,
            actual: { Surge.sinInPlace(&$0) },
            expected: { $0.map(sin) },
            accuracy: 1e-4
        )
    }

    func test_sin_in_place_double() {
        validate_inout_array(
            of: Double.self,
            actual: { Surge.sinInPlace(&$0) },
            expected: { $0.map(sin) },
            accuracy: 1e-4
        )
    }

    // MARK: - Cosine

    func test_cos_in_place_float() {
        validate_inout_array(
            of: Float.self,
            actual: { Surge.cosInPlace(&$0) },
            expected: { $0.map(cos) },
            accuracy: 1e-4
        )
    }

    func test_cos_in_place_double() {
        validate_inout_array(
            of: Double.self,
            actual: { Surge.cosInPlace(&$0) },
            expected: { $0.map(cos) },
            accuracy: 1e-4
        )
    }

    // MARK: - Tangent

    func test_tan_in_place_float() {
        validate_inout_array(
            of: Float.self,
            actual: { Surge.tanInPlace(&$0) },
            expected: { $0.map(tan) },
            accuracy: 1e-4
        )
    }

    func test_tan_in_place_double() {
        validate_inout_array(
            of: Double.self,
            actual: { Surge.tanInPlace(&$0) },
            expected: { $0.map(tan) },
            accuracy: 1e-4
        )
    }

//    // MARK: - Arc Sine/Cosine/Tangent

    func test_asin_in_place_float() {
        validate_inout_array(
            of: Float.self,
            actual: { Surge.asinInPlace(&$0) },
            expected: { $0.map(asin) },
            accuracy: 1e-4
        )
    }

    func test_asin_in_place_double() {
        validate_inout_array(
            of: Double.self,
            actual: { Surge.asinInPlace(&$0) },
            expected: { $0.map(asin) },
            accuracy: 1e-4
        )
    }

    // MARK: - Arc Cosine

    func test_acos_in_place_float() {
        validate_inout_array(
            of: Float.self,
            actual: { Surge.acosInPlace(&$0) },
            expected: { $0.map(acos) },
            accuracy: 1e-4
        )
    }

    func test_acos_in_place_double() {
        validate_inout_array(
            of: Double.self,
            actual: { Surge.acosInPlace(&$0) },
            expected: { $0.map(acos) },
            accuracy: 1e-4
        )
    }

    // MARK: - Arc Tangent

    func test_atan_in_place_float() {
        validate_inout_array(
            of: Float.self,
            actual: { Surge.atanInPlace(&$0) },
            expected: { $0.map(atan) },
            accuracy: 1e-4
        )
    }

    func test_atan_in_place_double() {
        validate_inout_array(
            of: Double.self,
            actual: { Surge.atanInPlace(&$0) },
            expected: { $0.map(atan) },
            accuracy: 1e-4
        )
    }

    // MARK: - Hyperbolic Sine

    func test_sinh_in_place_float() {
        validate_inout_array(
            of: Float.self,
            actual: { Surge.sinhInPlace(&$0) },
            expected: { $0.map(sinh) },
            accuracy: 1e-4
        )
    }

    func test_sinh_in_place_double() {
        validate_inout_array(
            of: Double.self,
            actual: { Surge.sinhInPlace(&$0) },
            expected: { $0.map(sinh) },
            accuracy: 1e-4
        )
    }

    // MARK: - Hyperbolic Cosine

    func test_cosh_in_place_float() {
        validate_inout_array(
            of: Float.self,
            actual: { Surge.coshInPlace(&$0) },
            expected: { $0.map(cosh) },
            accuracy: 1e-4
        )
    }

    func test_cosh_in_place_double() {
        validate_inout_array(
            of: Double.self,
            actual: { Surge.coshInPlace(&$0) },
            expected: { $0.map(cosh) },
            accuracy: 1e-4
        )
    }

    // MARK: - Hyperbolic Tangent

    func test_tanh_in_place_float() {
        validate_inout_array(
            of: Float.self,
            actual: { Surge.tanhInPlace(&$0) },
            expected: { $0.map(tanh) },
            accuracy: 1e-4
        )
    }

    func test_tanh_in_place_double() {
        validate_inout_array(
            of: Double.self,
            actual: { Surge.tanhInPlace(&$0) },
            expected: { $0.map(tanh) },
            accuracy: 1e-4
        )
    }

    // MARK: - Inverse Hyperbolic Sine

    func test_asinh_in_place_float() {
        validate_inout_array(
            of: Float.self,
            actual: { Surge.asinhInPlace(&$0) },
            expected: { $0.map(asinh) },
            accuracy: 1e-4
        )
    }

    func test_asinh_in_place_double() {
        validate_inout_array(
            of: Double.self,
            actual: { Surge.asinhInPlace(&$0) },
            expected: { $0.map(asinh) },
            accuracy: 1e-4
        )
    }

    // MARK: - Inverse Hyperbolic Cosine

    func test_acosh_in_place_float() {
        validate_inout_array(
            of: Float.self,
            lhs: Array.monotonicNormalized().map { $0 + 1.0 },
            actual: { Surge.acoshInPlace(&$0) },
            expected: { $0.map(acosh) },
            accuracy: 1e-4
        )
    }

    func test_acosh_in_place_double() {
        validate_inout_array(
            of: Double.self,
            lhs: Array.monotonicNormalized().map { $0 + 1.0 },
            actual: { Surge.acoshInPlace(&$0) },
            expected: { $0.map(acosh) },
            accuracy: 1e-4
        )
    }

    // MARK: - Inverse Hyperbolic Tangent

    func test_atanh_in_place_float() {
        validate_inout_array(
            of: Float.self,
            lhs: Array.monotonicNormalized(to: -0.0...0.5),
            actual: { Surge.atanhInPlace(&$0) },
            expected: { $0.map(atanh) },
            accuracy: 1e-4
        )
    }

    func test_atanh_in_place_double() {
        validate_inout_array(
            of: Double.self,
            lhs: Array.monotonicNormalized(to: -0.0...0.5),
            actual: { Surge.atanhInPlace(&$0) },
            expected: { $0.map(atanh) },
            accuracy: 1e-4
        )
    }
}
