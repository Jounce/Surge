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

class TensorTests: XCTestCase {
    var t1: Tensor<Int>?
    var s1: TensorSlice<Int>?
    
    var t2: Tensor<Real>?
    var s2: TensorSlice<Real>?
    
    override func setUp() {
        super.setUp()
        /*
        in front:
        ⎛1, 2⎞
        ⎝2, 2⎠
        behind:
        ⎛5, 2⎞
        ⎝5, 1⎠
        */
        t1 = Tensor(dimensions: [2, 2, 2], elements: [1, 2, 2, 2, 5, 2, 5, 1])
        s1 = t1![1, 0...1, 0] // [5, 5]
        
        /*
        Cube 1:
        in front:
        ⎛6.4, 2.4⎞
        ⎝8.6, 0.2⎠
        behind:
        ⎛6.4, 1.5⎞
        ⎝7.3, 1.1⎠
        
        Cube 2:
        in front:
        ⎛6.0, 1.4⎞
        ⎝7.8, 9.2⎠
        behind:
        ⎛4.2, 6.1⎞
        ⎝8.7, 3.6⎠
        */
        t2 = Tensor(dimensions: [2, 2, 2, 2], elements: [6.4, 2.4, 8.6, 0.2, 6.4, 1.5, 7.3, 1.1, 6.0, 1.4, 7.8, 9.2, 4.2, 6.1, 8.7, 3.6])
        /*
        in front:
        ⎛6.4, 1.5⎞
        ⎝7.3, 1.1⎠
        behind:
        ⎛4.2, 6.1⎞
        ⎝8.7, 3.6⎠
        */
        s2 = t2![0...1, 1, 0...1, 0...1]

    }
    
    func testSlice() {
        XCTAssertEqual(t1![1, 1, 0], 5)
        XCTAssertEqual(t1![0, 0, 0], 1)
        
        XCTAssertEqual(s1![0, 0, 0], 5)
        XCTAssertEqual(s1![0, 1, 0], 5)
    }
    
    func testValueAssignment() {
        t1![0, 1, 1] = 16
        let expected = Tensor(dimensions: [2, 2, 2], elements: [1, 2, 2, 16, 5, 2, 5, 1])
        XCTAssertEqual(t1, expected)
    }
    
    func testSliceValueAssignment() {
        t2![1, 0...1, 0...1, 0...1] = t2![0, 0...1, 0...1, 0...1]
        let expected = Tensor(dimensions: [2, 2, 2, 2], elements: [6.4, 2.4, 8.6, 0.2, 6.4, 1.5, 7.3, 1.1, 6.4, 2.4, 8.6, 0.2, 6.4, 1.5, 7.3, 1.1])
        XCTAssertEqual(t2, expected)
        XCTAssertEqual(t2![1, 0...1, 0...1, 0...1], t2![0, 0...1, 0...1, 0...1])
    }
    
    func testMatrixExtraction() {
        var m = t2!.extractMatrix(1, 1, 0...1, 0...1)
        var expected = RealMatrix([[4.2, 6.1], [8.7, 3.6]])
        XCTAssertEqual(m, expected)
        
        m = t2!.extractMatrix(0, 1, 0, 1)
        expected = RealMatrix([[1.5]])
        XCTAssertEqual(m, expected)
    }
}
