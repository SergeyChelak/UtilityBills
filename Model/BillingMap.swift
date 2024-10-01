//
//  BillingMap.swift
//  UtilityBills
//
//  Created by Sergey on 28.08.2024.
//

import Foundation

typealias BillingMapId = UUID

struct BillingMap {
    let id: BillingMapId
    let name: String
    let order: Int
    let tariff: Tariff
    let meters: [Meter]
}

extension BillingMap: Equatable, Hashable { }
