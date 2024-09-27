//
//  EditMeterViewModel.swift
//  UtilityBills
//
//  Created by Sergey on 27.09.2024.
//

import Foundation

typealias MeterActionUpdate = (Meter) throws -> Void
typealias MeterActionDelete = () throws -> ()

class EditMeterViewModel: ObservableObject {
    let meter: Meter
    private let actionDeleteMeter: MeterActionDelete
    private let actionUpdateMeter: MeterActionUpdate
    
    @Published
    var name: String
    @Published
    var inspectionDate = Date()
    @Published
    var isInspectionDateApplicable = true
    @Published
    var error: Error?
    
    init(
        meter: Meter,
        actionUpdateMeter: @escaping MeterActionUpdate,
        actionDeleteMeter: @escaping MeterActionDelete
    ) {
        self.meter = meter
        self.actionUpdateMeter = actionUpdateMeter
        self.actionDeleteMeter = actionDeleteMeter
        self.name = meter.name
        self.isInspectionDateApplicable = meter.inspectionDate != nil
        self.inspectionDate = meter.inspectionDate ?? Date()
    }
    
    func save() {
        let updatedMeter = Meter(
            id: meter.id,
            name: name,
            capacity: meter.capacity,
            inspectionDate: isInspectionDateApplicable ? inspectionDate : nil
        )
        do {
            try actionUpdateMeter(updatedMeter)
        } catch {
            self.error = error
        }
    }
    
    func delete() {
        do {
            try actionDeleteMeter()
        } catch {
            self.error = error
        }
    }

}
