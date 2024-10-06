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
                                CaptionValueCell(
                                    caption: $0.date.formatted(),
                                    value: $0.total.formatted()
                                )
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
    let viewModel = _propertyObjectViewModelMock()
    return PropertyObjectView(viewModel: viewModel)
}
