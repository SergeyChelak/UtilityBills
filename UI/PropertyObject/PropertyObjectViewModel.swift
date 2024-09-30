//
//  PropertyObjectViewModel.swift
//  UtilityBills
//
//  Created by Sergey on 22.09.2024.
//

import Combine
import Foundation

struct PropertyObjectData {
    let propObj: PropertyObject?
    let meters: [Meter]
}

typealias PropertyObjectActionLoad = () throws -> PropertyObjectData
typealias PropertyObjectActionInfoSectionTap = (PropertyObject) -> Void
typealias PropertyObjectActionMeterSelectionTap = (MeterId) -> Void
typealias PropertyObjectActionSettings = () -> Void


class PropertyObjectViewModel: ViewModel {
    private var cancellables: Set<AnyCancellable> = []
    
    let objectId: PropertyObjectId

    private let actionLoad: PropertyObjectActionLoad
    private let actionInfoSectionTap: PropertyObjectActionInfoSectionTap
    private let actionMeterSelectionTap: PropertyObjectActionMeterSelectionTap
    private let actionSettings: PropertyObjectActionSettings
    
    @Published 
    var data: PropertyObjectData?

    var propObj: PropertyObject? {
        data?.propObj
    }
    
    var meters: [Meter] {
        data?.meters ?? []
    }
    
    init(
        _ objectId: PropertyObjectId,
        actionLoad: @escaping PropertyObjectActionLoad,
        actionInfoSectionTap: @escaping PropertyObjectActionInfoSectionTap,
        actionMeterSelectionTap: @escaping PropertyObjectActionMeterSelectionTap,
        actionSettings: @escaping PropertyObjectActionSettings,
        updatePublisher: AnyPublisher<(), Never>
    ) {
        self.objectId = objectId
        self.actionLoad = actionLoad
        self.actionInfoSectionTap = actionInfoSectionTap
        self.actionMeterSelectionTap = actionMeterSelectionTap
        self.actionSettings = actionSettings
        super.init()
        updatePublisher
            .sink(receiveValue: load)
            .store(in: &cancellables)
    }
    
    func load() {
        do {
            data = try actionLoad()
        } catch {
            setError(error)
        }
    }
    
    func infoSectionSelected() {
        guard let propObj = data?.propObj else {
            self.error = NSError(domain: "UB.ObjLoad", code: 1)
            return
        }
        actionInfoSectionTap(propObj)
    }
    
    func meterSelected(_ meter: Meter) {
        actionMeterSelectionTap(meter.id)
    }
        
    func openSettings() {
        actionSettings()
    }
}

