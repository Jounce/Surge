// Copyright (c) 2014–2015 Alejandro Isaza
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
@testable import Surge

class IntervalTests: XCTestCase {
    func testJoinContiguous() {
        let interval1 = Interval(min: 0.0, max: 1.0)
        let interval2 = Interval(min: 1.0, max: 2.0)
        let actual = join(interval1, interval2)
        let expected = Interval(min: 0.0, max: 2.0)
        XCTAssertEqual(actual.min, expected.min)
        XCTAssertEqual(actual.max, expected.max)
    }

    func testJoinGap() {
        let interval1 = Interval(min: 0.0, max: 1.0)
        let interval2 = Interval(min: 2.0, max: 3.0)
        let actual = join(interval1, interval2)
        let expected = Interval(min: 0.0, max: 3.0)
        XCTAssertEqual(actual.min, expected.min)
        XCTAssertEqual(actual.max, expected.max)
    }

    func testJoinInverted() {
        let interval1 = Interval(min: 1.0, max: 2.0)
        let interval2 = Interval(min: 0.0, max: 1.0)
        let actual = join(interval1, interval2)
        let expected = Interval(min: 0.0, max: 2.0)
        XCTAssertEqual(actual.min, expected.min)
        XCTAssertEqual(actual.max, expected.max)
    }

    func testJoinOverlap() {
        let interval1 = Interval(min: 0.0, max: 1.0)
        let interval2 = Interval(min: 0.0, max: 1.0)
        let actual = join(interval1, interval2)
        let expected = Interval(min: 0.0, max: 1.0)
        XCTAssertEqual(actual.min, expected.min)
        XCTAssertEqual(actual.max, expected.max)
    }

    func testJoinEmpty() {
        let interval1 = Interval(min: 1.0, max: 2.0)
        let interval2 = Interval.empty
        let actual = join(interval1, interval2)
        let expected = Interval(min: 1.0, max: 2.0)
        XCTAssertEqual(actual.min, expected.min)
        XCTAssertEqual(actual.max, expected.max)
    }

    func testIntersect() {
        let interval1 = Interval(min: 0.0, max: 1.0)
        let interval2 = Interval(min: 0.5, max: 1.5)
        let actual = intersect(interval1, interval2)
        let expected = Interval(min: 0.5, max: 1.0)
        XCTAssertEqual(actual.min, expected.min)
        XCTAssertEqual(actual.max, expected.max)
    }

    func testIntersectInverted() {
        let interval1 = Interval(min: 0.5, max: 1.5)
        let interval2 = Interval(min: 0.0, max: 1.0)
        let actual = intersect(interval1, interval2)
        let expected = Interval(min: 0.5, max: 1.0)
        XCTAssertEqual(actual.min, expected.min)
        XCTAssertEqual(actual.max, expected.max)
    }

    func testIntersectDisjoint() {
        let interval1 = Interval(min: 0.0, max: 1.0)
        let interval2 = Interval(min: 2.0, max: 3.0)
        let actual = intersect(interval1, interval2)
        let expected = Interval.empty
        XCTAssertEqual(actual.min, expected.min)
        XCTAssertEqual(actual.max, expected.max)
    }

    func testIntersectSinglePoint() {
        let interval1 = Interval(min: 0.0, max: 1.0)
        let interval2 = Interval(min: 1.0, max: 2.0)
        let actual = intersect(interval1, interval2)
        let expected = Interval(min: 1.0, max: 1.0)
        XCTAssertEqual(actual.min, expected.min)
        XCTAssertEqual(actual.max, expected.max)
    }
}
