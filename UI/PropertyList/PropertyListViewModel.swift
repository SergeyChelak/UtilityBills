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
    
    init(
        actionLoad: @escaping CommonListActionLoad<PropertyObject>,
        actionSelect: @escaping CommonListActionSelect<PropertyObject>,
        actionCreate: @escaping PropertyListActionCreate
    ) {
        self.actionCreate = actionCreate
        super.init(actionLoad: actionLoad, actionSelect: actionSelect)
    }
        
    func onCreate() {
        do {
            _ = try actionCreate()
            load()
        } catch {
            setError(error)
            print("Failed to create item: \(error)")
        }
    }

}
