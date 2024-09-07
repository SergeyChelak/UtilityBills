//
//  iOSAppRouter.swift
//  UtilityBills
//
//  Created by Sergey on 31.08.2024.
//

import SwiftUI

class iOSNavigationStore: ObservableObject {
    @Published var navigationPath = NavigationPath()
    @Published var overlay: Route?
}

class iOSNavigationController: NavigationController {
    private let store: iOSNavigationStore
    
    init(store: iOSNavigationStore) {
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
        store.overlay = overlay
    }
    
    private func hideOverlay() {
        store.overlay = nil
    }
}

struct iOSNavigationView: View {
    let rootView: AnyView
    @StateObject
    var navigationStore: iOSNavigationStore
    var createViewCallback: (Route) -> AnyView
    
    var body: some View {
        NavigationStack(path: $navigationStore.navigationPath) {
            rootView
                .navigationDestination(
                    for: Route.self,
                    destination: createViewCallback
                )
        }
    }
}


