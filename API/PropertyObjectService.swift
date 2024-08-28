//
//  PropertyObjectService.swift
//  UtilityBills
//
//  Created by Sergey on 28.08.2024.
//

import Foundation

protocol PropertyObjectService {
    func allProperties() async throws -> [PropertyObject]
    
    func createProperty() async throws -> PropertyObject
    
    func deletePropery(_ properyObject: PropertyObject) async throws
    
    func updateProperty(_ properyObject: PropertyObject) async throws
}
