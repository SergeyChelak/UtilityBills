//
//  iOSAppFlow.swift
//  UtilityBills
//
//  Created by Sergey on 02.10.2024.
//

import Combine
import Foundation

class iOSAppFlow {
    let storage: LocalStorage
    let router: Router
    let updatePublisher: UpdatePublisher
    
    init(
        router: Router,
        storage: LocalStorage
    ) {
        self.router = router
        self.storage = storage
        self.updatePublisher = StorageWatcher(storage: storage)
    }
}

// MARK: PropertyObjectListFlow
extension iOSAppFlow: PropertyObjectListFlow {
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

// MARK: PropertyObjectFlow
extension iOSAppFlow: PropertyObjectFlow {
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

// MARK: EditPropertyInfoFlow
extension iOSAppFlow: EditPropertyInfoFlow {
    func updatePropertyObject(_ propertyObject: PropertyObject) throws {
        try storage.updateProperty(propertyObject)
        router.hideOverlay()
    }
}

// MARK: AddMeterFlow
extension iOSAppFlow: AddMeterFlow {
    func addNewMeter(_ meter: Meter, propertyObjectId: PropertyObjectId, initialValue: Double) throws {
        try storage.newMeter(
            propertyObjectId: propertyObjectId,
            meter: meter,
            initialValue: initialValue)
        router.hideOverlay()
    }
}

// MARK: MeterValuesListFlow
extension iOSAppFlow: MeterValuesListFlow {
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
