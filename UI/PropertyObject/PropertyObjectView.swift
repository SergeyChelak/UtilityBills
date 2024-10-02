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
        VStack {
            ScrollView(showsIndicators: false) {
                VStack(spacing: 24) {
                    // TODO: move to settings screen
                    if let obj = viewModel.propObj {
                        PropertyInfoView(propertyObject: obj)
                            .sectionWith(
                                title: "Info",
                                action: HeaderAction(
                                    title: "Edit",
                                    callback: viewModel.infoSectionSelected)
                            )
                    }
                    if !viewModel.meters.isEmpty {
                        SectionListView(
                            items: viewModel.meters,
                            selectionCallback: viewModel.meterSelected(_:),
                            cellProducer: { CaptionValueCell(caption: $0.name) }
                        )
                        .sectionWith(
                            title: "Meters"
                        )
                    }
                    
                    if !viewModel.bills.isEmpty {
                        SectionListView(
                            items: viewModel.bills,
                            selectionCallback: viewModel.billSelected(_:),
                            cellProducer: {
                                CaptionValueCell(caption: $0.date.formatted())
                            }
                        )
                        .sectionWith(
                            title: "Bills",
                            action: HeaderAction(
                                title: "View all",
                                callback: viewModel.viewAllBills
                            )
                        )
                    }
                }
            }
            Spacer()
            CTAButton(
                caption: "Generate bill",
                callback: viewModel.generateBill
            )
            .padding(.horizontal)
        }
        .navigationTitle(viewModel.propObj?.name ?? "")
        .toolbar {
            ToolbarItem {
                Button(action: viewModel.openSettings) {
                    Image(systemName: "gearshape")
                }
            }
        }
        .task {
            viewModel.load()
        }
        .errorAlert(for: $viewModel.error)
    }
}

#Preview {
    let store = PropertyObjectViewModel(
        UUID(),
        actionLoad: {
            let obj = PropertyObject(id: UUID(), name: "House", details: "My home")
            let meters: [Meter] = [
                // TODO: ...
            ]
            let bills: [Bill] = [
                // TODO: ...
            ]
            return PropertyObjectData(
                propObj: obj,
                meters: meters,
                bills: bills
            )
        },
        actionInfoSectionTap: { _ in },
        actionMeterSelectionTap: { _ in },
        actionSettings: { },
        actionGenerateBill: { _ in },
        updatePublisher: Empty().eraseToAnyPublisher()
    )
    return PropertyObjectView(viewModel: store)
}
