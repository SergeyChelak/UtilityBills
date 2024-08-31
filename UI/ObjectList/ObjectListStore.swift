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
    @Published private(set) var isEditMode = false
    
    private(set) var indicesToRemove: Set<UUID> = []
    
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
            load()
        } catch {
            fatalError("Failed to add property")
        }
    }
    
    private func delete() {
        let objToRemove = items
            .filter {
                indicesToRemove.contains($0.id)
            }
        guard !objToRemove.isEmpty else {
            return
        }
        do {
            try dataSource.deleteProperties(objToRemove)
            load()
        } catch {
            fatalError("Failed to remove objects \(objToRemove)")
        }
    }
    
    func cancelEdit() {
        indicesToRemove.removeAll()
        isEditMode = false
        load()
    }
    
    func toggleEditMode() {
        if isEditMode {
            delete()
            indicesToRemove.removeAll()
        }
        isEditMode.toggle()
    }
    
    func addToRemoveSet(_ indexSet: IndexSet) {
        indexSet.forEach {
            let item = items[$0]
            indicesToRemove.insert(item.id)
        }
    }
}
