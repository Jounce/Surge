// Copyright © 2014-2018 the Surge contributors
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

/// Memory region.
public struct UnsafeMemory<Element>: Sequence {
    /// Pointer to the first element
    public var pointer: UnsafePointer<Element>

    /// Pointer stride between elements
    public var stride: Int

    /// Number of elements
    public var count: Int

    public init(pointer: UnsafePointer<Element>, stride: Int = 1, count: Int) {
        self.pointer = pointer
        self.stride = stride
        self.count = count
    }

    public func makeIterator() -> UnsafeMemoryIterator<Element> {
        return UnsafeMemoryIterator(self)
    }
}

public struct UnsafeMemoryIterator<Element>: IteratorProtocol {
    let base: UnsafeMemory<Element>
    var index: Int?

    public init(_ base: UnsafeMemory<Element>) {
        self.base = base
    }

    public mutating func next() -> Element? {
        let newIndex: Int
        if let index = index {
            newIndex = index + 1
        } else {
            newIndex = 0
        }

        if newIndex >= base.count {
            return nil
        }

        self.index = newIndex
        return base.pointer[newIndex * base.stride]
    }
}

/// Protocol for collections that can be accessed via `UnsafeMemory`
public protocol UnsafeMemoryAccessible: Collection {
    func withUnsafeMemory<Result>(_ body: (UnsafeMemory<Element>) throws -> Result) rethrows -> Result
}

public func withUnsafeMemory<X: UnsafeMemoryAccessible, Result>(_ x: X, _ body: (UnsafeMemory<X.Element>) throws -> Result) rethrows -> Result {
    return try x.withUnsafeMemory(body)
}

public func withUnsafeMemory<X: UnsafeMemoryAccessible, Y: UnsafeMemoryAccessible, Result>(_ x: X, _ y: Y, _ body: (UnsafeMemory<X.Element>, UnsafeMemory<Y.Element>) throws -> Result) rethrows -> Result {
    return try x.withUnsafeMemory { xm in
        try y.withUnsafeMemory { ym in
            try body(xm, ym)
        }
    }
}
