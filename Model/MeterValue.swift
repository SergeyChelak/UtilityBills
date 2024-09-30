//
//  MeterValue.swift
//  UtilityBills
//
//  Created by Sergey on 10.09.2024.
//

import Foundation

typealias MeterValueId = UUID

struct MeterValue {
    let id: MeterValueId
    let date: Date
    let value: Double
    let isPaid: Bool
}

extension MeterValue: Equatable, Hashable { }

extension MeterValue {
    static func initial(_ value: Double) -> MeterValue {
        MeterValue(
            id: MeterValueId(),         // should be ignored!
            date: Date(),
            value: value,
            isPaid: true
        )
    }
}
