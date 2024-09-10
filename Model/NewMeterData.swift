//
//  NewMeterData.swift
//  UtilityBills
//
//  Created by Sergey on 10.09.2024.
//

import Foundation

struct NewMeterData {
    static let capacities = [5, 6, 7, 8, 9, 10, 11, 12]
    let propertyObjectId: PropertyObjectId
    
    var name: String = "New Meter"
    var capacity = capacities[0]
    var isCapacityApplicable = true
    var inspectionDate = Date()
    var isInspectionDateApplicable = true
    
    var initialValue: Double = 0.0
    
    static func newData(propertyObjectId: PropertyObjectId) -> Self {
        NewMeterData(propertyObjectId: propertyObjectId)
    }
}

func maxValue(for capacity: Int) -> Double {
    (pow(10, capacity) as NSNumber).doubleValue - 1
}

func formatPicker(for capacity: Int) -> String {
    String(format: "%d digits, max value: %.0f", capacity, maxValue(for: capacity) as CVarArg)
}
