//
//  ManageTariffViewModel.swift
//  UtilityBills
//
//  Created by Sergey on 25.09.2024.
//

import Foundation

typealias TariffActionNew = (Tariff) throws -> Void
typealias TariffActionUpdate = (Tariff) throws -> Void
typealias TariffActionDelete = (TariffId) throws -> Void

class ManageTariffViewModel: ObservableObject {
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
    var name: String
    @Published
    var price: String
    @Published
    var error: Error?
    
    @Published
    var isConfirmationAlertVisible = false
    private var deferredAction: ControlAction?

    private let tariffId: TariffId
    let dialogTitle: String
    let actions: [ControlAction]
    let choiceViewModel: MultiChoiceViewModel<String>
    private let actionSave: TariffActionNew?
    private let actionUpdate: TariffActionUpdate?
    private let actionDelete: TariffActionDelete?
    
    init(actionSave: @escaping TariffActionNew) {
        self.tariffId = TariffId()
        self.name = ""
        self.price = ""
        self.choiceViewModel = MultiChoiceViewModel(
            items: Self.monthList,
            initialSelection: true
        )
        self.dialogTitle = "Add new tariff"
        self.actions = [.new]
        self.actionSave = actionSave
        self.actionUpdate = nil
        self.actionDelete = nil
    }
    
    init(
        tariff: Tariff,
        actionUpdate: @escaping TariffActionUpdate,
        actionDelete: @escaping TariffActionDelete
    ) {
        self.tariffId = tariff.id
        self.name = tariff.name
        
        // TODO: review this approach
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        self.price = formatter.string(for: tariff.price) ?? ""
        
        self.choiceViewModel = MultiChoiceViewModel(items: Self.monthList) {
            tariff.activeMonthMask & (1 << $0) > 0
        }
        self.dialogTitle = "Edit tariff"
        self.actions = [.update, .delete]
        self.actionSave = nil
        self.actionUpdate = actionUpdate
        self.actionDelete = actionDelete
    }
    
    private func validatedTariff() throws -> Tariff {
        let monthMask = try arrayToBitMask(choiceViewModel.isSelected)
        // TODO: improve validation
        if monthMask == 0 {
            throw NSError(domain: "UB.MonthMask", code: 1)
        }
        guard let value = Decimal(string: price), value > 0.0 else {
            throw NSError(domain: "UB.PriceValue", code: 1)
        }
        if name.isEmpty {
            throw NSError(domain: "UB.Title", code: 1)
        }
        return Tariff(
            id: tariffId,
            name: name,
            price: value,
            activeMonthMask: monthMask
        )
    }
    
    func onAction(_ action: ControlAction) {
        switch action {
        case .delete:
            deferredAction = action
            isConfirmationAlertVisible = true
        default:
            performAction(action)
        }
    }
    
    func confirm() {
        guard let deferredAction else {
            return
        }
        performAction(deferredAction)
    }
    
    private func performAction(_ action: ControlAction) {
        switch action {
        case .new:
            new()
        case .update:
            update()
        case .delete:
            delete()
        }
    }
    
    private func new() {
        do {
            let tariff = try validatedTariff()
            try actionSave?(tariff)
        } catch {
            self.error = error
        }
    }
    
    private func update() {
        do {
            let tariff = try validatedTariff()
            try actionUpdate?(tariff)
        } catch {
            self.error = error
        }
    }
    
    private func delete() {
        do {
            try actionDelete?(tariffId)
        } catch {
            self.error = error
        }
    }
}
