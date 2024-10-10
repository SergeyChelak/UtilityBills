//
//  ModifyBillRecordView.swift
//  UtilityBills
//
//  Created by Sergey on 04.10.2024.
//

import SwiftUI

struct ModifyBillRecordView: View {
    @StateObject
    var viewModel: ModifyBillRecordViewModel
    let presenter: ModifyBillRecordPresenter
    
    var body: some View {
        VStack(spacing: 24) {
            Text(viewModel.name)
                .popoverTitle()
            if let amount = viewModel.amount {
                CaptionValueCell(
                    caption: presenter.amountCellCaption,
                    value: amount
                )
            }
            TextField("", text: $viewModel.price)
                #if os(iOS)
                .keyboardType(.decimalPad)
                #endif
                .inputStyle(caption: presenter.priceInputFieldTitle)
            Spacer()
            ControlButtonsView(viewModel: viewModel)
                .padding(.bottom, 12)
        }
        .padding(.horizontal)
        .errorAlert(for: $viewModel.error)
    }
}

#Preview {
    let record = BillRecord(
        id: BillRecordId(),
        name: "Some Record",
        amount: 47,
        price: 174.63
    )
    let vm = ModifyBillRecordViewModel(
        billRecord: record,
        flow: nil
    )
    let presenter = iOSModifyBillRecordPresenter()
    return ModifyBillRecordView(viewModel: vm, presenter: presenter)
}
