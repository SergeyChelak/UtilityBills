//
//  iOSGenerateBillPresenter.swift
//  UtilityBills
//
//  Created by Sergey on 10.10.2024.
//

import Foundation

struct iOSGenerateBillPresenter: GenerateBillPresenter {
    var screenTitle: String {
        "New Bill"
    }
    
    func totalPrice(_ price: Decimal) -> String {
        "Total price: \(price.formatted())"
    }
    
    var saveButtonTitle: String {
        "Accept"
    }
}
