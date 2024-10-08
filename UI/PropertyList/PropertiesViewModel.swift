//
//  PropertiesViewModel.swift
//  UtilityBills
//
//  Created by Sergey on 24.09.2024.
//

import Combine
import Foundation

enum HomeCard {
    case propertyObject(PropertyObject)
    case addNewObjectAction
}

class PropertiesViewModel: ViewModel {
    private var cancellable: AnyCancellable?
    private var flow: PropertyObjectListFlowDelegate?
    
    @Published
    private(set) var items: [HomeCard] = [.addNewObjectAction]
    
    @Published
    private var issues: [Issue] = []
    
    var issuesCount: Int {
        issues.count
    }
    
    init(flow: PropertyObjectListFlowDelegate?) {
        self.flow = flow
        super.init()
        self.cancellable = flow?.updatePublisher
            .publisher
            .sink { [weak self] in
                self?.load()
            }
    }
    
    func load() {
        guard let flow else { return }
        do {
            let data = try flow.loadDashboardData()
            var array = data.properties
                .map {
                    HomeCard.propertyObject($0)
                }
            array.append(.addNewObjectAction)
            self.items = array
            self.issues = data.issues
        } catch {
            setError(error)
        }
    }
    
    func onSelect(_ index: Int) {
        let card = items[index]
        switch card {
        case .propertyObject(let propertyObject):
            flow?.openPropertyObject(propertyObject.id)
        case .addNewObjectAction:
            flow?.openCreateNewPropertyObject()
        }
    }
    
    func showIssues() {
        flow?.openIssuesList(issues)
    }
}
