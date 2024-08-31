//
//  LocalStorage+PropertyObjectService.swift
//  UtilityBills
//
//  Created by Sergey on 31.08.2024.
//

import CoreData
import Foundation

extension LocalStorage: PropertyObjectDataSource {
    func allProperties() throws -> [PropertyObject] {
        let request = CDPropertyObject.fetchRequest()
        let result = try viewContext.fetch(request)
        return result.map(map(_:))
    }
    
    func createProperty() throws -> PropertyObject {
        let context = viewContext
        let obj = CDPropertyObject(context: context)
        obj.uuid = UUID()
        obj.name = "Unnamed";
        try context.save()
        return map(obj)
    }
    
    func deleteProperty(_ propertyObject: PropertyObject) throws {
        try deleteProperties([propertyObject])
    }
    
    func deleteProperties(_ objects: [PropertyObject]) throws {
        let request = CDPropertyObject.fetchRequest()
        let array = objects.map { $0.id }
        request.predicate = NSPredicate(format: "SELF.uuid IN %@", array)
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
    
    func updateProperty(_ propertyObject: PropertyObject) throws {
        fatalError("Not implemented")
    }
}

func map(_ cdPropertyObject: CDPropertyObject) -> PropertyObject {
    PropertyObject(
        id: cdPropertyObject.uuid!,
        name: cdPropertyObject.name!,
        details: cdPropertyObject.details,
        currencyId: nil)
}
