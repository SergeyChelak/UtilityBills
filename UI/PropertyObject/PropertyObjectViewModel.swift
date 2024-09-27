//
//  PropertyObjectViewModel.swift
//  UtilityBills
//
//  Created by Sergey on 22.09.2024.
//

import Combine

struct PropertyObjectData {
    let propObj: PropertyObject?
//    let meters: [Meter]
//    let tariffs: [Tariff]
}

typealias PropertyObjectActionLoad = () throws -> PropertyObjectData
typealias PropertyObjectActionInfoSectionTap = (PropertyObject) -> Void
typealias PropertyObjectActionSettings = () -> Void


class PropertyObjectViewModel: ObservableObject {
    private var cancellables: Set<AnyCancellable> = []
    
    let objectId: PropertyObjectId

    private let actionLoad: PropertyObjectActionLoad
    private let actionInfoSectionTap: PropertyObjectActionInfoSectionTap
    private let actionSettings: PropertyObjectActionSettings
    
    @Published 
    var data: PropertyObjectData?
    @Published
    var error: Error?
    
    var propObj: PropertyObject? {
        data?.propObj
    }
    
    init(
        _ objectId: PropertyObjectId,
        actionLoad: @escaping PropertyObjectActionLoad,
        actionInfoSectionTap: @escaping PropertyObjectActionInfoSectionTap,
        actionSettings: @escaping PropertyObjectActionSettings,
        updatePublisher: AnyPublisher<(), Never>
    ) {
        self.objectId = objectId
        self.actionLoad = actionLoad
        self.actionInfoSectionTap = actionInfoSectionTap
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
        
    func openSettings() {
        actionSettings()
    }
}

