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

private class __MeterValuesListViewModelMock: MeterValuesListViewModel {
    var retain: AnyObject?
}

private class __MeterValuesListFlowMock: MeterValuesListFlow {
    let updatePublisher: UpdatePublisher = UpdatePublisherMock()
    
    func loadMeterValues(_ meterId: MeterId) throws -> [MeterValue] {
        meterValuesMock()
    }
    
    func addNewMeterValue(_ meterId: MeterId) {
        //
    }
    
    func openMeterValue(_ meterValue: MeterValue) {
        //
    }
}

func meterValuesListViewModelMock(meterId: MeterId) -> MeterValuesListViewModel {
    let delegate = __MeterValuesListFlowMock()
    let vm = __MeterValuesListViewModelMock(
        meterId: meterId,
        delegate: delegate
    )
    vm.retain = delegate
    return vm
}
#endif
