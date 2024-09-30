//
//  LocalStorage.swift
//  UtilityBills
//
//  Created by Sergey on 28.08.2024.
//

import Foundation
import CoreData

enum StorageError: Error {
    case noContext
    case propertyObjectNotFound
    case meterNotFound
    case meterValueNotFound
    case tariffNotFound
}

struct LocalStorage {
    private static let modelName = "LocalStorageModel"
    
    public static func instance() -> Self {
        Self.init(modelName: modelName, inMemory: false)
    }
    
    public static func previewInstance() -> Self {
        Self.init(modelName: modelName, inMemory: true)
    }
    
    private let persistentContainer: NSPersistentContainer
    
    var viewContext: NSManagedObjectContext {
        persistentContainer.viewContext
    }
        
    private init(modelName: String, inMemory: Bool) {
        let container = NSPersistentContainer(name: modelName)
        if inMemory {
            container.persistentStoreDescriptions.first?.url = URL(fileURLWithPath: "/dev/null")
        }
        container.loadPersistentStores { store, error in
            if let error {
                fatalError(error.localizedDescription)
            }
        }        
        self.persistentContainer = container
    }
}

// utils
extension LocalStorage {
    func fetchPropertyObject(_ uuid: PropertyObjectId, into context: NSManagedObjectContext) throws -> CDPropertyObject? {
        let request = CDPropertyObject.fetchRequest()
        request.predicate = .byOwnUUID(uuid)
        request.fetchLimit = 1
        return try context.fetch(request).first
    }
    
    func fetchMeter(_ uuid: MeterId, into context: NSManagedObjectContext) throws -> CDMeter? {
        let request = CDMeter.fetchRequest()
        request.predicate = .byOwnUUID(uuid)
        request.fetchLimit = 1
        return try context.fetch(request).first
    }
    
    func fetchMeterValue(_ uuid: MeterValueId, into context: NSManagedObjectContext) throws -> CDMeterValue? {
        let request = CDMeterValue.fetchRequest()
        request.predicate = .byOwnUUID(uuid)
        request.fetchLimit = 1
        return try context.fetch(request).first
    }
    
    func fetchMeters(_ ids: [MeterId], into context: NSManagedObjectContext) throws -> [CDMeter] {
        let request = CDMeter.fetchRequest()
        request.predicate = NSPredicate(format: "SELF.uuid in %@", ids)
        return try context.fetch(request)
    }
    
    func fetchTariff(_ tariffId: TariffId, into context: NSManagedObjectContext) throws -> CDTariff? {
        let request = CDTariff.fetchRequest()
        request.predicate = .byOwnUUID(tariffId)
        request.fetchLimit = 1
        return try context.fetch(request).first
    }
    
    func createMeterValue(with value: MeterValue, for meter: CDMeter) throws -> CDMeterValue {
        guard let context = meter.managedObjectContext else {
            throw StorageError.noContext
        }
        let cdValue = CDMeterValue(context: context)
        cdValue.uuid = UUID()
        cdValue.meter = meter
        cdValue.date = value.date
        cdValue.isPaid = value.isPaid
        cdValue.value = value.value as NSNumber
        return cdValue
    }
}

