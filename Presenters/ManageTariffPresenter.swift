//
//  ManageTariffPresenter.swift
//  UtilityBills
//
//  Created by Sergey on 10.10.2024.
//

import Foundation

protocol ManageTariffPresenter {
    var screenTitle: String { get }
    var tariffNameInputFieldTitle: String { get }
    var priceInputFieldTitle: String { get }
    var deleteTariffAlertPresenter: ConfirmationAlertPresenter { get }
}
