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

@testable import Upsurge
import XCTest

class ArithmeticTests: XCTestCase {
    let n = 10000

    func testSumArray() {
        let values = (0...n).map{ _ in
            Real(arc4random()) - Real(UInt32.max)/2
        }
        let array = [Real](values)

        var expected = Real()
        for v in array {
            expected += v
        }

        var actual: Real = 0.0
        self.measureBlock {
            actual = sum(array)
        }

        XCTAssertEqualWithAccuracy(actual, expected, accuracy: 0.0001)
    }

    func testSumRealArray() {
        let values = (0...n).map{ _ in
            Real(arc4random()) - Real(UInt32.max)/2
        }
        let array = RealArray(values)

        var expected = Real()
        for v in array {
            expected += v
        }

        var actual: Real = 0.0
        self.measureBlock {
            actual = sum(array)
        }

        XCTAssertEqualWithAccuracy(actual, expected, accuracy: 0.0001)
    }

    func testMeanSlice() {
        let a1: RealArray = [1.0, 1.0, 2.0, 2.0, 3.0, 3.0]
        let s1 = RealArraySlice(base: a1, startIndex: 0, endIndex: a1.count, step: 2)
        let r = mean(s1)
        XCTAssertEqual(r, 2.0)
    }

    func testSqrt() {
        let values = (0...n).map{_ in Real(arc4random())}
        measureAndValidateMappedFunctionWithAccuracy(values, member: { return sqrt($0) }, mapped: { $0.map{ sqrt($0) } }, accuracy: 0.0001)
    }

    func testAdd() {
        let a1: RealArray = [1.0, 2.0, 3.0]
        let a2: RealArray = [3.0, 2.0, 1.0, 0.0, -1.0]
        let r = a1 + a2
        XCTAssertEqual(r.count, 3)
        for v in r {
            XCTAssertEqual(v, 4.0)
        }
    }

    func testSub() {
      let a1: RealArray = [5.0, 4.0, 3.0, 2.0]
      let a2: RealArray = [4.0, 3.0, 2.0, 1.0]
      let r = a1 - a2
      XCTAssertEqual(r.count, 4)
      for v in r {
        XCTAssertEqual(v, 1.0)
      }
    }

    func testSubAssign() {
      var a1: RealArray = [5.0, 4.0, 3.0, 2.0]
      let a2: RealArray = [4.0, 3.0, 2.0, 1.0]
      a1 -= a2
      XCTAssertEqual(a1.count, 4)
      for v in a1 {
        XCTAssertEqual(v, 1.0)
      }
    }

    func testAddSlice() {
        let a1: RealArray = [1.0, 1.0, 2.0, 2.0, 3.0, 3.0]
        let s1 = RealArraySlice(base: a1, startIndex: 0, endIndex: a1.count, step: 2)

        let a2: RealArray = [3.0, 2.0, 1.0, 0.0, -1.0]

        let r = s1 + a2
        XCTAssertEqual(r.count, 3)
        for v in r {
            XCTAssertEqual(v, 4.0)
        }
    }
  
  func testStd() {
        let a1: RealArray = [2.0, 4.0, 4.0, 4.0, 5.0, 5.0, 7.0, 9.0]
        let r = std(a1)
        XCTAssertEqual(r, 2.0)
  }

  func testLinregress() {
        let a1: RealArray = [1.0, 2.0, 3.0, 4.0, 5.0]
        let (slope, intercept) = linregress(a1, a1)
        XCTAssertEqual(slope, 1.0)
        XCTAssertEqual(intercept, 0.0)  }
}
