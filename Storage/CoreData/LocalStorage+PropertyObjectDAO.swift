//
//  LocalStorage+PropertyObjectDAO.swift
//  UtilityBills
//
//  Created by Sergey on 31.08.2024.
//

import CoreData
import Foundation

extension LocalStorage: PropertyObjectDAO {
    func allProperties() throws -> [PropertyObject] {
        let request = CDPropertyObject.fetchRequest()
        let result = try viewContext.fetch(request)
        return try result.map(mapPropertyObject(_:))
    }
    
    func createProperty(_ propertyObject: PropertyObject) throws {
        let context = viewContext
        let obj = CDPropertyObject(context: context)
        obj.uuid = propertyObject.id
        obj.name = propertyObject.name
        obj.details = propertyObject.details
        try context.save()
    }
    
    func deleteProperty(_ propertyObjectId: PropertyObjectId) throws {
        let request = CDPropertyObject.fetchRequest()
        request.predicate = .byOwnUUID(propertyObjectId)
        let context = viewContext
        let result = try context.fetch(request)
        result.forEach {
            context.delete($0)
        }
        try context.save()
    }
    
    func fetchProperty(_ propertyObjectId: PropertyObjectId) throws -> PropertyObject? {
        guard let obj = try fetchPropertyObject(propertyObjectId, into: viewContext) else {
            return nil
        }
        return try mapPropertyObject(obj)
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
