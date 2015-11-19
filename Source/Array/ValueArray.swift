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

/// A `ValueArray` is similar to an `Array` but it's a `class` instead of a `struct` and it has a fixed size. As opposed to an `Array`, assigning a `ValueArray` to a new variable will not create a copy, it only creates a new reference. If any reference is modified all other references will reflect the change. To copy a `ValueArray` you have to explicitly call `copy()`.
public class ValueArray<Element: Value> : ContiguousMutableMemory, MutableCollectionType, ArrayLiteralConvertible, Equatable, CustomStringConvertible {
    public typealias Index = Int

    public internal(set) var mutablePointer: UnsafeMutablePointer<Element>
    public internal(set) var capacity: Int
    public var count: Int

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
        return UnsafePointer<Element>(mutablePointer)
    }

    /// Construct an uninitialized ValueArray with the given capacity
    public required init(capacity: Int) {
        mutablePointer = UnsafeMutablePointer<Element>.alloc(capacity)
        self.capacity = capacity
        self.count = 0
    }

    /// Construct an uninitialized ValueArray with the given size
    public required init(count: Int) {
        mutablePointer = UnsafeMutablePointer<Element>.alloc(count)
        self.capacity = count
        self.count = count
    }

    /// Construct a ValueArray from an array literal
    public required init(arrayLiteral elements: Element...) {
        mutablePointer = UnsafeMutablePointer<Element>.alloc(elements.count)
        self.capacity = elements.count
        self.count = elements.count
        mutablePointer.initializeFrom(elements)
    }

    /// Construct a ValueArray from contiguous memory
    public required init<C : ContiguousMemory where C.Element == Element>(_ values: C) {
        mutablePointer = UnsafeMutablePointer<Element>.alloc(values.count)
        capacity = values.count
        count = values.count
        for var i = 0; i < count; i += 1 {
            mutablePointer[i] = values.pointer[values.startIndex + i * step]
        }
    }

    /// Construct a ValueArray of `count` elements, each initialized to `repeatedValue`.
    public required init(count: Int, repeatedValue: Element) {
        mutablePointer = UnsafeMutablePointer<Element>.alloc(count)
        capacity = count
        self.count = count
        for i in 0..<count {
            self[i] = repeatedValue
        }
    }

    deinit {
        mutablePointer.dealloc(capacity)
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

    public subscript(range: Swift.Range<Int>) -> ValueArraySlice<Element> {
        get {
            return ValueArraySlice<Element>(base: self, startIndex: range.startIndex, endIndex: range.endIndex, step: step)
        }
        set {
            for i in range {
                self[i] = newValue[i - range.startIndex]
            }
        }
    }

    public func copy() -> ValueArray {
        let copy = ValueArray(count: capacity)
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
    
    public var description: String {
        var string = "["
        for v in self {
            string += "\(v.description), "
        }
        if string.startIndex.distanceTo(string.endIndex) > 1 {
            let range = string.endIndex.advancedBy(-2)..<string.endIndex
            string.replaceRange(range, with: "]")
        } else {
            string += "]"
        }
        return string
    }

    public var debugDescription: String {
        return description
    }
}

public func ==<T>(lhs: ValueArray<T>, rhs: ValueArray<T>) -> Bool {
    if lhs.count != rhs.count {
        return false
    }

    for i in 0..<lhs.count {
        if lhs[i] != rhs[i] {
            return false
        }
    }
    return true
}

public func swap<T>(inout lhs: ValueArray<T>, inout rhs: ValueArray<T>) {
    swap(&lhs.mutablePointer, &rhs.mutablePointer)
    swap(&lhs.capacity, &rhs.capacity)
    swap(&lhs.count, &rhs.count)
}
