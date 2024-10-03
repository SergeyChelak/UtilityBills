//
//  Bill.swift
//  UtilityBills
//
//  Created by Sergey on 01.10.2024.
//

import Foundation

struct Bill {
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

struct BillRecord {
    let name: String
    let amount: Decimal
    let price: Decimal
}
