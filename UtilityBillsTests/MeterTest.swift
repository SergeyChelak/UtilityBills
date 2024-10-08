//
//  MeterTest.swift
//  UtilityBillsTests
//
//  Created by Sergey on 08.10.2024.
//

import XCTest
@testable import UtilityBills

final class MeterTest: XCTestCase {
    func test_meterNoInspectionDate() {
        let meter = Meter(
            id: MeterId(),
            name: "",
            capacity: nil,
            inspectionDate: nil
        )
        let state = meter.getInspectionState()
        XCTAssertEqual(state, .normal)
    }
    
    func test_meterExpiringDate() {
        let expirationDate = createDate(year: 2000, month: 1, day: 25)
        let currentDate = createDate(year: 2000, month: 1, day: 10)
                
        let meter = Meter(
            id: MeterId(),
            name: "",
            capacity: nil,
            inspectionDate: expirationDate
        )
        let state = meter.getInspectionState(currentDate)
        XCTAssertEqual(state, .expiring)
    }
    
    func test_meterOverdueDate() {
        let expirationDate = createDate(year: 2000, month: 1, day: 25)
        let currentDate = createDate(year: 2000, month: 2, day: 10)
                
        let meter = Meter(
            id: MeterId(),
            name: "",
            capacity: nil,
            inspectionDate: expirationDate
        )
        let state = meter.getInspectionState(currentDate)
        XCTAssertEqual(state, .overdue)
    }
    
    func test_meterExpiringDateInLongFuture() {
        let expirationDate = createDate(year: 2001, month: 1, day: 25)
        let currentDate = createDate(year: 2000, month: 1, day: 10)
                
        let meter = Meter(
            id: MeterId(),
            name: "",
            capacity: nil,
            inspectionDate: expirationDate
        )
        let state = meter.getInspectionState(currentDate)
        XCTAssertEqual(state, .normal)
    }
    
    private func createDate(year: Int, month: Int, day: Int) -> Date {
        let calendar = Calendar(identifier: .gregorian)
        let components = DateComponents(
            year: year,
            month: month,
            day: day,
            hour: 0,
            minute: 0,
            second: 0
        )
        return calendar.date(from: components)!
    }
}
