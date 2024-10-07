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
    
    private let adaptiveColumn = [
        GridItem(.adaptive(minimum: 150))
    ]
    
    var body: some View {
        VStack {
            ScrollView(showsIndicators: false) {
                LazyVGrid(columns: adaptiveColumn, spacing: 16) {
                    ForEach(viewModel.items.indices, id: \.self) { i in
                        HomeCardView(card: viewModel.items[i])
                            .frame(width: 150, height: 130)
                            .onTapGesture {
                                viewModel.onSelect(i)
                            }
                    }
                }
            }
            .padding(.horizontal)
            Spacer()
        }
        .navigationTitle("My Objects")
        .task {
            viewModel.load()
        }
        .errorAlert(for: $viewModel.error)
    }
}

#Preview {
    struct Flow: PropertyObjectListFlowDelegate {
        let updatePublisher: UpdatePublisher = UpdatePublisherMock()
        
        func loadPropertyObjects() throws -> [PropertyObject] {
            (0...5)
                .map { _ in
                    PropertyObject(
                        id: PropertyObjectId(),
                        name: "Obj #" + String(arc4random()),
                        details: "Details " + String(arc4random())
                    )
                }
        }
        
        func openPropertyObject(_ propertyObjectId: PropertyObjectId) {
            //
        }
        
        func openCreateNewPropertyObject() {
            //
        }
    }
    let vm = PropertiesViewModel(flow: Flow())
    return NavigationStack {
        PropertiesView(viewModel: vm)
    }
}
