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


public struct TensorSlice<Element: Value> : Equatable {
    public typealias Index = [Int]
    
    var base: Tensor<Element>
    public let dimensions: [Int]
    public var count: Int {
        return dimensions.reduce(1, combine: *)
    }
    
    var span: Span

    public var pointer: UnsafePointer<Element> {
        return base.pointer
    }
    
    public var mutablePointer: UnsafeMutablePointer<Element> {
        return base.mutablePointer
    }
    
    init(base: Tensor<Element>, span: Span) {
        assert(span.dimensions.count == base.dimensions.count)
        self.base = base
        self.span = span
        self.dimensions = span.dimensions
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
            var index = span.startIndex
            let indexReplacementRage: Range<Int> = span.startIndex.count - indices.count..<span.startIndex.count
            index.replaceRange(indexReplacementRage, with: zip(index[indexReplacementRage], indices).map{ $0 + $1 })
            assert(indexIsValid(index))
            return base[index]
        }
        set {
            let index = indices.enumerate().map{ $1 + span.startIndex[$0] }
            assert(indexIsValid(index))
            base[index] = newValue
        }
    }
    
    public subscript(slice: [Interval]) -> TensorSlice<Element> {
        get {
            let span = Span(dimensions: dimensions, elements: slice)
            assert(spanIsValid(span))
            let baseSlice = Span(base: self.span.startIndex, subSpan: span)
            return TensorSlice(base: base, span: baseSlice)
        }
        set {
            let span = Span(dimensions: dimensions, elements: slice)
            assert(span ≅ newValue.span)
            for index in span  {
                let baseIndex = zip(self.span.startIndex, index).map{ $0 + $1 }
                base[baseIndex] = newValue[index]
            }
        }
    }
    
    public subscript(slice: Interval...) -> TensorSlice<Element> {
        get {
            return self[slice]
        }
        set {
            self[slice] = newValue
        }
    }
    
    subscript(span: Span) -> TensorSlice<Element> {
        get {
            assert(span.count == self.span.count)
            assert(spanIsValid(span))
            let baseSlice = Span(base: self.span.startIndex, subSpan: span)
            return TensorSlice(base: base, span: baseSlice)
        }
        set {
            assert(span ≅ newValue.span)
            for index in span  {
                let baseIndex = zip(self.span.startIndex, index).map{ $0 + $1 }
                base[baseIndex] = newValue[index]
            }
        }
    }
    
    public func indexIsValid(indices: [Int]) -> Bool {
        assert(indices.count == dimensions.count)
        for (i, index) in indices.enumerate() {
            if index < 0 && dimensions[i] <= index {
                return false
            }
        }
        return true
    }
    
    func spanIsValid(indices: Span) -> Bool {
        assert(indices.dimensions.count == dimensions.count)
        for (i, range) in indices.enumerate() {
            if range.startIndex < 0 && dimensions[i] <= range.endIndex {
                return false
            }
        }
        return true
    }
}

// MARK: - Equatable

public func ==<T: Equatable>(lhs: TensorSlice<T>, rhs: TensorSlice<T>) -> Bool {
    assert(lhs.span ≅ rhs.span)
    let slice = Span(zeroTo: lhs.dimensions)
    for index in slice {
        if lhs[index] != rhs[index] {
            return false
        }
    }
    return true
}

public func ==<T: Equatable>(lhs: TensorSlice<T>, rhs: Matrix<T>) -> Bool {
    assert(lhs.span ≅ Span(zeroTo: [rhs.rows, rhs.columns]))
    let slice = Span(zeroTo: lhs.dimensions)
    var i = 0
    for index in slice {
        if lhs[index] != rhs.elements[i] {
            return false
        }
        i += 1
    }
    return true
}

public func ==<T: Equatable>(lhs: Matrix<T>, rhs: TensorSlice<T>) -> Bool {
    assert(Span(zeroTo: [lhs.rows, lhs.columns]) ≅ rhs.span)
    let slice = Span(zeroTo: rhs.dimensions)
    var i = 0
    for index in slice {
        if rhs[index] != lhs.elements[i] {
            return false
        }
        i += 1
    }
    return true
}
