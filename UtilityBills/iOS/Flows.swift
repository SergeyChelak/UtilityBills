//
//  Flows.swift
//  UtilityBills
//
//  Created by Sergey on 02.10.2024.
//

import Foundation

protocol PropertyObjectListFlowDelegate {
    func loadPropertyObjects() throws -> [PropertyObject]
    func openPropertyObject(_ propertyObjectId: PropertyObjectId)
    func createPropertyObject() throws
}

protocol PropertyObjectFlowDelegate {
    var updatePublisher: UpdatePublisher { get }
    func loadPropertyObjectData(_ propertyObjectId: PropertyObjectId) throws -> PropertyObjectData
    func openEditPropertyObject(_ propertyObject: PropertyObject)
    func openMeterValues(_ meterId: MeterId)
    func openPropertyObjectSettings(_ propertyObjectId: PropertyObjectId)
    func openGenerateBill(_ propertyObjectId: PropertyObjectId)
}

protocol EditPropertyInfoFlowDelegate {
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

protocol CalculateFlow {
    func calculate() throws -> [BillRecord]
    func openBillRecord(_ billRecord: BillRecord)
}

protocol ManageBillRecordFlow {
    func updateBillRecord(_ billRecord: BillRecord)
    func deleteBillRecord(_ billRecordId: BillRecordId)
}
