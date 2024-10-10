//
//  iOSBillingMapPresenter.swift
//  UtilityBills
//
//  Created by Sergey on 10.10.2024.
//

import Foundation

struct iOSBillingMapPresenter: BillingMapPresenter {
    var screenTitle: String { "Billing Map" }
    var itemNameInputFieldTitle: String { "Billing item name" }
    var emptyTariffListMessage: String { "You should create at least one tariff" }
    var tariffPickerTitle: String { "Pick tariff" }
    var meterPickerTitle: String { "Pick meter(s) if needed" }
}
