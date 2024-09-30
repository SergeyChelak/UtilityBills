//
//  PropertySettingsView.swift
//  UtilityBillsTests
//
//  Created by Sergey on 27.09.2024.
//

import Combine
import SwiftUI

struct PropertySettingsView: View {
    @StateObject
    var viewModel: PropertySettingsViewModel
    @State
    var isConfirmDeleteAlertVisible = false
    
    var body: some View {
        VStack {
            ScrollView(showsIndicators: false) {
                VStack(spacing: 24) {
                    SectionListView(
                        items: viewModel.meters,
                        emptyListMessage: "You have no meters yet",
                        selectionCallback: viewModel.meterSelected(_:),
                        cellProducer: { CaptionValueCell(caption: $0.name) }
                    )
                    .sectionWith(
                        title: "Meters",
                        action: HeaderAction(
                            title: "Add",
                            callback: viewModel.addMeter
                        )
                    )
                    SectionListView(
                        items: viewModel.tariffs,
                        emptyListMessage: "You have no tariffs yet",
                        selectionCallback: viewModel.tariffSelected(_:),
                        cellProducer: {
                            CaptionValueCell(
                                caption: $0.name,
                                value: $0.price.formatted()
                            )
                        }
                    )
                    .sectionWith(
                        title: "Tariffs",
                        action: HeaderAction(
                            title: "Add",
                            callback: viewModel.addTariff
                        )
                    )
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
                            callback: viewModel.addBillingMap
                        )
                    )
                }
            }
            Spacer()
            CTAButton(
                caption: "Delete Object",
                style: .destructive,
                callback: { isConfirmDeleteAlertVisible.toggle() }
            )
            .padding(.horizontal)
        }
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
    
    let billingItem = BillingMap(
        id: BillingMapId(),
        name: "Billing map #1",
        order: 1,
        tariff: tariff,
        meters: [meter1, meter2]
    )

    let vm = PropertySettingsViewModel(
        objectId: PropertyObjectId(),
        actionLoad: {
            PropertySettingsData(
                meters: [meter1, meter2],
                tariffs: [tariff, tariff],
                billingMaps: [billingItem, billingItem, billingItem]
            )
        },
        actionMeterHeaderSectionTap: { _ in },
        actionMeterSelectionTap: { _ in },
        actionAddTariff: { _ in },
        actionEditTariff: { _ in },
        actionAddBillingMap: { _ in },
        actionDelete: { },
        updatePublisher: Empty().eraseToAnyPublisher()
    )
    return PropertySettingsView(viewModel: vm)
}
