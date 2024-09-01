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
        
        try! storage.deleteProperty(obj.id)
        
        let after = try! storage.allProperties()
        XCTAssertEqual(after.count, 0)
    }
        
    func test_deleteMultiplePropertyObject() {
        let storage: LocalStorage = .previewInstance()
        
        let count = 10
        let objects = (0..<count)
            .map { _ in
                try! storage.createProperty().id
            }
        let prefix = 3
        try! storage.deleteProperties(Array(objects.prefix(prefix)))
        
        let after = try! storage.allProperties()
        XCTAssertEqual(after.count, count - prefix)
    }
}
