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


public struct TensorSlice<ElementType where ElementType: CustomStringConvertible, ElementType: Equatable> {
    public typealias RangedIndex = [RangedDimension]
    public typealias Index = [Int]
    public typealias Element = ElementType
    
    var base: Tensor<Element>
    let dimensions: [Int]
    
    public var slice: RangedIndex
    public var startIndices: [Int] {
        get {
            return slice.map{ $0.startIndex }
        }
    }
    public var endIndices: [Int] {
        get {
            return slice.map{ $0.endIndex - 1 }
        }
    }
    
    public var pointer: UnsafePointer<Element> {
        return base.pointer
    }
    
    public var mutablePointer: UnsafeMutablePointer<Element> {
        return base.mutablePointer
    }
    
    public init(base: Tensor<Element>, slice: RangedIndex) {
        assert(slice.count == base.dimensions.count)
        self.base = base
        self.slice = slice
        self.dimensions = slice.map{ $0.count }
    }
    
    public subscript(indices: Int...) -> Element {
        get {
            let index = indices.enumerate().map{ $1 + startIndices[$0] }
            assert(indexIsValid(index))
            return base[index]
        }
        set {
            let index = indices.enumerate().map{ $1 + dimensions[$0] }
            assert(indexIsValid(index))
            base[index] = newValue
        }
    }
    
    public subscript(indices: Index) -> Element {
        get {
            let index = indices.enumerate().map{ $1 + startIndices[$0] }
            assert(indexIsValid(index))
            return base[index]
        }
        set {
            let index = indices.enumerate().map{ $1 + startIndices[$0] }
            assert(indexIsValid(index))
            base[index] = newValue
        }
    }
    
    public subscript(slice: RangedIndex) -> TensorSlice<Element> {
        get {
            assert(slice.count == self.slice.count)
            let newSlice: RangedIndex = slice.enumerate().map{
                assert((0 <= $1.startIndex) && ($1.endIndex <= dimensions[$0]))
                return startIndices[$0] + $1.startIndex..<startIndices[$0] + $1.endIndex
            }
            return TensorSlice(base: base, slice: newSlice)
        }
        set {
            assignValues(newValue, dimensions: slice)
        }
    }
    
    public subscript(slice: RangedDimension...) -> TensorSlice<Element> {
        get {
            assert(slice.count == self.slice.count)
            let newSlice: RangedIndex = slice.enumerate().map{
                assert((0 <= $1.startIndex) && ($1.endIndex <= dimensions[$0]))
                return startIndices[$0] + $1.startIndex..<startIndices[$0] + $1.endIndex
            }
            return TensorSlice(base: base, slice: newSlice)
        }
        set {
            assignValues(newValue, dimensions: slice)
        }
    }
    
    private func assignValues(values: TensorSlice<Element>, dimensions: RangedIndex) {
        if dimensions.count == 1 {
            for i in dimensions[0] {
                var baseIndex = startIndices
                var valueIndex = [Int](count: self.dimensions.count, repeatedValue: 0)
                baseIndex[baseIndex.count - 1] += i
                valueIndex[valueIndex.count - 1] = i
                assert(indexIsValid(valueIndex) && base.indexIsValid(baseIndex))
                base[baseIndex] = values[valueIndex]
            }
        } else {
            var newDimensions: RangedIndex = self.dimensions.map{ 0..<$0 }
            for i in dimensions[0] {
                let index = newDimensions.count - dimensions.count
                newDimensions[index] = RangedDimension(integerLiteral: i)
                let newSlice = self[newDimensions]
                newSlice.assignValues(values[newDimensions], dimensions: RangedIndex(newDimensions[index + 1..<newDimensions.count]))
            }
        }
    }
    
    public func indexIsValid(indices: [Int]) -> Bool {
        assert(indices.count == dimensions.count)
        for (i, index) in indices.enumerate() {
            if index < 0 && dimensions[i] <= index {
                return false
            }
        }
        return true
    }
}
