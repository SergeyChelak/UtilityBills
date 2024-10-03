//
//  AddMeterViewModel.swift
//  UtilityBills
//
//  Created by Sergey on 24.09.2024.
//

import Foundation

class AddMeterViewModel: ViewModel {
    private static let availableCapacities = [5, 6, 7, 8, 9, 10, 11, 12]
    
    let propertyObjectId: PropertyObjectId
    private var flow: ManageMeterFlow?
    
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
        flow: ManageMeterFlow?
    ) {
        self.propertyObjectId = propertyObjectId
        self.flow = flow
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
            try flow?.addNewMeter(
                meter,
                propertyObjectId: propertyObjectId,
                initialValue: initialValue)
        } catch {
            setError(error)
        }
    }
}
