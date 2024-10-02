//
//  PropertyListViewModel.swift
//  UtilityBills
//
//  Created by Sergey on 24.09.2024.
//

import Foundation

class PropertyListViewModel: CommonListViewModel<PropertyObject> {
    private weak var delegate: PropertyObjectListFlow?
    
    init(
        delegate: PropertyObjectListFlow?
    ) {
        self.delegate = delegate
        super.init(
            actionLoad: {
                try delegate?.loadPropertyObjects() ?? []
            },
            actionSelect: {
                delegate?.openPropertyObject($0.id)
            }
        )
    }
        
    func onCreate() {
        do {
            try delegate?.createPropertyObject()
            load()
        } catch {
            setError(error)
            print("Failed to create item: \(error)")
        }
    }
}
