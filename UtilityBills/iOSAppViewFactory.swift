//
//  iOSAppViewFactory.swift
//  UtilityBills
//
//  Created by Sergey on 31.08.2024.
//

import Foundation
import SwiftUI

struct iOSAppViewFactory {
    // TODO: make dependency via protocol
    let storage = LocalStorage.instance()
    let navigationController: NavigationController
    
    init(navigationController: NavigationController) {
        self.navigationController = navigationController
    }
    
    private func composePropertyObjectListView() -> some View {
        let store = EditableListStore<PropertyObject>(
            loader: storage.allProperties,
            remover: storage.deleteProperty,
            creator: storage.createProperty
        )
        let view = EditableListView(
            title: "My Objects",
            store: store,
            factory: { ObjectListCell(item: $0) },
            selection: { navigationController.push(.propertyObjectHome($0.id)) }
            //            selection: { navigationController.push(.meterList($0.id)) }
        )
        return view
    }
    
    private func composePropertyHomeView(_ uuid: PropertyObjectId) -> some View {
        let store = PropertyObjectStore(uuid, dataSource: storage)
        return PropertyObjectHome(store: store)
    }
    
//    private func composePropertyInfoView(_ uuid: PropertyObjectId) -> some View {
//        let store = PropertyObjectInfoStore(uuid, dataSource: storage)
//        return PropertyObjectInfoView(store: store)
//    }
    
    private func composeMeterListView(_ uuid: PropertyObjectId) -> some View {
        let store = EditableListStore<Meter>(
            loader: { try storage.allMeters(for: uuid) },
            creator: { try storage.newMeter(for: uuid) }
        )
        let view = EditableListView(
            title: "Meters",
            store: store,
            // TODO: fix stub
            factory: {
                TitleSubtitleCell(
                    title: $0.name,
                    subtitle: $0.id.uuidString)
            },
            selection: { _ in print("navigation not implemented") }
        )
        return view
        
    }
    
    private func composeTariffListView(_ uuid: PropertyObjectId) -> some View {
        TariffListScreen()
    }
    
    private func composeBillingView(_ uuid: PropertyObjectId) -> some View {
        BillingScreen()
    }
}


extension iOSAppViewFactory: ViewFactory {
    func view(for route: Route) -> any View {
        switch route {
        case .properlyObjectList:
            composePropertyObjectListView()
        case .propertyObjectHome(let uuid):
            composePropertyHomeView(uuid)
        case .meterList(let uuid):
            composeMeterListView(uuid)
        }
    }
}
