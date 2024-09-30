//
//  Tariff.swift
//  UtilityBills
//
//  Created by Sergey on 28.08.2024.
//

import Foundation

typealias TariffId = UUID

struct Tariff {
    let id: TariffId
    var name: String
    var price: Decimal
    var activeMonthMask: Int
}

extension Tariff: Equatable, Hashable { }
