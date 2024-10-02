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
    private weak var delegate: MeterValuesListFlow?
    
    init(
        meterId: MeterId,
        delegate: MeterValuesListFlow?
    ) {
        self.meterId = meterId
        self.delegate = delegate
        super.init(
            actionLoad: {
                try delegate?.loadMeterValues(meterId) ?? []
            },
            actionSelect: {
                delegate?.openMeterValue($0)
            }
        )
        
        delegate?.updatePublisher
            .publisher
            .sink(receiveValue: load)
            .store(in: &cancellables)
    }
    
    func newValue() {
        delegate?.addNewMeterValue(meterId)
    }    
}
