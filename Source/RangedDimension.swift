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


public struct RangedDimension : SequenceType, IntegerLiteralConvertible {
    public typealias Element = Int
    public var startIndex: Int
    public var endIndex: Int
    public var count: Int {
        return endIndex - startIndex
    }
    
    public init(integerLiteral value: Int) {
        startIndex = value
        endIndex = value + 1
    }
    
    public init(range: Range<Int>) {
        startIndex = range.startIndex
        endIndex = range.endIndex
    }
    
    public init(start: Int, end: Int) {
        startIndex = start
        endIndex = end
    }
    
    public func generate() -> AnyGenerator<Element> {
        var current = startIndex
        return anyGenerator{ current < self.endIndex ? current++ : nil }
    }
    
    public subscript(index: Int) -> Int {
        return index
    }
}

public func ...(min: Int, max: Int) -> RangedDimension {
    return RangedDimension(start: min, end: max + 1)
}

public func ..<(min: Int, upper: Int) -> RangedDimension {
    return RangedDimension(start: min, end: upper)
}