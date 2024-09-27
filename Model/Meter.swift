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
    let name: String
    let capacity: Int?
    let inspectionDate: Date?
}

extension Meter: Equatable, Hashable { }
