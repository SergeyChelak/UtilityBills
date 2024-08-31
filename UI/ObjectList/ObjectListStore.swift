//
//  ObjectListStore.swift
//  UtilityBills
//
//  Created by Sergey on 28.08.2024.
//

import Foundation

class ObjectListStore: ObservableObject {
    private let dataSource: PropertyObjectDataSource
    
    @Published private(set) var items: [PropertyObject] = []
    
    init(dataSource: PropertyObjectDataSource) {
        self.dataSource = dataSource
    }
    
    func load() {
        do {
            items = try dataSource.allProperties()
        } catch {
            fatalError("Failed to load properties")
        }
    }
    
    func addObject() {
        do {
            _ = try dataSource.createProperty()
            items = try dataSource.allProperties()
        } catch {
            fatalError("Failed to add property")
        }
    }
}
