//
//  BillListViewModel.swift
//  UtilityBills
//
//  Created by Sergey on 06.10.2024.
//

import Foundation

class BillListViewModel: ViewModel {
    @Published
    private(set) var items: [Bill] = []
    
    private var flowDelegate: BillListFlowDelegate?
    
    init(flowDelegate: BillListFlowDelegate?) {
        self.flowDelegate = flowDelegate
    }
    
    func load() {
        do {
            self.items = try flowDelegate?.loadBillsList() ?? []
        } catch {
            setError(error)
        }
    }
    
    func onSelect(_ index: Int) {
        flowDelegate?.openBillDetails(items[index])
    }
}
