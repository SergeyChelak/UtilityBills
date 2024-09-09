//
//  PublishedLocalStorage.swift
//  UtilityBills
//
//  Created by Sergey on 10.09.2024.
//

import Combine
import Foundation

struct PublishedLocalStorage {
    let storage: LocalStorage
    let _publisher = PassthroughSubject<(), Never>()
    
    init(storage: LocalStorage) {
        self.storage = storage
    }
    
    var publisher: AnyPublisher<(), Never> {
        _publisher.eraseToAnyPublisher()
    }
    
    private func notify() {
        _publisher.send()
    }
}

extension PublishedLocalStorage: PropertyObjectListDataSource, PropertyObjectDataSource, MeterListDataSource {
    func allProperties() throws -> [PropertyObject] {
        try storage.allProperties()
    }
    
    func createProperty() throws -> PropertyObject {
        let result = try storage.createProperty()
        notify()
        return result
    }
    
    func deleteProperty(_ propertyObject: PropertyObject) throws {
        try storage.deleteProperty(propertyObject)
        notify()
    }
            
    func fetchProperty(_ uuid: PropertyObjectId) throws -> PropertyObject? {
        try storage.fetchProperty(uuid)
    }
    
    func updateProperty(_ propertyObject: PropertyObject) throws {
        try storage.updateProperty(propertyObject)
        notify()
    }
    
    func allMeters(for property: PropertyObjectId) throws -> [Meter] {
        try storage.allMeters(for: property)
    }
        
    func newMeter(for property: PropertyObjectId) throws -> Meter {
        let val = try storage.newMeter(for: property)
        notify()
        return val
    }
}
