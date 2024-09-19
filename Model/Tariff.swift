//
//  Tariff.swift
//  UtilityBills
//
//  Created by Sergey on 28.08.2024.
//

import Foundation

typealias TariffId = UUID

fileprivate let wholeYearMask = 0b111111111111

struct Tariff {
    let id: TariffId
    var name: String
    var price: Decimal
    var activeMonthMask: Int = wholeYearMask
    
    func isActiveMonth(_ number: Int) -> Bool {
        let monthMask = 1 << (number + 1)
        return activeMonthMask & monthMask != 0
    }
    
    mutating func setMonth(_ number: Int, isActive: Bool) {
        let monthMask = 1 << (number + 1)
        if isActive {
            activeMonthMask |= monthMask
        } else {
            activeMonthMask ^= monthMask
        }
    }
}
