//
//  MeterValueViewPresenters.swift
//  UtilityBills
//
//  Created by Sergey on 10.10.2024.
//

import Foundation

class AbstractMeterValuePresenter: MeterValuePresenter {
    var screenTitle: String {
        fatalError("'screenTitle' should be implemented in subclasses")
    }
    
    var datePickerTitle: String { "Date" }
    var valueInputTitle: String { "Value" }
    var paidToggleTitle: String { "Value already included in bill" }
}


class AddMeterValuePresenter: AbstractMeterValuePresenter {
    override var screenTitle: String {
        "Add new meter value"
    }
}

class EditMeterValuePresenter: AbstractMeterValuePresenter {
    override var screenTitle: String {
        "Edit meter value"
    }
}
