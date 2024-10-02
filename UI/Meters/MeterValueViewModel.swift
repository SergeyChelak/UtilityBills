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
    private weak var delegate: ManageMeterValueFlow?
    @Published
    var date: Date
    @Published
    var value: Double
    @Published
    var isPaid = false
    
    let actions: [ControlAction]
    let screenTitle: String
    
    init(
        meterId: MeterId,
        date: Date,
        value: Double,
        delegate: ManageMeterValueFlow?
    ) {
        self.meterId = meterId
        self.meterValueId = MeterValueId()
        self.date = date
        self.value = value
        self.delegate = delegate
        self.actions = [.new]
        self.screenTitle = "Add new meter value"
    }
    
    init(
        meterValue: MeterValue,
        delegate: ManageMeterValueFlow?
    ) {
        // TODO: fix it!
        self.meterId = nil
        self.meterValueId = meterValue.id
        self.date = meterValue.date
        self.value = meterValue.value
        self.isPaid = meterValue.isPaid
        self.delegate = delegate
        self.actions = [.update, .delete]
        self.screenTitle = "Edit meter value"
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
        // TODO: check if meter value is inside meter capacity
        MeterValue(
            id: meterValueId,
            date: date,
            value: value,
            isPaid: isPaid
        )
    }
    
    private func add() {
        guard let meterId else {
            setError(UtilityBillsError.unexpectedState("MeterValueViewModel: meterId is nil"))
            return
        }
        do {
            let meterValue = try validatedMeterValue()
            try delegate?.addNewMeterValue(meterId, value: meterValue)
        } catch {
            setError(error)
        }
    }
    
    private func update() {
        do {
            let meterValue = try validatedMeterValue()
            try delegate?.updateMeterValue(meterValue)
        } catch {
            setError(error)
        }
    }
    
    private func delete() {
        do {
            try delegate?.deleteMeterValue(meterValueId)
        } catch {
            setError(error)
        }
    }
}
