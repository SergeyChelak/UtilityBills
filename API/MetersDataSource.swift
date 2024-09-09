//
//  MetersDataSource.swift
//  UtilityBills
//
//  Created by Sergey on 28.08.2024.
//

import Foundation

protocol MeterListDataSource {
    func allMeters(for property: PropertyObjectId) throws -> [Meter]
    
    func newMeter(for property: PropertyObjectId) throws -> Meter    
}
