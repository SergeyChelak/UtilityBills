//
//  UtilityBillsError.swift
//  UtilityBills
//
//  Created by Sergey on 30.09.2024.
//

import Foundation

enum UtilityBillsError: Error {
    case notImplemented(String)
    case tariffNotSelected
    case emptyName
    case outOfBounds
    case loadingFailure
    case noMonthSelected
    case invalidPriceValue
    case invalidMeterValue
    case unexpectedState(String)
}

extension UtilityBillsError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .notImplemented(let string):
            "Feature \(string) isn't implemented yet"
        case .tariffNotSelected:
            "Tariff not selected"
        case .emptyName:
            "Empty name isn't acceptable"
        case .outOfBounds:
            "Selection is out of bounds"
        case .loadingFailure:
            "Failed to load data"
        case .noMonthSelected:
            "Month not selected"
        case .invalidPriceValue:
            "Price value is incorrect"
        case .invalidMeterValue:
            "Meter value is incorrect"
        case .unexpectedState(let msg):
            "Unexpected state: \(msg)"
        }
    }
}
