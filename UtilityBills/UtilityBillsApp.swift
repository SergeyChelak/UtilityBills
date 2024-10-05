//
//  UtilityBillsApp.swift
//  UtilityBills
//
//  Created by Sergey on 18.08.2024.
//

import SwiftUI

@main
struct UtilityBillsApp: App {
    let mainFlow: MainFlow
    let contentView: NavigationView
    
    init() {
        let viewFactory = iOSViewFactory()
        let storage = LocalStorage.instance()
        
        let updatePublisher = StorageWatcher(storage: storage)
        
        let navigationViewModel = NavigationViewModel()
        self.contentView = NavigationView(viewModel: navigationViewModel)
        
        self.mainFlow = MainFlow(
            viewFactory: viewFactory,
            storage: storage,
            updatePublisher: updatePublisher,
            navigation: navigationViewModel)
        self.mainFlow.start()
    }
    
    var body: some Scene {
        WindowGroup {
            contentView
        }
    }
}
