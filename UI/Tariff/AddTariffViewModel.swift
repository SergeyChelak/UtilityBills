//
//  AddTariffViewModel.swift
//  UtilityBills
//
//  Created by Sergey on 25.09.2024.
//

import Foundation

typealias AddTariffActionSave = (Tariff) throws -> Void

class AddTariffViewModel: ObservableObject {
    private static let monthList = [
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
    
    let choiceViewModel = MultiChoiceViewModel(
        items: monthList,
        initialSelection: true
    )
    
    let actionSave: AddTariffActionSave
    
    init(actionSave: @escaping AddTariffActionSave) {
        self.actionSave = actionSave
    }
            
    func save() {
        do {
            let monthMask = try arrayToBitMask(choiceViewModel.isSelected)
            // TODO: improve validation
            if monthMask == 0 {
                throw NSError(domain: "UB.MonthMask", code: 1)
            }
            guard let value = Decimal(string: price), value <= 0.0 else {
                throw NSError(domain: "UB.PriceValue", code: 1)
            }
            if name.isEmpty {
                throw NSError(domain: "UB.Title", code: 1)
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
