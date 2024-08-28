//
//  MeterService.swift
//  UtilityBills
//
//  Created by Sergey on 28.08.2024.
//

import Foundation

protocol MeterService {
    func allMeters(for property: PropertyObject) async throws -> [Meter]
    
    func newMeter(for property: PropertyObject) async throws -> Meter
    
    func deleteMeter(_ meter: Meter) async throws
    
    func updateMeter(_ meter: Meter) async throws
}
