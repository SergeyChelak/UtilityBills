//
//  BillingMapViewModel.swift
//  UtilityBills
//
//  Created by Sergey on 28.09.2024.
//

import Combine
import Foundation

class BillingMapViewModel: ViewModel, ActionControllable {
    private var cancellables: Set<AnyCancellable> = []
    let billingMapId: BillingMapId
    let actions: [ControlAction]
    private var flow: ManageBillingMapFlowDelegate?
    private let propertyObjectId: PropertyObjectId
    
    @Published
    var name: String = ""

    @Published
    private(set) var tariffModel: SingleChoiceViewModel<Tariff>
    @Published
    private(set) var meterModel: MultiChoiceViewModel<Meter>
    
    init(
        billingMapData: BillingMapData,
        flow: ManageBillingMapFlowDelegate?
    ) {
        self.actions = [.new]
        self.flow = flow
        self.propertyObjectId = billingMapData.propertyObjectId
        self.billingMapId = BillingMapId()
        self.tariffModel = SingleChoiceViewModel<Tariff>(items: billingMapData.tariffs) { _ in false }
        self.meterModel = MultiChoiceViewModel<Meter>(items: billingMapData.meters) { (_: Int) in false }
        super.init()
        observeTariffSelection()
    }
    
    init(
        billingMap: BillingMap,
        billingMapData: BillingMapData,
        flow: ManageBillingMapFlowDelegate?
    ) {
        self.actions = [.update, .delete]
        self.flow = flow
        self.propertyObjectId = billingMapData.propertyObjectId
        self.billingMapId = billingMap.id
        self.name = billingMap.name
        self.tariffModel = SingleChoiceViewModel<Tariff>(items: billingMapData.tariffs) {
            billingMap.tariff.id == $0.id
        }
        self.meterModel = MultiChoiceViewModel<Meter>(items: billingMapData.meters) { item in
            billingMap.meters
                .map { $0.id }
                .contains(item.id)
        }
        super.init()
        observeTariffSelection()
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
            throw UtilityBillsError.tariffNotSelected
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
                try flow?.addNewBillingMap(propertyObjectId, billingMap: billingMap)
            case .update:
                let billingMap = try validatedBillingMap()
                try flow?.updateBillingMap(billingMap)
            case .delete:
                try flow?.deleteBillingMap(billingMapId)
            }
        } catch {
            setError(error)
        }
    }
}
