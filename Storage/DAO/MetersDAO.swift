//
//  MetersDAO.swift
//  UtilityBills
//
//  Created by Sergey on 28.08.2024.
//

import Foundation

protocol MetersDAO {
    func allMeters(for property: PropertyObjectId) throws -> [Meter]
    
    func deleteMeter(_ meterId: MeterId) throws
    
    func meterValues(_ meterId: MeterId) throws -> [MeterValue]
    
    func newMeter(
        propertyObjectId: PropertyObjectId,
        meter: Meter,
        initialValue: Double
    ) throws
 
    func updateMeter(_ meter: Meter) throws
    
    func insertMeterValue(_ meterId: MeterId, value: MeterValue) throws
}
