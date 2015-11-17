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


public struct IntegerRange : SequenceType, IntervalType, IntegerLiteralConvertible {
    public var start: Int
    public var end: Int
    public var count: Int {
        return end - start
    }
    public var isEmpty: Bool {
        return start == end
    }
    
    public init(integerLiteral value: Int) {
        start = value
        end = value + 1
    }
    
    public init(range: Swift.Range<Int>) {
        start = range.startIndex
        end = range.endIndex
    }
    
    public init(start: Int, end: Int) {
        self.start = start
        self.end = end
    }
    
    public func clamp(intervalToClamp: IntegerRange) -> IntegerRange {
        return IntegerRange(range: max(intervalToClamp.start, self.start)..<min(intervalToClamp.end, self.end))
    }
    
    public func generate() -> AnyGenerator<Int> {
        var current = start
        return anyGenerator{ current < self.end ? current++ : nil }
    }
    
    public subscript(index: Int) -> Int {
        return index
    }
}

public func ...(min: Int, max: Int) -> IntegerRange {
    return IntegerRange(start: min, end: max + 1)
}

public func ..<(min: Int, upper: Int) -> IntegerRange {
    return IntegerRange(start: min, end: upper)
}
