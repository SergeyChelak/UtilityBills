//
//  MeterValuesListView.swift
//  UtilityBills
//
//  Created by Sergey on 24.09.2024.
//

import SwiftUI

struct MeterValuesListView: View {
    @StateObject
    var viewModel: MeterValuesListViewModel
    
    var body: some View {
        VStack {
            if viewModel.isEmpty {
                Text("No records found for this meter")
            }
            List {
                ForEach(viewModel.items.indices, id: \.self) { i in
                    let item = viewModel.items[i]
                    CaptionValueCell(
                        caption: item.date.formatted(),
                        value: String(format: "%.0f", item.value)
                    )
                    .onTapGesture(perform: { viewModel.select(index: i) })
                }
            }
        }
        .navigationTitle("Values")
        .toolbar {
            ToolbarItem {
                Button("Add") {
                    viewModel.openNewMeterValue()
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
    let vm = meterValuesListViewModelMock(meterId: MeterId())
    return MeterValuesListView(viewModel: vm)
}
