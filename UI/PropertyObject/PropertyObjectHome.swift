//
//  PropertyObjectHome.swift
//  UtilityBills
//
//  Created by Sergey on 08.09.2024.
//

import SwiftUI

class PropertyObjectStore: ObservableObject {
    let dataSource: PropertyObjectDataSource & MeterListDataSource
    let objectId: PropertyObjectId
    
    @Published var propObj: PropertyObject?
    @Published var meters: [Meter] = []
    
    init(_ objectId: PropertyObjectId, dataSource: PropertyObjectDataSource & MeterListDataSource) {
        self.objectId = objectId
        self.dataSource = dataSource
    }
    
    func load() {
        do {
            propObj = try dataSource.fetchProperty(objectId)
            meters = try dataSource.allMeters(for: objectId)
        } catch {
            fatalError(error.localizedDescription)
        }
    }
}

struct PropertyObjectHome: View {
    @ObservedObject var store: PropertyObjectStore
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(spacing: 24) {
                // Manage estate data
                if let obj = store.propObj {
                    PropertyInfoView(propertyObject: obj)
                        .sectionWith(title: "Info")
                }
        
                // Manage meters/meter data
                if !store.meters.isEmpty {
                    MetersInfoView(meters: store.meters)
                        .sectionWith(title: "Meters")
                }
                Spacer()
            }
        }
        .navigationTitle(store.propObj?.name ?? "")
        .task {
            store.load()
        }
        
        
        // Display historical data
        
        // Manage tariffs
        
        // Manage payment's settings
    }
}

#Preview {
    let ds = LocalStorage.previewInstance()
    let store = PropertyObjectStore(
        UUID(),
        dataSource: ds)
    return PropertyObjectHome(store: store)
}
