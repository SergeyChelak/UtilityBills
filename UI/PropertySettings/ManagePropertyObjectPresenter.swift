//
//  ManagePropertyObjectPresenter.swift
//  UtilityBills
//
//  Created by Sergey on 10.10.2024.
//

import Foundation

class AbstractManagePropertyObjectPresenter: ManagePropertyObjectPresenter {
    var header: String {
        fatalError()
    }
    
    var objectNameInputFieldTitle: String {
        "Title"
    }
    
    var objectDetailsInputFieldTitle: String {
        "Details"
    }

    func actionName(_ action: ControlAction) -> String {
        switch action {
        case .new:
            "Create new object"
        case .update:
            "Save changes"
        case .delete:
            "Delete object"
        }
    }
}

class CreateManagePropertyObjectPresenter: AbstractManagePropertyObjectPresenter {
    override var header: String {
        "New Object"
    }
}

class UpdateManagePropertyObjectPresenter: AbstractManagePropertyObjectPresenter {
    override var header: String {
        "Object Properties"
    }
}
