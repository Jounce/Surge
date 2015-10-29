// Copyright © 2015 Venture Media Labs.
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

class RealMatrixTests: XCTestCase {
    func testAdd() {
        let a = RealMatrix(rows: 2, columns: 2, elements: [1, 2, 3, 4])
        let b = RealMatrix(rows: 2, columns: 2, elements: [2, 3, 4, 1])
        let c = a + b
        a += b

        let d = RealMatrix(rows: 2, columns: 2, elements: [3, 5, 7, 5])

        XCTAssert(a.elements == c.elements)
        XCTAssert(a.elements == d.elements)
    }

    func testSub() {
        var a = RealMatrix(rows: 2, columns: 2, elements: [1, 2, 3, 4])
        let b = RealMatrix(rows: 2, columns: 2, elements: [2, 3, 4, 1])
        let c = a - b
        a -= b

        let d = RealMatrix(rows: 2, columns: 2, elements: [-1, -1, -1, 3])

        XCTAssert(a.elements == c.elements)
        XCTAssert(a.elements == d.elements)
    }

    func testMult() {
        var a = RealMatrix(rows: 2, columns: 2, elements: [1, 2, 3, 4])
        let b = RealMatrix(rows: 2, columns: 2, elements: [2, 3, 4, 5])
        let c = a * b

        let d = RealMatrix(rows: 2, columns: 2, elements: [10, 13, 22, 29])
        
        XCTAssert(c.elements == d.elements)

        a *= b
        XCTAssert(c.elements == a.elements)
    }

    func testMultiplyWithColumn() {
        let v = RealArray([2, 3, 4, 5, 6])
        let m = RealMatrix([[1, 2, 3, 4, 5]])
        let c = v.toColumnMatrix() * m

        let d = RealMatrix([[2, 4, 6, 8, 10], [3, 6, 9, 12, 15], [4, 8, 12, 16, 20], [5, 10, 15, 20, 25], [6, 12, 18, 24, 30]])

        XCTAssert(c.elements == d.elements)
    }

    func testMultiplyWithRow() {
        let m = RealMatrix([[1], [2], [3], [4], [5]])
        let v = RealArray([2, 3, 4, 5, 6])
        let c = v.toRowMatrix() * m

        let d = RealMatrix([[70]])

        XCTAssert(c.elements == d.elements)
    }

    func testPostMultiplyWithColumn() {
        let m = RealMatrix([[1, 2, 3, 4, 5], [6, 7, 8, 9, 10]])
        let v = RealArray([2, 3, 4, 5, 6])
        let c = m * v.toColumnMatrix()

        let d = RealMatrix([[70], [170]])

        XCTAssert(c.elements == d.elements)
    }

    func testPostMultiplyWithRow() {
        let m = RealMatrix([[1], [2], [3], [4], [5]])
        let v = RealArray([2, 3, 4, 5, 6])
        let c = m * v.toRowMatrix()

        let d = RealMatrix([[2, 3, 4, 5, 6], [4, 6, 8, 10, 12], [6, 9, 12, 15, 18], [8, 12, 16, 20, 24], [10, 15, 20, 25, 30]])

        XCTAssert(c.elements == d.elements)
    }

    func testTranspose() {
        let a = RealMatrix(rows: 2, columns: 2, elements: [1, 2, 3, 4])
        let c = a′

        XCTAssert(a.elements == c′.elements)
    }

    func testInvert() {
        let a = RealMatrix(rows: 2, columns: 2, elements: [2, 6, -2, 4])
        let b = inv(a)

        let c = RealMatrix(rows: 2, columns: 2, elements: [0.2, -0.3, 0.1, 0.1])

        XCTAssertEqualWithAccuracy(c.elements[0], b.elements[0], accuracy: 0.00001)
        XCTAssertEqualWithAccuracy(c.elements[1], b.elements[1], accuracy: 0.00001)
        XCTAssertEqualWithAccuracy(c.elements[2], b.elements[2], accuracy: 0.00001)
        XCTAssertEqualWithAccuracy(c.elements[3], b.elements[3], accuracy: 0.00001)
    }

    func testSwap() {
        var a = RealMatrix([[1, 2, 3], [4, 5, 6]])
        var b = RealMatrix([[4, 3], [2, 1]])
        swap(&a, &b)

        XCTAssertEqual(a.columns, 2)
        XCTAssertEqual(a[0, 0], 4)
        XCTAssertEqual(b.columns, 3)
        XCTAssertEqual(b[0, 0], 1)
    }
}
