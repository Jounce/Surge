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
