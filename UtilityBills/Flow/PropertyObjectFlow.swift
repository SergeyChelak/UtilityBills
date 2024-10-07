//
//  PropertyObjectFlow.swift
//  UtilityBills
//
//  Created by Sergey on 05.10.2024.
//

import Foundation

class PropertyObjectFlow {
    private let viewFactory: ViewFactory
    private let storage: LocalStorage
    private let navigation: StackNavigation
    private let propertyObjectId: PropertyObjectId
    let updatePublisher: UpdatePublisher
    
    private var calculateFlow: CalculateFlow?
    
    init(
        viewFactory: ViewFactory,
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

// MARK: PropertyObjectFlowDelegate
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
        
    func openMeterValues(_ meterId: MeterId) {
        let view = viewFactory.meterValuesView(meterId, flowDelegate: self)
        navigation.push(view)
    }
    
    func openPropertyObjectSettings(_ propertyObjectId: PropertyObjectId) {
        let view = viewFactory.propertyObjectSettingsView(propertyObjectId, flowDelegate: self)
        navigation.push(view)
    }
    
    func openGenerateBill(_ propertyObjectId: PropertyObjectId) {
        let flow = CalculateFlow(
            viewFactory: viewFactory,
            storage: storage,
            navigation: navigation,
            propertyObjectId: propertyObjectId)
        self.calculateFlow = flow
        flow.start()
    }
    
    func openBillList(_ propertyObjectId: PropertyObjectId) {
        let view = viewFactory.billsListView(propertyObjectId, flowDelegate: self)
        navigation.push(view)
    }
}

// MARK: UpdatePropertyObjectFlowDelegate
extension PropertyObjectFlow: UpdatePropertyObjectFlowDelegate {
    func updatePropertyObject(_ propertyObject: PropertyObject) throws {
        try storage.updateProperty(propertyObject)
        navigation.hideSheet()
    }
}

// MARK: MeterValuesListFlowDelegate
extension PropertyObjectFlow: MeterValuesListFlowDelegate {
    func loadMeterValues(_ meterId: MeterId) throws -> [MeterValue] {
        try storage.meterValues(meterId)
    }
    
    func openNewMeterValue(_ meterId: MeterId) {
        let view = viewFactory.addMeterValueView(meterId, flowDelegate: self)
        navigation.showSheet(view)
    }
    
    func openMeterValue(_ meterValue: MeterValue) {
        let view = viewFactory.editMeterValueView(meterValue, flowDelegate: self)
        navigation.showSheet(view)
    }
}

// MARK: ManageMeterValueFlowDelegate
extension PropertyObjectFlow: ManageMeterValueFlowDelegate {
    func addNewMeterValue(_ meterId: MeterId, value: MeterValue) throws {
        try storage.insertMeterValue(meterId, value: value)
        navigation.hideSheet()
    }
    
    func updateMeterValue(_ value: MeterValue) throws {
        try storage.updateMeterValue(value)
        navigation.hideSheet()
    }
    
    func deleteMeterValue(_ meterValueId: MeterValueId) throws {
        try storage.deleteMeterValue(meterValueId)
        navigation.hideSheet()
    }
}

// MARK: PropertyObjectSettingFlowDelegate
extension PropertyObjectFlow: PropertyObjectSettingFlowDelegate {
    func loadPropertySettingsData(_ propertyObjectId: PropertyObjectId) throws -> PropertySettingsData {
        let propObj = try storage.fetchProperty(propertyObjectId)
        let meters = try storage.allMeters(propertyObjectId)
        let tariffs = try storage.allTariffs(propertyObjectId)
        let billingMaps = try storage.allBillingMaps(propertyObjectId)
        return PropertySettingsData(
            propObj: propObj,
            meters: meters,
            tariffs: tariffs,
            billingMaps: billingMaps
        )
    }
    
    func openEditPropertyObject(_ propertyObject: PropertyObject) {
        let view = viewFactory.updatePropertyObjectView(propertyObject, flowDelegate: self)
        navigation.showSheet(view)
    }
    
    func openAddMeter(_ propertyObjectId: PropertyObjectId) {
        let view = viewFactory.addMeterView(propertyObjectId, flowDelegate: self)
        navigation.showSheet(view)
    }
    
    func openEditMeter(_ meter: Meter) {
        let view = viewFactory.editMeterView(meter, flowDelegate: self)
        navigation.showSheet(view)
    }
    
    func openAddTariff(_ propertyObjectId: PropertyObjectId) {
        let view = viewFactory.addTariffView(propertyObjectId, flowDelegate: self)
        navigation.showSheet(view)
    }
    
    func openEditTariff(_ tariff: Tariff) {
        let view = viewFactory.editTariffView(tariff, flowDelegate: self)
        navigation.showSheet(view)
    }
    
    func openAddBillingMap(_ data: BillingMapData) {
        let view = viewFactory.addBillingMapView(data, flowDelegate: self)
        navigation.showSheet(view)
    }
    
    func openEditBillingMap(_ billingMap: BillingMap, data: BillingMapData) {
        let view = viewFactory.editBillingMapView(billingMap, billingMapData: data, flowDelegate: self)
        navigation.showSheet(view)
    }
    
    func deletePropertyObject(_ propertyObjectId: PropertyObjectId) throws {
        try storage.deleteProperty(propertyObjectId)
        navigation.popToRoot()
    }
}


// MARK: ManageMeterFlowDelegate
extension PropertyObjectFlow: ManageMeterFlowDelegate {
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

// MARK: ManageTariffFlowDelegate
extension PropertyObjectFlow: ManageTariffFlowDelegate {
    func addNewTariff(_ propertyObjectId: PropertyObjectId, tariff: Tariff) throws {
        try storage.newTariff(
            propertyId: propertyObjectId,
            tariff: tariff)
        navigation.hideSheet()
    }
    
    func updateTariff(_ tariff: Tariff) throws {
        try storage.updateTariff(tariff: tariff)
        navigation.hideSheet()
    }
    
    func deleteTariff(_ tariffId: TariffId) throws {
        try storage.deleteTariff(tariffId: tariffId)
        navigation.hideSheet()
    }
}

// MARK: ManageBillingMapFlowDelegate
extension PropertyObjectFlow: ManageBillingMapFlowDelegate {
    func addNewBillingMap(_ propertyObjectId: PropertyObjectId, billingMap: BillingMap) throws {
        try storage.newBillingMap(propertyObjectId, value: billingMap)
        navigation.hideSheet()
    }
    
    func updateBillingMap(_ billingMap: BillingMap) throws {
        try storage.updateBillingMap(billingMap)
        navigation.hideSheet()
    }
    
    func deleteBillingMap(_ billingMapId: BillingMapId) throws {
        try storage.deleteBillingMap(billingMapId)
        navigation.hideSheet()
    }
}

// MARK: BillListFlowDelegate
extension PropertyObjectFlow: BillListFlowDelegate {
    func loadBillsList() throws -> [Bill] {
        try storage.bills(propertyObjectId, limit: nil)
    }
    
    func openBillDetails(_ bill: Bill) {
        let view = viewFactory.billDetailsView(bill)
        navigation.showSheet(view)
    }
}
