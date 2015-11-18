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


public class Tensor<ElementType where ElementType: CustomStringConvertible, ElementType: Equatable> : Equatable {
    public typealias Index = [Int]
    public typealias Element = ElementType
    
    public var dimensions: [Int]
    public var elements: ValueArray<Element>
    public var count: Int { return dimensions.reduce(1, combine: *) }
    
    public var pointer: UnsafePointer<Element> {
        return elements.pointer
    }
    
    public var mutablePointer: UnsafeMutablePointer<Element> {
        return elements.mutablePointer
    }
    
    public init<M: ContiguousMemory where M.Element == Element>(dimensions: [Int], elements: M) {
        assert(dimensions.reduce(1, combine: *) == elements.count)
        self.dimensions = dimensions
        self.elements = ValueArray(elements)
    }
    
    public init(matrix: Matrix<ElementType>) {
        self.dimensions = [matrix.rows, matrix.columns]
        self.elements = matrix.elements
    }
    
    public init(dimensions: [Int]) {
        self.dimensions = dimensions
        self.elements = ValueArray(count: dimensions.reduce(1, combine: *))
    }
    
    public init(dimensions: [Int], repeatedValue: Element) {
        self.dimensions = dimensions
        self.elements = ValueArray(count: dimensions.reduce(1, combine: *), repeatedValue: repeatedValue)
    }
    
    public subscript(indices: Int...) -> Element {
        get {
            return self[indices]
        }
        set {
            self[indices] = newValue
        }
    }

    public subscript(indices: Index) -> Element {
        get {
            assert(indexIsValid(indices))
            let index = constructIndex(indices)
            return elements[index]
        }
        set {
            assert(indexIsValid(indices))
            let index = constructIndex(indices)
            elements[index] = newValue
        }
    }
    
    public subscript(ranges: IntegerRange...) -> TensorSlice<Element> {
        get {
            return self[ranges]
        }
        set {
            self[ranges] = newValue
        }
    }
    
    public subscript(ranges: [IntegerRange]) -> TensorSlice<Element> {
        get {
            return self[Span(index: ranges)]
        }
        set {
            self[Span(index: ranges)] = newValue
        }
    }

    public subscript(span: Span) -> TensorSlice<Element> {
        get {
            assert(spanIsValid(span))
            return TensorSlice(base: self, span: span)
        }
        set {
            assert(spanIsValid(span))
            var tensorSlice = TensorSlice(base: self, span: span)
            let index = Span(index: tensorSlice.dimensions.map{ 0..<$0 })
            tensorSlice[index] = newValue
        }
    }
    
    /**
     Extract a matrix from the tensor.

     - Precondition: All but the last two elements of the span must be an specific index, not a range. If the second-last element is a range, the last element must span the full dimension.
     */
    public func extractMatrix(span: Span) -> Matrix<Element> {
        assert(spanIsValid(span))
        span.index[0..<span.dimensions.count - 2].forEach{ assert($0.count == 1) }
        if span[span.dimensions.count - 2].count != 1 {
            assert(span.index.last!.count == dimensions.last!)
        }
                
        let rows = span[span.dimensions.count - 2].count
        let columns = span[span.dimensions.count - 1].count
        
        let pointerOffset = constructIndex(span.startIndex)
        let count = span.count
        
        return Matrix(rows: rows, columns: columns, elements: elements[pointerOffset..<pointerOffset + count])
    }
    
    public func extractMatrix(ranges: IntegerRange...) -> Matrix<Element> {
        return extractMatrix(Span(index: ranges))
    }
    
    public func copy() -> Tensor {
        let copy = elements.copy()
        return Tensor(dimensions: dimensions, elements: copy)
    }
    
    private func constructIndex(indices: Index) -> Int {
        assert(indexIsValid(indices))
        var index = indices[0]
        for (i, dim) in dimensions[1..<dimensions.count].enumerate() {
            index = (dim * index) + indices[i+1]
        }
        return index
    }
    
    public func indexIsValid(indices: Index) -> Bool {
        assert(indices.count == dimensions.count)
        for (i, index) in indices.enumerate() {
            if index < 0 && dimensions[i] <= index {
                return false
            }
        }
        return true
    }
    
    public func spanIsValid(span: Span) -> Bool {
        assert(span.dimensions.count == dimensions.count)
        for (i, range) in span.enumerate() {
            if range.startIndex < 0 && dimensions[i] <= range.endIndex {
                return false
            }
        }
        return true
    }
}

// MARK: - Equatable

public func ==<T: Equatable>(lhs: Tensor<T>, rhs: Tensor<T>) -> Bool {
    return lhs.elements == rhs.elements
}

// MARK: -

public func swap<T>(lhs: Tensor<T>, rhs: Tensor<T>) {
    swap(&lhs.dimensions, &rhs.dimensions)
    swap(&lhs.elements, &rhs.elements)
}
