//
//  EditPropertyInfoViewModel.swift
//  UtilityBills
//
//  Created by Sergey on 28.09.2024.
//

import Foundation

typealias PropertyObjectActionUpdateInfo = (PropertyObject) throws -> Void

class EditPropertyInfoViewModel: ViewModel {
    private let propertyObject: PropertyObject
    private let actionUpdate: PropertyObjectActionUpdateInfo
    
    @Published
    var name: String
    @Published
    var details: String
    
    init(
        propertyObject: PropertyObject,
        actionUpdate: @escaping PropertyObjectActionUpdateInfo
    ) {
        self.propertyObject = propertyObject
        self.actionUpdate = actionUpdate
        
        self.name = propertyObject.name
        self.details = propertyObject.details
    }
    
    func save() {
        if name.isEmpty {
            self.error = NSError(domain: "UB.bad_value", code: 1)
            return
        }
        var obj = propertyObject
        obj.name = name
        obj.details = details
        do {
            try actionUpdate(obj)
        } catch {
            setError(error)
        }
    }
}
