//
//  PropertySettingsPresenter.swift
//  UtilityBills
//
//  Created by Sergey on 10.10.2024.
//

import Foundation

protocol PropertySettingsPresenter {
    var screenTitle: String { get }
    
    var sectionInfoTitle: String { get }
    var sectionInfoActionButtonTitle: String { get }
    
    var sectionMetersTitle: String { get }
    var sectionMetersActionButtonTitle: String { get }
    var noMetersMessage: String { get }
    
    var sectionTariffsTitle: String { get }
    var sectionTariffsActionButtonTitle: String { get }
    var noTariffsMessage: String { get }
    
    var sectionBillingMapsTitle: String { get }
    var sectionBillingMapsActionButtonTitle: String { get }
    var noBillingMapsMessage: String { get }
    
    var deleteObjectButtonTitle: String { get }
    
    func price(_ price: Decimal) -> String
    
    var deleteAlertPresenter: ConfirmationAlertPresenter { get }
}
