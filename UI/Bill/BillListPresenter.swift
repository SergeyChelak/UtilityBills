//
//  BillListPresenter.swift
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
