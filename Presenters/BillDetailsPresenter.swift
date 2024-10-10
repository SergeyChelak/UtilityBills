//
//  BillDetailsPresenter.swift
//  UtilityBills
//
//  Created by Sergey on 10.10.2024.
//

import Foundation

protocol BillDetailsPresenter {
    var header: String { get }
    var emptyBillMessage: String { get }
    func totalPrice(_ price: Decimal) -> String
    func billDate(_ date: Date) -> String
}
