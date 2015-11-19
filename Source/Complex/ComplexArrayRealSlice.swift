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

/// A slice of reals from a ComplexArray.
public struct ComplexArrayRealSlice : ContiguousMutableMemory, Equatable {
    public typealias Index = Int
    public typealias Element = Real

    var base: ValueArray<Complex>
    public var startIndex: Int
    public var endIndex: Int
    public var step: Int

    public var pointer: UnsafePointer<Element> {
        return UnsafePointer<Element>(base.pointer)
    }

    public var mutablePointer: UnsafeMutablePointer<Element> {
        return UnsafeMutablePointer<Element>(base.mutablePointer)
    }

    init(base: ValueArray<Complex>, startIndex: Int, endIndex: Int, step: Int) {
        self.base = base
        self.startIndex = startIndex
        self.endIndex = endIndex
        self.step = step
    }

    public subscript(index: Int) -> Element {
        get {
            let baseIndex = startIndex + index * step
            precondition(0 <= baseIndex && baseIndex < base.count)
            return pointer[baseIndex]
        }
        set {
            let baseIndex = startIndex + index * step
            precondition(0 <= baseIndex && baseIndex < base.count)
            mutablePointer[baseIndex] = newValue
        }
    }
}

public func ==(lhs: ComplexArrayRealSlice, rhs: ComplexArrayRealSlice) -> Bool {
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
