//
//  BillingMapViewModel.swift
//  UtilityBills
//
//  Created by Sergey on 28.09.2024.
//

import Combine
import Foundation

typealias BillingMapActionSave = (BillingMap) throws -> Void
typealias BillingMapActionUpdate = (BillingMap) throws -> Void
typealias BillingMapActionDelete = (BillingMapId) throws -> Void
typealias BillingMapActionLoadData = () throws -> BillingMapData

struct BillingMapData {
    let tariffs: [Tariff]
    let meters: [Meter]
    
    static func `default`() -> Self {
        BillingMapData(tariffs: [], meters: [])
    }
}

class BillingMapViewModel: ViewModel, ActionControllable {
    private var cancellables: Set<AnyCancellable> = []
    let billingMapId: BillingMapId
    let actions: [ControlAction]
    private let actionLoad: BillingMapActionLoadData
    private var actionSave: BillingMapActionSave = { _ in }
    private var actionUpdate: BillingMapActionUpdate = { _ in }
    private var actionDelete: BillingMapActionDelete = { _ in }
        
    @Published
    var name: String = ""

    @Published
    private(set) var tariffModel = SingleChoiceViewModel<Tariff>(items: [])
    private var tariffSelection: (Tariff) -> Bool = { _ in false }
    @Published
    private(set) var meterModel = MultiChoiceViewModel<Meter>(items: [])
    private var meterSelection: (Meter) -> Bool = { _ in false }
    
    init(
        actionLoad: @escaping BillingMapActionLoadData,
        actionSave: @escaping BillingMapActionSave
    ) {
        self.actions = [.new]
        self.actionLoad = actionLoad
        self.actionSave = actionSave
        self.billingMapId = BillingMapId()
        super.init()
    }
    
    init(
        billingMap: BillingMap,
        actionLoad: @escaping BillingMapActionLoadData,
        actionUpdate: @escaping BillingMapActionUpdate,
        actionDelete: @escaping BillingMapActionDelete
    ) {
        self.actions = [.update, .delete]
        self.actionLoad = actionLoad
        self.actionUpdate = actionUpdate
        self.actionDelete = actionDelete
        self.billingMapId = billingMap.id
        self.name = billingMap.name
        self.tariffSelection = {
            billingMap.tariff.id == $0.id
        }
        self.meterSelection = { item in
            billingMap.meters
                .map { $0.id }
                .contains(item.id)
        }
        super.init()
    }
    
    func load() {
        do {
            let data = try actionLoad()
            self.meterModel = MultiChoiceViewModel(
                items: data.meters, 
                selection: meterSelection
            )
            self.tariffModel = SingleChoiceViewModel(
                items: data.tariffs, 
                selection: tariffSelection
            )
            observeTariffSelection()
        } catch {
            setError(error)
        }
    }
    
    private func observeTariffSelection() {
        tariffModel
            .objectWillChange
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                guard let tariff = self?.tariffModel.selected else {
                    return
                }
                self?.name = tariff.name
            }
            .store(in: &cancellables)
    }
    
    private func validatedBillingMap() throws -> BillingMap {
        guard let tariff = tariffModel.selected else {
            throw UtilityBillsError.noTariffSelected
        }
        if name.isEmpty {
            throw UtilityBillsError.emptyName
        }
        return BillingMap(
            id: billingMapId,
            name: name,
            order: 0,
            tariff: tariff,
            meters: meterModel.selected
        )
    }
    
    func onAction(_ action: ControlAction) {
        do {
            switch action {
            case .new:
                let billingMap = try validatedBillingMap()
                try actionSave(billingMap)
            case .update:
                let billingMap = try validatedBillingMap()
                try actionUpdate(billingMap)
            case .delete:
                try actionDelete(billingMapId)
            }
        } catch {
            setError(error)
        }
    }
}
