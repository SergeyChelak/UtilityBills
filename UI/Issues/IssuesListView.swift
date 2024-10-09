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
    
    var body: some View {
        VStack {
            if viewModel.isEmpty {
                Text("It looks like everything is ok")
                    .padding(.horizontal)
            } else {
                List {
                    ForEach(viewModel.items.indices, id: \.self) { i in
                        let item = viewModel.items[i]
                        IssueView(issue: item)
                            .onTapGesture {
                                viewModel.onSelectIssue(item)
                            }
                    }
                }
                Spacer()
            }
        }
        .navigationTitle("Issues")
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
    return NavigationStack {
        IssuesListView(viewModel: vm)
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
    return NavigationStack {
        IssuesListView(viewModel: vm)
    }
}
