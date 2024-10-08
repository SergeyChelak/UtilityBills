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

enum InspectionState {
    case normal, expiring, overdue
}

let ExpiringInterval: TimeInterval = 60.0 * 60 * 24 * 30     // 30 days

extension Meter {
    func getInspectionState(_ date: Date = Date()) -> InspectionState {
        guard let inspectionDate else {
            return .normal
        }
        let interval = inspectionDate.timeIntervalSince(date)
        if interval <= 0 {
            return .overdue
        }
        if interval <= ExpiringInterval {
            return .expiring
        }
        return .normal
    }
}
