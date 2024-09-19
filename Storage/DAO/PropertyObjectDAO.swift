//
//  PropertyObjectService.swift
//  UtilityBills
//
//  Created by Sergey on 28.08.2024.
//

import Foundation

protocol PropertyObjectDAO {
    func allProperties() throws -> [PropertyObject]
    
    func createProperty() throws -> PropertyObject
    
    func deleteProperty(_ propertyObject: PropertyObject) throws

    func fetchProperty(_ uuid: PropertyObjectId) throws -> PropertyObject?

    func updateProperty(_ propertyObject: PropertyObject) throws
}

//protocol __PropertyDataSource {
//    func allProperties(_ callback: @escaping (Result<[PropertyObject], Error>) -> Void)
//    
//    func createProperty(_ callback: @escaping (Result<PropertyObject, Error>) -> Void)
//    
//    func deleteProperty(_ propertyObject: PropertyObject, _ callback: @escaping (Result<(), Error>) -> Void)
//    
//    func fetchProperty(_ uuid: PropertyObjectId, _ callback: @escaping (Result<PropertyObject?, Error>) -> Void)
//
//    func updateProperty(_ propertyObject: PropertyObject, _ callback: @escaping (Result<(), Error>) -> Void) throws
//}
