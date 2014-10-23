//
//  SurgeExponentialTests.swift
//  Surge
//
//  Created by adachi yuichi on 2014/10/24.
//  Copyright (c) 2014年 Mattt Thompson. All rights reserved.
//

import XCTest
import Surge

class SurgeExponentialTests: XCTestCase {

    func testExp() {
        var elist = [Double]()
        var etoTwo = exp(2.0)
        var etoThree = exp(3.0)
        
        self.measureBlock() {
            elist = exp([2.0, 3.0])
        }
        
        XCTAssertEqual(elist, [etoTwo, etoThree], "incollect exp")
    }
    
    func testExp2() {
        var twolist = [Double]()
        var twoToTwelve = exp2(12.0)
        var twoToNine = exp2(9.0)
        var twoToFive = exp2(5.0)
        
        self.measureBlock() {
            twolist = exp2([12.0, 9.0, 5.0])
        }
        
        XCTAssertEqual(twolist, [twoToTwelve, twoToNine, twoToFive], "incollect exp2")
    }
}
