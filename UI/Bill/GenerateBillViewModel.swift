//
//  GenerateBillViewModel.swift
//  UtilityBills
//
//  Created by Sergey on 03.10.2024.
//

import Combine
import Foundation

class GenerateBillViewModel: ViewModel {
    private var cancellables: Set<AnyCancellable> = []
    private let propertyObjectId: PropertyObjectId
    private let flow: CalculateFlowDelegate?
    
    init(
        propertyObjectId: PropertyObjectId,
        flow: CalculateFlowDelegate?
    ) {
        self.propertyObjectId = propertyObjectId
        self.flow = flow
        super.init()
        flow?.updatePublisher
            .publisher
            .sink { [weak self] in
                self?.load()
            }
            .store(in: &cancellables)
    }
    
    @Published
    var records: [BillRecord] = []
    
    func onTapAccept() {
        do {
            try flow?.acceptBillRecords()
        } catch {
            setError(error)
        }
    }
    
    func load() {
        guard let flow else {
            unexpectedError("Calculate flow is nil")
            return
        }
        do {
            self.records = try flow.load()
        } catch {
            setError(error)
        }
    }
    
    func onSelected(_ index: Int) {
        guard !records.isEmpty, (0..<records.count).contains(index) else {
            setError(UtilityBillsError.outOfBounds)
            return
        }
        flow?.openBillRecord(records[index])
    }
    
    var totalPrice: Decimal {
        records
            .map { $0.price }
            .reduce(0) { $0 + $1 }
    }
}
