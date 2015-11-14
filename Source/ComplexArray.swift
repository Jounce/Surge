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

public class ComplexArray : ContiguousMutableMemory, MutableCollectionType, ArrayLiteralConvertible  {
    public typealias Index = Int
    public typealias Element = Complex

    var elements: ValueArray<Complex>

    public var count: Int {
        get {
            return elements.count
        }
        set {
            elements.count = newValue
        }
    }

    public var capacity: Int {
        return elements.capacity
    }

    public var startIndex: Index {
        return 0
    }

    public var endIndex: Index {
        return count
    }

    public var step: Index {
        return 1
    }

    public var pointer: UnsafePointer<Element> {
        return elements.pointer
    }

    public var mutablePointer: UnsafeMutablePointer<Element> {
        return elements.mutablePointer
    }

    public var reals: ComplexArrayRealSlice {
        get {
            return ComplexArrayRealSlice(base: elements, startIndex: startIndex, endIndex: 2*endIndex - 1, step: 2)
        }
        set {
            precondition(newValue.count == reals.count)
            for var i = 0; i < newValue.count; i += 1 {
                self.reals[i] = newValue[i]
            }
        }
    }

    public var imags: ComplexArrayRealSlice {
        get {
            return ComplexArrayRealSlice(base: elements, startIndex: startIndex + 1, endIndex: 2*endIndex, step: 2)
        }
        set {
            precondition(newValue.count == imags.count)
            for var i = 0; i < newValue.count; i += 1 {
                self.imags[i] = newValue[i]
            }
        }
    }

    public func generate() -> IndexingGenerator<ComplexArray> {
        return IndexingGenerator(self)
    }

    /// Construct an uninitialized ComplexArray with the given capacity
    public required init(capacity: Int) {
        elements = ValueArray<Complex>(capacity: capacity)
    }

    /// Construct an uninitialized ComplexArray with the given size
    public required init(count: Int) {
        elements = ValueArray<Complex>(count: count)
    }

    /// Construct a ComplexArray from an array literal
    public required init(arrayLiteral elements: Element...) {
        self.elements = ValueArray<Complex>(count: elements.count)
        mutablePointer.initializeFrom(elements)
    }

    /// Construct a ComplexArray from contiguous memory
    public required init<C : ContiguousMemory where C.Element == Element>(_ values: C) {
        elements = ValueArray<Complex>(values)
    }

    /// Construct a ComplexArray of `count` elements, each initialized to `repeatedValue`.
    public required init(count: Int, repeatedValue: Element) {
        elements = ValueArray<Complex>(count: count, repeatedValue: repeatedValue)
    }

    public subscript(index: Index) -> Element {
        get {
            precondition(0 <= index && index < capacity)
            assert(index < count)
            return pointer[index]
        }
        set {
            precondition(0 <= index && index < capacity)
            assert(index < count)
            mutablePointer[index] = newValue
        }
    }

    public func copy() -> ComplexArray {
        let copy = ComplexArray(count: capacity)
        copy.mutablePointer.initializeFrom(mutablePointer, count: count)
        return copy
    }

    public func append(value: Element) {
        precondition(count + 1 <= capacity)
        mutablePointer[count] = value
        count += 1
    }

    public func appendContentsOf<C : CollectionType where C.Generator.Element == Element>(values: C) {
        precondition(count + Int(values.count.toIntMax()) <= capacity)
        let endPointer = mutablePointer + count
        endPointer.initializeFrom(values)
        count += Int(values.count.toIntMax())
    }

    public func replaceRange<C: CollectionType where C.Generator.Element == Element>(subRange: Range<Index>, with newElements: C) {
        assert(subRange.startIndex >= startIndex && subRange.endIndex <= endIndex)
        (mutablePointer + subRange.startIndex).initializeFrom(newElements)
    }

    public func toRowMatrix() -> Matrix<Element> {
        return Matrix(rows: 1, columns: count, elements: self)
    }

    public func toColumnMatrix() -> Matrix<Element> {
        return Matrix(rows: count, columns: 1, elements: self)
    }
}
