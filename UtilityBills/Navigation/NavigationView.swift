//
//  NavigationView.swift
//  UtilityBills
//
//  Created by Sergey on 05.10.2024.
//

import SwiftUI

struct NavigationView: View {
    @StateObject
    var viewModel: NavigationViewModel
    
    private var isSheetVisible: Binding<Bool> {
        Binding(
            get: { viewModel.sheetViewHolder != nil },
            set: { if !$0 { viewModel.sheetViewHolder = nil } }
        )
    }
    var body: some View {
        NavigationStack(path: $viewModel.navigationPath) {
            viewModel.rootViewHolder.view
                .navigationDestination(for: ViewIdentifier.self) {
                    viewModel.viewHolder(for: $0).view
                }
        }
        #if os(OSX)
        .padding()
        #endif
        .sheet(isPresented: isSheetVisible) {
            if let sheet = viewModel.sheetViewHolder {
                sheet.view
            }
        }
    }
}

#Preview {
    struct SomeView: View {
        var body: some View {
            List {
                ForEach(0..<10) { _ in
                    Text("Content")
                }
            }
            .navigationTitle("Title")
        }
    }

    let viewModel = NavigationViewModel()
    return NavigationView(viewModel: viewModel)
        .task {
            viewModel.setRoot(ViewHolder(SomeView()))
        }
}
