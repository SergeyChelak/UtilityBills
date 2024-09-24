//
//  MetersDAO.swift
//  UtilityBills
//
//  Created by Sergey on 28.08.2024.
//

import Foundation

protocol MetersDAO {
    func allMeters(for property: PropertyObjectId) throws -> [Meter]
    
    func meterValues(_ meterId: MeterId) throws -> [MeterValue]
    
    func newMeter(
        propertyObjectId: PropertyObjectId,
        name: String,
        capacity: Int?,
        inspectionDate: Date?,
        initialValue: Double
    ) throws -> Meter
}
