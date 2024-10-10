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
    let presenter: MeterValuesListPresenter
    
    var body: some View {
        VStack {
            if viewModel.isEmpty {
                Text(presenter.emptyListMessage)
            }
            List {
                ForEach(viewModel.items.indices, id: \.self) { i in
                    let item = viewModel.items[i]
                    CaptionValueCell(
                        caption: presenter.cellCaption(item),
                        value: presenter.cellValue(item)
                    )
                    .onTapGesture(perform: { viewModel.select(index: i) })
                }
            }
        }
        .navigationTitle(presenter.screenTitle)
        .toolbar {
            ToolbarItem {
                Button(presenter.addButtonTitle) {
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
    let presenter = iOSMeterValuesListPresenter()
    return MeterValuesListView(
        viewModel: vm,
        presenter: presenter
    )
}
