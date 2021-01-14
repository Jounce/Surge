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

/// Mutable memory region.
public struct UnsafeMutableMemory<Element> {
    /// Pointer to the first element
    public var pointer: UnsafeMutablePointer<Element>

    /// Pointer stride between elements
    public var stride: Int

    /// Number of elements
    public var count: Int

    public init(pointer: UnsafeMutablePointer<Element>, stride: Int = 1, count: Int) {
        self.pointer = pointer
        self.stride = stride
        self.count = count
    }

    public func makeIterator() -> UnsafeMutableMemoryIterator<Element> {
        return UnsafeMutableMemoryIterator(self)
    }
}

public struct UnsafeMutableMemoryIterator<Element>: IteratorProtocol {
    let base: UnsafeMutableMemory<Element>
    var index: Int?

    public init(_ base: UnsafeMutableMemory<Element>) {
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

/// Protocol for mutable collections that can be accessed via `UnsafeMutableMemory`
public protocol UnsafeMutableMemoryAccessible: UnsafeMemoryAccessible {
    mutating func withUnsafeMutableMemory<Result>(_ body: (UnsafeMutableMemory<Element>) throws -> Result) rethrows -> Result
}

public func withUnsafeMutableMemory<L, Result>(_ lhs: inout L, _ body: (UnsafeMutableMemory<L.Element>) throws -> Result) rethrows -> Result where L: UnsafeMutableMemoryAccessible {
    return try lhs.withUnsafeMutableMemory(body)
}

public func withUnsafeMutableMemory<L, R, Result>(_ lhs: inout L, _ rhs: inout R, _ body: (UnsafeMutableMemory<L.Element>, UnsafeMutableMemory<R.Element>) throws -> Result) rethrows -> Result where L: UnsafeMutableMemoryAccessible, R: UnsafeMutableMemoryAccessible {
    return try lhs.withUnsafeMutableMemory { lhsMemory in
        try rhs.withUnsafeMutableMemory { rhsMemory in
            try body(lhsMemory, rhsMemory)
        }
    }
}

public func withUnsafeMutableMemory<L, R, Z, Result>(_ lhs: inout L, _ rhs: inout R, _ z: inout Z, _ body: (UnsafeMutableMemory<L.Element>, UnsafeMutableMemory<R.Element>, UnsafeMutableMemory<Z.Element>) throws -> Result) rethrows -> Result where L: UnsafeMutableMemoryAccessible, R: UnsafeMutableMemoryAccessible, Z: UnsafeMutableMemoryAccessible {
    return try lhs.withUnsafeMutableMemory { lhsMemory in
        try rhs.withUnsafeMutableMemory { rhsMemory in
            try z.withUnsafeMutableMemory { zm in
                try body(lhsMemory, rhsMemory, zm)
            }
        }
    }
}
