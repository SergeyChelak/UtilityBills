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
    private var flow: ManageMeterFlowDelegate?
    
    @Published
    var name: String
    @Published
    var capacity = availableCapacities[0]
    @Published
    var isCapacityApplicable = true
    @Published
    var inspectionDate = Date()
    @Published
    var isInspectionDateApplicable = true
    @Published
    var initialValue: String = "0"

    init(
        propertyObjectId: PropertyObjectId,
        name: String = "",
        flow: ManageMeterFlowDelegate?
    ) {
        self.propertyObjectId = propertyObjectId
        self.name = name
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
            id: MeterId(),
            name: name,
            capacity: selectedCapacity,
            inspectionDate: selectedInspectionDate
        )
        // TODO: validate initial value
        do {
            guard let value = Decimal(string: initialValue) else {
                throw UtilityBillsError.invalidMeterValue
            }
            try flow?.addNewMeter(
                meter,
                propertyObjectId: propertyObjectId,
                initialValue: value)
        } catch {
            setError(error)
        }
    }
}
