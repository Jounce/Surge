// Created by Wenbin Zhang on 2/13/16.
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

import XCTest
@testable import Surge

class MatrixTests: XCTestCase {

    var matrix: Matrix<Double> = Matrix<Double>([[1, 2, 3, 4], [5, 6, 7, 8], [9, 10, 11, 12]])

    func testInit() {
        let m1 = Matrix([[1.0, 2.0]])
        XCTAssertEqual(m1.grid, [1.0, 2.0])

        let m2 = Matrix([[1, 1], [1, -1]])
        XCTAssertEqual(m2.grid, [1, 1, 1, -1])
    }

    func testSubscriptRow() {
        XCTAssertEqual(matrix[row: 0], [1, 2, 3, 4])
        XCTAssertEqual(matrix[row: 1], [5, 6, 7, 8])
    }

    func testSubscriptColumn() {
        XCTAssertEqual(matrix[column: 0], [1, 5, 9])
        XCTAssertEqual(matrix[column: 1], [2, 6, 10])
    }

    func testSetRow() {
        matrix[row: 0] = [13.0, 14.0, 15.0, 16.0]
        XCTAssertTrue(matrix==Matrix<Double>([[13, 14, 15, 16], [5, 6, 7, 8], [9, 10, 11, 12]]))
    }

    func testSetColumn() {
        matrix[column: 0] = [20, 30, 40]
        XCTAssertEqual(matrix, Matrix<Double>([[20, 2, 3, 4], [30, 6, 7, 8], [40, 10, 11, 12]]))
    }

    func testMatrixPower() {
        let expectedResult = Matrix<Double>([[1, 4, 9, 16], [25, 36, 49, 64], [81, 100, 121, 144]])
        XCTAssertEqual(pow(matrix, 2), expectedResult)
    }

    func testElementWiseMultiplication() {
        let matrix2 = Matrix<Double>([[2, 3, 4, 5], [6, 7, 8, 9], [10, 11, 12, 13]])
        XCTAssertEqual(elmul(matrix, matrix2), Matrix<Double>([[2, 6, 12, 20], [30, 42, 56, 72], [90, 110, 132, 156]]))
    }
}
