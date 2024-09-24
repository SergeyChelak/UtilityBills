//
//  MeterNewValueViewModel.swift
//  UtilityBills
//
//  Created by Sergey on 24.09.2024.
//

import Foundation

typealias MeterValueAddAction = (MeterValue) throws -> ()

class MeterNewValueViewModel: ObservableObject {
    @Published
    var date: Date
    @Published
    var value: Double
    @Published
    var error: Error?
    
    private let actionSave: MeterValueAddAction
    
    init(
        date: Date,
        value: Double,
        actionSave: @escaping MeterValueAddAction
    ) {
        self.date = date
        self.value = value
        self.actionSave = actionSave
    }
    
    func save() {
        let value = MeterValue(
            date: date,
            value: value,
            isPaid: false,
            id: UUID())
        do {
            try actionSave(value)
        } catch {
            self.error = error
        }
    }
}
