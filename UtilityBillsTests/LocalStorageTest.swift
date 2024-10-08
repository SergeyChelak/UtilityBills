//
//  LocalStorageTest.swift
//  UtilityBillsTests
//
//  Created by Sergey on 31.08.2024.
//

import XCTest
@testable import UtilityBills

final class LocalStorageTest: XCTestCase {
    func test_emptyPropertyObjectFetch() {
        let storage: LocalStorage = .previewInstance()
        let result = try! storage.allProperties()
        XCTAssertTrue(result.isEmpty)
    }
    
    func test_insertPropertyObject() {
        let storage: LocalStorage = .previewInstance()
        try! storage.createProperty(.dumb())
        let result = try! storage.allProperties()
        XCTAssertEqual(result.count, 1)
    }
    
    func test_insertMultiplePropertyObject() {
        let storage: LocalStorage = .previewInstance()
        let count = 10
        (0..<count).forEach { _ in
            try! storage.createProperty(.dumb())
        }
        let result = try! storage.allProperties()
        XCTAssertEqual(result.count, count)
    }
    
    func test_deleteSinglePropertyObject() {
        let storage: LocalStorage = .previewInstance()
        let obj: PropertyObject = .dumb()
        try! storage.createProperty(obj)
        
        let before = try! storage.allProperties()
        XCTAssertEqual(before.count, 1)
        
        try! storage.deleteProperty(obj.id)
        
        let after = try! storage.allProperties()
        XCTAssertEqual(after.count, 0)
    }
            
    func test_updatePropertyObject() {
        let storage: LocalStorage = .previewInstance()
        let obj: PropertyObject = .dumb()
        try! storage.createProperty(obj)
        let objId = obj.id
        
        let newName = UUID().uuidString
        let newDetails = UUID().uuidString
        
        let newObj = PropertyObject(
            id: objId,
            name: newName,
            details: newDetails
        )
        
        try! storage.updateProperty(newObj)
        
        let updatedObj = try! storage.fetchProperty(objId)!
        
        XCTAssertEqual(updatedObj.id, objId)
        XCTAssertEqual(updatedObj.name, newName)
        XCTAssertEqual(updatedObj.details, newDetails)
    }
    
    func test_addMeterToPropertyObject() {
        let storage: LocalStorage = .previewInstance()
        let obj: PropertyObject = .dumb()
        try! storage.createProperty(obj)
        
        let meter = Meter(id: UUID(), name: "new meter", capacity: nil, inspectionDate: nil)
        _ = try! storage.newMeter(propertyObjectId: obj.id, meter: meter, initialValue: 0)
    
        let allMeters = try! storage.allMeters(obj.id)
        XCTAssertTrue(allMeters.count == 1)
    }
    
    func test_fetchLatestMeterValue() {
        let storage: LocalStorage = .previewInstance()
        let obj: PropertyObject = .dumb()
        try! storage.createProperty(obj)
        let meter = Meter(id: UUID(), name: "new meter", capacity: nil, inspectionDate: nil)
        _ = try! storage.newMeter(propertyObjectId: obj.id, meter: meter, initialValue: 10)
        let meterId = try! storage.allMeters(obj.id).first!.id
    
        var date = Date()
        do {
            date.addTimeInterval(10)
            let val = MeterValue(
                id: MeterValueId(),
                date: date,
                value: 20,
                isPaid: true
            )
            try! storage.insertMeterValue(meterId, value: val)
        }
        
        do {
            date.addTimeInterval(10)
            let val = MeterValue(
                id: MeterValueId(),
                date: date,
                value: 30,
                isPaid: false
            )
            try! storage.insertMeterValue(meterId, value: val)
        }
        
        do {
            date.addTimeInterval(10)
            let val = MeterValue(
                id: MeterValueId(),
                date: date,
                value: 50,
                isPaid: false
            )
            try! storage.insertMeterValue(meterId, value: val)
        }
        
        let latestPaid = try! storage.fetchLatestValue(meterId, isPaid: true)
        XCTAssertEqual(latestPaid!.value, 20)
        
        let latestNotPaid = try! storage.fetchLatestValue(meterId, isPaid: false)
        XCTAssertEqual(latestNotPaid!.value, 50)
    }
}

fileprivate extension PropertyObject {
    static func dumb() -> PropertyObject {
        PropertyObject(id: PropertyObjectId(), name: "Name", details: "Details")
    }
}
