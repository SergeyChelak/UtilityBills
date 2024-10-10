//
//  MeterValueViewModel.swift
//  UtilityBills
//
//  Created by Sergey on 24.09.2024.
//

import Foundation

class MeterValueViewModel: ViewModel, ActionControllable {
    let meterId: MeterId?
    let meterValueId: MeterValueId
    private var flow: ManageMeterValueFlowDelegate?
    @Published
    var date: Date
    @Published
    var value: String
    @Published
    var isPaid = false
    
    let actions: [ControlAction]
    
    init(
        meterId: MeterId,
        date: Date,
        value: Double,
        flow: ManageMeterValueFlowDelegate?
    ) {
        self.meterId = meterId
        self.meterValueId = MeterValueId()
        self.date = date
        self.value = value.formatted()
        self.flow = flow
        self.actions = [.new]
    }
    
    init(
        meterValue: MeterValue,
        flow: ManageMeterValueFlowDelegate?
    ) {
        // TODO: fix it!
        self.meterId = nil
        self.meterValueId = meterValue.id
        self.date = meterValue.date
        self.value = meterValue.value.formatted()
        self.isPaid = meterValue.isPaid
        self.flow = flow
        self.actions = [.update, .delete]
    }
    
    func onAction(_ action: ControlAction) {
        switch action {
        case .new:
            add()
        case .update:
            update()
        case .delete:
            delete()
        }
    }
    
    private func validatedMeterValue() throws -> MeterValue {
        guard let price = Decimal(string: value) else {
            throw UtilityBillsError.invalidPriceValue            
        }
        // TODO: check if meter value is inside meter capacity
        return MeterValue(
            id: meterValueId,
            date: date,
            value: price,
            isPaid: isPaid
        )
    }
    
    private func add() {
        guard let meterId else {
            unexpectedError("MeterValueViewModel: meterId is nil")
            return
        }
        do {
            let meterValue = try validatedMeterValue()
            try flow?.addNewMeterValue(meterId, value: meterValue)
        } catch {
            setError(error)
        }
    }
    
    private func update() {
        do {
            let meterValue = try validatedMeterValue()
            try flow?.updateMeterValue(meterValue)
        } catch {
            setError(error)
        }
    }
    
    private func delete() {
        do {
            try flow?.deleteMeterValue(meterValueId)
        } catch {
            setError(error)
        }
    }
}
