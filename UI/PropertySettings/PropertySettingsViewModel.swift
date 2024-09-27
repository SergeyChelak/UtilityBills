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
typealias PropertySettingsActionDelete = () throws -> Void

class PropertySettingsViewModel: ObservableObject {
    private var cancellables: Set<AnyCancellable> = []
    
    let objectId: PropertyObjectId
    private let actionLoad: PropertySettingsActionLoad
    private let actionMeterHeaderSectionTap: PropertySettingsActionMeterHeaderSectionTap
    private let actionMeterSelectionTap: PropertySettingsActionMeterSelectionTap
    private let actionAddTariff: PropertySettingsActionAddTariff
    private let actionDelete: PropertySettingsActionDelete
    
    @Published
    var data: PropertySettingsData = .default()
    @Published
    var error: Error?
    
    init(
        objectId: PropertyObjectId,
        actionLoad: @escaping PropertySettingsActionLoad,
        actionMeterHeaderSectionTap: @escaping PropertySettingsActionMeterHeaderSectionTap,
        actionMeterSelectionTap: @escaping PropertySettingsActionMeterSelectionTap,
        actionAddTariff: @escaping PropertySettingsActionAddTariff,
        actionDelete: @escaping PropertySettingsActionDelete,
        updatePublisher: AnyPublisher<(), Never>
    ) {
        self.objectId = objectId
        self.actionLoad = actionLoad
        self.actionMeterHeaderSectionTap = actionMeterHeaderSectionTap
        self.actionMeterSelectionTap = actionMeterSelectionTap
        self.actionAddTariff = actionAddTariff
        self.actionDelete = actionDelete
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
            self.error = error
        }
    }
    
    func addMeter() {
        actionMeterHeaderSectionTap(objectId)
    }
    
    func meterSelected(_ meter: Meter) {
        actionMeterSelectionTap(meter)
    }
    
    func tariffSelected(_ tariff: Tariff) {
        print("Not implemented")
    }
    
    func addTariff() {
        actionAddTariff(objectId)
    }
    
    func deleteObject() {
        do {
            try actionDelete()
        } catch {
            self.error = error
        }
    }
}
