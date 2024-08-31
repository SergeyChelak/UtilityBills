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
        let request = CDPropertyObject.fetchRequest()
        request.predicate = NSPredicate(format: "uuid == %@", propertyObject.id as NSUUID)
        let context = viewContext
        guard let obj = try context.fetch(request).first else {
            return
        }
        context.delete(obj)
        try context.save()
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
