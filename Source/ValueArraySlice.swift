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

/// A slice of a `ValueArray`. Slices not only specify start and end indexes, they also specify a step size.
public struct ValueArraySlice<Element: Value> : ContiguousMutableMemory, MutableIndexable, CustomStringConvertible {
    public typealias Index = Int

    var base: ValueArray<Element>
    public var startIndex: Int
    public var endIndex: Int
    public var step: Int

    public var pointer: UnsafePointer<Element> {
        return base.pointer
    }

    public var mutablePointer: UnsafeMutablePointer<Element> {
        return base.mutablePointer
    }

    public init(base: ValueArray<Element>, startIndex: Int, endIndex: Int, step: Int) {
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

    public var description: String {
        var string = "["
        for var i = startIndex; i < endIndex; i += step {
            let v = base[i]
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
}
