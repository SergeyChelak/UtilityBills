//
//  PropertySettingsViewModel.swift
//  UtilityBillsTests
//
//  Created by Sergey on 27.09.2024.
//

import Combine
import Foundation

struct PropertySettingsData {
    let meters: [Meter]
    let tariffs: [Tariff]
    let billingMaps: [BillingMap]
    
    static func `default`() -> Self {
        PropertySettingsData(meters: [], tariffs: [], billingMaps: [])
    }
}

typealias PropertySettingsActionLoad = () throws -> PropertySettingsData
typealias PropertySettingsActionMeterHeaderSectionTap = (PropertyObjectId) -> Void
typealias PropertySettingsActionMeterSelectionTap = (Meter) -> Void
typealias PropertySettingsActionAddTariff = (PropertyObjectId) -> Void
typealias PropertySettingsActionEditTariff = (Tariff) -> Void
typealias PropertySettingsActionAddBillingMap = (BillingMapData) throws -> Void
typealias PropertySettingsActionEditBillingMap = (BillingMap, BillingMapData) -> Void
typealias PropertySettingsActionDelete = () throws -> Void

class PropertySettingsViewModel: ViewModel {
    private var cancellables: Set<AnyCancellable> = []
    
    let objectId: PropertyObjectId
    private let actionLoad: PropertySettingsActionLoad
    private let actionMeterHeaderSectionTap: PropertySettingsActionMeterHeaderSectionTap
    private let actionMeterSelectionTap: PropertySettingsActionMeterSelectionTap
    private let actionAddTariff: PropertySettingsActionAddTariff
    private let actionEditTariff: PropertySettingsActionEditTariff
    private let actionAddBillingMap: PropertySettingsActionAddBillingMap
    private let actionEditBillingMap: PropertySettingsActionEditBillingMap
    private let actionDelete: PropertySettingsActionDelete
    
    @Published
    var data: PropertySettingsData = .default()
    
    init(
        objectId: PropertyObjectId,
        actionLoad: @escaping PropertySettingsActionLoad,
        actionMeterHeaderSectionTap: @escaping PropertySettingsActionMeterHeaderSectionTap,
        actionMeterSelectionTap: @escaping PropertySettingsActionMeterSelectionTap,
        actionAddTariff: @escaping PropertySettingsActionAddTariff,
        actionEditTariff: @escaping PropertySettingsActionEditTariff,
        actionAddBillingMap: @escaping PropertySettingsActionAddBillingMap,
        actionEditBillingMap: @escaping PropertySettingsActionEditBillingMap,
        actionDelete: @escaping PropertySettingsActionDelete,
        updatePublisher: AnyPublisher<(), Never>
    ) {
        self.objectId = objectId
        self.actionLoad = actionLoad
        self.actionMeterHeaderSectionTap = actionMeterHeaderSectionTap
        self.actionMeterSelectionTap = actionMeterSelectionTap
        self.actionAddTariff = actionAddTariff
        self.actionEditTariff = actionEditTariff
        self.actionAddBillingMap = actionAddBillingMap
        self.actionEditBillingMap = actionEditBillingMap
        self.actionDelete = actionDelete
        super.init()
        updatePublisher
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
        do {
            data = try actionLoad()
        } catch {
            setError(error)
        }
    }
    
    func addMeter() {
        actionMeterHeaderSectionTap(objectId)
    }
    
    func meterSelected(_ meter: Meter) {
        actionMeterSelectionTap(meter)
    }
    
    func tariffSelected(_ tariff: Tariff) {
        actionEditTariff(tariff)
    }
    
    func addTariff() {
        actionAddTariff(objectId)
    }
    
    func addBillingMap() {
        do {
            try actionAddBillingMap(billingMapData)
        } catch {
            setError(error)
        }
    }
    
    func editBillingMap(_ billingMap: BillingMap) {
        actionEditBillingMap(billingMap, billingMapData)
    }
    
    func deleteObject() {
        do {
            try actionDelete()
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
