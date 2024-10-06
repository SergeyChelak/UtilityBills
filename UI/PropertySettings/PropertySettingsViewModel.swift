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
    private var flow: PropertyObjectSettingFlowDelegate?
    
    @Published
    var data: PropertySettingsData = .default()
    
    init(
        objectId: PropertyObjectId,
        flow: PropertyObjectSettingFlowDelegate?
    ) {
        self.objectId = objectId
        self.flow = flow
        super.init()
        flow?.updatePublisher
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
    
    var propObj: PropertyObject? {
        data.propObj
    }
    
    func load() {
        guard let flow else {
            return
        }
        do {
            data = try flow.loadPropertySettingsData(objectId)
        } catch {
            setError(error)
        }
    }
    
    func editPropertyDetails() {
        guard let propObj = data.propObj else {
            self.error = UtilityBillsError.loadingFailure
            return
        }
        flow?.openEditPropertyObject(propObj)
    }
    
    func addMeter() {
        flow?.openAddMeter(objectId)
    }
    
    func meterSelected(_ meter: Meter) {
        flow?.openEditMeter(meter)
    }
    
    func tariffSelected(_ tariff: Tariff) {
        flow?.openEditTariff(tariff)
    }
    
    func addTariff() {
        flow?.openAddTariff(objectId)
    }
    
    func addBillingMap() {
        flow?.openAddBillingMap(billingMapData)
    }
    
    func editBillingMap(_ billingMap: BillingMap) {
        flow?.openEditBillingMap(billingMap, data: billingMapData)
    }
    
    func deleteObject() {
        do {
            try flow?.deletePropertyObject(objectId)
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
