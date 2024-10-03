//
//  GenerateBillViewModel.swift
//  UtilityBills
//
//  Created by Sergey on 03.10.2024.
//

import Foundation

class GenerateBillViewModel: ViewModel {
    @Published
    var records: [BillRecord] = []
    
    func onTapAccept() {
        setError(UtilityBillsError.notImplemented("onTapAccept"))
    }
    
    func load() {
        records = [
            BillRecord(name: "Cold Water", amount: 12, price: 245.3),
            BillRecord(name: "Hot Water", amount: 6, price: 545.9),
            BillRecord(name: "Electricity", amount: 85, price: 124.53),
            BillRecord(name: "Gas", amount: 4, price: 31.14),
        ]
    }
    
    func onSelected(_ index: Int) {
        
    }
    
    var totalPrice: String {
        records
            .map { $0.price }
            .reduce(0) { $0 + $1 }
            .formatted()
    }
}

class Box<T> {
    let value: T
    
    init(_ value: T) {
        self.value = value
    }
}
