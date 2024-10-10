//
//  DefaultControlButtonsPresenter.swift
//  UtilityBills
//
//  Created by Sergey on 10.10.2024.
//

import Foundation

struct DefaultControlButtonsPresenter: ControlButtonsPresenter {
    //
}

extension ControlButtonsPresenter {
    func actionName(_ action: ControlAction) -> String {
        switch action {
        case .new:
            "Add"
        case .update:
            "Update"
        case .delete:
            "Delete"
        }
    }
}
