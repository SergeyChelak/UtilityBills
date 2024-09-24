//
//  MeterValuesListViewModel.swift
//  UtilityBills
//
//  Created by Sergey on 24.09.2024.
//

import Foundation

typealias MeterActionDelete = () throws -> ()

class MeterValuesListViewModel: CommonListViewModel<MeterValue> {
    private let actionDeleteMeter: MeterActionDelete
    
    init(
        actionLoad: @escaping CommonListActionLoad<MeterValue>,
        actionSelect: @escaping CommonListActionSelect<MeterValue>,
        actionDeleteMeter: @escaping MeterActionDelete
    ) {
        self.actionDeleteMeter = actionDeleteMeter
        super.init(actionLoad: actionLoad, actionSelect: actionSelect)
    }
    
    func deleteMeter() {
        do {
            try actionDeleteMeter()
        } catch {
            self.error = error
        }
    }
}
