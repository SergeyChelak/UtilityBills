//
//  PropertySettingsViewModelMock.swift
//  UtilityBills
//
//  Created by Sergey on 02.10.2024.
//

#if DEBUG
import Foundation

private func propertySettingsData() -> PropertySettingsData {
    let tariff = Tariff(
        id: TariffId(),
        name: "Tariff 1",
        price: Decimal(10.11),
        activeMonthMask: 4095
    )
    
    let meter1 = Meter(
        id: MeterId(),
        name: "M1",
        capacity: nil,
        inspectionDate: nil)
        
    let meter2 = Meter(
        id: MeterId(),
        name: "M2",
        capacity: nil,
        inspectionDate: nil
    )
    
    let billingItem = BillingMap(
        id: BillingMapId(),
        name: "Billing map #1",
        order: 1,
        tariff: tariff,
        meters: [meter1, meter2]
    )
    return PropertySettingsData(
        meters: [meter1, meter2],
        tariffs: [tariff, tariff],
        billingMaps: [billingItem, billingItem, billingItem]
    )
}

private class PropertyObjectSettingFlowMock: PropertyObjectSettingFlowDelegate {
    var updatePublisher: UpdatePublisher = UpdatePublisherMock()
    
    func loadPropertySettingsData(_ propertyObjectId: PropertyObjectId) throws -> PropertySettingsData {
        propertySettingsData()
    }
    
    func openAddMeter(_ propertyObjectId: PropertyObjectId) {
        //
    }
    
    func openEditMeter(_ meter: Meter) {
        //
    }
    
    func openAddTariff(_ propertyObjectId: PropertyObjectId) {
        //
    }
    
    func openEditTariff(_ tariff: Tariff) {
        //
    }
    
    func openAddBillingMap(_ data: BillingMapData) {
        //
    }
    
    func openEditBillingMap(_ billingMap: BillingMap, data: BillingMapData) {
        //
    }
    
    func deletePropertyObject(_ propertyObjectId: PropertyObjectId) throws {
        //
    }
}

func __propertySettingsViewModel() -> PropertySettingsViewModel {
    let delegate = PropertyObjectSettingFlowMock()
    let vm = PropertySettingsViewModel(
        objectId: PropertyObjectId(),
        flow: delegate
    )
    return vm
}
#endif
