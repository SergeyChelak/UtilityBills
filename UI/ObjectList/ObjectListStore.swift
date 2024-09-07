//
//  ObjectListStore.swift
//  UtilityBills
//
//  Created by Sergey on 28.08.2024.
//

import Foundation

class ObjectListStore: ObservableObject {
    private let dataSource: PropertyObjectListDataSource
    
    @Published private(set) var items: [PropertyObject] = []
    private(set) var editItems: [PropertyObject] = []
    @Published var isEditMode = false
    
    init(dataSource: PropertyObjectListDataSource) {
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
        let leftoverIds = editItems.map { $0.id }
        let removeIds = items
            .filter {
                !leftoverIds.contains($0.id)
            }
            .map {
                $0.id
            }
        guard !removeIds.isEmpty else {
            return
        }
        do {
            try dataSource.deleteProperties(removeIds)
            load()
        } catch {
            fatalError("Failed to remove objects \(removeIds)")
        }
    }
    
    func cancelEdit() {
        isEditMode = false
        load()
    }
    
    func toggleEditMode() {
        if isEditMode {
            delete()
        }
        editItems = items
        isEditMode.toggle()
    }
    
    func addToRemoveSet(_ indexSet: IndexSet) {
        editItems.remove(atOffsets: indexSet)
    }
}
