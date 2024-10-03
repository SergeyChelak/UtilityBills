//
//  GenerateBillViewModel.swift
//  UtilityBills
//
//  Created by Sergey on 03.10.2024.
//

import Foundation

class GenerateBillViewModel: ViewModel {
    private let propertyObjectId: PropertyObjectId
    private let flow: CalculateFlow?
    
    init(
        propertyObjectId: PropertyObjectId,
        flow: CalculateFlow?
    ) {
        self.propertyObjectId = propertyObjectId
        self.flow = flow
    }
    
    @Published
    var records: [BillRecord] = []
    
    func onTapAccept() {
        setError(UtilityBillsError.notImplemented("onTapAccept"))
    }
    
    func load() {
        guard let flow else {
            unexpectedError("Calculate flow is nil")
            return
        }
        do {
            self.records = try flow.calculate()
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
    
    var totalPrice: String {
        records
            .map { $0.price }
            .reduce(0) { $0 + $1 }
            .formatted()
    }
}
