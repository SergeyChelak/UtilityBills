//
//  PropertiesView.swift
//  UtilityBills
//
//  Created by Sergey on 24.09.2024.
//

import SwiftUI

struct PropertiesView: View {
    @ObservedObject
    var viewModel: PropertiesViewModel
    
    private let adaptiveColumn: [GridItem]
    
    private let presenter: PropertiesPresenter
    private let cardPresenter: HomeCardPresenter
    
    init(viewModel: PropertiesViewModel, 
         presenter: PropertiesPresenter,
         cardPresenter: HomeCardPresenter) {
        self.viewModel = viewModel
        self.presenter = presenter
        self.cardPresenter = cardPresenter
        self.adaptiveColumn = [
            GridItem(.adaptive(minimum: presenter.gridWidth))
        ]
    }
        
    var body: some View {
        VStack {
            ScrollView(showsIndicators: false) {
                LazyVGrid(columns: adaptiveColumn, spacing: 16) {
                    ForEach(viewModel.items.indices, id: \.self) { i in
                        HomeCardView(
                            card: viewModel.items[i],
                            presenter: cardPresenter
                        )
                        .frame(
                            width: presenter.gridWidth,
                            height: presenter.gridHeight
                        )
                        .onTapGesture {
                            viewModel.onSelect(i)
                        }
                    }
                }
            }
            .padding(.horizontal)
            Spacer()
        }
        .navigationTitle(presenter.screenTitle)
        .toolbar {
            ToolbarItem {
                Button {
                    viewModel.showIssues()
                }
                label: {
                    UBImage(holder: presenter.issuesIcon)
                        .customBadge(viewModel.issuesCount)
                }
            }            
        }
        .task {
            viewModel.load()
        }
        .errorAlert(for: $viewModel.error)
    }
}

#Preview {
    struct Flow: PropertyObjectListFlowDelegate {
        func loadDashboardData() throws -> DashboardData {
            let objects = try loadPropertyObjects()
            return DashboardData(
                properties: objects,
                issues: []
            )
        }
        
        let updatePublisher: UpdatePublisher = UpdatePublisherMock()
        
        func loadPropertyObjects() throws -> [PropertyObject] {
            (0...5)
                .map { _ in
                    _randPropertyObject()
                }
        }
        
        func openPropertyObject(_ propertyObjectId: PropertyObjectId) {
            //
        }
        
        func openCreateNewPropertyObject() {
            //
        }
        
        func openIssuesList(_ issues: [Issue]) {
            //
        }
    }
    let vm = PropertiesViewModel(flow: Flow())
    return NavigationStack {
        PropertiesView(
            viewModel: vm,
            presenter: DefaultPropertiesPresenter(),
            cardPresenter: DefaultHomeCardPresenter()
        )
    }
}
