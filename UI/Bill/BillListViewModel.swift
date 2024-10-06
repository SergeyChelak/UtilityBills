//
//  BillListViewModel.swift
//  UtilityBills
//
//  Created by Sergey on 06.10.2024.
//

import Foundation

class BillListViewModel: CommonListViewModel<Bill> {
    init(flowDelegate: BillListFlowDelegate?) {
        super.init(
            actionLoad: {
                try flowDelegate?.loadBillsList() ?? []
            }, actionSelect: {
                flowDelegate?.openBillDetails($0)
            }
        )
    }
}
