//
//  PropertySettingPresenters.swift
//  UtilityBills
//
//  Created by Sergey on 10.10.2024.
//

import Foundation

struct DeletePropertyObjectAlertPresenter: ConfirmationAlertPresenter {
    var title: String {
        "Warning"
    }
    
    var message: String {
        "Do you want to delete this object?"
    }
    
    var confirmButtonTitle: String {
        "Delete"
    }
    
    var cancelButtonTitle: String {
        "Cancel"
    }
}

struct iOSPropertySettingsPresenter: PropertySettingsPresenter {
    let deleteAlertPresenter: ConfirmationAlertPresenter
    
    var screenTitle: String {
        "Settings"
    }
    
    var sectionInfoTitle: String {
        "Info"
    }
    
    var sectionInfoActionButtonTitle: String {
        "Edit"
    }
    
    var sectionMetersTitle: String {
        "Meters"
    }
    
    var sectionMetersActionButtonTitle: String {
        "Add"
    }
    
    var noMetersMessage: String {
        "You have no meters yet"
    }
    
    var sectionTariffsTitle: String {
        "Tariffs"
    }
    
    var sectionTariffsActionButtonTitle: String {
        "Add"
    }
    
    var noTariffsMessage: String {
        "You have no tariffs yet"
    }
    
    var sectionBillingMapsTitle: String {
        "Payment Mapping"
    }
    
    var sectionBillingMapsActionButtonTitle: String {
        "Add"
    }
    
    var noBillingMapsMessage: String {
        "You didn't add any payment maps yet"
    }
    
    var deleteObjectButtonTitle: String {
        "Delete Object"
    }
    
    func price(_ price: Decimal) -> String {
        price.formatted()
    }
}
