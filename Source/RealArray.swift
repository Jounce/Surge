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

import Foundation

/// A real number
public typealias Real = Double


/// A `RealArray` is similar to an `Array` but it's a `class` instead of a `struct` and it has a fixed size. As opposed to an `Array`, assiging a `RealArray` to a new variable will not create a copy, it only creates a new reference. If any reference is modified all other references will reflect the change. To copy a `RealArray` you have to explicitly call `copy()`.
public final class RealArray : CollectionType, MutableCollectionType, ArrayLiteralConvertible {
    public typealias Element = Real
    private var buffer: ManagedBuffer<Int, Element>

    public var count: Int {
        return buffer.value
    }

    public var startIndex: Int {
        return 0
    }

    public var endIndex: Int {
        return count
    }

    /// A pointer to the RealArray's memory
    public var pointer: UnsafeMutablePointer<Element> {
        return buffer.withUnsafeMutablePointerToElements { $0 }
    }

    /// Construct an uninitialized RealArray of the given size
    public init(size: Int) {
        buffer = ManagedBuffer<Int, Element>.create(size, initialValue: { _ in size })
    }

    /// Construct a RealArray from an array literal
    public convenience init(arrayLiteral elements: Element...) {
        self.init(size: elements.count)
        pointer.initializeFrom(elements)
    }

    /// Construct a RealArray from an array of reals
    public convenience init(array elements: [Element]) {
        self.init(size: elements.count)
        pointer.initializeFrom(elements)
    }

    /// Construct a RealArray of `count` elements, each initialized to `repeatedValue`.
    public convenience init(count: Int, repeatedValue: Element) {
        self.init(size: count)
        for i in 0..<count {
            self[i] = repeatedValue
        }
    }

    public subscript(index: Int) -> Element {
        get {
            precondition(0 <= index && index < count)
            return pointer[index]
        }
        set {
            precondition(0 <= index && index < count)
            pointer[index] = newValue
        }
    }

    public func copy() -> RealArray {
        let copy = RealArray(size: count)
        copy.pointer.initializeFrom(pointer, count: count)
        return copy
    }
}

extension RealArray : CustomStringConvertible, CustomDebugStringConvertible {
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

extension RealArray: Comparable { }

public func == (lhs: RealArray, rhs: RealArray) -> Bool {
    for (a, b) in zip(lhs, rhs) {
        if a != b {
            return false
        }
    }
    return true
}

public func < (lhs: RealArray, rhs: RealArray) -> Bool {
    for (a, b) in zip(lhs, rhs) {
        if a >= b {
            return false
        }
    }
    return true}

public func <= (lhs: RealArray, rhs: RealArray) -> Bool {
    for (a, b) in zip(lhs, rhs) {
        if a > b {
            return false
        }
    }
    return true}

public func > (lhs: RealArray, rhs: RealArray) -> Bool {
    for (a, b) in zip(lhs, rhs) {
        if a <= b {
            return false
        }
    }
    return true}

public func >= (lhs: RealArray, rhs: RealArray) -> Bool {
    for (a, b) in zip(lhs, rhs) {
        if a < b {
            return false
        }
    }
    return true
}


public func swap(inout lhs: RealArray, inout rhs: RealArray) {
    swap(&lhs.buffer, &rhs.buffer)
}
