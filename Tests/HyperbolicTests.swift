// HyperbolicTests.swift
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
import Surge
import XCTest

class HyperbolicTests: XCTestCase {
    let n = 10000

    func test_sinh() {
        let values = (0...n).map{_ in drand48() * M_PI}
        measureAndValidateMappedFunctionWithAccuracy(source: values, member: sinh, mapped: sinh, accuracy: 0.0001)
    }

    func test_cosh() {
        let values = (0...n).map{_ in drand48() * M_PI}
        measureAndValidateMappedFunctionWithAccuracy(source: values, member: cosh, mapped: cosh, accuracy: 0.0001)
    }

    func test_tanh() {
        let values = (0...n).map{_ in drand48() * M_PI}
        measureAndValidateMappedFunctionWithAccuracy(source: values, member: tanh, mapped: tanh, accuracy: 0.0001)
    }

//    func test_asinh() {
//        let values = map(0...n){_ in drand48()}
//        measureAndValidateMappedFunctionWithAccuracy(values, member: asinh, mapped: asinh, accuracy: 0.0001)
//    }
//
//    func test_acosh() {
//        let values = map(0...n){_ in drand48()}
//        measureAndValidateMappedFunctionWithAccuracy(values, member: acosh, mapped: acosh, accuracy: 0.0001)
//    }
//
//    func test_atanh() {
//        let values = map(0...n){_ in drand48()}
//        measureAndValidateMappedFunctionWithAccuracy(values, member: atanh, mapped: atanh, accuracy: 0.0001)
//    }
}
