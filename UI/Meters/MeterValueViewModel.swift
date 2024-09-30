//
//  MeterValueViewModel.swift
//  UtilityBills
//
//  Created by Sergey on 24.09.2024.
//

import Foundation

typealias MeterValueActionAdd = (MeterValue) throws -> Void
typealias MeterValueActionUpdate = (MeterValue) throws -> Void
typealias MeterValueActionDelete = (MeterValueId) throws -> Void

class MeterValueViewModel: ObservableObject {
    let id: MeterValueId
    @Published
    var date: Date
    @Published
    var value: Double
    @Published
    var isPaid = false
    @Published
    var error: Error?
    
    let actions: [ControlAction]
    let screenTitle: String
    private var actionAdd: MeterValueActionAdd?
    private var actionUpdate: MeterValueActionUpdate?
    private var actionDelete: MeterValueActionDelete?
    
    init(
        date: Date,
        value: Double,
        actionAdd: @escaping MeterValueActionAdd
    ) {
        self.id = MeterValueId()
        self.date = date
        self.value = value
        self.actionAdd = actionAdd
        self.actions = [.new]
        self.screenTitle = "Add new meter value"
    }
    
    init(
        meterValue: MeterValue,
        actionUpdate: @escaping MeterValueActionUpdate,
        actionDelete: @escaping MeterValueActionDelete
    ) {
        self.id = meterValue.id
        self.date = meterValue.date
        self.value = meterValue.value
        self.isPaid = meterValue.isPaid
        self.actionUpdate = actionUpdate
        self.actionDelete = actionDelete
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
            id: id,
            date: date,
            value: value,
            isPaid: isPaid
        )
    }
    
    private func add() {
        do {
            let meterValue = try validatedMeterValue()
            try actionAdd?(meterValue)
        } catch {
            self.error = error
        }
    }
    
    private func update() {
        do {
            let meterValue = try validatedMeterValue()
            try actionUpdate?(meterValue)
        } catch {
            self.error = error
        }
    }
    
    private func delete() {
        do {
            try actionDelete?(id)
        } catch {
            self.error = error
        }
    }
}
