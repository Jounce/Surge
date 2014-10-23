//
//  SurgeAuxiliaryTests.swift
//  Surge
//
//  Created by adachi yuichi on 2014/10/24.
//  Copyright (c) 2014年 Mattt Thompson. All rights reserved.
//

import XCTest
import Surge

class SurgeAuxiliaryTests: XCTestCase {

    func testCopySign() {
        var signs = [1.0, -1.0, 1.0, -1.0]
        var magnitudes = [-2.0, 3.0, 4.0, -5.0]
        var results = [Double]()
        
        self.measureBlock() {
            results = copysign(signs, magnitudes)
        }
        
        XCTAssertEqual(results, [2.0, -3.0, 4.0, -5.0], "incollect copysign")
    }
}
