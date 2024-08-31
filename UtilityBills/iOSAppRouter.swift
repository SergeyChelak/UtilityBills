//
//  iOSAppRouter.swift
//  UtilityBills
//
//  Created by Sergey on 31.08.2024.
//

import SwiftUI

protocol AppRouter {
//    func route(to route: any Hashable)
    
    associatedtype V: View
    var view: V { get }
}

struct iOSAppRouter<VF: ViewFactory, RT: Hashable>: AppRouter, View where VF.RouteType == RT {
    private let appFactory: VF
    private var navigationPath = NavigationPath()
    
    init(appFactory: VF) {
        self.appFactory = appFactory
    }
    
    var body: some View {
        NavigationStack {
            AnyView(appFactory.initialView())
                .navigationDestination(for: RT.self) { route in
                    AnyView(appFactory.view(for: route))
                }
        }
    }
    
    var view: Self {
        self
    }
}
