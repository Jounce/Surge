// Hyperbolic.swift
//
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

import Accelerate

public struct Matrix<T where T: FloatingPointType, T: FloatLiteralConvertible> {
    public typealias Element = T

    public let rows: Int
    public let columns: Int
    public var elements: [Element]

    /// Construct a Matrix from an array of elements in row-major order--elemens in the same row are next to each other.
    public init(rows: Int, columns: Int, elements: [Element]) {
        assert(rows * columns == elements.count)
        self.rows = rows
        self.columns = columns
        self.elements = elements
    }

    /// Construct a Matrix of `rows` by `columns` with every element initialized to `repeatedValue`.
    public init(rows: Int, columns: Int, repeatedValue: Element) {
        self.rows = rows
        self.columns = columns
        self.elements = [Element](count: rows * columns, repeatedValue: repeatedValue)
    }

    /// Construct a Matrix from an array of rows
    public init(_ contents: [[Element]]) {
        let m: Int = contents.count
        let n: Int = contents[0].count
        let repeatedValue: Element = 0.0

        self.init(rows: m, columns: n, repeatedValue: repeatedValue)

        for (i, row) in contents.enumerate() {
            elements.replaceRange(i*n..<i*n+min(m, row.count), with: row)
        }
    }

    public subscript(row: Int, column: Int) -> Element {
        get {
            assert(indexIsValidForRow(row, column: column))
            return elements[(row * columns) + column]
        }
        set {
            assert(indexIsValidForRow(row, column: column))
            elements[(row * columns) + column] = newValue
        }
    }

    private func indexIsValidForRow(row: Int, column: Int) -> Bool {
        return row >= 0 && row < rows && column >= 0 && column < columns
    }
}

// MARK: - Printable

extension Matrix: CustomStringConvertible {
    public var description: String {
        var description = ""

        for i in 0..<rows {
            let contents = (0..<columns).map{"\(self[i, $0])"}.joinWithSeparator("\t")

            switch (i, rows) {
            case (0, 1):
                description += "(\t\(contents)\t)"
            case (0, _):
                description += "⎛\t\(contents)\t⎞"
            case (rows - 1, _):
                description += "⎝\t\(contents)\t⎠"
            default:
                description += "⎜\t\(contents)\t⎥"
            }

            description += "\n"
        }

        return description
    }
}

// MARK: - SequenceType

extension Matrix: SequenceType {
    public func generate() -> AnyGenerator<ArraySlice<Element>> {
        let endIndex = rows * columns
        var nextRowStartIndex = 0

        return anyGenerator {
            if nextRowStartIndex == endIndex {
                return nil
            }

            let currentRowStartIndex = nextRowStartIndex
            nextRowStartIndex += self.columns

            return self.elements[currentRowStartIndex..<nextRowStartIndex]
        }
    }
}

// MARK: -

public func mul(lhs: Matrix<Double>, rhs: Matrix<Double>, inout result: Matrix<Double>) {
    precondition(lhs.columns == rhs.rows, "Input matrices dimensions not compatible with multiplication")
    precondition(lhs.rows == result.rows, "Output matrix dimensions not compatible with multiplication")
    precondition(rhs.columns == result.columns, "Output matrix dimensions not compatible with multiplication")
    
    cblas_dgemm(CblasRowMajor, CblasNoTrans, CblasNoTrans, Int32(lhs.rows), Int32(rhs.columns), Int32(lhs.columns), 1.0, lhs.elements, Int32(lhs.columns), rhs.elements, Int32(rhs.columns), 0.0, &(result.elements), Int32(result.columns))
}

public func inv(x : Matrix<Float>) -> Matrix<Float> {
    precondition(x.rows == x.columns, "Matrix must be square")

    var results = x

    var ipiv = [__CLPK_integer](count: x.rows * x.rows, repeatedValue: 0)
    var lwork = __CLPK_integer(x.columns * x.columns)
    var work = [CFloat](count: Int(lwork), repeatedValue: 0.0)
    var error: __CLPK_integer = 0
    var nc = __CLPK_integer(x.columns)

    sgetrf_(&nc, &nc, &(results.elements), &nc, &ipiv, &error)
    sgetri_(&nc, &(results.elements), &nc, &ipiv, &work, &lwork, &error)

    assert(error == 0, "Matrix not invertible")

    return results
}

public func inv(x : Matrix<Double>) -> Matrix<Double> {
    precondition(x.rows == x.columns, "Matrix must be square")

    var results = x

    var ipiv = [__CLPK_integer](count: x.rows * x.rows, repeatedValue: 0)
    var lwork = __CLPK_integer(x.columns * x.columns)
    var work = [CDouble](count: Int(lwork), repeatedValue: 0.0)
    var error: __CLPK_integer = 0
    var nc = __CLPK_integer(x.columns)

    dgetrf_(&nc, &nc, &(results.elements), &nc, &ipiv, &error)
    dgetri_(&nc, &(results.elements), &nc, &ipiv, &work, &lwork, &error)

    assert(error == 0, "Matrix not invertible")

    return results
}

public func transpose(x: Matrix<Float>) -> Matrix<Float> {
    var results = Matrix<Float>(rows: x.columns, columns: x.rows, repeatedValue: 0.0)
    vDSP_mtrans(x.elements, 1, &(results.elements), 1, vDSP_Length(results.rows), vDSP_Length(results.columns))

    return results
}

public func transpose(x: Matrix<Double>) -> Matrix<Double> {
    var results = Matrix<Double>(rows: x.columns, columns: x.rows, repeatedValue: 0.0)
    vDSP_mtransD(x.elements, 1, &(results.elements), 1, vDSP_Length(results.rows), vDSP_Length(results.columns))

    return results
}

// MARK: - Operators

public func += (inout lhs: Matrix<Float>, rhs: Matrix<Float>) {
    precondition(lhs.rows == rhs.rows && lhs.columns == rhs.columns, "Matrix dimensions not compatible with addition")
    
    cblas_saxpy(Int32(lhs.elements.count), 1.0, rhs.elements, 1, &lhs.elements, 1)
}

public func += (inout lhs: Matrix<Double>, rhs: Matrix<Double>) {
    precondition(lhs.rows == rhs.rows && lhs.columns == rhs.columns, "Matrix dimensions not compatible with addition")
    
    cblas_daxpy(Int32(lhs.elements.count), 1.0, rhs.elements, 1, &lhs.elements, 1)
}

public func + (lhs: Matrix<Float>, rhs: Matrix<Float>) -> Matrix<Float> {
    precondition(lhs.rows == rhs.rows && lhs.columns == rhs.columns, "Matrix dimensions not compatible with addition")
    
    var results = lhs
    results += rhs
    
    return results
}

public func + (lhs: Matrix<Double>, rhs: Matrix<Double>) -> Matrix<Double> {
    precondition(lhs.rows == rhs.rows && lhs.columns == rhs.columns, "Matrix dimensions not compatible with addition")
    
    var results = lhs
    results += rhs
    
    return results
}

public func -= (inout lhs: Matrix<Float>, rhs: Matrix<Float>) {
    precondition(lhs.rows == rhs.rows && lhs.columns == rhs.columns, "Matrix dimensions not compatible with addition")
    
    cblas_saxpy(Int32(lhs.elements.count), -1.0, rhs.elements, 1, &lhs.elements, 1)
}

public func -= (inout lhs: Matrix<Double>, rhs: Matrix<Double>) {
    precondition(lhs.rows == rhs.rows && lhs.columns == rhs.columns, "Matrix dimensions not compatible with addition")
    
    cblas_daxpy(Int32(lhs.elements.count), -1.0, rhs.elements, 1, &lhs.elements, 1)
}

public func - (lhs: Matrix<Float>, rhs: Matrix<Float>) -> Matrix<Float> {
    precondition(lhs.rows == rhs.rows && lhs.columns == rhs.columns, "Matrix dimensions not compatible with addition")
    
    var results = lhs
    results -= rhs
    
    return results
}

public func - (lhs: Matrix<Double>, rhs: Matrix<Double>) -> Matrix<Double> {
    precondition(lhs.rows == rhs.rows && lhs.columns == rhs.columns, "Matrix dimensions not compatible with addition")
    
    var results = lhs
    results -= rhs
    
    return results
}

public func *= (inout lhs: Matrix<Float>, rhs: Float) {
    cblas_sscal(Int32(lhs.elements.count), rhs, &lhs.elements, 1)
}

public func *= (inout lhs: Matrix<Double>, rhs: Double) {
    cblas_dscal(Int32(lhs.elements.count), rhs, &lhs.elements, 1)
}

public func * (lhs: Float, rhs: Matrix<Float>) -> Matrix<Float> {
    var results = rhs
    results *= lhs
    
    return results
}

public func * (lhs: Double, rhs: Matrix<Double>) -> Matrix<Double> {
    var results = rhs
    results *= lhs
    
    return results
}

public func * (lhs: Matrix<Float>, rhs: Matrix<Float>) -> Matrix<Float> {
    precondition(lhs.columns == rhs.rows, "Matrix dimensions not compatible with multiplication")
    
    var results = Matrix<Float>(rows: lhs.rows, columns: rhs.columns, repeatedValue: 0.0)
    cblas_sgemm(CblasRowMajor, CblasNoTrans, CblasNoTrans, Int32(lhs.rows), Int32(rhs.columns), Int32(lhs.columns), 1.0, lhs.elements, Int32(lhs.columns), rhs.elements, Int32(rhs.columns), 0.0, &(results.elements), Int32(results.columns))
    
    return results
}

public func * (lhs: Matrix<Double>, rhs: Matrix<Double>) -> Matrix<Double> {
    precondition(lhs.columns == rhs.rows, "Matrix dimensions not compatible with multiplication")
    
    var results = Matrix<Double>(rows: lhs.rows, columns: rhs.columns, repeatedValue: 0.0)
    cblas_dgemm(CblasRowMajor, CblasNoTrans, CblasNoTrans, Int32(lhs.rows), Int32(rhs.columns), Int32(lhs.columns), 1.0, lhs.elements, Int32(lhs.columns), rhs.elements, Int32(rhs.columns), 0.0, &(results.elements), Int32(results.columns))
    
    return results
}

postfix operator ′ {}
public postfix func ′ (value: Matrix<Float>) -> Matrix<Float> {
    return transpose(value)
}

public postfix func ′ (value: Matrix<Double>) -> Matrix<Double> {
    return transpose(value)
}
