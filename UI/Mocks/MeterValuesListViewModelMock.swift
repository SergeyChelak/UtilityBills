//
//  MeterValuesListViewModelMock.swift
//  UtilityBills
//
//  Created by Sergey on 02.10.2024.
//

#if DEBUG
import Foundation
private func meterValuesMock() -> [MeterValue] {
    let values = [
        MeterValue(id: UUID(), date: Date(), value: 10, isPaid: true),
        MeterValue(id: UUID(), date: Date(), value: 17, isPaid: true),
        MeterValue(id: UUID(), date: Date(), value: 24, isPaid: true),
        MeterValue(id: UUID(), date: Date(), value: 25, isPaid: false)
    ].reversed()
    return Array(values)
}

private class MeterValuesListFlowMock: MeterValuesListFlowDelegate {
    let updatePublisher: UpdatePublisher = UpdatePublisherMock()
    
    func loadMeterValues(_ meterId: MeterId) throws -> [MeterValue] {
        meterValuesMock()
    }
    
    func openNewMeterValue(_ meterId: MeterId) {
        //
    }
    
    func openMeterValue(_ meterValue: MeterValue) {
        //
    }
}

func meterValuesListViewModelMock(meterId: MeterId) -> MeterValuesListViewModel {
    let flow = MeterValuesListFlowMock()
    let vm = MeterValuesListViewModel(
        meterId: meterId,
        flow: flow
    )
    return vm
}
#endif
