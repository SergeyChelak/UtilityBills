//
//  MeterValuesListViewModel.swift
//  UtilityBills
//
//  Created by Sergey on 24.09.2024.
//

import Foundation

typealias MeterActionDelete = () throws -> ()
typealias MeterActionNewValue = () -> ()

class MeterValuesListViewModel: CommonListViewModel<MeterValue> {
    private let actionNewValue: MeterActionNewValue
    private let actionDeleteMeter: MeterActionDelete
    
    init(
        actionLoad: @escaping CommonListActionLoad<MeterValue>,
        actionNewValue: @escaping MeterActionNewValue,
        actionSelect: @escaping CommonListActionSelect<MeterValue>,
        actionDeleteMeter: @escaping MeterActionDelete
    ) {
        self.actionNewValue = actionNewValue
        self.actionDeleteMeter = actionDeleteMeter
        super.init(actionLoad: actionLoad, actionSelect: actionSelect)
    }
    
    func newValue() {
        actionNewValue()
    }
    
    func deleteMeter() {
        do {
            try actionDeleteMeter()
        } catch {
            self.error = error
        }
    }
}
