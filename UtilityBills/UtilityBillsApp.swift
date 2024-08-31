//
//  UtilityBillsApp.swift
//  UtilityBills
//
//  Created by Sergey on 18.08.2024.
//

import SwiftUI

@main
struct UtilityBillsApp: App {
    let contentView: some View = iOSAppBootstrap()
    
    var body: some Scene {
        WindowGroup {
            contentView
        }
    }
}

func iOSAppBootstrap() -> some View {
    let factory = iOSAppViewFactory<Int>()
    let router = iOSAppRouter(appFactory: factory)
    return router.view
}
