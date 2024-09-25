//
//  AddTariffViewModel.swift
//  UtilityBills
//
//  Created by Sergey on 25.09.2024.
//

import Foundation

typealias AddTariffActionSave = (Tariff) throws -> Void

class AddTariffViewModel: ObservableObject {
    @Published
    var name: String = "New tariff"
    @Published
    var price: String = ""
    @Published
    var error: Error?
    
    let actionSave: AddTariffActionSave
    
    init(actionSave: @escaping AddTariffActionSave) {
        self.actionSave = actionSave
    }
    
    func save() {
        // TODO: fix stub
        let tariff = Tariff(id: UUID(), name: name, price: Decimal(0))
        do {
            try actionSave(tariff)
        } catch {
            self.error = error
        }
    }
}
