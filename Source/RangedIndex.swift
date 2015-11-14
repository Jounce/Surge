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


public struct RangedIndex : ArrayLiteralConvertible, SequenceType {
    public typealias Element = RangedDimension
    
    public var index: [Element]
    public var startIndex: [Int]
    public var endIndex: [Int]
    
    public var count: Int {
        return index.reduce(1){ (var a, b) in
            a *= b.count
            return a
        }
    }
    public var dimensions: [Int]
    
    public init(index: [Element]) {
        self.index = index
        self.startIndex = index.map{ $0.startIndex }
        self.endIndex = index.map{ $0.endIndex }
        self.dimensions = index.map{ $0.count }
    }
    
    public init(arrayLiteral elements: Element...) {
        index = elements
        startIndex = elements.map{ $0.startIndex }
        endIndex = elements.map{ $0.endIndex }
        self.dimensions = index.map{ $0.count }
    }
    
    public init(start: [Int], end: [Int]) {
        startIndex = start
        endIndex = end
        index = zip(start, end).map{ $0...$1 }
        self.dimensions = index.map{ $0.count }
    }
    
    public func generate() -> RangedIndexGenerator {
        return RangedIndexGenerator(rangedIndex: self)
    }
    
    public subscript(index: Int) -> Element {
        return self.index[index]
    }
}

public class RangedIndexGenerator: GeneratorType {
    private var rangedIndex: RangedIndex
    private var presentIndex: [Int]
    private var kill = false
    
    init(rangedIndex: RangedIndex) {
        self.rangedIndex = rangedIndex
        self.presentIndex = rangedIndex.startIndex
    }
    
    public func next() -> [Int]? {
        return incrementIndex(presentIndex.count - 1)
    }
    
    func incrementIndex(position: Int) -> [Int]? {
        if position < 0 || rangedIndex.count <= position || kill {
            return nil
        } else if presentIndex[position] + 1 < rangedIndex[position].endIndex {
            let result = presentIndex
            presentIndex[position] += 1
            return result
        } else {
            guard let result = incrementIndex(position - 1) else {
                kill = true
                return presentIndex
            }
            presentIndex[position] = rangedIndex[position].startIndex
            return result
        }
    }
}
