//
//  GenerateBillPresenter.swift
//  UtilityBills
//
//  Created by Sergey on 10.10.2024.
//

import Foundation

protocol GenerateBillPresenter {
    var screenTitle: String { get }
    func totalPrice(_ price: Decimal) -> String
    var saveButtonTitle: String { get }
}
