//
//  ObjectListStore.swift
//  UtilityBills
//
//  Created by Sergey on 28.08.2024.
//

import Foundation

class ObjectListStore: ObservableObject {
    let propertyObjectService: PropertyObjectService
    
    init(propertyObjectService: PropertyObjectService) {
        self.propertyObjectService = propertyObjectService
    }
}
