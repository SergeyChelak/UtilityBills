//
//  PropertyObject.swift
//  UtilityBills
//
//  Created by Sergey on 28.08.2024.
//

import Foundation

typealias PropertyObjectId = UUID

struct PropertyObject {
    let id: PropertyObjectId
    var name: String
    var details: String
//    let type: PropertyObjectType
    var currencyId: String?
}

extension PropertyObject: Equatable, Hashable { }

struct PropertyObjectData {
    let propObj: PropertyObject?
    let meters: [Meter]
    let bills: [Bill]
}

struct PropertySettingsData {
    let propObj: PropertyObject?
    let meters: [Meter]
    let tariffs: [Tariff]
    let billingMaps: [BillingMap]
    
    static func `default`() -> Self {
        PropertySettingsData(
            propObj: nil,
            meters: [],
            tariffs: [],
            billingMaps: []
        )
    }
}
