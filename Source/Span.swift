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
struct Span : ArrayLiteralConvertible, SequenceType {
    typealias Element = Range<Int>
    
    var ranges: [Element]

    var startIndex: [Int] {
        return ranges.map{ $0.startIndex }
    }

    var endIndex: [Int] {
        return ranges.map{ $0.endIndex }
    }
    
    var count: Int {
        return dimensions.reduce(1, combine: *)
    }

    var dimensions: [Int] {
        return ranges.map{ $0.count }
    }
    
    init(ranges: [Element]) {
        self.ranges = ranges
    }
    
    init(arrayLiteral elements: Element...) {
        self.init(ranges: elements)
    }
    
    init(dimensions: [Int], elements: [Interval]) {
        var ranges = [Element]()
        for (dimension, interval) in zip(dimensions, elements) {
            switch interval {
            case .All:
                ranges.append(0..<dimension)
            case .Range(let range):
                ranges.append(range)
            }
        }
        self.init(ranges: ranges)
    }
    
    init(zeroTo dimensions: [Int]) {
        let start = [Int](count: dimensions.count, repeatedValue: 0)
        self.init(start: start, end: dimensions)
    }
    
    init(start: [Int], end: [Int]) {
        ranges = zip(start, end).map{ $0..<$1 }
    }
    
    init(start: [Int], length: [Int]) {
        let end = zip(start, length).map{ $0 + $1 }
        self.init(start: start, end: end)
    }
    
    init(base: [Int], subSpan: Span) {
        let start = zip(base, subSpan.startIndex).map{ $0 + $1 }
        let length = subSpan.ranges.map{ $0.count }
        self.init(start: start, length: length)
    }
    
    func generate() -> SpanGenerator {
        return SpanGenerator(span: self)
    }
    
    subscript(index: Int) -> Element {
        return self.ranges[index]
    }
}

class SpanGenerator: GeneratorType {
    private var span: Span
    private var presentIndex: [Int]
    private var kill = false
    
    init(span: Span) {
        self.span = span
        self.presentIndex = span.startIndex
    }
    
    func next() -> [Int]? {
        return incrementIndex(presentIndex.count - 1)
    }
    
    func incrementIndex(position: Int) -> [Int]? {
        if position < 0 || span.count <= position || kill {
            return nil
        } else if presentIndex[position] + 1 < span[position].endIndex {
            let result = presentIndex
            presentIndex[position] += 1
            return result
        } else {
            guard let result = incrementIndex(position - 1) else {
                kill = true
                return presentIndex
            }
            presentIndex[position] = span[position].startIndex
            return result
        }
    }
}

// MARK: - Dimensional Congruency

infix operator ≅ { precedence 130 }
func ≅(lhs: Span, rhs: Span) -> Bool {
    if lhs.dimensions.count == rhs.dimensions.count {
        return true
    }

    let (max, min) = lhs.dimensions.count > rhs.dimensions.count ? (lhs, rhs) : (rhs, lhs)
    let diff = max.dimensions.count - min.dimensions.count
    return max.dimensions[0..<diff].reduce(1, combine: *) == 1 && Array(max.dimensions[diff..<max.dimensions.count]) == min.dimensions
}
