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
                    if let obj = viewModel.propObj {
                        PropertyInfoView(propertyObject: obj)
                            .sectionWith(
                                title: "Info",
                                action: HeaderAction(
                                    title: "Edit",
                                    callback: viewModel.editPropertyDetails)
                            )
                    }
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
                        selectionCallback: viewModel.editBillingMap(_:),
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
                .errorAlert(for: $viewModel.error)
            
            CTAButton(
                caption: "Delete Object",
                actionKind: .destructive,
                callback: { isConfirmDeleteAlertVisible.toggle() }
            )
            .padding(.horizontal)
            .alert(isPresented: $isConfirmDeleteAlertVisible) {
                Alert(
                    title: Text("Warning"),
                    message: Text("Do you want to delete this object?"),
                    primaryButton: .destructive(Text("Delete"), action: viewModel.deleteObject),
                    secondaryButton: .default(Text("Cancel"))
                )
            }
        }
        .navigationTitle("Settings")
        .task {
            viewModel.load()
        }
    }
}

#Preview {
    let vm = __propertySettingsViewModel()
    return PropertySettingsView(viewModel: vm)
}
