//
//  AddMeterViewModel.swift
//  UtilityBills
//
//  Created by Sergey on 24.09.2024.
//

import Foundation

typealias AddMeterActionSave = (_ meter: Meter,
                                _ initialValue: Double) throws -> Void

class AddMeterViewModel: ViewModel {
    private static let availableCapacities = [5, 6, 7, 8, 9, 10, 11, 12]
    
    let propertyObjectId: PropertyObjectId
    let actionSave: AddMeterActionSave
    
    @Published
    var name: String = "New Meter"
    @Published
    var capacity = availableCapacities[0]
    @Published
    var isCapacityApplicable = true
    @Published
    var inspectionDate = Date()
    @Published
    var isInspectionDateApplicable = true
    @Published
    var initialValue: Double = 0.0

    init(
        propertyObjectId: PropertyObjectId,
        actionSave: @escaping AddMeterActionSave
    ) {
        self.propertyObjectId = propertyObjectId
        self.actionSave = actionSave
    }
    
    var capacities: [Int] {
        Self.availableCapacities
    }
    
    private var selectedCapacity: Int? {
        isCapacityApplicable ? capacity : nil
    }
    
    private var selectedInspectionDate: Date? {
        isInspectionDateApplicable ? inspectionDate : nil
    }
    
    func save() {
        let meter = Meter(
            id: UUID(),
            name: name,
            capacity: selectedCapacity,
            inspectionDate: selectedInspectionDate
        )
        // TODO: validate initial value
        do {
            try actionSave(meter, initialValue)
        } catch {
            setError(error)
        }
    }
}
