//
//  MeterValuesListViewModel.swift
//  UtilityBills
//
//  Created by Sergey on 24.09.2024.
//

import Combine

typealias MeterActionDelete = () throws -> ()
typealias MeterActionNewValue = () -> ()

class MeterValuesListViewModel: CommonListViewModel<MeterValue> {
    private var cancellables: Set<AnyCancellable> = []
    private let actionNewValue: MeterActionNewValue
    private let actionDeleteMeter: MeterActionDelete
    
    init(
        actionLoad: @escaping CommonListActionLoad<MeterValue>,
        actionNewValue: @escaping MeterActionNewValue,
        actionSelect: @escaping CommonListActionSelect<MeterValue>,
        actionDeleteMeter: @escaping MeterActionDelete,
        updatePublisher: AnyPublisher<(), Never>
    ) {
        self.actionNewValue = actionNewValue
        self.actionDeleteMeter = actionDeleteMeter
        super.init(actionLoad: actionLoad, actionSelect: actionSelect)
        updatePublisher
            .sink(receiveValue: load)
            .store(in: &cancellables)
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
