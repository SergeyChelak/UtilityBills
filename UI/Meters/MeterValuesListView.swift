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
            Spacer()
            CTAButton(
                caption: "Delete Meter",
                fillColor: .red,
                callback: viewModel.deleteMeter
            )
            .padding(.horizontal)
        }
        .navigationTitle("Values")
        .toolbar {
            ToolbarItem {
                Button("Add") {
                    viewModel.newValue()
                }
            }
        }
        .task {
            viewModel.load()
        }
        .errorAlert(for: $viewModel.error)
    }
}

import Combine

#Preview {
    let values = [
        MeterValue(date: Date(), value: 10, isPaid: true, id: UUID()),
        MeterValue(date: Date(), value: 17, isPaid: true, id: UUID()),
        MeterValue(date: Date(), value: 24, isPaid: true, id: UUID()),
        MeterValue(date: Date(), value: 25, isPaid: false, id: UUID())
    ].reversed()
    let vm = MeterValuesListViewModel(
        actionLoad: { Array(values) },
        actionNewValue: { },
        actionSelect:  { _ in },
        actionDeleteMeter: { },
        updatePublisher: Empty().eraseToAnyPublisher()
    )
    return MeterValuesListView(viewModel: vm)
}
