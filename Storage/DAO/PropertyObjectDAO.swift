//
//  PropertyObjectService.swift
//  UtilityBills
//
//  Created by Sergey on 28.08.2024.
//

import Foundation

protocol PropertyObjectDAO {
    func allProperties() throws -> [PropertyObject]
    
    func createProperty(_ propertyObject: PropertyObject) throws
    
    func deleteProperty(_ propertyObjectId: PropertyObjectId) throws

    func fetchProperty(_ uuid: PropertyObjectId) throws -> PropertyObject?

    func updateProperty(_ propertyObject: PropertyObject) throws
}
