//
//  IssuesListViewModel.swift
//  UtilityBills
//
//  Created by Sergey on 08.10.2024.
//

import Combine
import Foundation

class IssuesListViewModel: ViewModel {
    private var cancellable: AnyCancellable?
    private var flow: IssuesFlowDelegate?
    
    @Published
    var items: [Issue] = []
    
    init(flow: IssuesFlowDelegate?) {
        self.flow = flow
        super.init()
        cancellable = flow?.updatePublisher
            .publisher
            .sink { [weak self] in
                self?.load()
            }
    }
    
    var isEmpty: Bool {
        items.isEmpty
    }
    
    func load() {
        do {
            self.items = try flow?.fetchIssues() ?? []
        } catch {
            setError(error)
        }
    }
    
    func onSelectIssue(_ issue: Issue) {
        fatalError()
    }
}
