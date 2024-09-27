//
//  PropertyObjectViewModel.swift
//  UtilityBills
//
//  Created by Sergey on 22.09.2024.
//

import Combine

struct PropertyObjectData {
    let propObj: PropertyObject?
    let meters: [Meter]
    let tariffs: [Tariff]
}

typealias PropertyObjectActionLoad = () throws -> PropertyObjectData
typealias PropertyObjectActionInfoSectionTap = (PropertyObject) -> Void
typealias PropertyObjectActionMeterHeaderSectionTap = (PropertyObjectId) -> Void
typealias PropertyObjectActionMeterSelectionTap = (MeterId) -> Void
typealias PropertyObjectActionAddTariff = (PropertyObjectId) -> Void
typealias PropertyObjectActionSettings = () -> Void


class PropertyObjectViewModel: ObservableObject {
    private var cancellables: Set<AnyCancellable> = []
    
    let objectId: PropertyObjectId

    private let actionLoad: PropertyObjectActionLoad
    private let actionInfoSectionTap: PropertyObjectActionInfoSectionTap
    private let actionMeterHeaderSectionTap: PropertyObjectActionMeterHeaderSectionTap
    private let actionMeterSelectionTap: PropertyObjectActionMeterSelectionTap
    private let actionAddTariff: PropertyObjectActionAddTariff    
    private let actionSettings: PropertyObjectActionSettings
    
    @Published 
    var data: PropertyObjectData?
    @Published
    var error: Error?
    
    var propObj: PropertyObject? {
        data?.propObj
    }
    
    var meters: [Meter] {
        data?.meters ?? []
    }
    
    var tariffs: [Tariff] { 
        data?.tariffs ?? []
    }
    
    init(
        _ objectId: PropertyObjectId,
        actionLoad: @escaping PropertyObjectActionLoad,
        actionInfoSectionTap: @escaping PropertyObjectActionInfoSectionTap,
        actionMeterHeaderSectionTap: @escaping PropertyObjectActionMeterHeaderSectionTap,
        actionMeterSelectionTap: @escaping PropertyObjectActionMeterSelectionTap,
        actionAddTariff: @escaping PropertyObjectActionAddTariff,    
        actionSettings: @escaping PropertyObjectActionSettings,
        updatePublisher: AnyPublisher<(), Never>
    ) {
        self.objectId = objectId
        self.actionLoad = actionLoad
        self.actionInfoSectionTap = actionInfoSectionTap
        self.actionMeterHeaderSectionTap = actionMeterHeaderSectionTap
        self.actionMeterSelectionTap = actionMeterSelectionTap
        self.actionAddTariff = actionAddTariff        
        self.actionSettings = actionSettings
        updatePublisher
            .sink(receiveValue: load)
            .store(in: &cancellables)
    }
    
    func load() {
        do {
            data = try actionLoad()
        } catch {
            self.error = error
        }
    }
    
    func infoSectionSelected() {
        guard let propObj = data?.propObj else {
            fatalError("Unexpected case")
        }
        actionInfoSectionTap(propObj)
    }
    
    func addMeter() {
        actionMeterHeaderSectionTap(objectId)
    }
    
    func meterSelected(_ meter: Meter) {
        actionMeterSelectionTap(meter.id)
    }
    
    func tariffSelected(_ tariff: Tariff) {
        print("Not implemented")
    }
    
    func addTariff() {
        actionAddTariff(objectId)
    }
    
    func openSettings() {
        actionSettings()
    }
}

