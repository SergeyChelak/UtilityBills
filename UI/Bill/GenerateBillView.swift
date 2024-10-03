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
    
    var body: some View {
        VStack {
            Text("Total price: \(viewModel.totalPrice)")
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal)
            List {
                ForEach(viewModel.records.indices, id: \.self) { i in
                    let item = viewModel.records[i]
                    CaptionValueCell(
                        caption: item.name,
                        value: item.price.formatted()
                    )
                }
            }
            Spacer()
            CTAButton(
                caption: "Accept",
                callback: viewModel.onTapAccept
            )
            .padding(.horizontal)
        }
        .errorAlert(for: $viewModel.error)
        .navigationTitle("New Bill")
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
    return GenerateBillView(viewModel: vm)
}
