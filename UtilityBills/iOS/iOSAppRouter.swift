//
//  iOSAppRouter.swift
//  UtilityBills
//
//  Created by Sergey on 31.08.2024.
//

import SwiftUI

class iOSRouterData: ObservableObject {
    @Published var navigationPath = NavigationPath()
    @Published var popover: Route?
}

class iOSRouter: Router {
    private let store: iOSRouterData
    
    init(store: iOSRouterData) {
        self.store = store
    }
    
    func push(_ route: Route) {
        hideOverlay()
        store.navigationPath.append(route)
    }
    
    func pop() {
        hideOverlay()
        store.navigationPath.removeLast()
    }
    
    func popToRoot() {
        hideOverlay()
        let count = store.navigationPath.count
        store.navigationPath.removeLast(count)
    }
    
    func showOverlay(_ overlay: Route) {
        store.popover = overlay
    }
    
    func hideOverlay() {
        store.popover = nil
    }
}

struct iOSNavigationView: View {
    let rootView: AnyView
    @StateObject
    var routerData: iOSRouterData
    var createViewCallback: (Route) -> AnyView
    
    private var isPopoverVisible: Binding<Bool> {
        Binding(
            get: { routerData.popover != nil },
            set: { if !$0 { routerData.popover = nil } }
        )
    }
    
    var body: some View {
        NavigationStack(path: $routerData.navigationPath) {
            rootView
                .navigationDestination(
                    for: Route.self,
                    destination: createViewCallback
                )
        }
        .sheet(isPresented: isPopoverVisible) {
            if let overlay = routerData.popover {
                createViewCallback(overlay)
            }
        }
    }
}


