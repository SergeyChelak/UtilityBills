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
        )
        return view
    }
    
    private func composePropertyHomeView(_ uuid: PropertyObjectId) -> some View {
        let store = PropertyObjectStore(uuid, dataSource: storage)
        return PropertyObjectHome(
            store: store,
            infoSectionCallback: { navigationController.showOverlay(.editPropertyInfo($0)) }
        )
    }
    
    private func composeEditPropertyInfoView(_ obj: PropertyObject) -> some View {
        EditPropertyInfoView(
            propertyObject: obj,
            callback: { try storage.updateProperty($0) }
        )
    }
}


extension iOSAppViewFactory: ViewFactory {
    func view(for route: Route) -> any View {
        switch route {
        case .properlyObjectList:
            composePropertyObjectListView()
        case .propertyObjectHome(let uuid):
            composePropertyHomeView(uuid)
        case .editPropertyInfo(let obj):
            composeEditPropertyInfoView(obj)
        }
    }
}
