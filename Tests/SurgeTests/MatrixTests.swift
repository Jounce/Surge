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

// swiftlint:disable nesting type_body_length

class MatrixTests: XCTestCase {
    let floatAccuracy: Float = 1e-8
    let doubleAccuracy: Double = 1e-11

    let matrixFloat: Matrix<Float> = [
        [Float(1.0), 2, 3, 4],
        [5, 6, 7, 8],
        [9, 10, 11, 12],
    ]
    let matrixDouble: Matrix<Double> = [
        [1, 2, 3, 4],
        [5, 6, 7, 8],
        [9, 10, 11, 12],
    ]

    func getMatrix() -> Matrix<Float> {
        return self.matrixFloat
    }

    func getMatrix() -> Matrix<Double> {
        return self.matrixDouble
    }

    func test_init() {
        let m1 = Matrix([[1.0, 2.0]])
        XCTAssertEqual(m1.grid, [1.0, 2.0])

        let m2 = Matrix([[1, 1], [1, -1]])
        XCTAssertEqual(m2.grid, [1, 1, 1, -1])
    }

    func test_subscript_row_get() {
        XCTAssertEqual(matrixDouble[row: 0], [1, 2, 3, 4])
        XCTAssertEqual(matrixDouble[row: 1], [5, 6, 7, 8])
    }

    func test_subscript_column_get() {
        XCTAssertEqual(matrixDouble[column: 0], [1, 5, 9])
        XCTAssertEqual(matrixDouble[column: 1], [2, 6, 10])
    }

    func test_subscript_row_set() {
        typealias Scalar = Double

        var matrix: Matrix<Scalar> = getMatrix()

        matrix[row: 0] = [13.0, 14.0, 15.0, 16.0]

        let expected: Matrix<Scalar> = [
            [13, 14, 15, 16],
            [5, 6, 7, 8],
            [9, 10, 11, 12],
        ]

        XCTAssertEqual(matrix, expected)
    }

    func test_subscript_column_set() {
        typealias Scalar = Double

        var matrix: Matrix<Scalar> = getMatrix()

        matrix[column: 0] = [20, 30, 40]

        let expected: Matrix<Scalar> = [
            [20, 2, 3, 4],
            [30, 6, 7, 8],
            [40, 10, 11, 12],
        ]

        XCTAssertEqual(matrix, expected)
    }

//    func test_pow() {
//        let expectedResult = Matrix<Double>([[1, 4, 9, 16], [25, 36, 49, 64], [81, 100, 121, 144]])
//        XCTAssertEqual(pow(matrix, 2), expectedResult)
//    }

    func test_add_matrix_matrix_float() {
        typealias Scalar = Float

        let matrix: Matrix<Scalar> = getMatrix()

        let expected: Matrix<Float> = [
            [2, 4, 6, 8],
            [10, 12, 14, 16],
            [18, 20, 22, 24],
        ]

        XCTAssertEqual(matrix + matrix, expected)
    }

    func test_add_matrix_matrix_double() {
        typealias Scalar = Double

        let matrix: Matrix<Scalar> = getMatrix()

        let expected: Matrix<Scalar> = [
            [2, 4, 6, 8],
            [10, 12, 14, 16],
            [18, 20, 22, 24],
        ]

        XCTAssertEqual(matrix + matrix, expected)
    }

    func test_sub_matrix_matrix_float() {
        typealias Scalar = Float

        let matrix: Matrix<Scalar> = getMatrix()

        let expected: Matrix<Float> = [
            [0, 0, 0, 0],
            [0, 0, 0, 0],
            [0, 0, 0, 0],
        ]

        XCTAssertEqual(matrix - matrix, expected)
    }

    func test_sub_matrix_matrix_double() {
        typealias Scalar = Double

        let matrix: Matrix<Scalar> = getMatrix()

        let expected: Matrix<Scalar> = [
            [0, 0, 0, 0],
            [0, 0, 0, 0],
            [0, 0, 0, 0],
        ]

        XCTAssertEqual(matrix - matrix, expected)
    }

    func test_mul_scalar_matrix_float() {
        typealias Scalar = Float

        let lhs: Scalar = 2

        let rhs: Matrix<Scalar> = [
            [2, 4, 6],
            [10, 12, 14],
        ]

        let expected: Matrix<Scalar> = [
            [4, 8, 12],
            [20, 24, 28],
        ]

        XCTAssertEqual(lhs * rhs, expected)
    }

    func test_mul_scalar_matrix_double() {
        typealias Scalar = Double

        let lhs: Scalar = 2

        let rhs: Matrix<Scalar> = [
            [2, 4, 6],
            [10, 12, 14],
        ]

        let expected: Matrix<Scalar> = [
            [4, 8, 12],
            [20, 24, 28],
        ]

        XCTAssertEqual(lhs * rhs, expected)
    }

    func test_mul_matrix_matrix_float() {
        typealias Scalar = Float

        let lhs: Matrix<Scalar> = [
            [2, 4],
            [10, 12],
            [18, 20],
        ]

        let rhs: Matrix<Scalar> = [
            [2, 4, 6],
            [10, 12, 14],
        ]

        let expected: Matrix<Scalar> = [
            [44, 56, 68],
            [140, 184, 228],
            [236, 312, 388],
        ]

        XCTAssertEqual(lhs * rhs, expected)
    }

    func test_mul_matrix_matrix_double() {
        typealias Scalar = Double

        let lhs: Matrix<Scalar> = [
            [2, 4],
            [10, 12],
            [18, 20],
        ]

        let rhs: Matrix<Scalar> = [
            [2, 4, 6],
            [10, 12, 14],
        ]

        let expected: Matrix<Scalar> = [
            [44, 56, 68],
            [140, 184, 228],
            [236, 312, 388],
        ]

        XCTAssertEqual(lhs * rhs, expected)
    }

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

    func test_div_matrix_scalar_float() {
        typealias Scalar = Float

        let lhs: Matrix<Scalar> = [
            [2, 4, 6],
            [10, 12, 14],
        ]

        let rhs: Scalar = 2

        let expected: Matrix<Scalar> = [
            [1, 2, 3],
            [5, 6, 7],
        ]

        XCTAssertEqual(lhs / rhs, expected, accuracy: 1e-6)
    }

    func test_div_matrix_scalar_double() {
        typealias Scalar = Double

        let lhs: Matrix<Scalar> = [
            [2, 4, 6],
            [10, 12, 14],
        ]

        let rhs: Scalar = 2

        let expected: Matrix<Scalar> = [
            [1, 2, 3],
            [5, 6, 7],
        ]

        XCTAssertEqual(lhs / rhs, expected, accuracy: 1e-8)
    }

    func test_div_matrix_matrix_float() {
        typealias Scalar = Float

        let lhs: Matrix<Scalar> = [
            [2, 3],
            [2, 2],
        ]

        let rhs: Matrix<Scalar> = [
            [-1, 3/2],
            [1, -1],
        ]

        let expected: Matrix<Scalar> = [
            [10, 12],
            [8, 10],
        ]

        XCTAssertEqual(lhs / rhs, expected, accuracy: 1e-5)
    }

    func test_div_matrix_matrix_double() {
        typealias Scalar = Double

        let lhs: Matrix<Scalar> = [
            [2, 3],
            [2, 2],
        ]

        let rhs: Matrix<Scalar> = [
            [-1, 3/2],
            [1, -1],
        ]

        let expected: Matrix<Scalar> = [
            [10, 12],
            [8, 10],
        ]

        XCTAssertEqual(lhs / rhs, expected, accuracy: 1e-8)
    }

    func test_pow_matrix_scalar_float() {
        typealias Scalar = Float

        let lhs: Matrix<Scalar> = [
            [1, 2, 3],
            [4, 5, 6],
        ]

        let rhs: Scalar = 2

        let expected: Matrix<Scalar> = .init(
            lhs.map { row in
                row.map { pow($0, rhs) }
            }
        )

        XCTAssertEqual(pow(lhs, rhs), expected, accuracy: 1e-5)
    }

    func test_pow_matrix_scalar_double() {
        typealias Scalar = Double

        let lhs: Matrix<Scalar> = [
            [1, 2, 3],
            [4, 5, 6],
        ]

        let rhs: Scalar = 2

        let expected: Matrix<Scalar> = .init(
            lhs.map { row in
                row.map { pow($0, rhs) }
            }
        )

        XCTAssertEqual(pow(lhs, rhs), expected, accuracy: 1e-8)
    }

    func test_exp_matrix_float() {
        typealias Scalar = Float

        let lhs: Matrix<Scalar> = [
            [1, 2, 3],
            [4, 5, 6],
        ]

        let expected: Matrix<Scalar> = .init(
            lhs.map { row in
                row.map { exp($0) }
            }
        )

        XCTAssertEqual(exp(lhs), expected, accuracy: 1e-5)
    }

    func test_exp_matrix_double() {
        typealias Scalar = Double

        let lhs: Matrix<Scalar> = [
            [1, 2, 3],
            [4, 5, 6],
        ]

        let expected: Matrix<Scalar> = .init(
            lhs.map { row in
                row.map { exp($0) }
            }
        )

        XCTAssertEqual(exp(lhs), expected, accuracy: 1e-8)
    }

    func test_sum_matrix_rows_float() {
        typealias Scalar = Float

        let lhs: Matrix<Scalar> = [
            [1, 2, 3],
            [4, 5, 6],
        ]

        let expected: Matrix<Scalar> = [
            [6],
            [15],
        ]

        XCTAssertEqual(sum(lhs, axies: .row), expected, accuracy: 1e-5)
    }

    func test_sum_matrix_columns_float() {
        typealias Scalar = Float

        let lhs: Matrix<Scalar> = [
            [1, 2, 3],
            [4, 5, 6],
        ]

        let expected: Matrix<Scalar> = [
            [5, 7, 9],
        ]

        XCTAssertEqual(sum(lhs, axies: .column), expected, accuracy: 1e-5)
    }

    func test_inv_matrix_double() {
        typealias Scalar = Double

        let lhs: Matrix<Scalar> = [
            [2, 3],
            [2, 2],
        ]

        let expected: Matrix<Scalar> = [
            [-1, 1.5],
            [1, -1],
        ]

        XCTAssertEqual(inv(lhs), expected, accuracy: 1e-8)
    }

    func test_inv_matrix_float() {
        typealias Scalar = Float

        let lhs: Matrix<Scalar> = [
            [2, 3],
            [2, 2],
        ]

        let expected: Matrix<Scalar> = [
            [-1, 1.5],
            [1, -1],
        ]

        XCTAssertEqual(inv(lhs), expected, accuracy: 1e-6)
    }

    func test_tranpose_matrix_double() {
        typealias Scalar = Double

        let lhs: Matrix<Scalar> = [
            [1, 2, 3],
            [4, 5, 6],
        ]

        let expected: Matrix<Scalar> = [
            [1, 4],
            [2, 5],
            [3, 6],
        ]

        XCTAssertEqual(transpose(lhs), expected)
    }

    func test_tranpose_matrix_float() {
        typealias Scalar = Float

        let lhs: Matrix<Scalar> = [
            [1, 2, 3],
            [4, 5, 6],
        ]

        let expected: Matrix<Scalar> = [
            [1, 4],
            [2, 5],
            [3, 6],
        ]

        XCTAssertEqual(transpose(lhs), expected)
    }

    func test_det_matrix_double() {
        typealias Scalar = Double

        let lhs: Matrix<Scalar> = [
            [1, 2],
            [5, 6],
        ]

        let expected: Scalar = 6 - 10

        XCTAssertEqual(det(lhs), expected)
    }

    func test_det_matrix_float() {
        typealias Scalar = Float

        let lhs: Matrix<Scalar> = [
            [1, 2],
            [5, 6],
        ]

        let expected: Scalar = 6 - 10

        XCTAssertEqual(det(lhs), expected)
    }

    func test_mul_empty_float() {
        typealias Scalar = Float

        let x: Matrix<Scalar> = [
            [1]
        ]
        let y: Matrix<Scalar> = [
            []
        ]

        let result = x * y

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

    func eigen_decomposition_trivial_generic<T: FloatingPoint & ExpressibleByFloatLiteral>(defaultAccuracy: T, eigendecompostionFn: ((Matrix<T>) throws -> MatrixEigenDecompositionResult<T>)) throws {
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

    func test_eigen_decomposition_trivial() throws {
        try eigen_decomposition_trivial_generic(defaultAccuracy: doubleAccuracy) { (m: Matrix<Double>) throws -> MatrixEigenDecompositionResult<Double> in
            try eigenDecompose(m)
        }
        try eigen_decomposition_trivial_generic(defaultAccuracy: floatAccuracy) { (m: Matrix<Float>) throws -> MatrixEigenDecompositionResult<Float> in
            try eigenDecompose(m)
        }
    }

    // Example from https://docs.scipy.org/doc/numpy/reference/generated/numpy.linalg.eig.html
    func eigen_decomposition_complex_results_numpy_example_generic<T: FloatingPoint & ExpressibleByFloatLiteral>(defaultAccuracy: T, eigendecompostionFn: ((Matrix<T>) throws -> MatrixEigenDecompositionResult<T>)) throws {
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

    func test_eigen_decomposition_complex_results_numpy_example() throws {
        try eigen_decomposition_complex_results_numpy_example_generic(defaultAccuracy: doubleAccuracy) { (m: Matrix<Double>) throws -> MatrixEigenDecompositionResult<Double> in
            try eigenDecompose(m)
        }
        try eigen_decomposition_complex_results_numpy_example_generic(defaultAccuracy: floatAccuracy) { (m: Matrix<Float>) throws -> MatrixEigenDecompositionResult<Float> in
            try eigenDecompose(m)
        }
    }

    // Example from Intel's DGEEV documentation
    // https://software.intel.com/sites/products/documentation/doclib/mkl_sa/11/mkl_lapack_examples/dgeev.htm
    func eigen_decomposition_complex_results_dgeev_example_generic<T: FloatingPoint & ExpressibleByFloatLiteral>(defaultAccuracy: T, eigendecompostionFn: ((Matrix<T>) throws -> MatrixEigenDecompositionResult<T>)) throws {
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

    func test_eigen_decomposition_complex_results_dgeev_example() throws {
        try eigen_decomposition_complex_results_dgeev_example_generic(defaultAccuracy: doubleAccuracy) { (m: Matrix<Double>) throws -> MatrixEigenDecompositionResult<Double> in
            try eigenDecompose(m)
        }
        try eigen_decomposition_complex_results_dgeev_example_generic(defaultAccuracy: floatAccuracy) { (m: Matrix<Float>) throws -> MatrixEigenDecompositionResult<Float> in
            try eigenDecompose(m)
        }
    }

    func test_eigen_decompose_throws_when_not_square() throws {
        let matrix = Matrix<Double>([
            [1, 0, 0],
            [0, 2, 0],
        ])

        XCTAssertThrowsError(try eigenDecompose(matrix), "not square") { e in
            XCTAssertEqual(e as? EigenDecompositionError, EigenDecompositionError.matrixNotSquare)
        }
    }
}
