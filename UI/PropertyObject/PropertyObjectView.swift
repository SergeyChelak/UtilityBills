//
//  PropertyObjectView.swift
//  UtilityBills
//
//  Created by Sergey on 08.09.2024.
//

import Combine
import SwiftUI

struct PropertyObjectView: View {
    @StateObject 
    var viewModel: PropertyObjectViewModel
    
    let presenter: PropertyObjectPresenter
    
    var body: some View {
        VStack {
            ScrollView(showsIndicators: false) {
                VStack(spacing: 24) {
                    if !viewModel.meters.isEmpty {
                        SectionListView(
                            items: viewModel.meters,
                            selectionCallback: viewModel.meterSelected(_:),
                            cellProducer: {
                                // TODO: replace to specific cell with own presenter
                                CaptionValueCell(caption: $0.name)
                            }
                        )
                        .sectionWith(
                            title: presenter.sectionMetersTitle
                        )
                    }
                    
                    if !viewModel.bills.isEmpty {
                        SectionListView(
                            items: viewModel.bills,
                            selectionCallback: viewModel.billSelected(_:),
                            cellProducer: {
                                BillCellView(item: $0, presenter: presenter.billCellPresenter)
                            }
                        )
                        .sectionWith(
                            title: presenter.sectionBillsTitle,
                            action: HeaderAction(
                                title: presenter.sectionBillsActionViewAllTitle,
                                callback: viewModel.viewAllBills
                            )
                        )
                    }
                }
            }
            Spacer()
            CTAButton(
                caption: presenter.buttonGenerateTitle,
                callback: viewModel.generateBill
            )
            .padding(.horizontal)
        }
        .navigationTitle(presenter.screenTitle(viewModel.propObj))
        .toolbar {
            ToolbarItem {
                Button(action: viewModel.openSettings) {
                    UBImage(holder: presenter.propertySettingsIcon)
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
    let billCellPresenter = iOSBillCellPresenter()
    let presenter = iOSPropertyObjectPresenter(billCellPresenter: billCellPresenter)
    return PropertyObjectView(
        viewModel: viewModel,
        presenter: presenter
    )
}
