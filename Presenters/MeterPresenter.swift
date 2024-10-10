//
//  MeterPresenter.swift
//  UtilityBills
//
//  Created by Sergey on 10.10.2024.
//

import Foundation

protocol MeterPresenter {
    var screenTitle: String { get }
    var meterNameInputFieldTitle: String { get }
    var toggleInspectionApplicableTitle: String { get }
    var inspectionDatePickerTitle: String { get }
}

protocol AddMeterPresenter: MeterPresenter {
    var toggleCapacityApplicableTitle: String { get }
    var capacityPickerTitle: String { get }
    func capacityValue(_ capacity: Int) -> String
    var initialValueInputFieldTitle: String { get }
    var addMeterButtonTitle: String { get }
}

protocol EditMeterPresenter: MeterPresenter {
    var updateMeterButtonTitle: String { get }
    var deleteMeterButtonTitle: String { get }
    var deleteMeterAlertPresenter: ConfirmationAlertPresenter { get }
}
