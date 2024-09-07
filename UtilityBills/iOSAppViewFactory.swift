//
//  iOSAppViewFactory.swift
//  UtilityBills
//
//  Created by Sergey on 31.08.2024.
//

import Foundation
import SwiftUI

struct iOSAppViewFactory: ViewFactory {
    // TODO: make dependency via protocol
    let storage = LocalStorage.instance()
    let navigationController: NavigationController
    
    init(navigationController: NavigationController) {
        self.navigationController = navigationController
    }
    
    private func composePropertyObjectListView() -> some View {
        let store = ObjectListStore(dataSource: storage)
        return ObjectListView(store: store) {
            navigationController.push(.propertyDetails($0))
        }
    }
    
    private func composePropertyDetailsView(_ uuid: UUID) -> some View {
        let tabs = [
            TabDescriptor(view: composePropertyInfoView(uuid), text: "Info"),
            TabDescriptor(view: composeMeterListView(uuid), text: "Meters"),
            TabDescriptor(view: composeTariffListView(uuid), text: "Tariff"),
            TabDescriptor(view: composeBillingView(uuid), text: "Billing"),
        ]
        return PropertyObjectTabContainer(tabs: tabs)
    }
    
    private func composePropertyInfoView(_ uuid: UUID) -> some View {
        let store = PropertyObjectInfoStore(uuid, storage: storage)
        return PropertyObjectInfoView(store: store)
    }
    
    private func composeMeterListView(_ uuid: UUID) -> some View {
        MeterListScreen()
    }
    
    private func composeTariffListView(_ uuid: UUID) -> some View {
        TariffListScreen()
    }
    
    private func composeBillingView(_ uuid: UUID) -> some View {
        BillingScreen()
    }
    
    func view(for route: Route) -> any View {
        switch route {
        case .properlyObjectList:
            composePropertyObjectListView()
        case .propertyDetails(let uuid):
            composePropertyDetailsView(uuid)
        }
    }
}
