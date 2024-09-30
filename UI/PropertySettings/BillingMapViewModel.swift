//
//  BillingMapViewModel.swift
//  UtilityBills
//
//  Created by Sergey on 28.09.2024.
//

import Combine
import Foundation

typealias BillingMapActionSave = (BillingMap) throws -> Void
typealias BillingMapActionLoadData = () throws -> BillingMapData

struct BillingMapData {
    let tariffs: [Tariff]
    let meters: [Meter]
    
    static func `default`() -> Self {
        BillingMapData(tariffs: [], meters: [])
    }
}

class BillingMapViewModel: ViewModel {
    private var cancellables: Set<AnyCancellable> = []
    let actionLoad: BillingMapActionLoadData
    let actionSave: BillingMapActionSave
    
    @Published
    var name: String = ""

    @Published
    private(set) var tariffModel = SingleChoiceViewModel<Tariff>(items: [])
    @Published
    private(set) var meterModel = MultiChoiceViewModel<Meter>(items: [])
    
    init(
        actionLoad: @escaping BillingMapActionLoadData,
        actionSave: @escaping BillingMapActionSave
    ) {
        self.actionLoad = actionLoad
        self.actionSave = actionSave
        super.init()
    }
    
    func load() {
        do {
            let data = try actionLoad()
            self.tariffModel = SingleChoiceViewModel(items: data.tariffs)
            self.meterModel = MultiChoiceViewModel(items: data.meters)
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
            throw NSError(domain: "UB.Tariff", code: 1)
        }
        if name.isEmpty {
            throw NSError(domain: "UB.Name", code: 1)
        }
        return BillingMap(
            id: UUID(),
            name: name,
            order: 0,
            tariff: tariff,
            meters: meterModel.selected
        )
    }
    
    func save() {
        do {
            let billingMap = try validatedBillingMap()
            try actionSave(billingMap)
        } catch {
            setError(error)
        }
    }
}
