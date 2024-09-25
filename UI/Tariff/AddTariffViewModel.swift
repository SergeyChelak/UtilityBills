//
//  AddTariffViewModel.swift
//  UtilityBills
//
//  Created by Sergey on 25.09.2024.
//

import Foundation

typealias AddTariffActionSave = (Tariff) throws -> Void

class AddTariffViewModel: ObservableObject {
    private static let _monthList = [
        "January",
        "February",
        "March",
        "April",
        "March",
        "June",
        "July",
        "August",
        "September",
        "October",
        "November",
        "December"
    ]
    
    @Published
    var name: String = "New tariff"
    @Published
    var price: String = ""
    @Published
    var error: Error?
    @Published
    var selected = [Bool].init(repeating: true, count: _monthList.count)
    
    let actionSave: AddTariffActionSave
    
    init(actionSave: @escaping AddTariffActionSave) {
        self.actionSave = actionSave
    }
    
    var monthList: [String] {
        Self._monthList
    }
    
    func toggle(_ month: Int) {
        selected[month].toggle()
    }
    
    func save() {
        do {
            let monthMask = try arrayToBitMask(selected)
            guard let value = Decimal(string: price) else {
                throw NSError(domain: "UB.Cast", code: 1)
            }
            let tariff = Tariff(
                id: UUID(),
                name: name,
                price: value,
                activeMonthMask: monthMask
            )
            try actionSave(tariff)
        } catch {
            self.error = error
        }
    }
}
