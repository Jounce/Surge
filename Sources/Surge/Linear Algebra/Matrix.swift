// Copyright © 2014-2019 the Surge contributors
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

public enum MatrixAxies {
    case row
    case column
}

public struct Matrix<Scalar> where Scalar: FloatingPoint, Scalar: ExpressibleByFloatLiteral {
    public enum Shape: Equatable {
        // `self.rows < self.columns` (aka. `m < n`)
        case wide
        /// `self.rows > self.columns` (aka. `m > n`)
        case tall
        // `self.rows == self.columns` (aka. `m == n`)
        case square
    }
    
    public let rows: Int
    public let columns: Int
    
    var grid: [Scalar]
    
    public var shape: Shape {
        if self.rows > self.columns {
            return .tall
        } else if self.rows < self.columns {
            return .wide
        } else {
            return .square
        }
    }
    
    // MARK: - Initialization
    
    public init(rows: Int, columns: Int, repeatedValue: Scalar) {
        self.rows = rows
        self.columns = columns
        
        self.grid = [Scalar](repeating: repeatedValue, count: rows * columns)
    }
    
    public init<T, U>(_ contents: T) where T: Collection, U: Collection, T.Element == U, U.Element == Scalar {
        self.init(rows: contents.count, columns: contents.first!.count, repeatedValue: 0.0)
        
        for (i, row) in contents.enumerated() {
            precondition(row.count == columns, "All rows should have the same number of columns")
            grid.replaceSubrange(i * columns..<(i + 1) * columns, with: row)
        }
    }
    
    public init(row: [Scalar]) {
        self.init(rows: 1, columns: row.count, grid: row)
    }
    
    public init(column: [Scalar]) {
        self.init(rows: column.count, columns: 1, grid: column)
    }
    
    public init(rows: Int, columns: Int, grid: [Scalar]) {
        precondition(grid.count == rows * columns)
        
        self.rows = rows
        self.columns = columns
        
        self.grid = grid
    }
    
    public init(rows: Int, columns: Int, _ closure: (_ row: Int, _ column: Int) throws -> Scalar) rethrows {
        var grid: [Scalar] = []
        grid.reserveCapacity(rows * columns)
        
        for row in 0..<rows {
            for column in 0..<columns {
                grid.append(try closure(row, column))
            }
        }
        
        self.init(rows: rows, columns: columns, grid: grid)
    }
    
    public static func identity(size: Int) -> Matrix<Scalar> {
        return self.diagonal(rows: size, columns: size, repeatedValue: 1.0)
    }
    
    public static func eye(rows: Int, columns: Int) -> Matrix<Scalar> {
        return self.diagonal(rows: rows, columns: columns, repeatedValue: 1.0)
    }
    
    public static func diagonal(rows: Int, columns: Int, repeatedValue: Scalar) -> Matrix<Scalar> {
        let count = Swift.min(rows, columns)
        let scalars = repeatElement(repeatedValue, count: count)
        return self.diagonal(rows: rows, columns: columns, scalars: scalars)
    }
    
    public static func diagonal<T>(rows: Int, columns: Int, scalars: T) -> Matrix<Scalar> where T: Collection, T.Element == Scalar {
        var matrix = self.init(rows: rows, columns: columns, repeatedValue: 0.0)
        
        let count = Swift.min(rows, columns)
        precondition(scalars.count == count)
        
        for (i, scalar) in scalars.enumerated() {
            matrix[i, i] = scalar
        }
        
        return matrix
    }
}

// MARK: - Initialization: Randomized

extension Matrix where Scalar == Float {
    /// Generates a matrix of uniform-distributed random values within a (closed) `range`.
    public static func random(
        rows: Int,
        columns: Int,
        in range: ClosedRange<Float> = 0.0...1.0
    ) -> Matrix {
        var generator = SystemRandomNumberGenerator()
        return self.random(
            rows: rows,
            columns: columns,
            in: range,
            using: &generator
        )
    }
    
    /// Generates a matrix of uniform-distributed random values within
    /// a (closed) `range`, based on the provided random-number `generator`.
    public static func random<T>(
        rows: Int,
        columns: Int,
        in range: ClosedRange<Float> = 0.0...1.0,
        using generator: inout T
    ) -> Matrix where T: RandomNumberGenerator {
        let grid = Surge.random(
            count: rows * columns,
            in: range,
            using: &generator
        )
        return Matrix(rows: rows, columns: columns, grid: grid)
    }
    
    /// Generates a matrix of normal-distributed random values with given
    /// `mean` (aka "mu") and `stdDeviation` (aka "sigma").
    public static func randomNormal(
        rows: Int,
        columns: Int,
        mean: Float = 0.0,
        stdDeviation: Float = 1.0
    ) -> Matrix {
        var generator = SystemRandomNumberGenerator()
        return self.randomNormal(
            rows: rows,
            columns: columns,
            mean: mean,
            stdDeviation: stdDeviation,
            using: &generator
        )
    }
    
    /// Generates a matrix of normal-distributed random values with given
    /// `mean` (aka "mu") and `stdDeviation` (aka "sigma")
    /// based on the provided random-number `generator`.
    public static func randomNormal<T>(
        rows: Int,
        columns: Int,
        mean: Float = 0.0,
        stdDeviation: Float = 1.0,
        using generator: inout T
    ) -> Matrix where T: RandomNumberGenerator {
        let grid = Surge.randomNormal(
            count: rows * columns,
            mean: mean,
            stdDeviation: stdDeviation,
            using: &generator
        )
        return Matrix(rows: rows, columns: columns, grid: grid)
    }
}

extension Matrix where Scalar == Double {
    /// Generates a matrix of uniform-distributed random values within a (closed) `range`.
    public static func random(
        rows: Int,
        columns: Int,
        in range: ClosedRange<Double> = 0.0...1.0
    ) -> Matrix {
        var generator = SystemRandomNumberGenerator()
        return self.random(
            rows: rows,
            columns: columns,
            in: range,
            using: &generator
        )
    }
    
    /// Generates a matrix of uniform-distributed random values within
    /// a (closed) `range`, based on the provided random-number `generator`.
    public static func random<T>(
        rows: Int,
        columns: Int,
        in range: ClosedRange<Double> = 0.0...1.0,
        using generator: inout T
    ) -> Matrix where T: RandomNumberGenerator {
        let grid = Surge.random(
            count: rows * columns,
            in: range,
            using: &generator
        )
        return Matrix(rows: rows, columns: columns, grid: grid)
    }
    
    /// Generates a matrix of normal-distributed random values with given
    /// `mean` (aka "mu") and `stdDeviation` (aka "sigma").
    public static func randomNormal(
        rows: Int,
        columns: Int,
        mean: Double = 0.0,
        stdDeviation: Double = 1.0
    ) -> Matrix {
        var generator = SystemRandomNumberGenerator()
        return self.randomNormal(
            rows: rows,
            columns: columns,
            mean: mean,
            stdDeviation: stdDeviation,
            using: &generator
        )
    }
    
    /// Generates a matrix of normal-distributed random values with given
    /// `mean` (aka "mu") and `stdDeviation` (aka "sigma")
    /// based on the provided random-number `generator`.
    public static func randomNormal<T>(
        rows: Int,
        columns: Int,
        mean: Double = 0.0,
        stdDeviation: Double = 1.0,
        using generator: inout T
    ) -> Matrix where T: RandomNumberGenerator {
        let grid = Surge.randomNormal(
            count: rows * columns,
            mean: mean,
            stdDeviation: stdDeviation,
            using: &generator
        )
        return Matrix(rows: rows, columns: columns, grid: grid)
    }
}

extension Matrix {
    // MARK: - Subscript
    
    public subscript(row: Int, column: Int) -> Scalar {
        get {
            assert(indexIsValidForRow(row, column: column))
            return grid[(row * columns) + column]
        }
        
        set {
            assert(indexIsValidForRow(row, column: column))
            grid[(row * columns) + column] = newValue
        }
    }
    
    public subscript(row row: Int) -> [Scalar] {
        get {
            assert(row < rows)
            let startIndex = row * columns
            let endIndex = row * columns + columns
            return Array(grid[startIndex..<endIndex])
        }
        
        set {
            assert(row < rows)
            assert(newValue.count == columns)
            let startIndex = row * columns
            let endIndex = row * columns + columns
            grid.replaceSubrange(startIndex..<endIndex, with: newValue)
        }
    }
    
    public subscript(column column: Int) -> [Scalar] {
        get {
            var result = [Scalar](repeating: 0.0, count: rows)
            for i in 0..<rows {
                let index = i * columns + column
                result[i] = self.grid[index]
            }
            return result
        }
        
        set {
            assert(column < columns)
            assert(newValue.count == rows)
            for i in 0..<rows {
                let index = i * columns + column
                grid[index] = newValue[i]
            }
        }
    }
    
    public subscript(row: ClosedRange<Int>, column: ClosedRange<Int>) -> Matrix {
        get {
            assert(row.map{$0 < rows && $0 >= 0}.allSatisfy{$0 == true})
            assert(column.map{$0 < columns && $0 >= 0}.allSatisfy{$0 == true})
            //            var matrix = Matrix<Scalar>(rows: row.count, columns: column.count, repeatedValue: 0)
            let subRows = row.count
            let subColumns = column.count
            var result = [Scalar](repeating: 0.0, count: subRows*subColumns)
            let r0 = row.first!
            let c0 = column.first!
            for rr in (row){
                //                for co in (column){
                result[(rr-r0)*subColumns ..< (rr-r0)*subColumns+subColumns] = grid[rr*columns+c0 ..< rr*columns+c0+subColumns]
                //                }
            }
            return Matrix(rows: subRows, columns: subColumns, grid: result)
        }
        
        set {
            assert(row.map{$0 < rows && $0 >= 0}.allSatisfy{$0 == true})
            assert(column.map{$0 < columns && $0 >= 0}.allSatisfy{$0 == true})
            assert(newValue.rows == row.count)
            assert(newValue.columns == column.count)
            //            var matrix = Matrix<Scalar>(rows: row.count, columns: column.count, repeatedValue: 0)
            //            let subRows = row.count
            let subColumns = column.count
            //            let result = [Float](repeating: 0.0, count: subRows*subColumns)
            let r0 = row.first!
            let c0 = column.first!
            for rr in (row){
                grid[rr*columns ..< rr*columns+c0 + subColumns] = newValue.grid[(rr-r0)*subColumns ..< (rr-r0)*subColumns+subColumns]
            }
            
        }
    }
    
    private func indexIsValidForRow(_ row: Int, column: Int) -> Bool {
        return row >= 0 && row < rows && column >= 0 && column < columns
    }
}

extension Matrix: ExpressibleByArrayLiteral where Scalar: FloatingPoint, Scalar: ExpressibleByFloatLiteral {
    public init(arrayLiteral elements: [Scalar]...) {
        self.init(AnyCollection(elements))
    }
}

/// Holds the result of eigendecomposition. The (Scalar, Scalar) used
/// in the property types represents a complex number with (real, imaginary) parts.
public struct MatrixEigenDecompositionResult<Scalar> where Scalar: FloatingPoint, Scalar: ExpressibleByFloatLiteral {
    public let eigenValues: [(Scalar, Scalar)]
    public let leftEigenVectors: [[(Scalar, Scalar)]]
    public let rightEigenVectors: [[(Scalar, Scalar)]]
    
    public init(eigenValues: [(Scalar, Scalar)], leftEigenVectors: [[(Scalar, Scalar)]], rightEigenVectors: [[(Scalar, Scalar)]]) {
        self.eigenValues = eigenValues
        self.leftEigenVectors = leftEigenVectors
        self.rightEigenVectors = rightEigenVectors
    }
    
    public init(rowCount: Int, eigenValueRealParts: [Scalar], eigenValueImaginaryParts: [Scalar], leftEigenVectorWork: [Scalar], rightEigenVectorWork: [Scalar]) {
        // The eigenvalues are an array of (real, imaginary) results from dgeev
        self.eigenValues = Array(zip(eigenValueRealParts, eigenValueImaginaryParts))
        
        // Build the left and right eigenvectors
        let emptyVector = [(Scalar, Scalar)](repeating: (0, 0), count: rowCount)
        var leftEigenVectors = [[(Scalar, Scalar)]](repeating: emptyVector, count: rowCount)
        buildEigenVector(eigenValueImaginaryParts: eigenValueImaginaryParts, eigenVectorWork: leftEigenVectorWork, result: &leftEigenVectors)
        
        var rightEigenVectors = [[(Scalar, Scalar)]](repeating: emptyVector, count: rowCount)
        buildEigenVector(eigenValueImaginaryParts: eigenValueImaginaryParts, eigenVectorWork: rightEigenVectorWork, result: &rightEigenVectors)
        
        self.leftEigenVectors = leftEigenVectors
        self.rightEigenVectors = rightEigenVectors
    }
}

/// Errors thrown when a matrix cannot be decomposed.
public enum EigenDecompositionError: Error {
    case matrixNotSquare
    case matrixNotDecomposable
}

// MARK: - Printable

extension Matrix: CustomStringConvertible {
    public var description: String {
        var description = ""
        
        for i in 0..<rows {
            let contents = (0..<columns).map { "\(self[i, $0])" }.joined(separator: "\t")
            
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

extension Matrix: Sequence {
    public func makeIterator() -> AnyIterator<ArraySlice<Scalar>> {
        let endIndex = rows * columns
        var nextRowStartIndex = 0
        
        return AnyIterator {
            if nextRowStartIndex == endIndex {
                return nil
            }
            
            let currentRowStartIndex = nextRowStartIndex
            nextRowStartIndex += self.columns
            
            return self.grid[currentRowStartIndex..<nextRowStartIndex]
        }
    }
}

// MARK: - Collection

extension Matrix: Collection {
    public subscript(_ row: Int) -> ArraySlice<Scalar> {
        let startIndex = row * columns
        let endIndex = startIndex + columns
        return self.grid[startIndex..<endIndex]
    }
    
    public var startIndex: Int {
        return 0
    }
    
    public var endIndex: Int {
        return self.rows
    }
    
    public func index(after i: Int) -> Int {
        return i + 1
    }
}

extension Matrix: Equatable {}
public func == <T>(lhs: Matrix<T>, rhs: Matrix<T>) -> Bool {
    return lhs.rows == rhs.rows && lhs.columns == rhs.columns && lhs.grid == rhs.grid
}

@inline(__always)
func withMatrix<Scalar>(from matrix: Matrix<Scalar>, _ closure: (inout Matrix<Scalar>) -> ()) -> Matrix<Scalar> {
    var copy = matrix
    closure(&copy)
    return copy
}

// MARK: - Addition

public func add(_ lhs: Matrix<Float>, _ rhs: Matrix<Float>) -> Matrix<Float> {
    return withMatrix(from: lhs) { addInPlace(&$0, rhs) }
}

public func add(_ lhs: Matrix<Double>, _ rhs: Matrix<Double>) -> Matrix<Double> {
    return withMatrix(from: lhs) { addInPlace(&$0, rhs) }
}

public func + (lhs: Matrix<Float>, rhs: Matrix<Float>) -> Matrix<Float> {
    return add(lhs, rhs)
}

public func + (lhs: Matrix<Double>, rhs: Matrix<Double>) -> Matrix<Double> {
    return add(lhs, rhs)
}

@available(macOS 10.15, *)
public func + (lhs: Matrix<Float>, rhs: Float) -> Matrix<Float> {
    withMatrix(from: lhs) {
        $0.grid = vDSP.add(rhs, $0.grid)
    }
}

@available(macOS 10.15, *)
public func + (lhs: Matrix<Double>, rhs: Double) -> Matrix<Double> {
    withMatrix(from: lhs) {
        $0.grid = vDSP.add(rhs, $0.grid)
    }
}

// MARK: - Addition: In Place

func addInPlace(_ lhs: inout Matrix<Float>, _ rhs: Matrix<Float>) {
    muladdInPlace(&lhs, rhs, 1.0)
}

func addInPlace(_ lhs: inout Matrix<Double>, _ rhs: Matrix<Double>) {
    muladdInPlace(&lhs, rhs, 1.0)
}

public func += (lhs: inout Matrix<Float>, rhs: Matrix<Float>) {
    return addInPlace(&lhs, rhs)
}

public func += (lhs: inout Matrix<Double>, rhs: Matrix<Double>) {
    return addInPlace(&lhs, rhs)
}

@available(macOS 10.15, *)

public func += (lhs: inout Matrix<Float>, rhs: Float) {
    lhs.grid = vDSP.add(rhs, lhs.grid)
}

@available(macOS 10.15, *)
public func += (lhs: inout Matrix<Double>, rhs: Double) {
    lhs.grid = vDSP.add(rhs, lhs.grid)
}

// MARK: - Subtraction

public func sub(_ lhs: Matrix<Float>, _ rhs: Matrix<Float>) -> Matrix<Float> {
    return withMatrix(from: lhs) { subInPlace(&$0, rhs) }
}

public func sub(_ lhs: Matrix<Double>, _ rhs: Matrix<Double>) -> Matrix<Double> {
    return withMatrix(from: lhs) { subInPlace(&$0, rhs) }
}

public func - (lhs: Matrix<Float>, rhs: Matrix<Float>) -> Matrix<Float> {
    return sub(lhs, rhs)
}

public func - (lhs: Matrix<Double>, rhs: Matrix<Double>) -> Matrix<Double> {
    return sub(lhs, rhs)
}

@available(macOS 10.15, *)
public func - (lhs: Matrix<Float>, rhs: Float) -> Matrix<Float> {
    withMatrix(from: lhs) {
        $0.grid = vDSP.add(-rhs, $0.grid)
    }
}
@available(macOS 10.15, *)
public func - (lhs: Matrix<Double>, rhs: Double) -> Matrix<Double> {
    withMatrix(from: lhs) {
        $0.grid = vDSP.add(-rhs, $0.grid)
    }
}

// MARK: - Subtraction: In Place

func subInPlace(_ lhs: inout Matrix<Float>, _ rhs: Matrix<Float>) {
    muladdInPlace(&lhs, rhs, -1.0)
}

func subInPlace(_ lhs: inout Matrix<Double>, _ rhs: Matrix<Double>) {
    muladdInPlace(&lhs, rhs, -1.0)
}

public func -= (lhs: inout Matrix<Float>, rhs: Matrix<Float>) {
    return subInPlace(&lhs, rhs)
}

public func -= (lhs: inout Matrix<Double>, rhs: Matrix<Double>) {
    return subInPlace(&lhs, rhs)
}

@available(macOS 10.15, *)
public func -= (lhs: inout Matrix<Float>, rhs: Float) {
    //    subInPlace(&lhs, .init(rows: lhs.rows, columns: lhs.columns, repeatedValue: rhs))
    lhs.grid = vDSP.add(-rhs, lhs.grid)
}

@available(macOS 10.15, *)
public func -= (lhs: inout Matrix<Double>, rhs: Double) {
    lhs.grid = vDSP.add(-rhs, lhs.grid)
}

// MARK: - Multiply Addition

func muladd(_ lhs: Matrix<Float>, _ rhs: Matrix<Float>, _ alpha: Float) -> Matrix<Float> {
    return withMatrix(from: lhs) { muladdInPlace(&$0, rhs, alpha) }
}

func muladd(_ lhs: Matrix<Double>, _ rhs: Matrix<Double>, _ alpha: Double) -> Matrix<Double> {
    return withMatrix(from: lhs) { muladdInPlace(&$0, rhs, alpha) }
}

// MARK: - Multiply Addition: In Place

func muladdInPlace(_ lhs: inout Matrix<Float>, _ rhs: Matrix<Float>, _ alpha: Float) {
    precondition(lhs.rows == rhs.rows && lhs.columns == rhs.columns, "Matrix dimensions not compatible with addition")
    
    let gridSize = Int32(lhs.grid.count)
    let stride: Int32 = 1
    
    lhs.grid.withUnsafeMutableBufferPointer { lhsPointer in
        rhs.grid.withUnsafeBufferPointer { rhsPointer in
            cblas_saxpy(gridSize, alpha, rhsPointer.baseAddress!, stride, lhsPointer.baseAddress!, stride)
        }
    }
}


func muladdInPlace(_ lhs: inout Matrix<Double>, _ rhs: Matrix<Double>, _ alpha: Double) {
    precondition(lhs.rows == rhs.rows && lhs.columns == rhs.columns, "Matrix dimensions not compatible with addition")
    
    let gridSize = Int32(lhs.grid.count)
    let stride: Int32 = 1
    
    lhs.grid.withUnsafeMutableBufferPointer { lhsPointer in
        rhs.grid.withUnsafeBufferPointer { rhsPointer in
            cblas_daxpy(gridSize, alpha, rhsPointer.baseAddress!, stride, lhsPointer.baseAddress!, stride)
        }
    }
}



// MARK: - Multiplication

public func mul(_ lhs: Matrix<Float>, _ rhs: Matrix<Float>) -> Matrix<Float> {
    precondition(lhs.columns == rhs.rows, "Matrix dimensions not compatible with multiplication")
    if lhs.rows == 0 || lhs.columns == 0 || rhs.columns == 0 {
        return Matrix<Float>(rows: lhs.rows, columns: rhs.columns, repeatedValue: 0.0)
    }
    
    var results = Matrix<Float>(rows: lhs.rows, columns: rhs.columns, repeatedValue: 0.0)
    results.grid.withUnsafeMutableBufferPointer { pointer in
        cblas_sgemm(CblasRowMajor, CblasNoTrans, CblasNoTrans, Int32(lhs.rows), Int32(rhs.columns), Int32(lhs.columns), 1.0, lhs.grid, Int32(lhs.columns), rhs.grid, Int32(rhs.columns), 0.0, pointer.baseAddress!, Int32(rhs.columns))
    }
    
    return results
}

public func mul(_ lhs: Matrix<Double>, _ rhs: Matrix<Double>) -> Matrix<Double> {
    precondition(lhs.columns == rhs.rows, "Matrix dimensions not compatible with multiplication")
    if lhs.rows == 0 || lhs.columns == 0 || rhs.columns == 0 {
        return Matrix<Double>(rows: lhs.rows, columns: rhs.columns, repeatedValue: 0.0)
    }
    
    var results = Matrix<Double>(rows: lhs.rows, columns: rhs.columns, repeatedValue: 0.0)
    results.grid.withUnsafeMutableBufferPointer { pointer in
        cblas_dgemm(CblasRowMajor, CblasNoTrans, CblasNoTrans, Int32(lhs.rows), Int32(rhs.columns), Int32(lhs.columns), 1.0, lhs.grid, Int32(lhs.columns), rhs.grid, Int32(rhs.columns), 0.0, pointer.baseAddress!, Int32(rhs.columns))
    }
    
    return results
}

public func * (lhs: Matrix<Float>, rhs: Matrix<Float>) -> Matrix<Float> {
    return mul(lhs, rhs)
}

public func * (lhs: Matrix<Double>, rhs: Matrix<Double>) -> Matrix<Double> {
    return mul(lhs, rhs)
}



public func mul(_ lhs: Matrix<Float>, _ rhs: Vector<Float>) -> Vector<Float> {
    precondition(lhs.columns == rhs.dimensions, "Matrix and vector dimensions not compatible with multiplication")
    if lhs.rows == 0 || lhs.columns == 0 || rhs.dimensions == 0 {
        return Vector<Float>(dimensions: lhs.rows, repeatedValue: 0.0)
    }
    
    var results = Vector<Float>(dimensions: lhs.rows, repeatedValue: 0.0)
    results.scalars.withUnsafeMutableBufferPointer { pointer in
        cblas_sgemv(CblasRowMajor, CblasNoTrans, Int32(lhs.rows), Int32(lhs.columns), 1.0, lhs.grid, Int32(lhs.columns), rhs.scalars, 1, 0.0, pointer.baseAddress!, 1)
    }
    
    return results
}

public func mul(_ lhs: Matrix<Double>, _ rhs: Vector<Double>) -> Vector<Double> {
    precondition(lhs.columns == rhs.dimensions, "Matrix and vector dimensions not compatible with multiplication")
    if lhs.rows == 0 || lhs.columns == 0 || rhs.dimensions == 0 {
        return Vector<Double>(dimensions: rhs.dimensions, repeatedValue: 0.0)
    }
    
    var results = Vector<Double>(dimensions: lhs.rows, repeatedValue: 0.0)
    results.scalars.withUnsafeMutableBufferPointer { pointer in
        cblas_dgemv(CblasRowMajor, CblasNoTrans, Int32(lhs.rows), Int32(lhs.columns), 1.0, lhs.grid, Int32(lhs.columns), rhs.scalars, 1, 0.0, pointer.baseAddress!, 1)
    }
    
    return results
}

public func * (lhs: Matrix<Float>, rhs: Vector<Float>) -> Vector<Float> {
    return mul(lhs, rhs)
}

public func * (lhs: Matrix<Double>, rhs: Vector<Double>) -> Vector<Double> {
    return mul(lhs, rhs)
}



// MARK: - Element-wise Multiplication

public func elmul(_ lhs: Matrix<Double>, _ rhs: Matrix<Double>) -> Matrix<Double> {
    precondition(lhs.rows == rhs.rows && lhs.columns == rhs.columns, "Matrix must have the same dimensions")
    var result = Matrix<Double>(rows: lhs.rows, columns: lhs.columns, repeatedValue: 0.0)
    result.grid = lhs.grid .* rhs.grid
    return result
}

public func elmul(_ lhs: Matrix<Float>, _ rhs: Matrix<Float>) -> Matrix<Float> {
    precondition(lhs.rows == rhs.rows && lhs.columns == rhs.columns, "Matrix must have the same dimensions")
    var result = Matrix<Float>(rows: lhs.rows, columns: lhs.columns, repeatedValue: 0.0)
    result.grid = lhs.grid .* rhs.grid
    return result
}

public func * (lhs: Matrix<Float>, rhs: Float) -> Matrix<Float> {
    elmul(lhs, .init(rows: lhs.rows, columns: lhs.columns, repeatedValue: rhs))
}

public func * (lhs: Matrix<Double>, rhs: Double) -> Matrix<Double> {
    elmul(lhs, .init(rows: lhs.rows, columns: lhs.columns, repeatedValue: rhs))
}

// MARK: - Division

public func div(_ lhs: Matrix<Double>, _ rhs: Matrix<Double>) -> Matrix<Double> {
    let yInv = inv(rhs)
    precondition(lhs.columns == yInv.rows, "Matrix dimensions not compatible")
    return mul(lhs, yInv)
}

public func div(_ lhs: Matrix<Float>, _ rhs: Matrix<Float>) -> Matrix<Float> {
    let yInv = inv(rhs)
    precondition(lhs.columns == yInv.rows, "Matrix dimensions not compatible")
    return mul(lhs, yInv)
}

public func / (lhs: Matrix<Double>, rhs: Matrix<Double>) -> Matrix<Double> {
    return div(lhs, rhs)
}

public func / (lhs: Matrix<Float>, rhs: Matrix<Float>) -> Matrix<Float> {
    return div(lhs, rhs)
}

public func div(_ lhs: Matrix<Double>, _ rhs: Double) -> Matrix<Double> {
    var result = Matrix<Double>(rows: lhs.rows, columns: lhs.columns, repeatedValue: 0.0)
    result.grid = lhs.grid / rhs
    return result
}

public func div(_ lhs: Matrix<Float>, _ rhs: Float) -> Matrix<Float> {
    var result = Matrix<Float>(rows: lhs.rows, columns: lhs.columns, repeatedValue: 0.0)
    result.grid = lhs.grid / rhs
    return result
}

public func / (lhs: Matrix<Double>, rhs: Double) -> Matrix<Double> {
    return div(lhs, rhs)
}

public func / (lhs: Matrix<Float>, rhs: Float) -> Matrix<Float> {
    return div(lhs, rhs)
}

// MARK: - Power

public func pow(_ lhs: Matrix<Double>, _ rhs: Double) -> Matrix<Double> {
    var result = Matrix<Double>(rows: lhs.rows, columns: lhs.columns, repeatedValue: 0.0)
    result.grid = pow(lhs.grid, rhs)
    return result
}

public func pow(_ lhs: Matrix<Float>, _ rhs: Float) -> Matrix<Float> {
    var result = Matrix<Float>(rows: lhs.rows, columns: lhs.columns, repeatedValue: 0.0)
    result.grid = pow(lhs.grid, rhs)
    return result
}

// MARK: - Exponential

public func exp(_ lhs: Matrix<Double>) -> Matrix<Double> {
    var result = Matrix<Double>(rows: lhs.rows, columns: lhs.columns, repeatedValue: 0.0)
    result.grid = exp(lhs.grid)
    return result
}

public func exp(_ lhs: Matrix<Float>) -> Matrix<Float> {
    var result = Matrix<Float>(rows: lhs.rows, columns: lhs.columns, repeatedValue: 0.0)
    result.grid = exp(lhs.grid)
    return result
}

// MARK: - Summation

public func sum(_ lhs: Matrix<Double>, axies: MatrixAxies = .column) -> Matrix<Double> {
    switch axies {
    case .column:
        var result = Matrix<Double>(rows: 1, columns: lhs.columns, repeatedValue: 0.0)
        for i in 0..<lhs.columns {
            result.grid[i] = sum(lhs[column: i])
        }
        return result
    case .row:
        var result = Matrix<Double>(rows: lhs.rows, columns: 1, repeatedValue: 0.0)
        for i in 0..<lhs.rows {
            result.grid[i] = sum(lhs[row: i])
        }
        return result
    }
    
}

public func sum(_ lhs: Matrix<Float>, axies: MatrixAxies = .column) -> Matrix<Float> {
    switch axies {
    case .column:
        var result = Matrix<Float>(rows: 1, columns: lhs.columns, repeatedValue: 0.0)
        for i in 0..<lhs.columns {
            result.grid[i] = sum(lhs[column: i])
        }
        return result
    case .row:
        var result = Matrix<Float>(rows: lhs.rows, columns: 1, repeatedValue: 0.0)
        for i in 0..<lhs.rows {
            result.grid[i] = sum(lhs[row: i])
        }
        return result
    }
}


public func sum(_ lhs: Matrix<Double>) -> Double {
    sum(lhs.grid)
}

public func sum(_ lhs: Matrix<Float>) -> Float {
    sum(lhs.grid)
}

public func mean(_ lhs: Matrix<Float>) -> Float {
    mean(lhs.grid)
}

public func mean(_ lhs: Matrix<Double>) -> Double {
    mean(lhs.grid)
}





// MARK: - Inverse

public func inv(_ lhs: Matrix<Float>) -> Matrix<Float> {
    precondition(lhs.rows == lhs.columns, "Matrix must be square")
    
    var results = lhs
    
    var ipiv = [__CLPK_integer](repeating: 0, count: lhs.rows * lhs.rows)
    var lwork = __CLPK_integer(lhs.columns * lhs.columns)
    var work = [CFloat](repeating: 0.0, count: Int(lwork))
    var error: __CLPK_integer = 0
    var nc = __CLPK_integer(lhs.columns)
    
    withUnsafeMutablePointers(&nc, &lwork, &error) { nc, lwork, error in
        withUnsafeMutableMemory(&ipiv, &work, &results.grid) { ipiv, work, grid in
            sgetrf_(nc, nc, grid.pointer, nc, ipiv.pointer, error)
            sgetri_(nc, grid.pointer, nc, ipiv.pointer, work.pointer, lwork, error)
        }
    }
    
    assert(error == 0, "Matrix not invertible")
    
    return results
}

public func inv(_ lhs: Matrix<Double>) -> Matrix<Double> {
    precondition(lhs.rows == lhs.columns, "Matrix must be square")
    
    var results = lhs
    
    var ipiv = [__CLPK_integer](repeating: 0, count: lhs.rows * lhs.rows)
    var lwork = __CLPK_integer(lhs.columns * lhs.columns)
    var work = [CDouble](repeating: 0.0, count: Int(lwork))
    var error: __CLPK_integer = 0
    var nc = __CLPK_integer(lhs.columns)
    
    withUnsafeMutablePointers(&nc, &lwork, &error) { nc, lwork, error in
        withUnsafeMutableMemory(&ipiv, &work, &results.grid) { ipiv, work, grid in
            dgetrf_(nc, nc, grid.pointer, nc, ipiv.pointer, error)
            dgetri_(nc, grid.pointer, nc, ipiv.pointer, work.pointer, lwork, error)
        }
    }
    
    assert(error == 0, "Matrix not invertible")
    
    return results
}

// MARK: - Transpose

public func transpose(_ lhs: Matrix<Float>) -> Matrix<Float> {
    var results = Matrix<Float>(rows: lhs.columns, columns: lhs.rows, repeatedValue: 0.0)
    results.grid.withUnsafeMutableBufferPointer { pointer in
        vDSP_mtrans(lhs.grid, 1, pointer.baseAddress!, 1, vDSP_Length(lhs.columns), vDSP_Length(lhs.rows))
    }
    
    return results
}

public func transpose(_ lhs: Matrix<Double>) -> Matrix<Double> {
    var results = Matrix<Double>(rows: lhs.columns, columns: lhs.rows, repeatedValue: 0.0)
    results.grid.withUnsafeMutableBufferPointer { pointer in
        vDSP_mtransD(lhs.grid, 1, pointer.baseAddress!, 1, vDSP_Length(lhs.columns), vDSP_Length(lhs.rows))
    }
    
    return results
}

public postfix func ′ (value: Matrix<Float>) -> Matrix<Float> {
    return transpose(value)
}

public postfix func ′ (value: Matrix<Double>) -> Matrix<Double> {
    return transpose(value)
}

// MARK: - Determinant

/// Computes the matrix determinant.
public func det(_ lhs: Matrix<Float>) -> Float? {
    var decomposed = lhs
    var pivots = [__CLPK_integer](repeating: 0, count: min(lhs.rows, lhs.columns))
    var info = __CLPK_integer()
    var m = __CLPK_integer(lhs.rows)
    var n = __CLPK_integer(lhs.columns)
    _ = withUnsafeMutableMemory(&pivots, &decomposed.grid) { ipiv, grid in
        withUnsafeMutablePointers(&m, &n, &info) { m, n, info in
            sgetrf_(m, n, grid.pointer, m, ipiv.pointer, info)
        }
    }
    
    if info != 0 {
        return nil
    }
    
    var det = 1 as Float
    for (i, p) in zip(pivots.indices, pivots) {
        if p != i + 1 {
            det = -det * decomposed[i, i]
        } else {
            det = det * decomposed[i, i]
        }
    }
    return det
}

/// Computes the matrix determinant.
public func det(_ lhs: Matrix<Double>) -> Double? {
    var decomposed = lhs
    var pivots = [__CLPK_integer](repeating: 0, count: min(lhs.rows, lhs.columns))
    var info = __CLPK_integer()
    var m = __CLPK_integer(lhs.rows)
    var n = __CLPK_integer(lhs.columns)
    _ = withUnsafeMutableMemory(&pivots, &decomposed.grid) { ipiv, grid in
        withUnsafeMutablePointers(&m, &n, &info) { m, n, info in
            dgetrf_(m, n, grid.pointer, m, ipiv.pointer, info)
        }
    }
    
    if info != 0 {
        return nil
    }
    
    var det = 1 as Double
    for (i, p) in zip(pivots.indices, pivots) {
        if p != i + 1 {
            det = -det * decomposed[i, i]
        } else {
            det = det * decomposed[i, i]
        }
    }
    return det
}

// MARK: - Eigen-Decomposition

// Convert the result of dgeev into an array of complex numbers
// See Intel's documentation on column-major results for sample code that this
// is based on:
// https://software.intel.com/sites/products/documentation/doclib/mkl_sa/11/mkl_lapack_examples/dgeev.htm
private func buildEigenVector<Scalar>(eigenValueImaginaryParts: [Scalar], eigenVectorWork: [Scalar], result: inout [[(Scalar, Scalar)]]) where Scalar: FloatingPoint & ExpressibleByFloatLiteral {
    // row and col count are the same because result must be square.
    let rowColCount = result.count
    
    for row in 0..<rowColCount {
        var col = 0
        while col < rowColCount {
            if eigenValueImaginaryParts[col] == 0.0 {
                // v is column-major
                result[row][col] = (eigenVectorWork[row + rowColCount * col], 0.0)
                col += 1
            } else {
                // v is column-major
                result[row][col] = (eigenVectorWork[row + col * rowColCount], eigenVectorWork[row + rowColCount * (col + 1)])
                result[row][col + 1] = (eigenVectorWork[row + col * rowColCount], -eigenVectorWork[row + rowColCount * (col + 1)])
                col += 2
            }
        }
    }
}

/// Decomposes a square matrix into its eigenvalues and left and right eigenvectors.
/// The decomposition may result in complex numbers, represented by (Float, Float), which
///   are the (real, imaginary) parts of the complex number.
/// - Parameters:
///   - lhs: a square matrix
/// - Returns: a struct with the eigen values and left and right eigen vectors using (Float, Float)
///   to represent a complex number.
public func eigenDecompose(_ lhs: Matrix<Float>) throws -> MatrixEigenDecompositionResult<Float> {
    var input = Matrix<Double>(rows: lhs.rows, columns: lhs.columns, repeatedValue: 0.0)
    input.grid = lhs.grid.map { Double($0) }
    let decomposition = try eigenDecompose(input)
    
    return MatrixEigenDecompositionResult<Float>(
        eigenValues: decomposition.eigenValues.map { (Float($0.0), Float($0.1)) },
        leftEigenVectors: decomposition.leftEigenVectors.map { $0.map { (Float($0.0), Float($0.1)) } },
        rightEigenVectors: decomposition.rightEigenVectors.map { $0.map { (Float($0.0), Float($0.1)) } }
    )
}

/// Decomposes a square matrix into its eigenvalues and left and right eigenvectors.
/// The decomposition may result in complex numbers, represented by (Double, Double), which
///   are the (real, imaginary) parts of the complex number.
/// - Parameters:
///   - lhs: a square matrix
/// - Returns: a struct with the eigen values and left and right eigen vectors using (Double, Double)
///   to represent a complex number.
public func eigenDecompose(_ lhs: Matrix<Double>) throws -> MatrixEigenDecompositionResult<Double> {
    guard lhs.rows == lhs.columns else {
        throw EigenDecompositionError.matrixNotSquare
    }
    
    // dgeev_ needs column-major matrices, so transpose lhs.
    var matrixGrid: [__CLPK_doublereal] = transpose(lhs).grid
    var matrixRowCount = __CLPK_integer(lhs.rows)
    let matrixColCount = matrixRowCount
    var eigenValueCount = matrixRowCount
    var leftEigenVectorCount = matrixRowCount
    var rightEigenVectorCount = matrixRowCount
    
    var workspaceQuery: Double = 0.0
    var workspaceSize = __CLPK_integer(-1)
    var error: __CLPK_integer = 0
    
    var eigenValueRealParts = [Double](repeating: 0, count: Int(eigenValueCount))
    var eigenValueImaginaryParts = [Double](repeating: 0, count: Int(eigenValueCount))
    var leftEigenVectorWork = [Double](repeating: 0, count: Int(leftEigenVectorCount * matrixColCount))
    var rightEigenVectorWork = [Double](repeating: 0, count: Int(rightEigenVectorCount * matrixColCount))
    
    var decompositionJobVL: [CChar] = [0x56, 0x00] // "V" (compute)
    var decompositionJobVR: [CChar] = [0x56, 0x00] // "V" (compute)
    
    // Call dgeev to find out how much workspace to allocate
    dgeev_(&decompositionJobVL, &decompositionJobVR, &matrixRowCount, &matrixGrid, &eigenValueCount, &eigenValueRealParts, &eigenValueImaginaryParts, &leftEigenVectorWork, &leftEigenVectorCount, &rightEigenVectorWork, &rightEigenVectorCount, &workspaceQuery, &workspaceSize, &error)
    if error != 0 {
        throw EigenDecompositionError.matrixNotDecomposable
    }
    
    // Allocate the workspace and call dgeev again to do the actual decomposition
    var workspace = [Double](repeating: 0.0, count: Int(workspaceQuery))
    workspaceSize = __CLPK_integer(workspaceQuery)
    dgeev_(&decompositionJobVL, &decompositionJobVR, &matrixRowCount, &matrixGrid, &eigenValueCount, &eigenValueRealParts, &eigenValueImaginaryParts, &leftEigenVectorWork, &leftEigenVectorCount, &rightEigenVectorWork, &rightEigenVectorCount, &workspace, &workspaceSize, &error)
    if error != 0 {
        throw EigenDecompositionError.matrixNotDecomposable
    }
    
    return MatrixEigenDecompositionResult<Double>(rowCount: lhs.rows, eigenValueRealParts: eigenValueRealParts, eigenValueImaginaryParts: eigenValueImaginaryParts, leftEigenVectorWork: leftEigenVectorWork, rightEigenVectorWork: rightEigenVectorWork)
}


extension Matrix where Scalar == Float{
    
    public func isSymmetric() ->Bool{
        guard self.rows == self.columns
        else{
            return false
        }
        return (0 ..< self.rows).map {
            self[row: $0] == self[column: $0]
        }.allSatisfy {$0 == true}
    }
}

extension Matrix where Scalar == Double{
    public func isSymmetric() ->Bool{
        guard self.rows == self.columns
        else{
            return false
        }
        return (0 ..< self.rows).map {
            self[row: $0] == self[column: $0]
        }.allSatisfy {$0 == true}
    }
}

extension Matrix where Scalar == Double{
    public func isPositiveDefined() ->Bool{
        guard self.rows == self.columns,
              let eigen = try? eigenDecompose(self)
        else{
            return false
        }
        
        return eigen.eigenValues.allSatisfy {
            print($0)
            return $0.1 == 0.0 && $0.0 >= 0.0
        }
    }
}

extension Matrix where Scalar == Float{
    public func isPositiveDefined() ->Bool{
        guard self.rows == self.columns,
              let eigen = try? eigenDecompose(self)
        else{
            return false
        }
        
        return eigen.eigenValues.allSatisfy {
            print($0)
            return $0.1 == 0.0 && $0.0 > 0.0
        }
    }
}




public func toSparseFormat(_ lhs:Matrix<Float>)-> ([Int32], [Int], [Float]){
    //    (structure: SparseMatrixStructure, values: [Scalar]){
    let columns = lhs.columns
    let rows = lhs.rows
    if lhs.isSymmetric(){
        
        var columnStarts = [Int ]()
        
        let colArrays = (0 ..< columns).map {col in
            zip(Array(0 ..< rows), lhs[column: col])
                .map { (idx, value) in
                    (value == 0.0 || idx < col) ? -1: idx
                }
        }
        
        let rowIndices:[Int32] = colArrays.reduce([]) { partialResult, val in
            let valFiltered = val.filter {$0 != -1}.map {Int32($0)}
            columnStarts.append(partialResult.count)
            return partialResult + valFiltered
        }
        columnStarts.append(rowIndices.count)
        
        let values = (0 ..< columns)
            .map {
                lhs[column: $0].dropFirst($0)
            }
            .reduce([]) {
                $0 + $1.filter{ value in value != 0.0}
            }
        
        return (rowIndices, columnStarts, values)
        
    }
    else{
        //           var attributes = SparseAttributes_t()
        var columnStarts = [Int ]()
        let colArrays = (0 ..< columns).map {
            zip(Array(0 ..< rows), lhs[column: $0])
                .map { (idx, value) in
                    abs(value) < 1e-8 ? -1: idx
                }
        }
        
        
        var rowIndices:[Int32] = colArrays.reduce([]) { partialResult, val in
            let valFiltered = val.filter {$0 != -1}.map {Int32($0)}
            columnStarts.append(partialResult.count)
            return partialResult + valFiltered
        }
        columnStarts.append(rowIndices.count)
        
        
        let values = (0 ..< columns)
            .map{lhs[column: $0]}
            .reduce([]) {$0 + $1.filter{ value in abs(value) > 1e-8}}
        
        return (rowIndices, columnStarts, values)
        
    }
}

//extension Matrix where Scalar == Double{
public func toSparseFormat(_ lhs:Matrix<Double>)-> ([Int32], [Int], [Double]){
    //    (structure: SparseMatrixStructure, values: [Scalar]){
    let columns = lhs.columns
    let rows = lhs.rows
    if lhs.isSymmetric(){
        
        var columnStarts = [Int ]()
        
        let colArrays = (0 ..< columns).map {col in
            zip(Array(0 ..< rows), lhs[column: col])
                .map { (idx, value) in
                    (abs(value) < 1e-11 || idx < col) ? -1: idx
                }
        }
        
        let rowIndices:[Int32] = colArrays.reduce([]) { partialResult, val in
            let valFiltered = val.filter {$0 != -1}.map {Int32($0)}
            columnStarts.append(partialResult.count)
            return partialResult + valFiltered
        }
        columnStarts.append(rowIndices.count)
        
        let values = (0 ..< columns)
            .map {
                lhs[column: $0].dropFirst($0)
            }
            .reduce([]) {
                $0 + $1.filter{ value in abs(value) > 1e-11}
            }
        
        return (rowIndices, columnStarts, values)
        
    }
    else{
        //           var attributes = SparseAttributes_t()
        var columnStarts = [Int ]()
        let colArrays = (0 ..< columns).map {
            zip(Array(0 ..< rows), lhs[column: $0])
                .map { (idx, value) in
                    abs(value) < 1e-8  ? -1: idx
                }
        }
        
        
        var rowIndices:[Int32] = colArrays.reduce([]) { partialResult, val in
            let valFiltered = val.filter {$0 != -1}.map {Int32($0)}
            columnStarts.append(partialResult.count)
            return partialResult + valFiltered
        }
        columnStarts.append(rowIndices.count)
        
        
        let values = (0 ..< columns)
            .map{lhs[column: $0]}
            .reduce([]) {$0 + $1.filter{ value in abs(value) > 1e-8}}
        
        return (rowIndices, columnStarts, values)
        
    }
}
//}

@available(macOS 10.13, *)
public func choleskyDecomposition(_ lhs: Matrix<Float>) throws -> Matrix<Float>{
    precondition(lhs.isPositiveDefined())
    
    let rows = Int32(lhs.rows)
    let colomns = Int32(lhs.columns)
    var (rowIndices, columnStarts, values) = toSparseFormat(lhs)
    
    var identifiedFlatten = Matrix<Float>.identity(size: Int(rows)).reduce([]) { partialResult, next in
        partialResult + next
    }
    
    rowIndices.withUnsafeMutableBufferPointer { rowIndicesPtr in
        columnStarts.withUnsafeMutableBufferPointer { columnStartsPtr in
            values.withUnsafeMutableBufferPointer { valuePtr in
                identifiedFlatten.withUnsafeMutableBufferPointer { idtPtr in
                    
                    var attributes = SparseAttributes_t()
                    attributes.triangle = SparseLowerTriangle
                    attributes.kind = SparseSymmetric
                    
                    let structure: SparseMatrixStructure =  SparseMatrixStructure(
                        rowCount: rows,
                        columnCount: colomns,
                        columnStarts: columnStartsPtr.baseAddress!,
                        rowIndices: rowIndicesPtr.baseAddress!,
                        attributes: attributes,
                        blockSize: 1
                    )
                    
                    let a = SparseMatrix_Float(
                        structure: structure,
                        data: valuePtr.baseAddress!
                    )
                    
                    let llt: SparseOpaqueFactorization_Float = SparseFactor(SparseFactorizationCholesky, a)
                    
                    let subFactor = SparseCreateSubfactor(SparseSubfactorL, llt)
                    
                    let sparseAs = SparseAttributes_t(transpose: false,
                                                      triangle: SparseLowerTriangle,
                                                      kind: SparseOrdinary,
                                                      _reserved: 0,
                                                      _allocatedBySparse: false)
                    
                    let identifiedDense = DenseMatrix_Float(rowCount: rows, columnCount: rows, columnStride: rows, attributes: sparseAs, data: idtPtr.baseAddress!)
                    defer{

                        SparseCleanup(a)
                        SparseCleanup(llt)
                        SparseCleanup(subFactor)
                    
                    }
                    
                    SparseMultiply(subFactor, identifiedDense)
                }
    
            }
        }
    }
    return transpose(Matrix<Float>(rows: Int(rows), columns: Int(colomns), grid: identifiedFlatten))
}


@available(macOS 10.13, *)
public func choleskyDecomposition(_ lhs: Matrix<Double>) throws -> Matrix<Double>{
//    precondition(lhs.isPositiveDefined())
    
    let rows = Int32(lhs.rows)
    let colomns = Int32(lhs.columns)
    var (rowIndices, columnStarts, values) = toSparseFormat(lhs)
    
    var identifiedFlatten = Matrix<Double>.identity(size: Int(rows)).reduce([]) { partialResult, next in
        partialResult + next
    }
    
    rowIndices.withUnsafeMutableBufferPointer { rowIndicesPtr in
        columnStarts.withUnsafeMutableBufferPointer { columnStartsPtr in
            values.withUnsafeMutableBufferPointer { valuePtr in
                identifiedFlatten.withUnsafeMutableBufferPointer { idtPtr in
                    
                    var attributes = SparseAttributes_t()
                    attributes.triangle = SparseLowerTriangle
                    attributes.kind = SparseSymmetric
                    
                    let structure: SparseMatrixStructure =  SparseMatrixStructure(
                        rowCount: rows,
                        columnCount: colomns,
                        columnStarts: columnStartsPtr.baseAddress!,
                        rowIndices: rowIndicesPtr.baseAddress!,
                        attributes: attributes,
                        blockSize: 1
                    )
                    
                    let a = SparseMatrix_Double(
                        structure: structure,
                        data: valuePtr.baseAddress!
                    )
                    
                    let llt: SparseOpaqueFactorization_Double = SparseFactor(SparseFactorizationCholesky, a)
                    
                    let subFactor = SparseCreateSubfactor(SparseSubfactorL, llt)
                    
                    let sparseAs = SparseAttributes_t(transpose: false,
                                                      triangle: SparseLowerTriangle,
                                                      kind: SparseOrdinary,
                                                      _reserved: 0,
                                                      _allocatedBySparse: false)
                    
                    let identifiedDense = DenseMatrix_Double(rowCount: rows, columnCount: rows, columnStride: rows, attributes: sparseAs, data: idtPtr.baseAddress!)
                    
                    defer{

                        SparseCleanup(a)
                        SparseCleanup(llt)
                        SparseCleanup(subFactor)
                    
                    }
                    
                    SparseMultiply(subFactor, identifiedDense)
                }
    
            }
        }
    }
    return transpose(Matrix<Double>(rows: Int(rows), columns: Int(colomns), grid: identifiedFlatten))
}
