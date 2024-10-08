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
    
    func loadPropertyObjects() throws -> [PropertyObject] {
        try storage.allProperties()
    }
    
    func fetchIssues() throws -> [Issue] {
        try storage.allMeters()
            .filter {
                $0.getInspectionState() != .normal
            }
            .map {
                Issue.meter($0)
            }
    }
}

// MARK: PropertyObjectListFlowDelegate
extension MainFlow: PropertyObjectListFlowDelegate {
    func loadDashboardData() throws -> DashboardData {
        let properties = try loadPropertyObjects()
        let issues = try fetchIssues()
        return DashboardData(
            properties: properties,
            issues: issues
        )
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
    
    func openCreateNewPropertyObject() {
        let view = viewFactory.createPropertyObjectView(flowDelegate: self)
        navigation.showSheet(view)
    }
    
    func openIssuesList(_ issues: [Issue]) {
        let view = viewFactory.issuesListView(flowDelegate: self)
        navigation.push(view)
    }
}

// MARK: CreatePropertyObjectFlowDelegate
extension MainFlow: CreatePropertyObjectFlowDelegate {
    func createPropertyObject(_ propertyObject: PropertyObject) throws {
        try storage.createProperty(propertyObject)
        openPropertyObject(propertyObject.id)
    }
}

// MARK: IssuesFlowDelegate
extension MainFlow: IssuesFlowDelegate {
    func openIssue(_ issue: Issue) {
        fatalError("Not implemented")
    }
}
