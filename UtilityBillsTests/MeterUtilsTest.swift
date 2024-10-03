//
//  MeterUtilsTest.swift
//  UtilityBillsTests
//
//  Created by Sergey on 03.10.2024.
//

import XCTest
@testable import UtilityBills

final class MeterUtilsTest: XCTestCase {
    func test_diffWithZero_NoCapacity() {
        let left = Decimal(arc4random())
        let right: Decimal = 0
        let res = diff(left, right, capacity: nil)
        XCTAssertEqual(res, left)
    }
    
    func test_diff_NoCapacity() {
        for _ in 0..<1000 {
            let left = Decimal(arc4random())
            let right = Decimal(arc4random())
            let res = diff(left, right, capacity: nil)
            XCTAssertEqual(res, left - right)
        }
    }
    
    func test_diff_withCapacity() {
        let left = Decimal(99)
        let right = Decimal(2)
        let res = diff(left, right, capacity: 2)
        XCTAssertEqual(res, left - right)
    }
    
    func test_diffOverCapacity() {
        let left = Decimal(2)
        let right = Decimal(99)
        let res = diff(left, right, capacity: 2)
        XCTAssertEqual(res, 3)
    }
}
