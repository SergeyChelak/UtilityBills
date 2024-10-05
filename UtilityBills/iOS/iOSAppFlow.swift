//
//  iOSAppFlow.swift
//  UtilityBills
//
//  Created by Sergey on 02.10.2024.
//

import Combine
import Foundation

class iOSAppFlow {
    private let storage: LocalStorage
    private let router: Router
    let updatePublisher: UpdatePublisher
    
    init(
        router: Router,
        storage: LocalStorage,
        updatePublisher: UpdatePublisher
    ) {
        self.router = router
        self.storage = storage
        self.updatePublisher = updatePublisher
    }
}

// MARK: +PropertyObjectListFlow
extension iOSAppFlow: PropertyObjectListFlowDelegate {
    func loadPropertyObjects() throws -> [PropertyObject] {
        try storage.allProperties()
    }
    
    func openPropertyObject(_ propertyObjectId: PropertyObjectId) {
        router.push(.propertyObjectHome(propertyObjectId))
    }
    
    func createPropertyObject() throws {
        _ = try storage.createProperty()
    }
}

// MARK: +PropertyObjectFlow
extension iOSAppFlow: PropertyObjectFlowDelegate {
    func loadPropertyObjectData(_ propertyObjectId: PropertyObjectId) throws -> PropertyObjectData {
        let propObj = try storage.fetchProperty(propertyObjectId)
        let meters = try storage.allMeters(propertyObjectId)
        let bills = try storage.bills(propertyObjectId, limit: 5)
        return PropertyObjectData(
            propObj: propObj,
            meters: meters,
            bills: bills
        )
    }
    
    func openEditPropertyObject(_ propertyObject: PropertyObject) {
        router.showOverlay(.editPropertyInfo(propertyObject))
    }
    
    func openMeterValues(_ meterId: MeterId) {
        router.push(.meterValues(meterId))
    }
    
    func openPropertyObjectSettings(_ propertyObjectId: PropertyObjectId) {
        router.push(.propertyObjectSettings(propertyObjectId))
    }
    
    func openGenerateBill(_ propertyObjectId: PropertyObjectId) {
        router.push(.generateBill(propertyObjectId))
    }
}

// MARK: +EditPropertyInfoFlow
extension iOSAppFlow: EditPropertyInfoFlowDelegate {
    func updatePropertyObject(_ propertyObject: PropertyObject) throws {
        try storage.updateProperty(propertyObject)
        router.hideOverlay()
    }
}

// MARK: +AddMeterFlow
extension iOSAppFlow: ManageMeterFlowDelegate {
    func addNewMeter(_ meter: Meter, propertyObjectId: PropertyObjectId, initialValue: Decimal) throws {
        try storage.newMeter(
            propertyObjectId: propertyObjectId,
            meter: meter,
            initialValue: initialValue)
        router.hideOverlay()
    }
    func updateMeter(_ meter: Meter) throws {
        try storage.updateMeter(meter)
        router.hideOverlay()
    }
    
    func deleteMeter(_ meterId: MeterId) throws {
        try storage.deleteMeter(meterId)
        router.hideOverlay()
    }
}

// MARK: +MeterValuesListFlow
extension iOSAppFlow: MeterValuesListFlowDelegate {
    func loadMeterValues(_ meterId: MeterId) throws -> [MeterValue] {
        try storage.meterValues(meterId)
    }
    
    func openNewMeterValue(_ meterId: MeterId) {
        router.showOverlay(.addMeterValue(meterId))
    }
    
    func openMeterValue(_ meterValue: MeterValue) {
        router.showOverlay(.editMeterValue(meterValue))
    }
}

// MARK: +ManageMeterValueFlow
extension iOSAppFlow: ManageMeterValueFlowDelegate {
    func addNewMeterValue(_ meterId: MeterId, value: MeterValue) throws {
        try storage.insertMeterValue(meterId, value: value)
        router.hideOverlay()
    }
    
    func updateMeterValue(_ value: MeterValue) throws {
        try storage.updateMeterValue(value)
        router.hideOverlay()
    }
    
    func deleteMeterValue(_ meterValueId: MeterValueId) throws {
        try storage.deleteMeterValue(meterValueId)
        router.hideOverlay()
    }
    
}

// MARK: +ManageTariffFlow
extension iOSAppFlow: ManageTariffFlowDelegate {
    func addNewTariff(_ propertyObjectId: PropertyObjectId, tariff: Tariff) throws {
        try storage.newTariff(
            propertyId: propertyObjectId,
            tariff: tariff)
        router.hideOverlay()
    }
    
    func updateTariff(_ tariff: Tariff) throws {
        try storage.updateTariff(tariff: tariff)
        router.hideOverlay()
    }
    
    func deleteTariff(_ tariffId: TariffId) throws {
        try storage.deleteTariff(tariffId: tariffId)
        router.hideOverlay()
    }
}

// MARK: +PropertyObjectSettingFlow
extension iOSAppFlow: PropertyObjectSettingFlowDelegate {
    func loadPropertySettingsData(_ propertyObjectId: PropertyObjectId) throws -> PropertySettingsData {
        let meters = try storage.allMeters(propertyObjectId)
        let tariffs = try storage.allTariffs(propertyObjectId)
        let billingMaps = try storage.allBillingMaps(propertyObjectId)
        return PropertySettingsData(
            meters: meters,
            tariffs: tariffs,
            billingMaps: billingMaps
        )
    }
    
    func openAddMeter(_ propertyObjectId: PropertyObjectId) {
        router.showOverlay(.addMeter(propertyObjectId))
    }
    
    func openEditMeter(_ meter: Meter) {
        router.showOverlay(.editMeter(meter))
    }
    
    func openAddTariff(_ propertyObjectId: PropertyObjectId) {
        router.showOverlay(.addTariff(propertyObjectId))
    }
    
    func openEditTariff(_ tariff: Tariff) {
        router.showOverlay(.editTariff(tariff))
    }
    
    func openAddBillingMap(_ data: BillingMapData) {
        router.showOverlay(.addBillingMap(data))
    }
    
    func openEditBillingMap(_ billingMap: BillingMap, data: BillingMapData) {
        router.showOverlay(.editBillingMap(billingMap, data))
    }
    
    func deletePropertyObject(_ propertyObjectId: PropertyObjectId) throws {
        try storage.deleteProperty(propertyObjectId)
        router.popToRoot()
    }
}

// MARK: +ManageBillingMapFlow
extension iOSAppFlow: ManageBillingMapFlowDelegate {
    func addNewBillingMap(_ propertyObjectId: PropertyObjectId, billingMap: BillingMap) throws {
        try storage.newBillingMap(propertyObjectId, value: billingMap)
        router.hideOverlay()
    }
    
    func updateBillingMap(_ billingMap: BillingMap) throws {
        try storage.updateBillingMap(billingMap)
        router.hideOverlay()
    }
    
    func deleteBillingMap(_ billingMapId: BillingMapId) throws {
        try storage.deleteBillingMap(billingMapId)
        router.hideOverlay()
    }
}
