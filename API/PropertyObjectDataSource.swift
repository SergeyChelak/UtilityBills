//
//  PropertyObjectService.swift
//  UtilityBills
//
//  Created by Sergey on 28.08.2024.
//

import Foundation

typealias PropertyObjectId = UUID

protocol PropertyObjectDataSource {
    func allProperties() throws -> [PropertyObject]
    
    func createProperty() throws -> PropertyObject
    
    func deleteProperty(_ propertyObject: PropertyObjectId) throws
    
    func deleteProperties(_ objects: [PropertyObjectId]) throws
    
    func updateProperty(_ propertyObject: PropertyObject) throws
}
