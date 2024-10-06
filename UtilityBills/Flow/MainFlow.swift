//
//  MainFlow.swift
//  UtilityBills
//
//  Created by Sergey on 05.10.2024.
//

import Foundation

class MainFlow: Flow {
    private let viewFactory: ViewFactory
    private let storage: LocalStorage
    let updatePublisher: UpdatePublisher
    private let navigation: StackNavigation
    
    private var propertyObjectFlow: PropertyObjectFlow?
    
    init(
        viewFactory: ViewFactory,
        storage: LocalStorage,
        updatePublisher: UpdatePublisher,
        navigation: StackNavigation
    ) {
        self.viewFactory = viewFactory
        self.storage = storage
        self.updatePublisher = updatePublisher
        self.navigation = navigation
    }
    
    func start() {
        navigation.setRoot(viewFactory.propertyObjectListView(delegateFlow: self))
    }
}

// MARK: PropertyObjectListFlow
extension MainFlow: PropertyObjectListFlowDelegate {
    func loadPropertyObjects() throws -> [PropertyObject] {
        try storage.allProperties()
    }
    
    func openPropertyObject(_ propertyObjectId: PropertyObjectId) {
        let flow = PropertyObjectFlow(
            viewFactory: self.viewFactory,
            storage: self.storage,
            updatePublisher: self.updatePublisher,
            navigation: self.navigation,
            propertyObjectId: propertyObjectId
        )
        flow.start()
        self.propertyObjectFlow = flow
    }
    
    func createPropertyObject() throws {
        _ = try storage.createProperty()
    }
}
