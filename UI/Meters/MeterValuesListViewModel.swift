//
//  MeterValuesListViewModel.swift
//  UtilityBills
//
//  Created by Sergey on 24.09.2024.
//

import Combine

class MeterValuesListViewModel: CommonListViewModel<MeterValue> {
    private var cancellables: Set<AnyCancellable> = []
    let meterId: MeterId
    private var flow: MeterValuesListFlow?
    
    init(
        meterId: MeterId,
        flow: MeterValuesListFlow?
    ) {
        self.meterId = meterId
        self.flow = flow
        super.init(
            actionLoad: {
                try flow?.loadMeterValues(meterId) ?? []
            },
            actionSelect: {
                flow?.openMeterValue($0)
            }
        )
        
        flow?.updatePublisher
            .publisher
            .sink(receiveValue: load)
            .store(in: &cancellables)
    }
    
    func openNewMeterValue() {
        flow?.openNewMeterValue(meterId)
    }    
}
