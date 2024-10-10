//
//  BillListPresenter.swift
//  UtilityBills
//
//  Created by Sergey on 10.10.2024.
//

import Foundation

protocol BillListPresenter {
    var billCellPresenter: BillCellPresenter { get }
    var emptyBillListMessage: String { get }
    var screenTitle: String { get }
}
