// XCTestCase+Surge.swift
//
// Copyright (c) 2014–2015 Mattt Thompson (http://mattt.me)
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

import Foundation
import XCTest

extension XCTestCase {
    func measureAndValidateMappedFunctionWithAccuracy<C : Collection>(source: C, member: (C.Iterator.Element) -> (C.Iterator.Element), mapped: @escaping (C) -> ([C.Iterator.Element]), accuracy: C.Iterator.Element) where C.Iterator.Element: ExpressibleByFloatLiteral & FloatingPoint {
        var expected = source.map(member)

        var actual: [C.Generator.Element] = []
        self.measure {
            actual = mapped(source)
        }
        
        for (i, _) in source.enumerated() {
            XCTAssertEqualWithAccuracy(actual[i], expected[i], accuracy: accuracy)
        }
    }
    
    func XCTAssertArrayFloatEqualWithAccuracy(calcArray: [Float], _ testArray: [Float], _ accuracy: Float) {
        assert(calcArray.count == testArray.count, "XCTAssertArrayFloatEqualWithAccuracy arrays must be same size")
        for i:Int in 0..<calcArray.count {
            XCTAssertEqualWithAccuracy(calcArray[i], testArray[i], accuracy: accuracy)
        }
    }
    
    func XCTAssertArrayDoubleEqualWithAccuracy(calcArray: [Double], _ testArray: [Double], _ accuracy: Double) {
        assert(calcArray.count == testArray.count, "XCTAssertArrayFloatEqualWithAccuracy arrays must be same size")
        for i:Int in 0..<calcArray.count {
            XCTAssertEqualWithAccuracy(calcArray[i], testArray[i], accuracy: accuracy)
        }
    }
}
