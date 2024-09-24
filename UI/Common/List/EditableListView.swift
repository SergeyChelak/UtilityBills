//
//  CommonListView.swift
//  UtilityBills
//
//  Created by Sergey on 07.09.2024.
//

import SwiftUI

struct EditableListView<ElementType, ViewModel: EditableListViewModel<ElementType>, ViewType: View>: View {
    let title: String
    @ObservedObject var viewModel: ViewModel
    let factory: (ElementType) -> ViewType
        
    var body: some View {
        VStack {
            if viewModel.isEmpty {
                Text("No items yet...")
            }
            List {
                ForEach(viewModel.items.indices, id: \.self) { i in
                    factory(viewModel.items[i])
                        .onTapGesture(perform: { viewModel.select(index: i) })
                }
                .onDelete(perform: viewModel.onDelete(_:))
                .deleteDisabled(!viewModel.isDeleteAllowed)
            }
        }
        .navigationTitle(title)
        .toolbar {
            if viewModel.canCreateItems {
                ToolbarItem {
                    Button("Add") {
                        viewModel.onCreate()
                    }
                }
            }
        }
        .task {
            viewModel.load()
        }
        .errorAlert(for: $viewModel.error)
    }
}
