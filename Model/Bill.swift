//
//  Bill.swift
//  UtilityBills
//
//  Created by Sergey on 01.10.2024.
//

import Foundation

typealias BillId = UUID

struct Bill {
    let id: BillId
    let date: Date
    let records: [BillRecord]
    
    var total: Decimal {
        records
            .map { $0.price }
            .reduce(0) { acc, val in
                acc + val
            }
    }
}

typealias BillRecordId = UUID

struct BillRecord {
    let id: BillRecordId
    let name: String
    let amount: Decimal?
    var price: Decimal
}
