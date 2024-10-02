//
//  Flows.swift
//  UtilityBills
//
//  Created by Sergey on 02.10.2024.
//

import Foundation

protocol PropertyObjectListFlow: AnyObject {
    func loadPropertyObjects() throws -> [PropertyObject]
    func openPropertyObject(_ propertyObjectId: PropertyObjectId)
    func createPropertyObject() throws
}

protocol PropertyObjectFlow: AnyObject {
    var updatePublisher: UpdatePublisher { get }
    func loadPropertyObjectData(_ propertyObjectId: PropertyObjectId) throws -> PropertyObjectData
    func openEditPropertyObject(_ propertyObject: PropertyObject)
    func openMeterValues(_ meterId: MeterId)
    func openPropertyObjectSettings(_ propertyObjectId: PropertyObjectId)
    func openGenerateBill(_ propertyObjectId: PropertyObjectId)
}

protocol EditPropertyInfoFlow: AnyObject {
    func updatePropertyObject(_ propertyObject: PropertyObject) throws
}

protocol ManageMeterFlow: AnyObject {
    func addNewMeter(_ meter: Meter, propertyObjectId: PropertyObjectId, initialValue: Double) throws
    func updateMeter(_ meter: Meter) throws
    func deleteMeter(_ meterId: MeterId) throws
}

protocol MeterValuesListFlow: AnyObject {
    var updatePublisher: UpdatePublisher { get }
    func loadMeterValues(_ meterId: MeterId) throws -> [MeterValue]
    func openNewMeterValue(_ meterId: MeterId)
    func openMeterValue(_ meterValue: MeterValue)
}

protocol ManageMeterValueFlow: AnyObject {
    func addNewMeterValue(_ meterId: MeterId, value: MeterValue) throws
    func updateMeterValue(_ value: MeterValue) throws
    func deleteMeterValue(_ meterValueId: MeterValueId) throws
}

protocol ManageTariffFlow: AnyObject {
    func addNewTariff(_ propertyObjectId: PropertyObjectId, tariff: Tariff) throws
    func updateTariff(_ tariff: Tariff) throws
    func deleteTariff(_ tariffId: TariffId) throws
}

protocol PropertyObjectSettingFlow: AnyObject {
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
