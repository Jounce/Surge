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

public class Matrix<ElementType> {
    public typealias Index = (Int, Int)
    public typealias Element = ElementType
    
    public var rows: Int
    public var columns: Int
    public var elements: ValueArray<Element>
    
    public var pointer: UnsafePointer<Element> {
        return elements.pointer
    }
    
    public var mutablePointer: UnsafeMutablePointer<Element> {
        return elements.mutablePointer
    }
    
    /// Construct a Matrix of `rows` by `columns` with every the given elements in row-major order
    public init<M: ContiguousMemory where M.Element == Element>(rows: Int, columns: Int, elements: M) {
        assert(rows * columns == elements.count)
        self.rows = rows
        self.columns = columns
        self.elements = ValueArray(elements)
    }

    /// Construct a Matrix of `rows` by `columns` with uninitialized elements
    public init(rows: Int, columns: Int) {
        self.rows = rows
        self.columns = columns
        self.elements = ValueArray(count: rows * columns)
    }

    /// Construct a Matrix of `rows` by `columns` with elements initialized to repeatedValue
    public init(rows: Int, columns: Int, repeatedValue: Element) {
        self.rows = rows
        self.columns = columns
        self.elements = ValueArray(count: rows * columns, repeatedValue: repeatedValue)
    }
    
    /// Construct a Matrix from an array of rows
    public convenience init(_ contents: [[Element]]) {
        let rows = contents.count
        let cols = contents[0].count

        self.init(rows: rows, columns: cols)

        for (i, row) in contents.enumerate() {
            elements.replaceRange(i*cols..<i*cols+min(cols, row.count), with: row)
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

    public func row(index: Int) -> ValueArraySlice<Element> {
        return ValueArraySlice<Element>(base: elements, startIndex: index * columns, endIndex: (index + 1) * columns, step: 1)
    }

    public func column(index: Int) -> ValueArraySlice<Element> {
        return ValueArraySlice<Element>(base: elements, startIndex: index, endIndex: rows * columns - columns + index + 1, step: columns)
    }

    public func copy() -> Matrix {
        let copy = elements.copy()
        return Matrix(rows: rows, columns: columns, elements: copy)
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
    public func generate() -> AnyGenerator<MutableSlice<ValueArray<Element>>> {
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

// MARK: - Equatable

public func ==<T: Equatable>(lhs: Matrix<T>, rhs: Matrix<T>) -> Bool {
    return lhs.elements == rhs.elements
}

// MARK: -

public func swap<T>(lhs: Matrix<T>, rhs: Matrix<T>) {
    swap(&lhs.rows, &rhs.rows)
    swap(&lhs.columns, &rhs.columns)
    swap(&lhs.elements, &rhs.elements)
}
