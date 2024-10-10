//
//  MeterValuePresenter.swift
//  UtilityBills
//
//  Created by Sergey on 10.10.2024.
//

import Foundation

protocol MeterValuePresenter: ControlButtonsPresenter {
    var screenTitle: String { get }
    var datePickerTitle: String { get }
    var valueInputTitle: String { get }
    var paidToggleTitle: String { get }
}
