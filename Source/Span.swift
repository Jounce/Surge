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


/// Span is a collection of Ranges to specify a multi-dimensional slice of a Tensor.
public struct Span : ArrayLiteralConvertible, SequenceType {
    public typealias Element = IntegerRange
    
    public var span: [Element]
    public var startIndex: [Int] {
        return span.map{ $0.start }
    }
    public var endIndex: [Int] {
        return span.map{ $0.end }
    }
    
    public var count: Int {
        return dimensions.reduce(1, combine: *)
    }
    public var dimensions: [Int] {
        return span.map{ $0.count }
    }
    
    public init(span: [Element]) {
        self.span = span
    }
    
    public init(arrayLiteral elements: Element...) {
        self.init(span: elements)
    }
    
    public init(dimensions: [Int], elements: [Interval]) {
        var span = [Element]()
        for (dimension, interval) in zip(dimensions, elements) {
            switch interval {
            case .All:
                span.append(0..<dimension)
            case .Range(let range):
                span.append(range)
            }
        }
        self.init(span: span)
    }
    
    public init(zeroTo dimensions: [Int]) {
        let start = [Int](count: dimensions.count, repeatedValue: 0)
        self.init(start: start, end: dimensions)
    }
    
    public init(start: [Int], end: [Int]) {
        span = zip(start, end).map{ $0..<$1 }
    }
    
    public init(start: [Int], length: [Int]) {
        let end = zip(start, length).map{ $0 + $1 }
        self.init(start: start, end: end)
    }
    
    public init(base: [Int], subSpan: Span) {
        let start = zip(base, subSpan.startIndex).map{ $0 + $1 }
        let length = subSpan.span.map{ $0.count }
        self.init(start: start, length: length)
    }
    
    public func generate() -> SpanGenerator {
        return SpanGenerator(span: self)
    }
    
    public subscript(index: Int) -> Element {
        return self.span[index]
    }
}

public class SpanGenerator: GeneratorType {
    private var span: Span
    private var presentIndex: [Int]
    private var kill = false
    
    init(span: Span) {
        self.span = span
        self.presentIndex = span.startIndex
    }
    
    public func next() -> [Int]? {
        return incrementIndex(presentIndex.count - 1)
    }
    
    func incrementIndex(position: Int) -> [Int]? {
        if position < 0 || span.count <= position || kill {
            return nil
        } else if presentIndex[position] + 1 < span[position].end {
            let result = presentIndex
            presentIndex[position] += 1
            return result
        } else {
            guard let result = incrementIndex(position - 1) else {
                kill = true
                return presentIndex
            }
            presentIndex[position] = span[position].start
            return result
        }
    }
}

// MARK: - Dimensional Congruency

infix operator ≅ { precedence 130 }
public func ≅(lhs: Span, rhs: Span) -> Bool {
    let (max, min) = lhs.dimensions.count > rhs.dimensions.count ? (lhs, rhs) : (rhs, lhs)
    if (min.dimensions == max.dimensions) {
        return true
    } else if max.dimensions[0..<max.dimensions.count - min.dimensions.count].reduce(1, combine: *) == 1 && Array(max.dimensions[max.dimensions.count - min.dimensions.count..<max.dimensions.count]) == min.dimensions {
        return true
    }
    return false
}
