//
//  ManageTariffView.swift
//  UtilityBills
//
//  Created by Sergey on 25.09.2024.
//

import SwiftUI

struct ManageTariffView: View {
    @StateObject
    var viewModel: ManageTariffViewModel
    
    private let adaptiveColumn = [
        GridItem(.adaptive(minimum: 150))
    ]
        
    var body: some View {
        VStack(alignment: .center, spacing: 24) {
            Text(viewModel.dialogTitle)
                .popoverTitle()
            
            TextField("", text: $viewModel.name)
                .inputStyle(caption: "Tariff name")
            
            TextField("", text: $viewModel.price)
                .keyboardType(.decimalPad)
                .inputStyle(caption: "Price")
            
            GridChoiceView(minWidth: 150, viewModel: viewModel.choiceViewModel) {
                Text($0)
                    .frame(width: 120)
            }
            Spacer()
            VStack(spacing: 24) {
                ForEach(viewModel.actions, id: \.hashValue) { action in
                    CTAButton(caption: action.name, style: action.style) {
                        viewModel.onAction(action)
                    }
                }
            }
            .padding(.bottom, 12)
        }
        .padding(.horizontal)
        .errorAlert(for: $viewModel.error)
        .alert(isPresented: $viewModel.isConfirmationAlertVisible) {
            Alert(
                title: Text("Warning"),
                message: Text("This action isn't undoable. Do you want to proceed?"),
                primaryButton: .destructive(Text("Proceed"), action: viewModel.confirm),
                secondaryButton: .default(Text("Cancel"))
            )
        }
    }
}

#Preview("Add") {
    let vm = ManageTariffViewModel(actionSave: { _ in })
    return ManageTariffView(viewModel: vm)
}

#Preview("Edit") {
    let tariff = Tariff(
        id: TariffId(),
        name: "Electricity",
        price: 10.23,
        activeMonthMask: 1000
    )
    let vm = ManageTariffViewModel(
        tariff: tariff,
        actionUpdate: { _ in },
        actionDelete: { _ in }
    )
    return ManageTariffView(viewModel: vm)
}
