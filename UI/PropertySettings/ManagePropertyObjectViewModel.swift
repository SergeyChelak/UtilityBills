//
//  ManagePropertyObjectViewModel.swift
//  UtilityBills
//
//  Created by Sergey on 28.09.2024.
//

import Foundation

class ManagePropertyObjectViewModel: ViewModel, ActionControllable {
    private var createFlow: CreatePropertyObjectFlowDelegate?
    private var updateFlow: UpdatePropertyObjectFlowDelegate?
    
    private let propertyObjectId: PropertyObjectId
    let actions: [ControlAction]
    @Published
    var name: String
    @Published
    var details: String
    
    init(
        propertyObject: PropertyObject,
        updateFlow: UpdatePropertyObjectFlowDelegate?
    ) {
        self.actions = [.update]
        self.propertyObjectId = propertyObject.id
        self.updateFlow = updateFlow
        self.name = propertyObject.name
        self.details = propertyObject.details
    }
    
    init(
        createFlow: CreatePropertyObjectFlowDelegate?,
        name: String = "",
        details: String = ""
    ) {
        self.actions = [.new]
        self.propertyObjectId = PropertyObjectId()
        self.createFlow = createFlow
        self.name = name
        self.details = details
    }
    
    func onAction(_ action: ControlAction) {
        switch action {
        case .new:
            new()
        case .update:
            update()
        case .delete:
            delete()
        }
    }
    
    private func validatedPropertyObject() throws -> PropertyObject {
        if name.isEmpty {
            throw UtilityBillsError.emptyName
        }
        return PropertyObject(
            id: propertyObjectId,
            name: name,
            details: details
        )
    }
    
    private func new() {
        do {
            let obj = try validatedPropertyObject()
            try createFlow?.createPropertyObject(obj)
        } catch {
            setError(error)
        }
    }

    private func update() {
        do {
            let obj = try validatedPropertyObject()
            try updateFlow?.updatePropertyObject(obj)
        } catch {
            setError(error)
        }
    }
    
    private func delete() {
        unexpectedError("Delete action isn't expected for this context")
    }
}
