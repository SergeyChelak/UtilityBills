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
    func deleteMeter(_ meterId: MeterId) throws {
        try storage.deleteMeter(meterId)
        notify()
    }
    
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
    
    func deleteProperty(_ propertyObjectId: PropertyObjectId) throws {
        try storage.deleteProperty(propertyObjectId)
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
        meter: Meter,
        initialValue: Double
    ) throws -> Meter {
        let val = try storage.newMeter(
            propertyObjectId: propertyObjectId,
            meter: meter,
            initialValue: initialValue
        )
        notify()
        return val
    }
    
    func meterValues(_ meterId: MeterId) throws -> [MeterValue] {
        try storage.meterValues(meterId)        
    }
}
