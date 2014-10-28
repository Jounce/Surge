import Foundation
import Accelerate

public struct Matrix {
    let rows: Int, columns: Int
    var grid: [Double]
    
    public init(rows: Int, columns: Int, value: Double) {
        self.rows = rows
        self.columns = columns
        grid = Array(count: rows * columns, repeatedValue: value)
    }
    
    public init(rows: Int, columns: Int) {
        self.init(rows: rows, columns: columns, value: 0.0)
    }
    
    public init(_ rows: [Double]...) {
        let nRows: Int = rows.count
        let nColumns: Int = rows[0].count
        self.init(rows: nRows, columns: nColumns, value: 0.0)
        for (i, row) in enumerate(rows) {
            let nValues = min(nColumns, row.count)
            grid.replaceRange(i*nColumns..<i*nColumns+nValues, with: row)
        }
    }
    
    func indexIsValidForRow(row: Int, column: Int) -> Bool {
        return row >= 0 && row < rows && column >= 0 && column < columns
    }
    
    public subscript(row: Int, column: Int) -> Double {
        get {
            assert(indexIsValidForRow(row, column: column), "Index out of range")
            return grid[(row * columns) + column]
        }
        set {
            assert(indexIsValidForRow(row, column: column), "Index out of range")
            grid[(row * columns) + column] = newValue
        }
    }
    
    
    
}

public func add(x: Matrix, y: Matrix) -> Matrix {
    assert(x.rows == y.rows && x.columns == y.columns, "Matrix dimensions not compatible with addition")
    var results = y
    cblas_daxpy(Int32(x.grid.count), 1.0, x.grid, 1, &(results.grid), 1)
    
    return results
}

public func mul(alpha: Double, x:Matrix) -> Matrix {
    var results = x
    cblas_dscal(Int32(x.grid.count), alpha, &(results.grid), 1)
    
    return results
}

public func mul(x: Matrix, y: Matrix) -> Matrix {
    assert(x.columns == y.rows, "Matrix dimensions not compatible with multiplication")
    var results = Matrix(rows: x.rows, columns: y.columns)
    cblas_dgemm(CblasRowMajor, CblasNoTrans, CblasNoTrans, Int32(x.rows), Int32(y.columns), Int32(x.columns), 1.0, x.grid, Int32(x.columns), y.grid, Int32(y.columns), 0.0, &(results.grid), Int32(results.columns))
    
    return results
}

public func inv(x : Matrix) -> Matrix {
    assert(x.rows == x.columns, "To take an inverse of a matrix, the matrix must be square.")
    var results = x
    
    var ipiv:Array<__CLPK_integer> = Array(count:x.rows*x.rows, repeatedValue:0)
    var lwork:__CLPK_integer = __CLPK_integer(x.columns*x.columns)
    var work = [CDouble](count: Int(lwork), repeatedValue: 0.0)
    var error:__CLPK_integer=0
    var nc = __CLPK_integer(x.columns)
    dgetrf_(&nc, &nc, &(results.grid), &nc, &ipiv, &error)
    dgetri_(&nc, &(results.grid), &nc, &ipiv, &work, &lwork, &error)
    assert(error == 0, "Matrix not invertible")
    
    return results
    
}

public func transpose(x: Matrix) -> Matrix {
    var results = Matrix(rows: x.columns, columns: x.rows)
    vDSP_mtransD(x.grid, 1, &(results.grid), 1, vDSP_Length(results.rows), vDSP_Length(results.columns))
    
    return results
}

