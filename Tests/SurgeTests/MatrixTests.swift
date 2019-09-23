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
    func test_init_rows_columns_repeatedValue() {
        typealias Scalar = Double

        let actual: Matrix<Scalar> = Matrix(rows: 2, columns: 3, repeatedValue: 42.0)
        let expected: Matrix<Scalar> = [
            [42.0, 42.0, 42.0],
            [42.0, 42.0, 42.0],
        ]

        XCTAssertEqual(actual, expected)
    }

    func test_init_contents() {
        typealias Scalar = Double

        let contents: [[Scalar]] = [
            [1, 2, 3, 4],
            [5, 6, 7, 8],
            [9, 10, 11, 12],
        ]

        let actual: Matrix<Scalar> = Matrix(contents)
        let expected: Matrix<Scalar> = [
            [1, 2, 3, 4],
            [5, 6, 7, 8],
            [9, 10, 11, 12],
        ]

        XCTAssertEqual(actual, expected)
    }

    func test_init_row() {
        typealias Scalar = Double

        let row: [Scalar] = [1, 2, 3, 4]

        let actual: Matrix<Scalar> = Matrix(row: row)
        let expected: Matrix<Scalar> = [
            [1, 2, 3, 4],
        ]

        XCTAssertEqual(actual, expected)
    }

    func test_init_column() {
        typealias Scalar = Double

        let column: [Scalar] = [1, 2, 3, 4]

        let actual: Matrix<Scalar> = Matrix(column: column)
        let expected: Matrix<Scalar> = [
            [1],
            [2],
            [3],
            [4],
        ]

        XCTAssertEqual(actual, expected)
    }

    func test_init_rows_columns_grid() {
        typealias Scalar = Double

        let grid: [Scalar] = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12]

        let actual: Matrix<Scalar> = Matrix(rows: 3, columns: 4, grid: grid)
        let expected: Matrix<Scalar> = [
            [1, 2, 3, 4],
            [5, 6, 7, 8],
            [9, 10, 11, 12],
        ]

        XCTAssertEqual(actual, expected)
    }

    func test_init_arrayLiteral() {
        typealias Scalar = Double

        let contents: [[Scalar]] = [
            [1, 2, 3, 4],
            [5, 6, 7, 8],
            [9, 10, 11, 12],
        ]
        let matrix: Matrix<Scalar> = Matrix(contents)

        let actual = matrix.grid
        let expected: [Scalar] = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12]

        XCTAssertEqual(actual, expected)
    }

    func test_init_identity() {
        let actual: Matrix<Double> = Matrix.identity(size: 3)
        let expected: Matrix<Double> = [
            [1.0, 0.0, 0.0],
            [0.0, 1.0, 0.0],
            [0.0, 0.0, 1.0],
        ]
        XCTAssertEqual(actual, expected)
    }

    func test_init_eye() {
        let actual_2x3: Matrix<Double> = Matrix.eye(rows: 2, columns: 3)
        let expected_2x3: Matrix<Double> = [
            [1.0, 0.0, 0.0],
            [0.0, 1.0, 0.0],
        ]
        XCTAssertEqual(actual_2x3, expected_2x3)

        let actual_3x2: Matrix<Double> = Matrix.eye(rows: 3, columns: 2)
        let expected_3x2: Matrix<Double> = [
            [1.0, 0.0],
            [0.0, 1.0],
            [0.0, 0.0],
        ]
        XCTAssertEqual(actual_3x2, expected_3x2)

        let actual_3x3: Matrix<Double> = Matrix.eye(rows: 3, columns: 3)
        let expected_3x3: Matrix<Double> = [
            [1.0, 0.0, 0.0],
            [0.0, 1.0, 0.0],
            [0.0, 0.0, 1.0],
        ]
        XCTAssertEqual(actual_3x3, expected_3x3)
    }

    func test_init_diagonal_repeatedValue() {
        let actual_2x3: Matrix<Double> = Matrix.diagonal(rows: 2, columns: 3, repeatedValue: 42.0)
        let expected_2x3: Matrix<Double> = [
            [42.0, 0.0, 0.0],
            [0.0, 42.0, 0.0],
        ]
        XCTAssertEqual(actual_2x3, expected_2x3)

        let actual_3x2: Matrix<Double> = Matrix.diagonal(rows: 3, columns: 2, repeatedValue: 42.0)
        let expected_3x2: Matrix<Double> = [
            [42.0, 0.0],
            [0.0, 42.0],
            [0.0, 0.0],
        ]
        XCTAssertEqual(actual_3x2, expected_3x2)

        let actual_3x3: Matrix<Double> = Matrix.diagonal(rows: 3, columns: 3, repeatedValue: 42.0)
        let expected_3x3: Matrix<Double> = [
            [42.0, 0.0, 0.0],
            [0.0, 42.0, 0.0],
            [0.0, 0.0, 42.0],
        ]
        XCTAssertEqual(actual_3x3, expected_3x3)
    }

    func test_init_diagonal_scalars() {
        let actual_2x3: Matrix<Double> = Matrix.diagonal(rows: 2, columns: 3, scalars: [1, 2])
        let expected_2x3: Matrix<Double> = [
            [1.0, 0.0, 0.0],
            [0.0, 2.0, 0.0],
        ]
        XCTAssertEqual(actual_2x3, expected_2x3)

        let actual_3x2: Matrix<Double> = Matrix.diagonal(rows: 3, columns: 2, scalars: [1, 2])
        let expected_3x2: Matrix<Double> = [
            [1.0, 0.0],
            [0.0, 2.0],
            [0.0, 0.0],
        ]
        XCTAssertEqual(actual_3x2, expected_3x2)

        let actual_3x3: Matrix<Double> = Matrix.diagonal(rows: 3, columns: 3, scalars: [1, 2, 3])
        let expected_3x3: Matrix<Double> = [
            [1.0, 0.0, 0.0],
            [0.0, 2.0, 0.0],
            [0.0, 0.0, 3.0],
        ]
        XCTAssertEqual(actual_3x3, expected_3x3)
    }

    // MARK: - Subscript

    func test_subscript_row_get() {
        typealias Scalar = Double

        let matrix: Matrix<Scalar> = [
            [1, 2, 3, 4],
            [5, 6, 7, 8],
            [9, 10, 11, 12],
        ]

        XCTAssertEqual(matrix[row: 0], [1, 2, 3, 4])
        XCTAssertEqual(matrix[row: 1], [5, 6, 7, 8])
    }

    func test_subscript_column_get() {
        typealias Scalar = Double

        let matrix: Matrix<Scalar> = [
            [1, 2, 3, 4],
            [5, 6, 7, 8],
            [9, 10, 11, 12],
        ]

        XCTAssertEqual(matrix[column: 0], [1, 5, 9])
        XCTAssertEqual(matrix[column: 1], [2, 6, 10])
    }

    func test_subscript_row_set() {
        typealias Scalar = Double

        var matrix: Matrix<Scalar> = [
            [1, 2, 3, 4],
            [5, 6, 7, 8],
            [9, 10, 11, 12],
        ]

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

        var matrix: Matrix<Scalar> = [
            [1, 2, 3, 4],
            [5, 6, 7, 8],
            [9, 10, 11, 12],
        ]

        matrix[column: 0] = [20, 30, 40]

        let expected: Matrix<Scalar> = [
            [20, 2, 3, 4],
            [30, 6, 7, 8],
            [40, 10, 11, 12],
        ]

        XCTAssertEqual(matrix, expected)
    }

    // MARK: - Addition

    func test_add_matrix_matrix_float() {
        typealias Scalar = Float

        let matrix: Matrix<Scalar> = [
            [1, 2, 3, 4],
            [5, 6, 7, 8],
            [9, 10, 11, 12],
        ]

        let actual = matrix + matrix
        let expected: Matrix<Float> = [
            [2, 4, 6, 8],
            [10, 12, 14, 16],
            [18, 20, 22, 24],
        ]

        XCTAssertEqual(actual, expected)
    }

    func test_add_matrix_matrix_double() {
        typealias Scalar = Double

        let matrix: Matrix<Scalar> = [
            [1, 2, 3, 4],
            [5, 6, 7, 8],
            [9, 10, 11, 12],
        ]

        let actual = matrix + matrix
        let expected: Matrix<Scalar> = [
            [2, 4, 6, 8],
            [10, 12, 14, 16],
            [18, 20, 22, 24],
        ]

        XCTAssertEqual(actual, expected)
    }

    // MARK: - Subtraction

    func test_sub_matrix_matrix_float() {
        typealias Scalar = Float

        let matrix: Matrix<Scalar> = [
            [1, 2, 3, 4],
            [5, 6, 7, 8],
            [9, 10, 11, 12],
        ]

        let actual = matrix - matrix
        let expected: Matrix<Float> = [
            [0, 0, 0, 0],
            [0, 0, 0, 0],
            [0, 0, 0, 0],
        ]

        XCTAssertEqual(actual, expected)
    }

    func test_sub_matrix_matrix_double() {
        typealias Scalar = Double

        let matrix: Matrix<Scalar> = [
            [1, 2, 3, 4],
            [5, 6, 7, 8],
            [9, 10, 11, 12],
        ]

        let actual = matrix - matrix
        let expected: Matrix<Scalar> = [
            [0, 0, 0, 0],
            [0, 0, 0, 0],
            [0, 0, 0, 0],
        ]

        XCTAssertEqual(actual, expected)
    }

    // MARK: - Multiplication

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

        let actual = lhs * rhs
        let expected: Matrix<Scalar> = [
            [44, 56, 68],
            [140, 184, 228],
            [236, 312, 388],
        ]

        XCTAssertEqual(actual, expected)
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

        let actual = lhs * rhs
        let expected: Matrix<Scalar> = [
            [44, 56, 68],
            [140, 184, 228],
            [236, 312, 388],
        ]

        XCTAssertEqual(actual, expected)
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

    func test_mul_empty_float() {
        typealias Scalar = Float

        let lhs: Matrix<Scalar> = [
            [1]
        ]
        let rhs: Matrix<Scalar> = [
            []
        ]

        let result = lhs * rhs

        XCTAssertEqual(result.rows, 1)
        XCTAssertEqual(result.columns, 0)
    }

    func test_mul_empty_double() {
        typealias Scalar = Double

        let lhs: Matrix<Scalar> = [
            [1]
        ]
        let rhs: Matrix<Scalar> = [
            []
        ]

        let result = lhs * rhs

        XCTAssertEqual(result.rows, 1)
        XCTAssertEqual(result.columns, 0)
    }

    // MARK: - Division

    func test_div_matrix_scalar_float() {
        typealias Scalar = Float

        let lhs: Matrix<Scalar> = [
            [2, 4, 6],
            [10, 12, 14],
        ]

        let rhs: Scalar = 2

        let actual = lhs / rhs
        let expected: Matrix<Scalar> = [
            [1, 2, 3],
            [5, 6, 7],
        ]

        XCTAssertEqual(actual, expected, accuracy: 1e-6)
    }

    func test_div_matrix_scalar_double() {
        typealias Scalar = Double

        let lhs: Matrix<Scalar> = [
            [2, 4, 6],
            [10, 12, 14],
        ]

        let rhs: Scalar = 2

        let actual = lhs / rhs
        let expected: Matrix<Scalar> = [
            [1, 2, 3],
            [5, 6, 7],
        ]

        XCTAssertEqual(actual, expected, accuracy: 1e-8)
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

        let actual = lhs / rhs
        let expected: Matrix<Scalar> = [
            [10, 12],
            [8, 10],
        ]

        XCTAssertEqual(actual, expected, accuracy: 1e-5)
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

        let actual = lhs / rhs
        let expected: Matrix<Scalar> = [
            [10, 12],
            [8, 10],
        ]

        XCTAssertEqual(actual, expected, accuracy: 1e-8)
    }

    // MARK: - Power

    func test_pow_matrix_scalar_float() {
        typealias Scalar = Float

        let lhs: Matrix<Scalar> = [
            [1, 2, 3],
            [4, 5, 6],
        ]

        let rhs: Scalar = 2

        let actual = pow(lhs, rhs)
        let expected: Matrix<Scalar> = .init(
            lhs.map { row in
                row.map { pow($0, rhs) }
            }
        )

        XCTAssertEqual(actual, expected, accuracy: 1e-5)
    }

    func test_pow_matrix_scalar_double() {
        typealias Scalar = Double

        let lhs: Matrix<Scalar> = [
            [1, 2, 3],
            [4, 5, 6],
        ]

        let rhs: Scalar = 2

        let actual = pow(lhs, rhs)
        let expected: Matrix<Scalar> = .init(
            lhs.map { row in
                row.map { pow($0, rhs) }
            }
        )

        XCTAssertEqual(actual, expected, accuracy: 1e-8)
    }

    // MARK: - Exponential

    func test_exp_matrix_float() {
        typealias Scalar = Float

        let lhs: Matrix<Scalar> = [
            [1, 2, 3],
            [4, 5, 6],
        ]

        let actual = exp(lhs)
        let expected: Matrix<Scalar> = .init(
            lhs.map { row in
                row.map { exp($0) }
            }
        )

        XCTAssertEqual(actual, expected, accuracy: 1e-3)
    }

    func test_exp_matrix_double() {
        typealias Scalar = Double

        let lhs: Matrix<Scalar> = [
            [1, 2, 3],
            [4, 5, 6],
        ]

        let actual = exp(lhs)
        let expected: Matrix<Scalar> = .init(
            lhs.map { row in
                row.map { exp($0) }
            }
        )

        XCTAssertEqual(actual, expected, accuracy: 1e-8)
    }

    // MARK: - Summation

    func test_sum_matrix_rows_double() {
        typealias Scalar = Double

        let lhs: Matrix<Scalar> = [
            [1, 2, 3],
            [4, 5, 6],
        ]

        let actual = sum(lhs, axies: .row)
        let expected: Matrix<Scalar> = [
            [6],
            [15],
        ]

        XCTAssertEqual(actual, expected, accuracy: 1e-5)
    }

    func test_sum_matrix_rows_float() {
        typealias Scalar = Float

        let lhs: Matrix<Scalar> = [
            [1, 2, 3],
            [4, 5, 6],
        ]

        let actual = sum(lhs, axies: .row)
        let expected: Matrix<Scalar> = [
            [6],
            [15],
        ]

        XCTAssertEqual(actual, expected, accuracy: 1e-5)
    }

    func test_sum_matrix_columns_double() {
        typealias Scalar = Double

        let lhs: Matrix<Scalar> = [
            [1, 2, 3],
            [4, 5, 6],
        ]

        let actual = sum(lhs, axies: .column)
        let expected: Matrix<Scalar> = [
            [5, 7, 9],
        ]

        XCTAssertEqual(actual, expected, accuracy: 1e-5)
    }

    func test_sum_matrix_columns_float() {
        typealias Scalar = Float

        let lhs: Matrix<Scalar> = [
            [1, 2, 3],
            [4, 5, 6],
        ]

        let actual = sum(lhs, axies: .column)
        let expected: Matrix<Scalar> = [
            [5, 7, 9],
        ]

        XCTAssertEqual(actual, expected, accuracy: 1e-5)
    }

    // MARK: - Inverse

    func test_inv_matrix_double() {
        typealias Scalar = Double

        let lhs: Matrix<Scalar> = [
            [2, 3],
            [2, 2],
        ]

        let actual = inv(lhs)
        let expected: Matrix<Scalar> = [
            [-1, 1.5],
            [1, -1],
        ]

        XCTAssertEqual(actual, expected, accuracy: 1e-8)
    }

    func test_inv_matrix_float() {
        typealias Scalar = Float

        let lhs: Matrix<Scalar> = [
            [2, 3],
            [2, 2],
        ]

        let actual = inv(lhs)
        let expected: Matrix<Scalar> = [
            [-1, 1.5],
            [1, -1],
        ]

        XCTAssertEqual(actual, expected, accuracy: 1e-6)
    }

    // MARK: - Transpose

    func test_tranpose_matrix_double() {
        typealias Scalar = Double

        let lhs: Matrix<Scalar> = [
            [1, 2, 3],
            [4, 5, 6],
        ]

        let actual = transpose(lhs)
        let expected: Matrix<Scalar> = [
            [1, 4],
            [2, 5],
            [3, 6],
        ]

        XCTAssertEqual(actual, expected)
    }

    func test_tranpose_matrix_float() {
        typealias Scalar = Float

        let lhs: Matrix<Scalar> = [
            [1, 2, 3],
            [4, 5, 6],
        ]

        let actual = transpose(lhs)
        let expected: Matrix<Scalar> = [
            [1, 4],
            [2, 5],
            [3, 6],
        ]

        XCTAssertEqual(actual, expected)
    }

    // MARK: - Determinant

    func test_det_matrix_double() {
        typealias Scalar = Double

        let lhs: Matrix<Scalar> = [
            [1, 2],
            [5, 6],
        ]

        let actual = det(lhs)
        let expected: Scalar = 6 - 10

        XCTAssertEqual(actual, expected)
    }

    func test_det_matrix_float() {
        typealias Scalar = Float

        let lhs: Matrix<Scalar> = [
            [1, 2],
            [5, 6],
        ]

        let actual = det(lhs)
        let expected: Scalar = 6 - 10

        XCTAssertEqual(actual, expected)
    }

    // MARK: - Eigen-Decomposition

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
        try eigen_decomposition_trivial_generic(defaultAccuracy: 1e-11) { (m: Matrix<Double>) throws -> MatrixEigenDecompositionResult<Double> in
            try eigenDecompose(m)
        }
        try eigen_decomposition_trivial_generic(defaultAccuracy: 1e-8) { (m: Matrix<Float>) throws -> MatrixEigenDecompositionResult<Float> in
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
        try eigen_decomposition_complex_results_numpy_example_generic(defaultAccuracy: 1e-11) { (m: Matrix<Double>) throws -> MatrixEigenDecompositionResult<Double> in
            try eigenDecompose(m)
        }
        try eigen_decomposition_complex_results_numpy_example_generic(defaultAccuracy: 1e-8) { (m: Matrix<Float>) throws -> MatrixEigenDecompositionResult<Float> in
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
        try eigen_decomposition_complex_results_dgeev_example_generic(defaultAccuracy: 1e-11) { (m: Matrix<Double>) throws -> MatrixEigenDecompositionResult<Double> in
            try eigenDecompose(m)
        }
        try eigen_decomposition_complex_results_dgeev_example_generic(defaultAccuracy: 1e-8) { (m: Matrix<Float>) throws -> MatrixEigenDecompositionResult<Float> in
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
