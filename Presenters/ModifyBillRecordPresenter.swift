//
//  ModifyBillRecordPresenter.swift
//  UtilityBills
//
//  Created by Sergey on 10.10.2024.
//

import Foundation

protocol ModifyBillRecordPresenter: ControlButtonsPresenter {
    var priceInputFieldTitle: String { get }
    var amountCellCaption: String { get }
}
