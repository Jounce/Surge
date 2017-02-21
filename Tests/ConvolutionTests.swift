// ConvolutionTests.swift
//
// Copyright (c) 2014–2015 Mattt Thompson (http://mattt.me)
// Copyright (c) 2015-2016 Remy Prechelt
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
import Surge
import XCTest

class ConvolutionTests: XCTestCase {
    let floatAccuracy:Float = 0.00000001
    let doubleAccuracy:Double = 0.00000000001
    
    // MARK: Test Arrays - Float
    let a1f: [Float] = [0, 0, 1, 0, 0]
    let a2f: [Float] = [1, 0, 0]
    let b1f: [Float] = [0, 2, 3, 1, 5, 6]
    let b2f: [Float] = [0, 0, -1]
    let c1f: [Float] = [-1, 0, -2, 1, 3]
    let c2f: [Float] = [0, 0, 0, 0, 1]
    let d1f: [Float] = [1, 1]
    let d2f: [Float] = [0, 1]
    let e1f: [Float] = [0, 0, 0, 0, 0]
    let e2f: [Float] = [0, 0, 0]
    
    // MARK: Test Arrays - Double
    let a1d: [Double] = [0, 0, 1, 0, 0]
    let a2d: [Double] = [1, 0, 0]
    let b1d: [Double] = [0, 2, 3, 1, 5, 6]
    let b2d: [Double] = [0, 0, -1]
    let c1d: [Double] = [-1, 0, -2, 1, 3]
    let c2d: [Double] = [0, 0, 0, 0, 1]
    let d1d: [Double] = [1, 1]
    let d2d: [Double] = [0, 1]
    let e1d: [Double] = [0, 0, 0, 0, 0]
    let e2d: [Double] = [0, 0, 0]
    
    // MARK: Convolution - Float
    func test_conv_float() {
        let a3f: [Float] = [0, 0, 1, 0, 0, 0, 0]
        let b3f: [Float] = [0, 0, 0, -2, -3,  -1, -5, -6]
        let c3f: [Float] = [0, 0, 0, 0,  -1, 0, -2,  1, 3]
        let d3f: [Float] = [0, 1, 1]
        let e3f: [Float] = [0, 0, 0, 0, 0, 0, 0]
        
        
        XCTAssertArrayFloatEqualWithAccuracy(calcArray: conv(a1f, a2f), a3f, floatAccuracy)
        XCTAssertArrayFloatEqualWithAccuracy(calcArray: conv(b1f, b2f), b3f, floatAccuracy)
        XCTAssertArrayFloatEqualWithAccuracy(calcArray: conv(c1f, c2f), c3f, floatAccuracy)
        XCTAssertArrayFloatEqualWithAccuracy(calcArray: conv(d1f, d2f), d3f, floatAccuracy)
        XCTAssertArrayFloatEqualWithAccuracy(calcArray: conv(e1f, e2f), e3f, floatAccuracy)
    }
    
    // MARK: Convolution - Double
    func test_conv_double() {
        let a3d: [Double] = [0, 0, 1, 0, 0, 0, 0]
        let b3d: [Double] = [0, 0, 0, -2, -3,  -1, -5, -6]
        let c3d: [Double] = [0, 0, 0, 0,  -1, 0, -2,  1, 3]
        let d3d: [Double] = [0, 1, 1]
        let e3d: [Double] = [0, 0, 0, 0, 0, 0, 0]
        
        XCTAssertArrayDoubleEqualWithAccuracy(calcArray: conv(a1d, a2d), a3d, doubleAccuracy)
        XCTAssertArrayDoubleEqualWithAccuracy(calcArray: conv(b1d, b2d), b3d, doubleAccuracy)
        XCTAssertArrayDoubleEqualWithAccuracy(calcArray: conv(c1d, c2d), c3d, doubleAccuracy)
        XCTAssertArrayDoubleEqualWithAccuracy(calcArray: conv(d1d, d2d), d3d, doubleAccuracy)
        XCTAssertArrayDoubleEqualWithAccuracy(calcArray:  conv(e1d, e2d), e3d, doubleAccuracy)
    }

    // MARK: Cross-Correlation - Float
    func test_xcorr_float() {
        let a3f: [Float] = [0, 0, 0, 0, 0, 0,  1, 0, 0]
        let b3f: [Float] = [0, 0, 0, 0,  -2, -3,  -1, -5, -6, 0, 0]
        let c3f: [Float] = [-1,  0, -2,  1, 3,  0, 0, 0, 0]
        let d3f: [Float] = [1, 1, 0]
        let e3f: [Float] = [0, 0, 0, 0, 0, 0, 0, 0, 0]
        
        XCTAssertArrayFloatEqualWithAccuracy(calcArray: xcorr(a1f, a2f), a3f, floatAccuracy)
        XCTAssertArrayFloatEqualWithAccuracy(calcArray: xcorr(b1f, b2f), b3f, floatAccuracy)
        XCTAssertArrayFloatEqualWithAccuracy(calcArray: xcorr(c1f, c2f), c3f, floatAccuracy)
        XCTAssertArrayFloatEqualWithAccuracy(calcArray: xcorr(d1f, d2f), d3f, floatAccuracy)
        XCTAssertArrayFloatEqualWithAccuracy(calcArray: xcorr(e1f, e2f), e3f, floatAccuracy)
    }
    
    // MARK: Cross-Correlation - Double
    func test_xcorr_double() {
        let a3d: [Double] = [0, 0, 0, 0, 0, 0,  1, 0, 0]
        let b3d: [Double] = [0, 0, 0, 0,  -2, -3,  -1, -5, -6, 0, 0]
        let c3d: [Double] = [-1,  0, -2,  1, 3,  0, 0, 0, 0]
        let d3d: [Double] = [1, 1, 0]
        let e3d: [Double] = [0, 0, 0, 0, 0, 0, 0, 0, 0]
        
        XCTAssertArrayDoubleEqualWithAccuracy(calcArray: xcorr(a1d, a2d), a3d, doubleAccuracy)
        XCTAssertArrayDoubleEqualWithAccuracy(calcArray: xcorr(b1d, b2d), b3d, doubleAccuracy)
        XCTAssertArrayDoubleEqualWithAccuracy(calcArray: xcorr(c1d, c2d), c3d, doubleAccuracy)
        XCTAssertArrayDoubleEqualWithAccuracy(calcArray: xcorr(d1d, d2d), d3d, doubleAccuracy)
        XCTAssertArrayDoubleEqualWithAccuracy(calcArray: xcorr(e1d, e2d), e3d, doubleAccuracy)
    }
    
    // MARK: Auto-Correlation - Float
    func test_acorr_float() {
        let a3f: [Float] = [0, 0, 0, 0, 1, 0, 0, 0, 0]
        let b3f: [Float] = [0, 12, 28, 23, 44, 75, 44,  23, 28, 12, 0]
        let c3f: [Float] = [-3,  -1, -4,  1, 15, 1, -4, -1, -3]
        let d3f: [Float] = [1, 2, 1]
        let e3f: [Float] = [0, 0, 0, 0, 0, 0, 0, 0, 0]
        
        XCTAssertArrayFloatEqualWithAccuracy(calcArray: xcorr(a1f), a3f, floatAccuracy)
        XCTAssertArrayFloatEqualWithAccuracy(calcArray: xcorr(b1f), b3f, floatAccuracy)
        XCTAssertArrayFloatEqualWithAccuracy(calcArray: xcorr(c1f), c3f, floatAccuracy)
        XCTAssertArrayFloatEqualWithAccuracy(calcArray: xcorr(d1f), d3f, floatAccuracy)
        XCTAssertArrayFloatEqualWithAccuracy(calcArray: xcorr(e1f), e3f, floatAccuracy)
    }
    
    // MARK: Auto-Correlation - Double
    func test_acorr_double() {
        let a3d: [Double] = [0, 0, 0, 0, 1, 0, 0, 0, 0]
        let b3d: [Double] = [0, 12, 28, 23, 44, 75, 44,  23, 28, 12, 0]
        let c3d: [Double] = [-3,  -1, -4,  1, 15, 1, -4, -1, -3]
        let d3d: [Double] = [1, 2, 1]
        let e3d: [Double] = [0, 0, 0, 0, 0, 0, 0, 0, 0]
        
        XCTAssertArrayDoubleEqualWithAccuracy(calcArray: xcorr(a1d), a3d, doubleAccuracy)
        XCTAssertArrayDoubleEqualWithAccuracy(calcArray: xcorr(b1d), b3d, doubleAccuracy)
        XCTAssertArrayDoubleEqualWithAccuracy(calcArray: xcorr(c1d), c3d, doubleAccuracy)
        XCTAssertArrayDoubleEqualWithAccuracy(calcArray: xcorr(d1d), d3d, doubleAccuracy)
        XCTAssertArrayDoubleEqualWithAccuracy(calcArray: xcorr(e1d), e3d, doubleAccuracy)
    }
    
}
