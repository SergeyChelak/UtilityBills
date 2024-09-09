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
        let navigationStore = iOSNavigationStore()
        let navigationController = iOSNavigationController(store: navigationStore)
        let factory = iOSAppViewFactory(navigationController: navigationController)
        let navigationView = iOSNavigationView(
            rootView: AnyView(factory.view(for: .properlyObjectList)),
            navigationStore: navigationStore,
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

enum Route: Hashable {
    case properlyObjectList
    case propertyObjectHome(PropertyObjectId)
}

protocol NavigationController {
    func push(_ route: Route)
    func pop()
    func popToRoot()
    func showOverlay(_ route: Route)
}
