import XCTest
import Surge

class RealArrayTests: XCTestCase {
    func testDescription() {
        let emptyRealArray: RealArray = []
        XCTAssertEqual(emptyRealArray.description, "[]")

        let realArray: RealArray = [1.0, 2.0, 3.0]
        XCTAssertEqual(realArray.description, "[1.0, 2.0, 3.0]")
    }

    func testCopy() {
        let a: RealArray = [1, 2, 3]
        let b = a.copy()
        b[0] = 4
        XCTAssertEqual(a[0], 1.0)
        XCTAssertEqual(b[0], 4.0)
    }

    func testSwap() {
        var a: RealArray = [1, 2, 3]
        var b: RealArray = [4]
        swap(&a, &b)

        XCTAssertEqual(a.count, 1)
        XCTAssertEqual(b.count, 3)
        XCTAssertEqual(a[0], 4.0)
        XCTAssertEqual(b[0], 1.0)
    }
}
