//
//  MeterValue.swift
//  UtilityBills
//
//  Created by Sergey on 10.09.2024.
//

import Foundation

struct MeterValue {
    let date: Date
    let value: Double
    let isPaid: Bool
    let id: UUID
}

extension MeterValue {
    static func initial(_ value: Double) -> MeterValue {
        MeterValue(
            date: Date(),
            value: value,
            isPaid: true,
            id: UUID()          // should be ignored!
        )
    }
}
