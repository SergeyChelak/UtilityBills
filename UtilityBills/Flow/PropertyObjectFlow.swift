//
//  PropertyObjectFlow.swift
//  UtilityBills
//
//  Created by Sergey on 05.10.2024.
//

import Foundation

class PropertyObjectFlow {
    private let viewFactory: AppViewFactory
    private let storage: LocalStorage
    private let navigation: StackNavigation
    private let propertyObjectId: PropertyObjectId
    let updatePublisher: UpdatePublisher
    
    init(
        viewFactory: AppViewFactory,
        storage: LocalStorage,
        updatePublisher: UpdatePublisher,
        navigation: StackNavigation,
        propertyObjectId: PropertyObjectId
    ) {
        self.viewFactory = viewFactory
        self.storage = storage
        self.updatePublisher = updatePublisher
        self.navigation = navigation
        self.propertyObjectId = propertyObjectId
    }
    
    func start() {
        let view = viewFactory.propertyHomeView(propertyObjectId, flowDelegate: self)
        navigation.push(view)
    }
}

extension PropertyObjectFlow: PropertyObjectFlowDelegate {
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
        let view = viewFactory.editPropertyInfoView(propertyObject, flowDelegate: self)
        navigation.showSheet(view)
    }
    
    func openMeterValues(_ meterId: MeterId) {
        let view = viewFactory.meterValuesView(meterId, flowDelegate: self)
        navigation.push(view)
    }
    
    func openPropertyObjectSettings(_ propertyObjectId: PropertyObjectId) {
        fatalError()
//        router.push(.propertyObjectSettings(propertyObjectId))
    }
    
    func openGenerateBill(_ propertyObjectId: PropertyObjectId) {
        fatalError()
//        router.push(.generateBill(propertyObjectId))
    }
}

// MARK: EditPropertyInfoFlowDelegate
extension PropertyObjectFlow: EditPropertyInfoFlowDelegate {
    func updatePropertyObject(_ propertyObject: PropertyObject) throws {
        try storage.updateProperty(propertyObject)
        navigation.hideSheet()
    }
}

// MARK: MeterValuesListFlow
extension PropertyObjectFlow: MeterValuesListFlowDelegate {
    func loadMeterValues(_ meterId: MeterId) throws -> [MeterValue] {
        try storage.meterValues(meterId)
    }
    
    func openNewMeterValue(_ meterId: MeterId) {
        fatalError()
//        router.showOverlay(.addMeterValue(meterId))
    }
    
    func openMeterValue(_ meterValue: MeterValue) {
        fatalError()
//        router.showOverlay(.editMeterValue(meterValue))
    }
}

// MARK: ManageMeterFlow
extension PropertyObjectFlow: ManageMeterFlow {
    func addNewMeter(_ meter: Meter, propertyObjectId: PropertyObjectId, initialValue: Decimal) throws {
        try storage.newMeter(
            propertyObjectId: propertyObjectId,
            meter: meter,
            initialValue: initialValue)
        navigation.hideSheet()
    }
    func updateMeter(_ meter: Meter) throws {
        try storage.updateMeter(meter)
        navigation.hideSheet()
    }
    
    func deleteMeter(_ meterId: MeterId) throws {
        try storage.deleteMeter(meterId)
        navigation.hideSheet()
    }
}
