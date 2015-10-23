// Copyright (c) 2014–2015 Mattt Thompson (http://mattt.me)
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
import Upsurge
import XCTest

class ArithmeticTests: XCTestCase {
    let n = 100000

    func test_sum_complex() {
        let values = (0...n).map{ _ in
            Complex(
                real: Real(arc4random()) - Real(UInt32.max)/2,
                imag: Real(arc4random()) - Real(UInt32.max)/2)
        }

        var expected = Complex()
        for v in values {
            expected.real += v.real
            expected.imag += v.imag
        }

        var actual = Complex()
        self.measureBlock {
            actual = sum(values)
        }
        
        XCTAssertEqualWithAccuracy(actual.real, expected.real, accuracy: 0.0001)
        XCTAssertEqualWithAccuracy(actual.imag, expected.imag, accuracy: 0.0001)
    }

    func test_sqrt() {
        let values = (0...n).map{_ in Real(arc4random())}
        measureAndValidateMappedFunctionWithAccuracy(values, member: { return sqrt($0) }, mapped: { $0.map{ sqrt($0) } }, accuracy: 0.0001)
    }
}
