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

class BillingMapViewModel: ObservableObject {
    private var cancellables: Set<AnyCancellable> = []
    let actionLoad: BillingMapActionLoadData
    let actionSave: BillingMapActionSave
    
    @Published
    var name: String = ""

    @Published
    private(set) var tariffModel = SingleChoiceViewModel<Tariff>(items: [])
    @Published
    private(set) var meterModel = MultiChoiceViewModel<Meter>(items: [])
    
    @Published
    var error: Error?
    
    init(
        actionLoad: @escaping BillingMapActionLoadData,
        actionSave: @escaping BillingMapActionSave
    ) {
        self.actionLoad = actionLoad
        self.actionSave = actionSave
        self.error = error
    }
    
    func load() {
        do {
            let data = try actionLoad()
            self.tariffModel = SingleChoiceViewModel(items: data.tariffs)
            self.meterModel = MultiChoiceViewModel(items: data.meters)
            observeTariffSelection()
        } catch {
            self.error = error
        }
    }
    
    private func observeTariffSelection() {
        tariffModel
            .objectWillChange
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                guard let tariff = self?.tariffModel.selected else {
                    self?.name = "Nothing is selected..."
                    return
                }
                self?.name = tariff.name
            }
            .store(in: &cancellables)
    }
    
    func save() {
        guard let tariff = tariffModel.selected else {
            self.error = NSError(domain: "UB.Tariff", code: 1)
            return
        }
        if name.isEmpty {
            self.error = NSError(domain: "UB.Name", code: 1)
            return
        }
        let billingMap = BillingMap(
            id: UUID(),
            name: name,
            order: 0,
            tariff: tariff,
            meters: meterModel.selected
        )
        do {
            try actionSave(billingMap)
        } catch {
            self.error = error
        }
    }
}
