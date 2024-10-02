//
//  EditPropertyInfoViewModel.swift
//  UtilityBills
//
//  Created by Sergey on 28.09.2024.
//

import Foundation

class EditPropertyInfoViewModel: ViewModel {
    private let propertyObject: PropertyObject
    private weak var delegate: EditPropertyInfoFlow?
    
    @Published
    var name: String
    @Published
    var details: String
    
    init(
        propertyObject: PropertyObject,
        delegate: EditPropertyInfoFlow?
    ) {
        self.propertyObject = propertyObject
        self.delegate = delegate
        self.name = propertyObject.name
        self.details = propertyObject.details
    }
    
    func save() {
        if name.isEmpty {
            self.error = UtilityBillsError.emptyName
            return
        }
        var obj = propertyObject
        obj.name = name
        obj.details = details
        do {
            try delegate?.updatePropertyObject(obj)
        } catch {
            setError(error)
        }
    }
}
