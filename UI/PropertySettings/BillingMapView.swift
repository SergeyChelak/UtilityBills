//
//  BillingMapView.swift
//  UtilityBills
//
//  Created by Sergey on 28.09.2024.
//

import SwiftUI

struct BillingMapView: View {
    @StateObject
    var viewModel: BillingMapViewModel
    let presenter: BillingMapPresenter
    
    var body: some View {
        VStack {
            ScrollView(showsIndicators: false) {
                VStack(spacing: 24) {
                    Text(presenter.screenTitle)
                        .popoverTitle()
                    
                    TextField("", text: $viewModel.name)
                        .inputStyle(caption: presenter.itemNameInputFieldTitle)
                    Divider()
                    if viewModel.tariffModel.isEmpty {
                        Text(presenter.emptyTariffListMessage)
                    } else {
                        VStack(spacing: 4) {
                            Text(presenter.tariffPickerTitle)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .lineLimit(1)
                            GridChoiceView(viewModel: viewModel.tariffModel) {
                                Text($0.name)
                                    .frame(maxWidth: 130)
                            }
                        }
                    }
                    Divider()
                    if !viewModel.meterModel.isEmpty {
                        VStack(spacing: 4) {
                            Text(presenter.meterPickerTitle)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .lineLimit(1)
                            GridChoiceView(viewModel: viewModel.meterModel) {
                                Text($0.name)
                                    .frame(maxWidth: 130)
                            }
                        }
                    }
                }
            }
            Spacer()
            ControlButtonsView(
                viewModel: viewModel,
                presenter: presenter
            )
            .padding(.bottom, 12)
        }
        .padding(.horizontal)
        .errorAlert(for: $viewModel.error)
    }
}

#Preview {
    let data = {
        let tariff1 = Tariff(
            id: TariffId(),
            name: "Tariff 1",
            price: Decimal(10.11),
            activeMonthMask: 4095
        )
        let tariff2 = Tariff(
            id: TariffId(),
            name: "Tariff 2",
            price: Decimal(32.10),
            activeMonthMask: 4094
        )
        let meter1 = _randMeter()
            
        let meter2 = _randMeter()
        
        return BillingMapData(
            tariffs: [tariff1, tariff2],
            meters: [meter1, meter2, meter2, meter1, meter1],
            propertyObjectId: PropertyObjectId()
        )
    }()
    let vm = BillingMapViewModel(
        billingMapData: data,
        flow: nil
    )
    let presenter = iOSBillingMapPresenter()
    return BillingMapView(viewModel: vm, presenter: presenter)
}
