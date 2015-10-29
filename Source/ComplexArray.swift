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

public class ComplexArray : ValueArray<Complex> {
    public typealias Index = Int
    public typealias Element = Complex

    public var reals: ComplexArrayRealSlice {
        get {
            return ComplexArrayRealSlice(base: self, startIndex: startIndex, endIndex: 2*endIndex - 1, step: 2)
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
            return ComplexArrayRealSlice(base: self, startIndex: startIndex + 1, endIndex: 2*endIndex, step: 2)
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
        super.init(capacity: capacity)
    }

    /// Construct an uninitialized ComplexArray with the given size
    public required init(count: Int) {
        super.init(count: count)
    }

    /// Construct a ComplexArray from an array literal
    public required init(arrayLiteral elements: Element...) {
        super.init(count: elements.count)
        mutablePointer.initializeFrom(elements)
    }

    /// Construct a ComplexArray from contiguous memory
    public required init<C : ContiguousMemory where C.Element == Element>(_ values: C) {
        super.init(values)
    }

    /// Construct a ComplexArray of `count` elements, each initialized to `repeatedValue`.
    public required init(count: Int, repeatedValue: Element) {
        super.init(count: count, repeatedValue: repeatedValue)
    }
}
