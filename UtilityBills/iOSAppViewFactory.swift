//
//  iOSAppViewFactory.swift
//  UtilityBills
//
//  Created by Sergey on 31.08.2024.
//

import Foundation
import SwiftUI

protocol ViewFactory {
    func initialView() -> any View
    
    associatedtype RouteType: Hashable
    func view(for route: RouteType) -> any View
}

struct iOSAppViewFactory<RouteType: Hashable>: ViewFactory {
    let storage = LocalStorage.instance()
    
    func initialView() -> any View {
        let store = ObjectListStore(dataSource: storage)
        return ObjectListView(store: store)
    }
    
    func view(for route: RouteType) -> any View {
        EmptyView()
    }
}
