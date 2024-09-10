//
//  PropertyObjectHome.swift
//  UtilityBills
//
//  Created by Sergey on 08.09.2024.
//

import Combine
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
    @StateObject var store: PropertyObjectStore
    let updatePublisher: AnyPublisher<(), Never>
    let infoSectionCallback: (PropertyObject) -> Void
    let meterHeaderSectionCallback: (PropertyObjectId) -> Void
    let meterSelectionCallback: (MeterId) -> Void
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(spacing: 24) {
                // Manage estate data
                if let obj = store.propObj {
                    PropertyInfoView(propertyObject: obj)
                        .sectionWith(
                            title: "Info",
                            action: HeaderAction(
                                title: "Edit",
                                imageDescriptor: .system("pencil"),
                                callback: { infoSectionCallback(obj) })
                        )
                }        
                // Manage meters/meter data
                MetersInfoView(
                    meters: store.meters,
                    meterSelectionCallback: meterSelectionCallback
                )
                .sectionWith(
                    title: "Meters",
                    action: HeaderAction(
                        title: "Add",
                        imageDescriptor: .system("plus.circle"),
                        callback: { meterHeaderSectionCallback(store.objectId) }
                    )
                )
                Spacer()
            }
        }
        .navigationTitle(store.propObj?.name ?? "")
        .task {
            store.load()
        }
        .onReceive(updatePublisher) {
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
    return PropertyObjectHome(
        store: store,
        updatePublisher: Empty().eraseToAnyPublisher(),
        infoSectionCallback: { _ in },
        meterHeaderSectionCallback: { _ in },
        meterSelectionCallback: { _ in }
    )
}
