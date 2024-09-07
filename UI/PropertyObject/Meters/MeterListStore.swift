//
//  MeterListStore.swift
//  UtilityBills
//
//  Created by Sergey on 07.09.2024.
//

import Foundation

class MeterListStore: ObservableObject {
    let propertyId: PropertyObjectId
    let dataSource: MeterListDataSource
    
    @Published var meters: [Meter] = []
    @Published var isEdit = false
    
    init(propertyId: PropertyObjectId, dataSource: MeterListDataSource) {
        self.propertyId = propertyId
        self.dataSource = dataSource
    }
    
    func load() {
        do {
            meters = try dataSource.allMeters(for: propertyId)
        } catch {
            fatalError(error.localizedDescription)
        }
    }
}
