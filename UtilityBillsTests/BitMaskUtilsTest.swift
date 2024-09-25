//
//  BitMaskUtilsTest.swift
//  UtilityBillsTests
//
//  Created by Sergey on 25.09.2024.
//

import Foundation

import XCTest
@testable import UtilityBills

final class BitMaskUtilsTest: XCTestCase {
    func test_arrayToBitmap_allTrue() {
        let array = [Bool].init(repeating: true, count: 12)
        let val = try! arrayToBitMask(array)
        XCTAssertEqual(val, 4095)
    }
    
    func test_arrayToBitmap_allFalse() {
        let array = [Bool].init(repeating: false, count: 12)
        let val = try! arrayToBitMask(array)
        XCTAssertEqual(val, 0)
    }
    
    func test_arrayToBitmap_firstTrue() {
        var array = [Bool].init(repeating: false, count: 12)
        array[0].toggle()
        let val = try! arrayToBitMask(array)
        XCTAssertEqual(val, 1)
    }
}
