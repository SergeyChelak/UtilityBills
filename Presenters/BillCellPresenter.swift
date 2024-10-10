//
//  BillCellPresenter.swift
//  UtilityBills
//
//  Created by Sergey on 10.10.2024.
//

import Foundation

protocol BillCellPresenter {
    func title(_ bill: Bill) -> String
    func value(_ bill: Bill) -> String
}
