//
//  IssuesListView.swift
//  UtilityBills
//
//  Created by Sergey on 08.10.2024.
//

import SwiftUI

struct IssuesListView: View {
    @StateObject
    var viewModel: IssuesListViewModel
    
    let presenter: IssuesListPresenter
    
    var body: some View {
        VStack {
            if viewModel.isEmpty {
                Text(presenter.emptyListMessage)
                    .padding(.horizontal)
            } else {
                List {
                    ForEach(viewModel.items.indices, id: \.self) { i in
                        let item = viewModel.items[i]
                        IssueView(issue: item, presenter: presenter.issueCellPresenter)
                            .onTapGesture {
                                viewModel.onSelectIssue(item)
                            }
                    }
                }
                Spacer()
            }
        }
        .navigationTitle(presenter.screenTitle)
        .task {
            viewModel.load()
        }
    }
}

#Preview("Empty") {
    struct Flow: IssuesFlowDelegate {
        let updatePublisher: UpdatePublisher = UpdatePublisherMock()
        
        func fetchIssues() throws -> [Issue] {
            []
        }
        
        func openIssue(_ issue: Issue) {
            //
        }
    }
    let vm = IssuesListViewModel(flow: Flow())
    let issueCellPresenter = iOSIssueCellPresenter()
    let presenter = iOSIssuesListPresenter(issueCellPresenter: issueCellPresenter)
    return NavigationStack {
        IssuesListView(
            viewModel: vm,
            presenter: presenter
        )
    }
}

#Preview("Some items") {
    struct Flow: IssuesFlowDelegate {
        let updatePublisher: UpdatePublisher = UpdatePublisherMock()
        
        func fetchIssues() throws -> [Issue] {
            var date = Date()
            return (0...10)
                .map { i in
                    date = date.addingTimeInterval(Double(i) * 10.0)
                    let meter = Meter(
                        id: MeterId(),
                        name: "Meter #\(i)",
                        capacity: nil,
                        inspectionDate: date)
                    return FullMeterData(
                        propertyObject: _propertyObject(),
                        meter: meter
                    )
                }
                .map {
                    Issue.meter($0)
                }
        }
        
        func openIssue(_ issue: Issue) {
            //
        }
    }

    let vm = IssuesListViewModel(flow: Flow())
    let issueCellPresenter = iOSIssueCellPresenter()
    let presenter = iOSIssuesListPresenter(issueCellPresenter: issueCellPresenter)
    return NavigationStack {
        IssuesListView(
            viewModel: vm,
            presenter: presenter
        )
    }
}
