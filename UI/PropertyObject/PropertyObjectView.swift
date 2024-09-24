//
//  PropertyObjectView.swift
//  UtilityBills
//
//  Created by Sergey on 08.09.2024.
//

import Combine
import SwiftUI

struct PropertyObjectView: View {
    @StateObject var viewModel: PropertyObjectViewModel
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(spacing: 24) {
                // Manage estate data
                if let obj = viewModel.propObj {
                    PropertyInfoView(propertyObject: obj)
                        .sectionWith(
                            title: "Info",
                            action: HeaderAction(
                                title: "Edit",
                                imageDescriptor: .system("pencil"),
                                callback: viewModel.infoSectionSelected)
                        )
                }        
                // Manage meters/meter data
                MetersInfoView(
                    meters: viewModel.meters,
                    meterSelectionCallback: viewModel.meterSelected(_:)
                )
                .sectionWith(
                    title: "Meters",
                    action: HeaderAction(
                        title: "Add",
                        imageDescriptor: .system("plus.circle"),
                        callback: viewModel.meterHeaderSectionSelected
                    )
                )
                TariffInfoView(
                    tariffs: viewModel.tariffs
                )
                .sectionWith(
                    title: "Tariffs",
                    action: HeaderAction(
                        title: "Add",
                        callback: viewModel.tariffSectionSelected
                    )
                )
                Spacer()
                CTAButton(
                    caption: "Delete Object",
                    fillColor: .red,
                    callback: viewModel.deleteObject
                )
                .padding(.horizontal)
            }
        }
        .navigationTitle(viewModel.propObj?.name ?? "")
        .task {
            viewModel.load()
        }
        .errorAlert(for: $viewModel.error)
        
        // Display historical data
        
        // Manage tariffs
        
        // Manage payment's settings
    }
}

#Preview {
    let store = PropertyObjectViewModel(
        UUID(),
        actionLoad: {
            let obj = PropertyObject(id: UUID(), name: "House", details: "My home")
            let meters: [Meter] = []
            let tariffs: [Tariff] = []
            return PropertyObjectData(
                propObj: obj,
                meters: meters,
                tariffs: tariffs
            )
        },
        actionInfoSectionTap: { _ in },
        actionMeterHeaderSectionTap: { _ in },
        actionMeterSelectionTap: { _ in },
        actionDelete: { },
        updatePublisher: Empty().eraseToAnyPublisher()
    )
    return PropertyObjectView(viewModel: store)
}
