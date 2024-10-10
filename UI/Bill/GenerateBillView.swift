//
//  GenerateBillView.swift
//  UtilityBills
//
//  Created by Sergey on 02.10.2024.
//

import SwiftUI

struct GenerateBillView: View {
    @StateObject
    var viewModel: GenerateBillViewModel
    let presenter: GenerateBillPresenter
    
    var body: some View {
        VStack {
            Text(presenter.totalPrice(viewModel.totalPrice))
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal)
            List {
                ForEach(viewModel.records.indices, id: \.self) { i in
                    let item = viewModel.records[i]
                    CaptionValueCell(
                        caption: item.name,
                        value: item.price.formatted()
                    )
                    .onTapGesture {
                        viewModel.onSelected(i)
                    }
                }
            }
            Spacer()
            CTAButton(
                caption: presenter.saveButtonTitle,
                callback: viewModel.onTapAccept
            )
            .padding(.horizontal)
        }
        .errorAlert(for: $viewModel.error)
        .navigationTitle(presenter.screenTitle)
        .task {
            viewModel.load()
        }
    }
}

#Preview {
    let vm = GenerateBillViewModel(
        propertyObjectId: PropertyObjectId(),
        flow: nil
    )
    let presenter = iOSGenerateBillPresenter()
    return GenerateBillView(viewModel: vm, presenter: presenter)
}
