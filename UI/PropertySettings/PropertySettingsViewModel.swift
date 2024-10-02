//
//  PropertySettingsViewModel.swift
//  UtilityBillsTests
//
//  Created by Sergey on 27.09.2024.
//

import Combine
import Foundation

class PropertySettingsViewModel: ViewModel {
    private var cancellables: Set<AnyCancellable> = []
    
    let objectId: PropertyObjectId
    private weak var delegate: PropertyObjectSettingFlow?
    
    @Published
    var data: PropertySettingsData = .default()
    
    init(
        objectId: PropertyObjectId,
        delegate: PropertyObjectSettingFlow?
    ) {
        self.objectId = objectId
        self.delegate = delegate
        super.init()
        delegate?.updatePublisher
            .publisher
            .sink(receiveValue: load)
            .store(in: &cancellables)
    }
    
    var meters: [Meter] {
        data.meters
    }
    
    var tariffs: [Tariff] {
        data.tariffs
    }
    
    var billingMaps: [BillingMap] {
        data.billingMaps
    }
    
    func load() {
        guard let delegate else {
            return
        }
        do {
            data = try delegate.loadPropertySettingsData(objectId)
        } catch {
            setError(error)
        }
    }
    
    func addMeter() {
        delegate?.openAddMeter(objectId)
    }
    
    func meterSelected(_ meter: Meter) {
        delegate?.openEditMeter(meter)
    }
    
    func tariffSelected(_ tariff: Tariff) {
        delegate?.openEditTariff(tariff)
    }
    
    func addTariff() {
        delegate?.openAddTariff(objectId)
    }
    
    func addBillingMap() {
        delegate?.openAddBillingMap(billingMapData)
    }
    
    func editBillingMap(_ billingMap: BillingMap) {
        delegate?.openEditBillingMap(billingMap, data: billingMapData)
    }
    
    func deleteObject() {
        do {
            try delegate?.deletePropertyObject(objectId)
        } catch {
            setError(error)
        }
    }
    
    private var billingMapData: BillingMapData {
        BillingMapData(
            tariffs: tariffs,
            meters: meters, 
            propertyObjectId: objectId
        )
    }
}
