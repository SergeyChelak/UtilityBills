//
//  PropertySettingsView.swift
//  UtilityBillsTests
//
//  Created by Sergey on 27.09.2024.
//

import SwiftUI

struct PropertySettingsView: View {
    @StateObject
    var viewModel: PropertySettingsViewModel
    @State
    var isConfirmDeleteAlertVisible = false
    
    var body: some View {
        VStack {
            ScrollView(showsIndicators: false) {
                // Manage payment's settings
                SectionListView(
                    items: viewModel.billingMaps,
                    emptyListMessage: "You didn't add any payment maps yet",
                    selectionCallback: { _ in },
                    cellProducer: { CaptionValueCell(caption: $0.name) }
                )
                .sectionWith(
                    title: "Payment Mapping",
                    action: HeaderAction(
                        title: "Add",
                        callback: { }
                    )
                )
            }
            Spacer()
            CTAButton(
                caption: "Delete Object",
                fillColor: .red,
                callback: { isConfirmDeleteAlertVisible.toggle() }
            )
        }
        .padding(.horizontal)
        .navigationTitle("Settings")
        .errorAlert(for: $viewModel.error)
        .alert(isPresented: $isConfirmDeleteAlertVisible) {
            Alert(
                title: Text("Warning"),
                message: Text("Do you want to delete this object?"),
                primaryButton: .destructive(Text("Delete"), action: viewModel.deleteObject),
                secondaryButton: .default(Text("Cancel"))
            )
        }
        .task {
            viewModel.load()
        }
    }
}

#Preview {
    let tariff = Tariff(
        id: TariffId(),
        name: "Tariff 1",
        price: Decimal(10.11),
        activeMonthMask: 4095
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

    let vm = PropertySettingsViewModel(
        objectId: PropertyObjectId(),
        actionLoad: {
            let item = BillingMap(
                id: BillingMapId(),
                name: "Billing map #1",
                order: 1,
                tariff: tariff,
                meters: [meter1, meter2]
            )
            return [item, item, item]
        },
        actionDelete: { }
    )
    return PropertySettingsView(viewModel: vm)
}
