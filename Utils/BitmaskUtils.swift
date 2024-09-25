//
//  BitmaskUtils.swift
//  UtilityBills
//
//  Created by Sergey on 25.09.2024.
//

import Foundation

enum BitMaskError: Error {
    case arrayTooLong
}

func arrayToBitMask(_ array: [Bool]) throws -> Int {
    let size = MemoryLayout<Int>.size
    if size > array.count {
        throw BitMaskError.arrayTooLong
    }
    var value = 0
    for (i, x) in array.enumerated() {
        if !x { continue }
        value |= 1 << i
    }
    return value
}
