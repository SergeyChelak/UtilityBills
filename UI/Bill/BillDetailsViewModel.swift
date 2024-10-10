//
//  BillDetailsViewModel.swift
//  UtilityBills
//
//  Created by Sergey on 06.10.2024.
//

import Foundation

class BillDetailsViewModel: CommonListViewModel<BillRecord> {
    let bill: Bill
    
    init(_ bill: Bill) {
        self.bill = bill
        super.init(
            actionLoad: {
                bill.records
            },
            actionSelect: { _ in
                // no op
            }
        )
    }
    
    var date: Date {
        bill.date
    }
    
    var totalPrice: Decimal {
        bill.total
    }
}
