//
//  iOSMeterValuesListPresenter.swift
//  UtilityBills
//
//  Created by Sergey on 10.10.2024.
//

import Foundation

struct iOSMeterValuesListPresenter: MeterValuesListPresenter {
    var screenTitle: String { "Values" }
    var emptyListMessage: String { "No records found for this meter" }
    var addButtonTitle: String { "Add" }
    
    func cellCaption(_ item: MeterValue) -> String {
        item.date.formatted()
    }
    func cellValue(_ item: MeterValue) -> String {
        item.value.formatted()
    }
}
