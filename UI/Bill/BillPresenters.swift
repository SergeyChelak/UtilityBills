//
//  BillPresenters.swift
//  UtilityBills
//
//  Created by Sergey on 10.10.2024.
//

import Foundation

struct iOSBillListPresenter: BillListPresenter {
    var emptyBillListMessage: String {
        "You have no bills yet"
    }
    
    var screenTitle: String {
        "Your Bills"
    }
}

struct iOSBillDetailsPresenter: BillDetailsPresenter {
    var header: String {
        "Bill Details"
    }
    
    var emptyBillMessage: String {
        "No records found"
    }
    
    func totalPrice(_ price: Decimal) -> String {
        "Total price: \(price.formatted())"
    }
    
    func billDate(_ date: Date) -> String {
        date.formatted()
    }
}
