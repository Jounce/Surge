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

/// A `RealArray` is similar to an `Array` but it's a `class` instead of a `struct` and it has a fixed size. As opposed to an `Array`, assiging a `RealArray` to a new variable will not create a copy, it only creates a new reference. If any reference is modified all other references will reflect the change. To copy a `RealArray` you have to explicitly call `copy()`.
public final class RealArray : MutableCollectionType, ArrayLiteralConvertible {
    public typealias Element = Real
    private var buffer: ManagedBuffer<(Int, Int), Element>

    public var count: Int {
        get {
            return buffer.value.0
        }
        set {
            buffer.value.0 = newValue
        }
    }

    public var capacity: Int {
        return buffer.value.1
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

    /// Construct an uninitialized RealArray with the given capacity
    public init(capacity: Int) {
        buffer = ManagedBuffer<(Int, Int), Element>.create(capacity, initialValue: { _ in (0, capacity) })
    }

    /// Construct an uninitialized RealArray with the given size
    public init(count: Int) {
        buffer = ManagedBuffer<(Int, Int), Element>.create(count, initialValue: { _ in (count, count) })
    }

    /// Construct a RealArray from an array literal
    public convenience init(arrayLiteral elements: Element...) {
        self.init(capacity: elements.count)
        pointer.initializeFrom(elements)
        count = capacity
    }

    /// Construct a RealArray from an array of reals
    public convenience init<C : CollectionType where C.Generator.Element == Element>(_ c: C) {
        self.init(capacity: Int(c.count.toIntMax()))
        pointer.initializeFrom(c)
        count = capacity
    }

    /// Construct a RealArray of `count` elements, each initialized to `repeatedValue`.
    public convenience init(count: Int, repeatedValue: Element) {
        self.init(capacity: count)
        for i in 0..<count {
            self[i] = repeatedValue
        }
        self.count = count
    }

    public subscript(index: Int) -> Element {
        get {
            precondition(0 <= index && index < capacity)
            return pointer[index]
        }
        set {
            precondition(0 <= index && index < capacity)
            pointer[index] = newValue
        }
    }

    public func copy() -> RealArray {
        let copy = RealArray(capacity: capacity)
        copy.pointer.initializeFrom(pointer, count: count)
        copy.count = count
        return copy
    }

    public func append<C : CollectionType where C.Generator.Element == Element>(c: C) {
        let p = pointer + count
        p.initializeFrom(c)
        count += Int(c.count.toIntMax())
        precondition(count <= capacity)
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
    return true
}

public func <= (lhs: RealArray, rhs: RealArray) -> Bool {
    for (a, b) in zip(lhs, rhs) {
        if a > b {
            return false
        }
    }
    return true
}

public func > (lhs: RealArray, rhs: RealArray) -> Bool {
    for (a, b) in zip(lhs, rhs) {
        if a <= b {
            return false
        }
    }
    return true
}

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
