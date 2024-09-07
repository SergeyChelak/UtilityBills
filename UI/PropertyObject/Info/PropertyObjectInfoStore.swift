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

class PropertyObjectInfoStore: ObservableObject {
    let dataSource: PropertyObjectInfoDataSource
    private let id: PropertyObjectId
    
    @Published var info: PropertyObjectInfo?
    
    init(_ id: PropertyObjectId, dataSource: PropertyObjectInfoDataSource) {
        self.id = id
        self.dataSource = dataSource
    }
    
    func load() {
        do {
            guard let obj = try dataSource.fetchProperty(id) else {
                print("obj with \(id) not found")
                return
            }
            self.info = PropertyObjectInfo(with: obj)            
        } catch {
            fatalError(error.localizedDescription)
        }
    }
}

