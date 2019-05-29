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

@testable import Surge
import XCTest

class MatrixTests: XCTestCase {
    let floatAccuracy: Float = 1e-8
    let doubleAccuracy: Double = 1e-11

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

    func testSubscriptRows() {
        let matrix: Matrix<Double> = Matrix<Double>([[1, 2, 3, 4], [5, 6, 7, 8], [9, 10, 11, 12], [13, 14, 15, 16]])
        XCTAssertEqual(matrix[rows: 0..<2], [1, 2, 3, 4, 5, 6, 7, 8])
        XCTAssertEqual(matrix[rows: 0...1], [1, 2, 3, 4, 5, 6, 7, 8])
        XCTAssertEqual(matrix[rows: 1..<3], [5, 6, 7, 8, 9, 10, 11, 12])
    }

    func testSubscriptColumn() {
        XCTAssertEqual(matrix[column: 0], [1, 5, 9])
        XCTAssertEqual(matrix[column: 1], [2, 6, 10])
    }

    func testSetRow() {
        matrix[row: 0] = [13.0, 14.0, 15.0, 16.0]
        XCTAssertTrue(matrix == Matrix<Double>([[13, 14, 15, 16], [5, 6, 7, 8], [9, 10, 11, 12]]))
    }

    func testSetColumn() {
        matrix[column: 0] = [20, 30, 40]
        XCTAssertEqual(matrix, Matrix<Double>([[20, 2, 3, 4], [30, 6, 7, 8], [40, 10, 11, 12]]))
    }

    func testMatrixPower() {
        let expectedResult = Matrix<Double>([[1, 4, 9, 16], [25, 36, 49, 64], [81, 100, 121, 144]])
        XCTAssertEqual(pow(matrix, 2), expectedResult)
    }

    func testMatrixAddition() {
        let expectedResult: Matrix<Double> = Matrix<Double>([[2, 4, 6, 8], [10, 12, 14, 16], [18, 20, 22, 24]])
        XCTAssertEqual(matrix + matrix, expectedResult)
    }

    func testMatrixAdditionWithBroadcasting() {
        let mat: Matrix<Float> = Matrix<Float>([[2, 4, 6, 8], [10, 12, 14, 16], [18, 20, 22, 24]])

        let rowVec: Matrix<Float> = Matrix<Float>([[1, 2, 3, 4]])
        let res1 = addbc(mat, rowVec)
        let exp1: Matrix<Float> = Matrix<Float>([[3, 6, 9, 12], [11, 14, 17, 20], [19, 22, 25, 28]])
        XCTAssertEqual(res1, exp1)

        let colVec: Matrix<Float> = Matrix<Float>([[1], [2], [3]])
        let res2 = addbc(mat, colVec)
        let exp2: Matrix<Float> = Matrix<Float>([[3, 5, 7, 9], [12, 14, 16, 18], [21, 23, 25, 27]])
        XCTAssertEqual(res2, exp2)

        let matD: Matrix<Double> = Matrix<Double>([[2, 4, 6, 8], [10, 12, 14, 16], [18, 20, 22, 24]])

        let rowVecD: Matrix<Double> = Matrix<Double>([[1, 2, 3, 4]])
        let resD1 = addbc(matD, rowVecD)
        let expD1: Matrix<Double> = Matrix<Double>([[3, 6, 9, 12], [11, 14, 17, 20], [19, 22, 25, 28]])
        XCTAssertEqual(resD1, expD1)

        let colVecD: Matrix<Double> = Matrix<Double>([[1], [2], [3]])
        let resD2 = addbc(matD, colVecD)
        let expD2: Matrix<Double> = Matrix<Double>([[3, 5, 7, 9], [12, 14, 16, 18], [21, 23, 25, 27]])
        XCTAssertEqual(resD2, expD2)
    }

    func testMatrixSubtractionWithBroadcasting() {
        let mat: Matrix<Float> = Matrix<Float>([[2, 4, 6, 8], [10, 12, 14, 16], [18, 20, 22, 24]])

        let rowVec: Matrix<Float> = Matrix<Float>([[1, 2, 3, 4]])
        let res1 = subbc(mat, rowVec)
        let exp1: Matrix<Float> = Matrix<Float>([[1, 2, 3, 4], [9, 10, 11, 12], [17, 18, 19, 20]])
        XCTAssertEqual(res1, exp1)

        let colVec: Matrix<Float> = Matrix<Float>([[1], [2], [3]])
        let res2 = subbc(mat, colVec)
        let exp2: Matrix<Float> = Matrix<Float>([[1, 3, 5, 7], [8, 10, 12, 14], [15, 17, 19, 21]])
        XCTAssertEqual(res2, exp2)

        let matD: Matrix<Double> = Matrix<Double>([[2, 4, 6, 8], [10, 12, 14, 16], [18, 20, 22, 24]])

        let rowVecD: Matrix<Double> = Matrix<Double>([[1, 2, 3, 4]])
        let resD1 = subbc(matD, rowVecD)
        let expD1: Matrix<Double> = Matrix<Double>([[1, 2, 3, 4], [9, 10, 11, 12], [17, 18, 19, 20]])
        XCTAssertEqual(resD1, expD1)

        let colVecD: Matrix<Double> = Matrix<Double>([[1], [2], [3]])
        let resD2 = subbc(matD, colVecD)
        let expD2: Matrix<Double> = Matrix<Double>([[1, 3, 5, 7], [8, 10, 12, 14], [15, 17, 19, 21]])
        XCTAssertEqual(resD2, expD2)
    }

    func testMatrixSubtraction() {
        let expectedResult: Matrix<Double> = Matrix<Double>([[0, 0, 0, 0], [0, 0, 0, 0], [0, 0, 0, 0]])
        XCTAssertEqual(matrix - matrix, expectedResult)
    }

    func testElementWiseMultiplication() {
        let matrix2 = Matrix<Double>([[2, 3, 4, 5], [6, 7, 8, 9], [10, 11, 12, 13]])
        XCTAssertEqual(elmul(matrix, matrix2), Matrix<Double>([[2, 6, 12, 20], [30, 42, 56, 72], [90, 110, 132, 156]]))
    }

    func testElementWiseMultiplicationWithBroadcasting() {
        let mat: Matrix<Double> = Matrix<Double>([[2, 4, 6, 8], [10, 12, 14, 16], [18, 20, 22, 24]])

        let rowVec: Matrix<Double> = Matrix<Double>([[1, 2, 2, 4]])
        let res1 = elmulbc(mat, rowVec)
        let exp1: Matrix<Double> = Matrix<Double>([[2, 8, 12, 32], [10, 24, 28, 64], [18, 40, 44, 96]])
        XCTAssertEqual(res1, exp1)

        let colVec: Matrix<Double> = Matrix<Double>([[1], [2], [3]])
        let res2 = elmulbc(mat, colVec)
        let exp2: Matrix<Double> = Matrix<Double>([[2, 4, 6, 8], [20, 24, 28, 32], [54, 60, 66, 72]])
        XCTAssertEqual(res2, exp2)
    }

    func testElementWiseDivision() {
        let matrix1 = Matrix<Double>([[2, 4, 6, 8], [10, 12, 14, 16], [18, 20, 22, 24]])
        let matrix2 = Matrix<Double>([[2, 2, 2, 4], [4, 3, 14, 8], [9, 5, 11, 24]])
        let res = eldiv(matrix1, matrix2)
        let exp = Matrix<Double>([[1, 2, 3, 2], [2.5, 4, 1, 2], [2, 4, 2, 1]])
        XCTAssertEqual(res, exp)
    }

    func testElementWiseDivisionWithBroadcasting() {
        let mat: Matrix<Double> = Matrix<Double>([[2, 4, 6, 8], [10, 12, 14, 16], [18, 20, 22, 24]])

        let rowVec: Matrix<Double> = Matrix<Double>([[1, 2, 2, 4]])
        let res1 = eldivbc(mat, rowVec)
        let exp1: Matrix<Double> = Matrix<Double>([[2, 2, 3, 2], [10, 6, 7, 4], [18, 10, 11, 6]])
        XCTAssertEqual(res1, exp1)

        let colVec: Matrix<Double> = Matrix<Double>([[1], [2], [3]])
        let res2 = eldivbc(mat, colVec)
        let exp2: Matrix<Double> = Matrix<Double>([[2, 4, 6, 8], [5, 6, 7, 8], [6, Double(20)/3, Double(22)/3, 8]])
        XCTAssertEqual(res2, exp2)
    }

    func testDeterminantFloat() {
        let matrix = Matrix<Float>([[1, 2], [5, 6]])
        XCTAssertEqual(det(matrix)!, Float(6 - 10), accuracy: floatAccuracy)
    }

    func testDeterminantDouble() {
        let matrix = Matrix<Double>([[-4, -5], [5, 6]])
        XCTAssertEqual(det(matrix)!, Double(-24 + 25), accuracy: doubleAccuracy)
    }

    func testMultiplyEmpty() {
        let x = Matrix<Float>([[1]])
        let y = Matrix<Float>([[]])
        let result = x*y

        XCTAssertEqual(result.rows, 1)
        XCTAssertEqual(result.columns, 0)
    }

    func complexVectorMatches<T: FloatingPoint>(_ a: [(T, T)], _ b: [(T, T)], accuracy: T) -> Bool {
        guard a.count == b.count else {
            return false
        }
        return (zip(a, b).first { a, e -> Bool in
            !(abs(a.0 - e.0) < accuracy && abs(a.1 - e.1) < accuracy)
        }) == nil
    }

    func testEigenDecompositionTrivialGeneric<T: FloatingPoint & ExpressibleByFloatLiteral>(defaultAccuracy: T, eigendecompostionFn: ((Matrix<T>) throws -> MatrixEigenDecompositionResult<T>)) throws {
        let matrix = Matrix<T>([
            [1, 0, 0],
            [0, 2, 0],
            [0, 0, 3],
        ])
        let ed = try eigendecompostionFn(matrix)

        let expectedEigenValues: [(T, T)] = [(1, 0), (2, 0), (3, 0)]
        XCTAssertTrue(complexVectorMatches(ed.eigenValues, expectedEigenValues, accuracy: defaultAccuracy))

        let expectedEigenVector: [(T, T)] = [(1, 0), (0, 0), (0, 0), (0, 0), (1, 0), (0, 0), (0, 0), (0, 0), (1, 0)]
        let flatLeft = ed.leftEigenVectors.flatMap { $0 }
        XCTAssertTrue(complexVectorMatches(flatLeft, expectedEigenVector, accuracy: defaultAccuracy))

        let flatRight = ed.rightEigenVectors.flatMap { $0 }
        XCTAssertTrue(complexVectorMatches(flatRight, expectedEigenVector, accuracy: defaultAccuracy))
    }

    func testEigenDecompositionTrivial() throws {
        try testEigenDecompositionTrivialGeneric(defaultAccuracy: doubleAccuracy) { (m: Matrix<Double>) throws -> MatrixEigenDecompositionResult<Double> in
            try eigenDecompose(m)
        }
        try testEigenDecompositionTrivialGeneric(defaultAccuracy: floatAccuracy) { (m: Matrix<Float>) throws -> MatrixEigenDecompositionResult<Float> in
            try eigenDecompose(m)
        }
    }

    // Example from https://docs.scipy.org/doc/numpy/reference/generated/numpy.linalg.eig.html
    func testEigenDecompositionComplexResultsNumpyExampleGeneric<T: FloatingPoint & ExpressibleByFloatLiteral>(defaultAccuracy: T, eigendecompostionFn: ((Matrix<T>) throws -> MatrixEigenDecompositionResult<T>)) throws {
        let matrix = Matrix<T>([
            [1, -1],
            [1, 1],
        ])
        let ed = try eigendecompostionFn(matrix)

        let expectedEigenValues: [(T, T)] = [(1, 1), (1, -1)]
        XCTAssertTrue(complexVectorMatches(ed.eigenValues, expectedEigenValues, accuracy: defaultAccuracy))

        let expectedEigenVector: [(T, T)] = [(0.707_106_78, 0), (0.707_106_78, 0), (0, -0.707_106_78), (0, 0.707_106_78)]

        // Numpy only gives the right eigenvector
        let flatRight = ed.rightEigenVectors.flatMap { $0 }
        XCTAssertTrue(complexVectorMatches(flatRight, expectedEigenVector, accuracy: 0.000_001))
    }

    func testEigenDecompositionComplexResultsNumpyExample() throws {
        try testEigenDecompositionComplexResultsNumpyExampleGeneric(defaultAccuracy: doubleAccuracy) { (m: Matrix<Double>) throws -> MatrixEigenDecompositionResult<Double> in
            try eigenDecompose(m)
        }
        try testEigenDecompositionComplexResultsNumpyExampleGeneric(defaultAccuracy: floatAccuracy) { (m: Matrix<Float>) throws -> MatrixEigenDecompositionResult<Float> in
            try eigenDecompose(m)
        }
    }

    // Example from Intel's DGEEV documentation
    // https://software.intel.com/sites/products/documentation/doclib/mkl_sa/11/mkl_lapack_examples/dgeev.htm
    func testEigenDecompositionComplexResultsDGEEVExampleGeneric<T: FloatingPoint & ExpressibleByFloatLiteral>(defaultAccuracy: T, eigendecompostionFn: ((Matrix<T>) throws -> MatrixEigenDecompositionResult<T>)) throws {
        let matrix = Matrix<T>(rows: 5, columns: 5, grid: [
            -1.01, 0.86, -4.60, 3.31, -4.81,
            3.98, 0.53, -7.04, 5.29, 3.55,
            3.30, 8.26, -3.89, 8.20, -1.51,
            4.43, 4.96, -7.66, -7.33, 6.18,
            7.31, -6.43, -6.16, 2.47, 5.58
        ])
        let ed = try eigendecompostionFn(matrix)

        let expectedEigenValues: [(T, T)] = [(2.86, 10.76), (2.86, -10.76), (-0.69, 4.70), (-0.69, -4.70), (-10.46, 0)]
        XCTAssertTrue(complexVectorMatches(ed.eigenValues, expectedEigenValues, accuracy: 0.02))

        let expectedLeftEigenVectors: [[(T, T)]] = [
            [(0.04, 0.29), (0.04, -0.29), (-0.13, -0.33), (-0.13, 0.33), (0.04, 0)],
            [(0.62, 0.00), (0.62, 0.00), (0.69, 0.00), (0.69, 0.00), (0.56, 0)],
            [(-0.04, -0.58), (-0.04, 0.58), (-0.39, -0.07), (-0.39, 0.07), (-0.13, 0)],
            [(0.28, 0.01), (0.28, -0.01), (-0.02, -0.19), (-0.02, 0.19), (-0.80, 0)],
            [(-0.04, 0.34), (-0.04, -0.34), (-0.40, 0.22), (-0.40, -0.22), (0.18, 0)],
        ]
        XCTAssertEqual(ed.leftEigenVectors.count, expectedLeftEigenVectors.count)
        for i in 0..<ed.leftEigenVectors.count {
            XCTAssertTrue(complexVectorMatches(ed.leftEigenVectors[i], expectedLeftEigenVectors[i], accuracy: 0.02))
        }

        let expectedRightEigenVectors: [[(T, T)]] = [
            [(0.11, 0.17), (0.11, -0.17), (0.73, 0.00), (0.73, 0.00), (0.46, 0.0)],
            [(0.41, -0.26), (0.41, 0.26), (-0.03, -0.02), (-0.03, 0.02), (0.34, 0.0)],
            [(0.10, -0.51), (0.10, 0.51), (0.19, -0.29), (0.19, 0.29), (0.31, 0.0)],
            [(0.40, -0.09), (0.40, 0.09), (-0.08, -0.08), (-0.08, 0.08), (-0.74, 0.0)],
            [(0.54, 0.00), (0.54, 0.00), (-0.29, -0.49), (-0.29, 0.49), (0.16, 0.0)],
        ]
        XCTAssertEqual(ed.rightEigenVectors.count, expectedRightEigenVectors.count)
        for i in 0..<ed.rightEigenVectors.count {
            XCTAssertTrue(complexVectorMatches(ed.rightEigenVectors[i], expectedRightEigenVectors[i], accuracy: 0.02))
        }
    }

    func testEigenDecompositionComplexResultsDGEEVExample() throws {
        try testEigenDecompositionComplexResultsDGEEVExampleGeneric(defaultAccuracy: doubleAccuracy) { (m: Matrix<Double>) throws -> MatrixEigenDecompositionResult<Double> in
            try eigenDecompose(m)
        }
        try testEigenDecompositionComplexResultsDGEEVExampleGeneric(defaultAccuracy: floatAccuracy) { (m: Matrix<Float>) throws -> MatrixEigenDecompositionResult<Float> in
            try eigenDecompose(m)
        }
    }

    func testEigenDecomposeThrowsWhenNotSquare() throws {
        let matrix = Matrix<Double>([
            [1, 0, 0],
            [0, 2, 0],
        ])

        XCTAssertThrowsError(try eigenDecompose(matrix), "not square") { e in
            XCTAssertEqual(e as? EigenDecompositionError, EigenDecompositionError.matrixNotSquare)
        }
    }
}
