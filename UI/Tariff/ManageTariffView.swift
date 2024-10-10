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
    let presenter: ManageTariffPresenter
    
    private let adaptiveColumn = [
        GridItem(.adaptive(minimum: 150))
    ]
        
    var body: some View {
        VStack(alignment: .center, spacing: 24) {
            Text(presenter.screenTitle)
                .popoverTitle()
            
            TextField("", text: $viewModel.name)
                .inputStyle(caption: presenter.tariffNameInputFieldTitle)
            
            TextField("", text: $viewModel.price)
                #if os(iOS)
                .keyboardType(.decimalPad)
                #endif
                .inputStyle(caption: presenter.priceInputFieldTitle)
            
            GridChoiceView(minWidth: 150, viewModel: viewModel.choiceViewModel) {
                Text($0)
                    .frame(width: 120)
            }            
            Spacer()
                .errorAlert(for: $viewModel.error)
            ControlButtonsView(
                viewModel: viewModel,
                presenter: presenter
            )
            .padding(.bottom, 12)
            .alert(isPresented: $viewModel.isConfirmationAlertVisible) {
                confirmationAlert(
                    presenter: presenter.deleteTariffAlertPresenter,
                    action: viewModel.confirm)
            }
        }
        .padding(.horizontal)
    }
}

#Preview("Add") {
    let vm = ManageTariffViewModel(
        propertyObjectId: PropertyObjectId(),
        flow: nil
    )
    let alertPresenter = DeleteTariffAlertPresenter()
    let presenter = iOSManageTariffPresenter(
        mode: .add,
        deleteTariffAlertPresenter: alertPresenter
    )
    return ManageTariffView(viewModel: vm, presenter: presenter)
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
        flow: nil
    )
    let alertPresenter = DeleteTariffAlertPresenter()
    let presenter = iOSManageTariffPresenter(
        mode: .edit,
        deleteTariffAlertPresenter: alertPresenter
    )
    return ManageTariffView(viewModel: vm, presenter: presenter)

}
