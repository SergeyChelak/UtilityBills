//
//  EditMeterViewModel.swift
//  UtilityBills
//
//  Created by Sergey on 27.09.2024.
//

import Foundation

class EditMeterViewModel: ViewModel {
    let meter: Meter
    private weak var delegate: ManageMeterFlow?
    
    @Published
    var name: String
    @Published
    var inspectionDate = Date()
    @Published
    var isInspectionDateApplicable = true
    
    init(
        meter: Meter,
        delegate: ManageMeterFlow?
    ) {
        self.meter = meter
        self.delegate = delegate
        self.name = meter.name
        self.isInspectionDateApplicable = meter.inspectionDate != nil
        self.inspectionDate = meter.inspectionDate ?? Date()
    }
    
    func save() {
        do {
            if name.isEmpty {
                throw UtilityBillsError.emptyName
            }
            let updatedMeter = Meter(
                id: meter.id,
                name: name,
                capacity: meter.capacity,
                inspectionDate: isInspectionDateApplicable ? inspectionDate : nil
            )            
            try delegate?.updateMeter(updatedMeter)
        } catch {
            setError(error)
        }
    }
    
    func delete() {
        do {
            try delegate?.deleteMeter(meter.id)
        } catch {
            setError(error)
        }
    }

}
