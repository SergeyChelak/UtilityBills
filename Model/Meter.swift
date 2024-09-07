//
//  Meter.swift
//  UtilityBills
//
//  Created by Sergey on 28.08.2024.
//

import Foundation

typealias MeterId = UUID

struct Meter {
    let id: MeterId
//    let type: MeterType
    let name: String
    let capacity: Int?
    let inspectionDate: Date?
}
