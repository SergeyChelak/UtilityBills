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
typealias PropertyObjectActionDelete = () throws -> Void
typealias PropertyObjectActionInfoSectionTap = (PropertyObject) -> Void
typealias PropertyObjectActionMeterHeaderSectionTap = (PropertyObjectId) -> Void
typealias PropertyObjectActionMeterSelectionTap = (MeterId) -> Void


class PropertyObjectViewModel: ObservableObject {
    private var cancellables: Set<AnyCancellable> = []
    
    let objectId: PropertyObjectId

    private let actionLoad: PropertyObjectActionLoad
    private let actionInfoSectionTap: PropertyObjectActionInfoSectionTap
    private let actionMeterHeaderSectionTap: PropertyObjectActionMeterHeaderSectionTap
    private let actionMeterSelectionTap: PropertyObjectActionMeterSelectionTap
    private let actionDelete: PropertyObjectActionDelete
    
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
        actionDelete: @escaping PropertyObjectActionDelete,
        updatePublisher: AnyPublisher<(), Never>
    ) {
        self.objectId = objectId
        self.actionLoad = actionLoad
        self.actionInfoSectionTap = actionInfoSectionTap
        self.actionMeterHeaderSectionTap = actionMeterHeaderSectionTap
        self.actionMeterSelectionTap = actionMeterSelectionTap
        self.actionDelete = actionDelete
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
    
    func meterHeaderSectionSelected() {
        actionMeterHeaderSectionTap(objectId)
    }
    
    func meterSelected(_ meterId: MeterId) {
        actionMeterSelectionTap(meterId)
    }
    
    func tariffSectionSelected() {
        print("Not implemented")
    }
    
    func deleteObject() {
        do {
            try actionDelete()
        } catch {
            self.error = error
        }
    }
}

