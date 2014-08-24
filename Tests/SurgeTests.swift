import Foundation
import Surge
import XCTest

class SurgeTests: XCTestCase {
    let count: Int = 100000000
    var repeatedValue: Double = Double(arc4random())
    var numbers: [Double] = []

    override func setUp() {
        self.numbers = [Double](count: count, repeatedValue: repeatedValue)
    }

//    func testPerformanceNaive() {
//        var sum: Double = 0.0
//
//        self.measureBlock() {
//            sum = reduce(self.numbers, 0.0, +)
//        }
//
//        XCTAssertEqualWithAccuracy(sum, repeatedValue * Double(count), 1.0, "incorrect sum")
//    }

    func testPerformanceSurge() {
        var sum: Double = 0.0
        self.measureBlock() {
            sum = Surge.sum(self.numbers)
        }

        XCTAssertEqualWithAccuracy(sum, repeatedValue * Double(count), 0.1, "incorrect sum")
    }
}
