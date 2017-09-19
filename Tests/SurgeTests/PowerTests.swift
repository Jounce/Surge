//
//  PowerTests.swift
//  Surge
//
//  Created by Wenbin Zhang on 2/13/16.
//  Copyright © 2016 Mattt Thompson. All rights reserved.
//

import XCTest
import Surge

class PowerTests: XCTestCase {
    
    let vector = [1.0, 2.0, 3.0, 4.0, 5.0, 6.0]
    
    func testPower() {
        let powered = pow(vector, 2.0)
        XCTAssertEqual(powered, [1.0, 4.0, 9.0, 16.0, 25.0, 36.0])
    }
}
