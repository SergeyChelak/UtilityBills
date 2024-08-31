//
//  PropertyObjectService.swift
//  UtilityBills
//
//  Created by Sergey on 28.08.2024.
//

import Foundation

protocol PropertyObjectDataSource {
    func allProperties() throws -> [PropertyObject]
    
    func createProperty() throws -> PropertyObject
    
    func deleteProperty(_ propertyObject: PropertyObject) throws
    
    func deleteProperties(_ objects: [PropertyObject]) throws
    
    func updateProperty(_ propertyObject: PropertyObject) throws
}
