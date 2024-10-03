//
//  PropertyListViewModel.swift
//  UtilityBills
//
//  Created by Sergey on 24.09.2024.
//

import Foundation

class PropertyListViewModel: CommonListViewModel<PropertyObject> {
    private var flow: PropertyObjectListFlow?
    
    init(
        flow: PropertyObjectListFlow?
    ) {
        self.flow = flow
        super.init(
            actionLoad: {
                try flow?.loadPropertyObjects() ?? []
            },
            actionSelect: {
                flow?.openPropertyObject($0.id)
            }
        )
    }
        
    func onCreate() {
        do {
            try flow?.createPropertyObject()
            load()
        } catch {
            setError(error)
            print("Failed to create item: \(error)")
        }
    }
}
