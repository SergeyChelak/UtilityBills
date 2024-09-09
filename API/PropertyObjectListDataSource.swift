//
//  PropertyObjectService.swift
//  UtilityBills
//
//  Created by Sergey on 28.08.2024.
//

import Foundation

protocol PropertyObjectListDataSource {
    func allProperties() throws -> [PropertyObject]
    
    func createProperty() throws -> PropertyObject
    
    func deleteProperty(_ propertyObject: PropertyObject) throws
}

protocol PropertyObjectDataSource {
    func fetchProperty(_ uuid: PropertyObjectId) throws -> PropertyObject?

    func updateProperty(_ propertyObject: PropertyObject) throws
}
