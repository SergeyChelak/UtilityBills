//
//  MeterUtils.swift
//  UtilityBills
//
//  Created by Sergey on 03.10.2024.
//

import Foundation

func maxValue(for capacity: Int) -> Decimal {
    pow(10, capacity) - 1
}

func diff(_ left: Decimal, _ right: Decimal, capacity: Int?) -> Decimal {
    guard let capacity else {
        return left - right
    }
    var left = left
    if left < right {
        left += maxValue(for: capacity)
    }
    return left - right
}
