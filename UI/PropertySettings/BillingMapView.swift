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
    
    var body: some View {
        VStack {
            ScrollView(showsIndicators: false) {
                VStack(spacing: 24) {
                    Text("Billing Map")
                        .popoverTitle()
                    
                    TextField("", text: $viewModel.name)
                        .inputStyle(caption: "Billing item name")
                    Divider()
                    VStack(spacing: 4) {
                        Text("Pick tariff")
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .lineLimit(1)
                        GridChoiceView(viewModel: viewModel.tariffModel) {
                            Text($0.name)
                                .frame(maxWidth: 130)
                        }
                    }
                    Divider()
                    VStack(spacing: 4) {
                        Text("Pick meter(s) if needed")
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .lineLimit(1)
                        GridChoiceView(viewModel: viewModel.meterModel) {
                            Text($0.name)
                                .frame(maxWidth: 130)
                        }
                    }
                }
            }
            Spacer()
            CTAButton(caption: "Save mapping", callback: viewModel.save)
                .padding(.bottom, 12)
        }
        .padding(.horizontal)
        .errorAlert(for: $viewModel.error)
        .task {
            viewModel.load()
        }
    }
}

#Preview {
    let vm = BillingMapViewModel(
        actionLoad: {
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
            let meter1 = Meter(
                id: MeterId(),
                name: "M1",
                capacity: nil,
                inspectionDate: nil)
                
            let meter2 = Meter(
                id: MeterId(),
                name: "M2",
                capacity: nil,
                inspectionDate: nil
            )
            return BillingMapData(
                tariffs: [tariff1, tariff2],
                meters: [meter1, meter2, meter2, meter1, meter1]
            )
        },
        actionSave: { _ in }
    )
    return BillingMapView(viewModel: vm)
}
