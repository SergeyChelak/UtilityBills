//
//  ModifyBillRecordViewModel.swift
//  UtilityBills
//
//  Created by Sergey on 04.10.2024.
//

import Foundation

class ModifyBillRecordViewModel: ViewModel, ActionControllable {
    let actions: [ControlAction] = [.update, .delete]
    let billRecord: BillRecord
    let flow: ManageBillRecordFlowDelegate?
    @Published
    var price: String
    
    init(
        billRecord: BillRecord,
        flow: ManageBillRecordFlowDelegate?
    ) {
        self.billRecord = billRecord
        self.flow = flow
        self.price = billRecord.price.formatted()
    }
    
    var name: String {
        billRecord.name
    }

    var amount: String? {
        billRecord.amount?.formatted()
    }
    
    func onAction(_ action: ControlAction) {
        switch action {
        case .new:
            unexpectedError("Action 'Add' isn't expected for this screen")
        case .update:
            update()
        case .delete:
            delete()
        }
    }
    
    private func update() {
        guard let newPrice = Decimal(string: price) else {
            setError(UtilityBillsError.invalidPriceValue)
            return
        }
        var newRecord = billRecord
        newRecord.price = newPrice
        flow?.updateBillRecord(newRecord)
    }
    
    private func delete() {
        flow?.deleteBillRecord(billRecord.id)
    }
}
