//
//  CommonListView.swift
//  UtilityBills
//
//  Created by Sergey on 07.09.2024.
//

import SwiftUI


struct CommonListView<ElementType, ViewModel: CommonListViewModel<ElementType>, ViewType: View>: View {
    let title: String
    @ObservedObject var viewModel: ViewModel
    let factory: (ElementType) -> ViewType
    
    private var isErrorAlertVisible: Binding<Bool> {
        Binding(
            get: { viewModel.error != nil },
            set: { if !$0 { viewModel.error = nil } }
        )
    }
    
    var body: some View {
        List {
            ForEach(viewModel.items.indices, id: \.self) { i in
                factory(viewModel.items[i])
                    .onTapGesture(perform: { viewModel.onSelect(index: i) })
            }
            .onDelete(perform: viewModel.onDelete(_:))
            .deleteDisabled(!viewModel.isDeleteAllowed)
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
        .alert(isPresented: isErrorAlertVisible) {
            Alert(
                title: Text("Error"),
                message: Text(viewModel.error?.localizedDescription ?? "Something went wrong"),
                dismissButton: .default(Text("Dismiss")))
        }
    }
}
