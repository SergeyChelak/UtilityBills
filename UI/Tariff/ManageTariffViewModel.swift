//
//  ManageTariffViewModel.swift
//  UtilityBills
//
//  Created by Sergey on 25.09.2024.
//

import Foundation

class ManageTariffViewModel: ViewModel, ActionControllable {
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
    var isConfirmationAlertVisible = false
    private var deferredAction: ControlAction?

    private let tariffId: TariffId
    let dialogTitle: String
    let actions: [ControlAction]
    let choiceViewModel: MultiChoiceViewModel<String>
    let propertyObjectId: PropertyObjectId?
    private var flow: ManageTariffFlow?
    
    init(
        propertyObjectId: PropertyObjectId,
        flow: ManageTariffFlow?
    ) {
        self.propertyObjectId = propertyObjectId
        self.flow = flow
        self.tariffId = TariffId()
        self.name = ""
        self.price = ""
        self.choiceViewModel = MultiChoiceViewModel(
            items: Self.monthList,
            initialSelection: true
        )
        self.dialogTitle = "Add new tariff"
        self.actions = [.new]
    }
    
    init(
        tariff: Tariff,
        flow: ManageTariffFlow?
    ) {
        self.propertyObjectId = nil
        self.flow = flow
        
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
    }
    
    private func validatedTariff() throws -> Tariff {
        let monthMask = try arrayToBitMask(choiceViewModel.isSelected)
        // TODO: improve validation
        if monthMask == 0 {
            throw UtilityBillsError.noMonthSelected
        }
        guard let value = Decimal(string: price), value > 0.0 else {
            throw UtilityBillsError.invalidPriceValue
        }
        if name.isEmpty {
            throw UtilityBillsError.emptyName
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
        guard let propertyObjectId else {
            unexpectedError("ManageTariffViewModel: propertyObjectId is nil")
            return
        }
        do {
            let tariff = try validatedTariff()
            try flow?.addNewTariff(propertyObjectId, tariff: tariff)
        } catch {
            setError(error)
        }
    }
    
    private func update() {
        do {
            let tariff = try validatedTariff()
            try flow?.updateTariff(tariff)
        } catch {
            setError(error)
        }
    }
    
    private func delete() {
        do {
            try flow?.deleteTariff(tariffId)
        } catch {
            setError(error)
        }
    }
}
