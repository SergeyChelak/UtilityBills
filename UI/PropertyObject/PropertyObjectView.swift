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
    
    let screenPresenter: PropertyObjectPresenter
    let billCellPresenter: BillCellPresenter
    
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
                            title: screenPresenter.sectionMetersTitle
                        )
                    }
                    
                    if !viewModel.bills.isEmpty {
                        SectionListView(
                            items: viewModel.bills,
                            selectionCallback: viewModel.billSelected(_:),
                            cellProducer: {
                                BillCellView(item: $0, presenter: billCellPresenter)
                            }
                        )
                        .sectionWith(
                            title: screenPresenter.sectionBillsTitle,
                            action: HeaderAction(
                                title: screenPresenter.sectionBillsActionViewAllTitle,
                                callback: viewModel.viewAllBills
                            )
                        )
                    }
                }
            }
            Spacer()
            CTAButton(
                caption: screenPresenter.buttonGenerateTitle,
                callback: viewModel.generateBill
            )
            .padding(.horizontal)
        }
        .navigationTitle(screenPresenter.screenTitle(viewModel.propObj))
        .toolbar {
            ToolbarItem {
                Button(action: viewModel.openSettings) {
                    UBImage(holder: screenPresenter.propertySettingsIcon)
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
    return PropertyObjectView(
        viewModel: viewModel,
        screenPresenter: iOSPropertyObjectPresenter(),
        billCellPresenter: iOSBillCellPresenter()
    )
}
