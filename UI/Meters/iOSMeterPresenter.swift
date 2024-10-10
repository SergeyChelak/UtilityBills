//
//  iOSMeterPresenter.swift
//  UtilityBills
//
//  Created by Sergey on 10.10.2024.
//

import Foundation

class AbstractMeterPresenter: MeterPresenter {
    var screenTitle: String {
        fatalError("'screenTitle' must be implemented in subclasses")
    }
    
    var meterNameInputFieldTitle: String {
        "Meter name"
    }
    
    var toggleInspectionApplicableTitle: String {
        "Inspection date is applicable"
    }
    
    var inspectionDatePickerTitle: String {
        "Inspection Date"
    }
}

class iOSAddMeterPresenter: AbstractMeterPresenter, AddMeterPresenter {
    override var screenTitle: String {
        "Add new meter"
    }
    
    var toggleCapacityApplicableTitle: String {
        "Capacity is applicable for this meter"
    }
    
    var capacityPickerTitle: String {
        "Capacity"
    }
    
    func capacityValue(_ capacity: Int) -> String {
        let val = maxValue(for: capacity).formatted()
        return String(format: "%d digits, max value: %@", capacity, val)
    }
    
    var initialValueInputFieldTitle: String {
        "Initial value"
    }
    
    var addMeterButtonTitle: String {
        "Add Meter"
    }
}

class iOSEditMeterPresenter: AbstractMeterPresenter, EditMeterPresenter {
    let deleteMeterAlertPresenter: ConfirmationAlertPresenter
    
    init(deleteMeterAlertPresenter: ConfirmationAlertPresenter) {
        self.deleteMeterAlertPresenter = deleteMeterAlertPresenter
    }
    
    override var screenTitle: String {
        "Edit meter"
    }
    
    var updateMeterButtonTitle: String {
        "Update"
    }
    
    var deleteMeterButtonTitle: String {
        "Delete Meter"
    }
}

struct DeleteMeterAlertPresenter: ConfirmationAlertPresenter {
    var title: String {
        "Warning"
    }
    
    var message: String {
        "Do you want to delete this meter?"
    }
    
    var confirmButtonTitle: String {
        "Delete"
    }
    
    var cancelButtonTitle: String {
        "Cancel"
    }
}
