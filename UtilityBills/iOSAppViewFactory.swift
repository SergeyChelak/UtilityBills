//
//  iOSAppViewFactory.swift
//  UtilityBills
//
//  Created by Sergey on 31.08.2024.
//

import Foundation
import SwiftUI

struct iOSAppViewFactory: ViewFactory {
    let storage = LocalStorage.instance()
    let navigationController: NavigationController
    
    init(navigationController: NavigationController) {
        self.navigationController = navigationController
    }
    
    func initialView() -> any View {
        composePropertyObjectListView()
    }
    
    private func composePropertyObjectListView() -> some View {
        let store = ObjectListStore(dataSource: storage)
        return ObjectListView(store: store) {
            navigationController.push(.propertyDetails($0))
        }
    }
    
    private func composePropertyDetailsView(_ uuid: UUID) -> some View {
        PropertyObjectTabContainer()
    }
    
    func view(for route: Route) -> any View {
        switch route {
        case .properlyObjectList:
            initialView()
        case .propertyDetails(let uuid):
            composePropertyDetailsView(uuid)
        }
    }
}
