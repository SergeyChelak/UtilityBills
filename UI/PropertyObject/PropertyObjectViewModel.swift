//
//  PropertyObjectViewModel.swift
//  UtilityBills
//
//  Created by Sergey on 22.09.2024.
//

import Combine

typealias PropertyObjectDataSource = PropertyObjectDAO & MetersDAO & TariffDAO

class PropertyObjectViewModel: ObservableObject {
    private var cancellables: Set<AnyCancellable> = []
    private let dataSource: PropertyObjectDataSource
    let objectId: PropertyObjectId
    
    private let infoSectionCallback: (PropertyObject) -> Void
    private let meterHeaderSectionCallback: (PropertyObjectId) -> Void
    private let meterSelectionCallback: (MeterId) -> Void

    
    @Published var propObj: PropertyObject?
    @Published var meters: [Meter] = []
    @Published var tariffs: [Tariff] = []
    
    init(
        _ objectId: PropertyObjectId,
        dataSource: PropertyObjectDataSource,
        updatePublisher: AnyPublisher<(), Never>,
        infoSectionCallback: @escaping (PropertyObject) -> Void = { _ in },
        meterHeaderSectionCallback: @escaping (PropertyObjectId) -> Void = { _ in },
        meterSelectionCallback: @escaping (MeterId) -> Void = { _ in }
    ) {
        self.objectId = objectId
        self.dataSource = dataSource
        self.infoSectionCallback = infoSectionCallback
        self.meterHeaderSectionCallback = meterHeaderSectionCallback
        self.meterSelectionCallback = meterSelectionCallback
        updatePublisher
            .sink(receiveValue: load)
            .store(in: &cancellables)
    }
    
    func load() {
        do {
            propObj = try dataSource.fetchProperty(objectId)
            meters = try dataSource.allMeters(for: objectId)
            tariffs = try dataSource.allTariffs(for: objectId)
        } catch {
            fatalError(error.localizedDescription)
        }
    }
    
    func infoSectionSelected() {
        guard let propObj else {
            fatalError("Unexpected case")
        }
        infoSectionCallback(propObj)
    }
    
    func meterHeaderSectionSelected() {
        meterHeaderSectionCallback(objectId)
    }
    
    func meterSelected(_ meterId: MeterId) {
        meterSelectionCallback(meterId)
    }
    
    func tariffSectionSelected() {
        print("Not implemented")
    }
}

