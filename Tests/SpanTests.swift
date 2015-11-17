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

import XCTest
import Upsurge

class RangedIndexTests: XCTestCase {
    var rangedDimension: IntegerRange?
    var indexedDimension: IntegerRange?
    var rangedIndex: Span?
    
    override func setUp() {
        rangedDimension = 4...7
        indexedDimension = 1
        rangedIndex = [0...1, 5, 3...4, 2...3, 0]
    }
    
    func testDimensionGenerator() {
        var result = [Int]()
        for i in rangedDimension! {
            result.append(i)
        }
        for i in indexedDimension! {
            result.append(i)
        }
        XCTAssertEqual(result, [4, 5, 6, 7, 1])
    }

    func testIndexGenerator() {
        var result = [[Int]]()
        for index in rangedIndex! {
            result.append(index)
        }
        let expected: [[Int]] = [
            [0, 5, 3, 2, 0],
            [0, 5, 3, 3, 0],
            [0, 5, 4, 2, 0],
            [0, 5, 4, 3, 0],
            [1, 5, 3, 2, 0],
            [1, 5, 3, 3, 0],
            [1, 5, 4, 2, 0],
            [1, 5, 4, 3, 0]
        ]
        
        XCTAssertEqual(result, expected)
    }
}
