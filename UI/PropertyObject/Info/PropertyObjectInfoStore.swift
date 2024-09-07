//
//  PropertyObjectInfoStore.swift
//  UtilityBills
//
//  Created by Sergey on 07.09.2024.
//

import Foundation

struct PropertyObjectInfo {
    var name: String
    var details: String
    
    init(with propertyObject: PropertyObject) {
        self.name = propertyObject.name
        self.details = propertyObject.details ?? ""
    }
}

protocol PropertyObjectInfoDataSource {
    func fetchProperty(_ uuid: PropertyObjectId) throws -> PropertyObject?
    func updateProperty(_ propertyObject: PropertyObject) throws
}

class PropertyObjectInfoStore: ObservableObject {
    let storage: PropertyObjectInfoDataSource
    private let id: PropertyObjectId
    
    @Published var info: PropertyObjectInfo?
    
    init(_ id: PropertyObjectId, storage: PropertyObjectInfoDataSource) {
        self.id = id
        self.storage = storage
    }
    
    func load() {
        do {
            guard let obj = try storage.fetchProperty(id) else {
                print("obj with \(id) not found")
                return
            }
            self.info = PropertyObjectInfo(with: obj)            
        } catch {
            fatalError(error.localizedDescription)
        }
    }
}

