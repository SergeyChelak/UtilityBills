//
//  PropertyListViewModel.swift
//  UtilityBills
//
//  Created by Sergey on 24.09.2024.
//

import Foundation

class PropertyListViewModel: CommonListViewModel<PropertyObject> {
    private var flow: PropertyObjectListFlowDelegate?
    
    init(
        flow: PropertyObjectListFlowDelegate?
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
        flow?.openCreateNewPropertyObject()
    }
}
