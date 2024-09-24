//
//  LocalStorageTest.swift
//  UtilityBillsTests
//
//  Created by Sergey on 31.08.2024.
//

import XCTest
import UtilityBills
@testable import UtilityBills

final class LocalStorageTest: XCTestCase {
    func test_emptyPropertyObjectFetch() {
        let storage: LocalStorage = .previewInstance()
        let result = try! storage.allProperties()
        XCTAssertTrue(result.isEmpty)
    }
    
    func test_insertPropertyObject() {
        let storage: LocalStorage = .previewInstance()
        _ = try! storage.createProperty()
        let result = try! storage.allProperties()
        XCTAssertEqual(result.count, 1)
    }
    
    func test_insertMultiplePropertyObject() {
        let storage: LocalStorage = .previewInstance()
        let count = 10
        (0..<count).forEach { _ in
            _ = try! storage.createProperty()
        }
        let result = try! storage.allProperties()
        XCTAssertEqual(result.count, count)
    }
    
    func test_deleteSinglePropertyObject() {
        let storage: LocalStorage = .previewInstance()
        let obj = try! storage.createProperty()
        
        let before = try! storage.allProperties()
        XCTAssertEqual(before.count, 1)
        
        try! storage.deleteProperty(obj)
        
        let after = try! storage.allProperties()
        XCTAssertEqual(after.count, 0)
    }
            
    func test_updatePropertyObject() {
        let storage: LocalStorage = .previewInstance()
        
        let objId = try! storage.createProperty().id
        
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
        let obj = try! storage.createProperty()
        
        let meter = Meter(id: UUID(), name: "new meter", capacity: nil, inspectionDate: nil)
        _ = try! storage.newMeter(propertyObjectId: obj.id, meter: meter, initialValue: 0)
    
        let allMeters = try! storage.allMeters(for: obj.id)
        XCTAssertTrue(allMeters.count == 1)
    }
}
