//
//  MetersDAO.swift
//  UtilityBills
//
//  Created by Sergey on 28.08.2024.
//

import Foundation

protocol MetersDAO {
    func allMeters(_ property: PropertyObjectId) throws -> [Meter]
    
    func deleteMeter(_ meterId: MeterId) throws
    
    func meterValues(_ meterId: MeterId) throws -> [MeterValue]
    
    func newMeter(
        propertyObjectId: PropertyObjectId,
        meter: Meter,
        initialValue: Double
    ) throws
 
    func updateMeter(_ meter: Meter) throws
    
    func insertMeterValue(_ meterId: MeterId, value: MeterValue) throws
    
    func updateMeterValue(_ meterValue: MeterValue) throws
    
    func deleteMeterValue(_ meterValueId: MeterValueId) throws
}
