//  Copyright © 2015 Venture Media Labs. All rights reserved.

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
