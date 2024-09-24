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
            }
        }
        .navigationTitle(viewModel.propObj?.name ?? "")
        .task {
            viewModel.load()
        }
        
        // Display historical data
        
        // Manage tariffs
        
        // Manage payment's settings
    }
}

#Preview {
    let ds = LocalStorage.previewInstance()
    let store = PropertyObjectViewModel(
        UUID(),
        dataSource: ds,
        updatePublisher: Empty().eraseToAnyPublisher())
    return PropertyObjectView(viewModel: store)
}
