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
import Surge
import XCTest

class TrigonometricTests: XCTestCase {
    let n = 10_000

    func test_sin() {
        let values = (0...n).map { _ in drand48() * Double.pi }
        measureAndValidateMappedFunctionWithAccuracy(source: values, member: sin, mapped: sin, accuracy: 1e-4)
    }

    func test_cos() {
        let values = (0...n).map { _ in drand48() * Double.pi }
        measureAndValidateMappedFunctionWithAccuracy(source: values, member: cos, mapped: cos, accuracy: 1e-4)
    }

    func test_tan() {
        let values = (0...n).map { _ in drand48() * Double.pi }
        measureAndValidateMappedFunctionWithAccuracy(source: values, member: tan, mapped: tan, accuracy: 1e-4)
    }

    func test_asin() {
        let values = (0...n).map { _ in drand48() }
        measureAndValidateMappedFunctionWithAccuracy(source: values, member: asin, mapped: asin, accuracy: 1e-4)
    }

    func test_acos() {
        let values = (0...n).map { _ in drand48() }
        measureAndValidateMappedFunctionWithAccuracy(source: values, member: acos, mapped: acos, accuracy: 1e-4)
    }

    func test_atan() {
        let values = (0...n).map { _ in drand48() }
        measureAndValidateMappedFunctionWithAccuracy(source: values, member: atan, mapped: atan, accuracy: 1e-4)
    }
}
