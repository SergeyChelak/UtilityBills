//
//  PropertyListViewModel.swift
//  UtilityBills
//
//  Created by Sergey on 24.09.2024.
//

import Foundation

typealias PropertyListActionRemove = (PropertyObject) throws -> Void
typealias PropertyListActionCreate = () throws -> PropertyObject

class PropertyListViewModel: CommonListViewModel<PropertyObject> {
    let actionCreate: PropertyListActionCreate
    let actionRemove: PropertyListActionRemove
    
    init(
        actionLoad: @escaping CommonListActionLoad<PropertyObject>,
        actionSelect: @escaping CommonListActionSelect<PropertyObject>,
        actionCreate: @escaping PropertyListActionCreate,
        actionRemove: @escaping PropertyListActionRemove) {
        self.actionCreate = actionCreate
        self.actionRemove = actionRemove
        super.init(actionLoad: actionLoad, actionSelect: actionSelect)
    }
    
    func onDelete(_ indexSet: IndexSet) {
        do {
            for index in indexSet {
                let item = items[index]
                try actionRemove(item)
            }
        } catch {
            print("Failed to remove items: \(error)")
            load()
        }
    }
    
    func onCreate() {
        do {
            _ = try actionCreate()
            load()
        } catch {
            self.error = error
            print("Failed to create item: \(error)")
        }
    }

}
