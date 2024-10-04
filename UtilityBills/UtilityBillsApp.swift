//
//  UtilityBillsApp.swift
//  UtilityBills
//
//  Created by Sergey on 18.08.2024.
//

import SwiftUI

@main
struct UtilityBillsApp: App {
    private var contentView: AnyView
    
    init() {
        let routerData = iOSRouterData()
        let router = iOSRouter(store: routerData)
        let storage = LocalStorage.instance()
        let updatePublisher = StorageWatcher(storage: storage)
        let flowFactory = iOSAppFlowFactory(
            router: router,
            storage: storage,
            updatePublisher: updatePublisher
        )
        let factory = iOSAppViewFactory(flowFactory: flowFactory)
        let navigationView = iOSNavigationView(
            rootView: AnyView(factory.view(for: .properlyObjectList)),
            routerData: routerData,
            createViewCallback: {
                AnyView(factory.view(for: $0))
            }
        )
        contentView = AnyView(navigationView)
    }
    
    var body: some Scene {
        WindowGroup {
            contentView
        }
    }
}

protocol ViewFactory {
    func view(for route: Route) -> any View
}
