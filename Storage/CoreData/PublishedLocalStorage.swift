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

extension PublishedLocalStorage: PropertyObjectDAO, MetersDAO, TariffDAO {
    func allTariffs(for propertyId: PropertyObjectId) throws -> [Tariff] {
        try storage.allTariffs(for: propertyId)
    }
    
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

    func newMeter(
        propertyObjectId: PropertyObjectId,
        name: String,
        capacity: Int?,
        inspectionDate: Date?,
        initialValue: Double
    ) throws -> Meter {
        let val = try storage.newMeter(
            propertyObjectId: propertyObjectId,
            name: name,
            capacity: capacity,
            inspectionDate: inspectionDate,
            initialValue: initialValue
        )
        notify()
        return val
    }
    
    func meterValues(_ meterId: MeterId) throws -> [MeterValue] {
        try storage.meterValues(meterId)        
    }
}
