//
//  BillingMapPresenter.swift
//  UtilityBills
//
//  Created by Sergey on 10.10.2024.
//

import Foundation

protocol BillingMapPresenter: ControlButtonsPresenter {
    var screenTitle: String { get }
    var itemNameInputFieldTitle: String { get }
    var emptyTariffListMessage: String { get }
    var tariffPickerTitle: String { get }
    var meterPickerTitle: String { get }
}
