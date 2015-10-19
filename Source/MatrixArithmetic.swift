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

import Accelerate


public func mul(lhs: RealMatrix, rhs: RealMatrix, result: RealMatrix) {
    precondition(lhs.columns == rhs.rows, "Input matrices dimensions not compatible with multiplication")
    precondition(lhs.rows == result.rows, "Output matrix dimensions not compatible with multiplication")
    precondition(rhs.columns == result.columns, "Output matrix dimensions not compatible with multiplication")

    cblas_dgemm(CblasRowMajor, CblasNoTrans, CblasNoTrans, Int32(lhs.rows), Int32(rhs.columns), Int32(lhs.columns), 1.0, lhs.pointer, Int32(lhs.columns), rhs.pointer, Int32(rhs.columns), 0.0, result.pointer, Int32(result.columns))
}

public func inv(x : RealMatrix) -> RealMatrix {
    precondition(x.rows == x.columns, "Matrix must be square")

    let results = x.copy()

    var ipiv = [__CLPK_integer](count: x.rows * x.rows, repeatedValue: 0)
    var lwork = __CLPK_integer(x.columns * x.columns)
    var work = [CDouble](count: Int(lwork), repeatedValue: 0.0)
    var error: __CLPK_integer = 0
    var nc = __CLPK_integer(x.columns)

    dgetrf_(&nc, &nc, results.pointer, &nc, &ipiv, &error)
    dgetri_(&nc, results.pointer, &nc, &ipiv, &work, &lwork, &error)

    assert(error == 0, "Matrix not invertible")

    return results
}

public func transpose(x: RealMatrix) -> RealMatrix {
    let results = RealMatrix(rows: x.columns, columns: x.rows, repeatedValue: 0.0)
    vDSP_mtransD(x.pointer, 1, results.pointer, 1, vDSP_Length(results.rows), vDSP_Length(results.columns))

    return results
}

// MARK: - Operators

public func += (lhs: RealMatrix, rhs: RealMatrix) {
    precondition(lhs.rows == rhs.rows && lhs.columns == rhs.columns, "Matrix dimensions not compatible with addition")

    cblas_daxpy(Int32(lhs.elements.count), 1.0, rhs.pointer, 1, lhs.pointer, 1)
}

public func + (lhs: RealMatrix, rhs: RealMatrix) -> RealMatrix {
    precondition(lhs.rows == rhs.rows && lhs.columns == rhs.columns, "Matrix dimensions not compatible with addition")

    let results = lhs.copy()
    results += rhs

    return results
}

public func -= (inout lhs: RealMatrix, rhs: RealMatrix) {
    precondition(lhs.rows == rhs.rows && lhs.columns == rhs.columns, "Matrix dimensions not compatible with addition")

    lhs.elements -= rhs.elements
}

public func - (lhs: RealMatrix, rhs: RealMatrix) -> RealMatrix {
    precondition(lhs.rows == rhs.rows && lhs.columns == rhs.columns, "Matrix dimensions not compatible with addition")

    var results = lhs.copy()
    results -= rhs
    
    return results
}

public func *= (inout lhs: RealMatrix, rhs: RealMatrix) {
    precondition(lhs.columns == lhs.rows, "Matrix dimensions not compatible with multiplication")
    precondition(rhs.columns == rhs.rows, "Matrix dimensions not compatible with multiplication")
    precondition(lhs.columns == rhs.columns, "Matrix dimensions not compatible with multiplication")

    lhs = lhs * rhs
}

public func *= (lhs: RealMatrix, rhs: Real) {
    cblas_dscal(Int32(lhs.elements.count), rhs, lhs.pointer, 1)
}

public func * (lhs: Double, rhs: RealMatrix) -> RealMatrix {
    let results = rhs.copy()
    results *= lhs

    return results
}

public func * (lhs: RealMatrix, rhs: RealMatrix) -> RealMatrix {
    precondition(lhs.columns == rhs.rows, "Matrix dimensions not compatible with multiplication")

    let results = RealMatrix(rows: lhs.rows, columns: rhs.columns, repeatedValue: 0.0)
    cblas_dgemm(CblasRowMajor, CblasNoTrans, CblasNoTrans, Int32(lhs.rows), Int32(rhs.columns), Int32(lhs.columns), 1.0, lhs.pointer, Int32(lhs.columns), rhs.pointer, Int32(rhs.columns), 0.0, results.pointer, Int32(results.columns))

    return results
}

postfix operator ′ {}
public postfix func ′ (value: RealMatrix) -> RealMatrix {
    return transpose(value)
}
