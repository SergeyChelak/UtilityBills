//
//  MeterValuesListViewModel.swift
//  UtilityBills
//
//  Created by Sergey on 24.09.2024.
//

import Combine

typealias MeterActionNewValue = () -> ()

class MeterValuesListViewModel: CommonListViewModel<MeterValue> {
    private var cancellables: Set<AnyCancellable> = []
    private let actionNewValue: MeterActionNewValue    
    
    init(
        actionLoad: @escaping CommonListActionLoad<MeterValue>,
        actionNewValue: @escaping MeterActionNewValue,
        actionSelect: @escaping CommonListActionSelect<MeterValue>,        
        updatePublisher: AnyPublisher<(), Never>
    ) {
        self.actionNewValue = actionNewValue        
        super.init(actionLoad: actionLoad, actionSelect: actionSelect)
        updatePublisher
            .sink(receiveValue: load)
            .store(in: &cancellables)
    }
    
    func newValue() {
        actionNewValue()
    }    
}
