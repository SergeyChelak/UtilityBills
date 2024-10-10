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
    let presenter: PropertySettingsPresenter
    @State
    var isConfirmDeleteAlertVisible = false
    
    var body: some View {
        VStack {
            ScrollView(showsIndicators: false) {
                VStack(spacing: 24) {
                    if let obj = viewModel.propObj {
                        PropertyInfoView(propertyObject: obj)
                            .sectionWith(
                                title: presenter.sectionInfoTitle,
                                action: HeaderAction(
                                    title: presenter.sectionInfoActionButtonTitle,
                                    callback: viewModel.editPropertyDetails)
                            )
                    }
                    SectionListView(
                        items: viewModel.meters,
                        emptyListMessage: presenter.noMetersMessage,
                        selectionCallback: viewModel.meterSelected(_:),
                        cellProducer: { CaptionValueCell(caption: $0.name) }
                    )
                    .sectionWith(
                        title: presenter.sectionMetersTitle,
                        action: HeaderAction(
                            title: presenter.sectionMetersActionButtonTitle,
                            callback: viewModel.addMeter
                        )
                    )
                    SectionListView(
                        items: viewModel.tariffs,
                        emptyListMessage: presenter.noTariffsMessage,
                        selectionCallback: viewModel.tariffSelected(_:),
                        cellProducer: {
                            CaptionValueCell(
                                caption: $0.name,
                                value: $0.price.formatted()
                            )
                        }
                    )
                    .sectionWith(
                        title: presenter.sectionTariffsTitle,
                        action: HeaderAction(
                            title: presenter.sectionTariffsActionButtonTitle,
                            callback: viewModel.addTariff
                        )
                    )
                    // Manage payment's settings
                    SectionListView(
                        items: viewModel.billingMaps,
                        emptyListMessage: presenter.noBillingMapsMessage,
                        selectionCallback: viewModel.editBillingMap(_:),
                        cellProducer: { CaptionValueCell(caption: $0.name) }
                    )
                    .sectionWith(
                        title: presenter.sectionBillingMapsTitle,
                        action: HeaderAction(
                            title: presenter.sectionBillingMapsActionButtonTitle,
                            callback: viewModel.addBillingMap
                        )
                    )
                }
            }
            Spacer()
                .errorAlert(for: $viewModel.error)
            
            CTAButton(
                caption: presenter.deleteObjectButtonTitle,
                actionKind: .destructive,
                callback: { isConfirmDeleteAlertVisible.toggle() }
            )
            .padding(.horizontal)
            .alert(isPresented: $isConfirmDeleteAlertVisible) {
                confirmationAlert(
                    presenter: presenter.deleteAlertPresenter,
                    action: viewModel.deleteObject
                )
            }
        }
        .navigationTitle(presenter.screenTitle)
        .task {
            viewModel.load()
        }
    }
}

#Preview {
    let vm = __propertySettingsViewModel()
    let alertPresenter = DeletePropertyObjectAlertPresenter()
    let presenter = iOSPropertySettingsPresenter(deleteAlertPresenter: alertPresenter)
    return PropertySettingsView(
        viewModel: vm,
        presenter: presenter
    )
}
