//
//  iOSManageTariffPresenter.swift
//  UtilityBills
//
//  Created by Sergey on 10.10.2024.
//

import Foundation

enum ManageTariffMode {
    case add, edit
}

struct iOSManageTariffPresenter: ManageTariffPresenter {
    private let mode: ManageTariffMode
    
    let deleteTariffAlertPresenter: ConfirmationAlertPresenter
    
    init(
        mode: ManageTariffMode,
        deleteTariffAlertPresenter: ConfirmationAlertPresenter
    ) {
        self.mode = mode
        self.deleteTariffAlertPresenter = deleteTariffAlertPresenter
    }
    
    var screenTitle: String {
        switch mode {
        case .add:
            "Add new tariff"
        case .edit:
            "Edit tariff"
        }
    }
    
    var tariffNameInputFieldTitle: String {
        "Tariff name"
    }
    
    var priceInputFieldTitle: String {
        "Price"
    }
}

struct DeleteTariffAlertPresenter: ConfirmationAlertPresenter {
    var title: String {
        "Warning"
    }
    
    var message: String {
        "This action isn't undoable. Do you want to proceed?"
    }
    
    var confirmButtonTitle: String {
        "Proceed"
    }
    
    var cancelButtonTitle: String {
        "Cancel"
    }
}
