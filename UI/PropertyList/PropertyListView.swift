//
//  PropertyListView.swift
//  UtilityBills
//
//  Created by Sergey on 24.09.2024.
//

import SwiftUI

struct PropertyListView: View {
    @ObservedObject
    var viewModel: PropertyListViewModel
    
    var body: some View {
        VStack {
            if viewModel.isEmpty {
                Text("You haven't added any objects yet")
            }
            List {
                ForEach(viewModel.items.indices, id: \.self) { i in
                    ObjectListCell(item: viewModel.items[i])
                        .onTapGesture(perform: { viewModel.select(index: i) })
                }
            }
        }
        .navigationTitle("My Objects")
        .toolbar {
            ToolbarItem {
                Button("Add") {
                    viewModel.onCreate()
                }
            }
        }
        .task {
            viewModel.load()
        }
        .errorAlert(for: $viewModel.error)
    }
}
