//
//  UtilityBillsError.swift
//  UtilityBills
//
//  Created by Sergey on 30.09.2024.
//

import Foundation

enum UtilityBillsError: Error {
    case tariffNotSelected
    case emptyName
    case outOfBounds
    case loadingFailure
    case noTariffSelected
    case noMonthSelected
    case invalidPriceValue
}
