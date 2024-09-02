//
//  iOSAppRouter.swift
//  UtilityBills
//
//  Created by Sergey on 31.08.2024.
//

import SwiftUI

class iOSNavigationStore: ObservableObject {
    @Published
    var navigationPath = NavigationPath()    
}

class iOSNavigationController: NavigationController {
    private let store: iOSNavigationStore
    
    init(store: iOSNavigationStore) {
        self.store = store
    }
        
    func push(_ route: Route) {
        store.navigationPath.append(route)
    }
    
    func pop() {
        store.navigationPath.removeLast()
    }
    
    func popToRoot() {
        let count = store.navigationPath.count
        store.navigationPath.removeLast(count)
    }
    
    func showOverlay(_ view: Route) {
        fatalError("Show overlay not implemented yet")
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
                .navigationDestination(for: Route.self, destination: createViewCallback)
        }
    }
}


