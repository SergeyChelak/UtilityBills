//
//  iOSAppViewFactory.swift
//  UtilityBills
//
//  Created by Sergey on 31.08.2024.
//

import Foundation
import SwiftUI
import Combine

struct iOSAppViewFactory {
//     TODO: make dependency via protocol
    let storage = {
        let ls = LocalStorage.instance()
        return PublishedLocalStorage(storage: ls)
    }()
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
            updatePublisher: storage.publisher,
            infoSectionCallback: { navigationController.showOverlay(.editPropertyInfo($0)) },
            meterHeaderSectionCallback: { navigationController.showOverlay(.addMeter($0)) }
        )
    }
    
    private func composeEditPropertyInfoView(_ obj: PropertyObject) -> some View {
        EditPropertyInfoView(
            propertyObject: obj,
            callback: { try storage.updateProperty($0) }
        )
    }
    
    private func composeAddMeterView(_ propObjId: PropertyObjectId) -> some View {
        AddMeterView(state: .newData(propertyObjectId: propObjId)) {
            try storage.newMeter($0)
        }
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
        case .addMeter(let objId):
            composeAddMeterView(objId)
        }
    }
}
