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

// swiftlint:disable nesting

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

    func testSubscriptColumn() {
        XCTAssertEqual(matrix[column: 0], [1, 5, 9])
        XCTAssertEqual(matrix[column: 1], [2, 6, 10])
    }

    func testSetRow() {
        matrix[row: 0] = [13.0, 14.0, 15.0, 16.0]
        let expectedResult: Matrix<Double> = Matrix<Double>([[13, 14, 15, 16], [5, 6, 7, 8], [9, 10, 11, 12]])
        XCTAssertEqual(matrix, expectedResult)
    }

    func testSetColumn() {
        matrix[column: 0] = [20, 30, 40]
        let expectedResult: Matrix<Double> = Matrix<Double>([[20, 2, 3, 4], [30, 6, 7, 8], [40, 10, 11, 12]])
        XCTAssertEqual(matrix, expectedResult)
    }

    func testMatrixPower() {
        let expectedResult = Matrix<Double>([[1, 4, 9, 16], [25, 36, 49, 64], [81, 100, 121, 144]])
        XCTAssertEqual(pow(matrix, 2), expectedResult)
    }

    func testMatrixAddition() {
        let expectedResult: Matrix<Double> = Matrix<Double>([[2, 4, 6, 8], [10, 12, 14, 16], [18, 20, 22, 24]])
        XCTAssertEqual(matrix + matrix, expectedResult)
    }

    func testMatrixSubtraction() {
        let expectedResult: Matrix<Double> = Matrix<Double>([[0, 0, 0, 0], [0, 0, 0, 0], [0, 0, 0, 0]])
        XCTAssertEqual(matrix - matrix, expectedResult)
    }

    func testElementWiseMultiplication() {
        let matrix2 = Matrix<Double>([[2, 3, 4, 5], [6, 7, 8, 9], [10, 11, 12, 13]])
        let expectedResult: Matrix<Double> = Matrix<Double>([[2, 6, 12, 20], [30, 42, 56, 72], [90, 110, 132, 156]])
        XCTAssertEqual(elmul(matrix, matrix2), expectedResult)
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

extension MatrixTests {
    func test_mul_matrix_vector_float() {
        typealias Scalar = Float

        let lhs: Matrix<Scalar> = [
            [1, 2, 3],
            [4, 5, 6],
        ]

        let rhs: Vector<Scalar> = [1, 2, 4]

        let actual = lhs * rhs
        let expected: Vector<Scalar> = [17, 38]

        XCTAssertEqual(actual, expected)
    }

    func test_mul_matrix_vector_double() {
        typealias Scalar = Double

        let lhs: Matrix<Scalar> = [
            [1, 2, 3],
            [4, 5, 6],
        ]

        let rhs: Vector<Scalar> = [1, 2, 4]

        let actual = lhs * rhs
        let expected: Vector<Scalar> = [17, 38]

        XCTAssertEqual(actual, expected)
    }

    func test_mul_vector_matrix_float() {
        typealias Scalar = Float

        let lhs: Vector<Scalar> = [1, 2, 4]

        let rhs: Matrix<Scalar> = [
            [1, 4],
            [2, 5],
            [3, 6],
        ]

        let actual = lhs * rhs
        let expected: Vector<Scalar> = [17, 38]

        XCTAssertEqual(actual, expected)
    }

    func test_mul_vector_matrix_double() {
        typealias Scalar = Double

        let lhs: Vector<Scalar> = [1, 2, 4]

        let rhs: Matrix<Scalar> = [
            [1, 4],
            [2, 5],
            [3, 6],
        ]

        let actual = lhs * rhs
        let expected: Vector<Scalar> = [17, 38]

        XCTAssertEqual(actual, expected)
    }
}
