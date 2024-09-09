//
//  LocalStorage+PropertyObjectService.swift
//  UtilityBills
//
//  Created by Sergey on 31.08.2024.
//

import CoreData
import Foundation

extension LocalStorage: PropertyObjectListDataSource {
    func allProperties() throws -> [PropertyObject] {
        let request = CDPropertyObject.fetchRequest()
        let result = try viewContext.fetch(request)
        return result.map(map(_:))
    }
    
    func createProperty() throws -> PropertyObject {
        let context = viewContext
        let obj = CDPropertyObject(context: context)
        obj.uuid = UUID()
        obj.name = "Title";
        obj.details = "Details";
        try context.save()
        return map(obj)
    }
    
    func deleteProperty(_ propertyObject: PropertyObject) throws {
        let request = CDPropertyObject.fetchRequest()
        request.predicate = NSPredicate(format: "SELF.uuid == %@", propertyObject.id.uuidString)
        let context = viewContext
        do {
            let result = try context.fetch(request)
            result.forEach {
                context.delete($0)
            }
            try context.save()
        } catch {
            fatalError("Failed to delete property object")
        }
    }
    
}

extension LocalStorage: PropertyObjectDataSource {
    func fetchProperty(_ uuid: PropertyObjectId) throws -> PropertyObject? {
        guard let obj = try fetchPropertyObject(uuid, into: viewContext) else {
            return nil
        }
        return map(obj)
    }
    
    func updateProperty(_ propertyObject: PropertyObject) throws {
        let context = viewContext
        guard let obj = try fetchPropertyObject(propertyObject.id, into: context) else {
            return
        }
        // TODO: add more fields if needed
        obj.name = propertyObject.name
        obj.details = propertyObject.details
        try context.save()
    }
}

extension LocalStorage: MeterListDataSource {
    func allMeters(for propertyId: PropertyObjectId) throws -> [Meter] {
        let context = viewContext
        guard let obj = try fetchPropertyObject(propertyId, into: context) else {
            return []
        }
        let request = CDMeter.fetchRequest()
        request.predicate = NSPredicate(format: "SELF.propertyObject == %@", obj)
        
        return try context.fetch(request).map(map)
    }
    
    func newMeter(for propertyId: PropertyObjectId) throws -> Meter {
        let context = viewContext
        guard let propertyObject = try fetchPropertyObject(propertyId, into: context) else {
            // TODO: fix this
            throw NSError()
        }
        let meterObj = CDMeter(context: context)
        meterObj.uuid = UUID()
        meterObj.name = "New Meter"
        meterObj.capacity = 5
        meterObj.propertyObject = propertyObject
        
        try context.save()
        
        return map(meterObj)
    }
}

// utils
extension LocalStorage {
    private func fetchPropertyObject(
        _ uuid: PropertyObjectId,
        into context: NSManagedObjectContext
    ) throws -> CDPropertyObject? {
        let request = CDPropertyObject.fetchRequest()
        request.predicate = NSPredicate(format: "SELF.uuid == %@", uuid.uuidString)
        request.fetchLimit = 1
        return try context.fetch(request).first
    }
}

func map(_ cdPropertyObject: CDPropertyObject) -> PropertyObject {
    PropertyObject(
        id: cdPropertyObject.uuid!,
        name: cdPropertyObject.name!,
        details: cdPropertyObject.details ?? "",
        currencyId: nil)
}

func map(_ cdMeter: CDMeter) -> Meter {
    Meter(
        id: cdMeter.uuid!,
        name: cdMeter.name!,
        capacity: (cdMeter.capacity as NSNumber).intValue,
        inspectionDate: cdMeter.inspectionDate
    )
}
