//
//  FlowDelegates.swift
//  UtilityBills
//
//  Created by Sergey on 02.10.2024.
//

import Foundation

protocol PropertyObjectListFlowDelegate {
    var updatePublisher: UpdatePublisher { get }
    func loadDashboardData() throws -> DashboardData
    func openPropertyObject(_ propertyObjectId: PropertyObjectId)
    func openCreateNewPropertyObject()
    func openIssuesList(_ issues: [Issue])
}

protocol IssuesFlowDelegate {
    var updatePublisher: UpdatePublisher { get }
    func fetchIssues() throws -> [Issue]
    func openIssue(_ issue: Issue)
}

protocol PropertyObjectFlowDelegate {
    var updatePublisher: UpdatePublisher { get }
    func loadPropertyObjectData(_ propertyObjectId: PropertyObjectId) throws -> PropertyObjectData    
    func openMeterValues(_ meterId: MeterId)
    func openPropertyObjectSettings(_ propertyObjectId: PropertyObjectId)
    func openGenerateBill(_ propertyObjectId: PropertyObjectId)
    func openBillList(_ propertyObjectId: PropertyObjectId)
    func openBillDetails(_ bill: Bill)
}

protocol CreatePropertyObjectFlowDelegate {
    func createPropertyObject(_ propertyObject: PropertyObject) throws
}

protocol UpdatePropertyObjectFlowDelegate {    
    func updatePropertyObject(_ propertyObject: PropertyObject) throws
}

protocol ManageMeterFlowDelegate {
    func addNewMeter(_ meter: Meter, propertyObjectId: PropertyObjectId, initialValue: Decimal) throws
    func updateMeter(_ meter: Meter) throws
    func deleteMeter(_ meterId: MeterId) throws
}

protocol MeterValuesListFlowDelegate {
    var updatePublisher: UpdatePublisher { get }
    func loadMeterValues(_ meterId: MeterId) throws -> [MeterValue]
    func openNewMeterValue(_ meterId: MeterId)
    func openMeterValue(_ meterValue: MeterValue)
}

protocol ManageMeterValueFlowDelegate {
    func addNewMeterValue(_ meterId: MeterId, value: MeterValue) throws
    func updateMeterValue(_ value: MeterValue) throws
    func deleteMeterValue(_ meterValueId: MeterValueId) throws
}

protocol ManageTariffFlowDelegate {
    func addNewTariff(_ propertyObjectId: PropertyObjectId, tariff: Tariff) throws
    func updateTariff(_ tariff: Tariff) throws
    func deleteTariff(_ tariffId: TariffId) throws
}

protocol PropertyObjectSettingFlowDelegate {
    var updatePublisher: UpdatePublisher { get }
    func loadPropertySettingsData(_ propertyObjectId: PropertyObjectId) throws -> PropertySettingsData
    func openEditPropertyObject(_ propertyObject: PropertyObject)
    func openAddMeter(_ propertyObjectId: PropertyObjectId)
    func openEditMeter(_ meter: Meter)
    func openAddTariff(_ propertyObjectId: PropertyObjectId)
    func openEditTariff(_ tariff: Tariff)
    func openAddBillingMap(_ data: BillingMapData)
    func openEditBillingMap(_ billingMap: BillingMap, data: BillingMapData)
    func deletePropertyObject(_ propertyObjectId: PropertyObjectId) throws
}

protocol ManageBillingMapFlowDelegate {
    func addNewBillingMap(_ propertyObjectId: PropertyObjectId, billingMap: BillingMap) throws
    func updateBillingMap(_ billingMap: BillingMap) throws
    func deleteBillingMap(_ billingMapId: BillingMapId) throws
}

protocol CalculateFlowDelegate {
    var updatePublisher: UpdatePublisher { get }
    func load() throws -> [BillRecord]
    func openBillRecord(_ billRecord: BillRecord)
    func acceptBillRecords() throws
}

protocol ManageBillRecordFlowDelegate {
    func updateBillRecord(_ billRecord: BillRecord)
    func deleteBillRecord(_ billRecordId: BillRecordId)
}

protocol BillListFlowDelegate {
    func loadBillsList() throws -> [Bill]
    func openBillDetails(_ bill: Bill)
}
