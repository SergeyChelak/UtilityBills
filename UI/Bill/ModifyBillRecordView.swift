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
    
    var body: some View {
        VStack(spacing: 24) {
            Text(viewModel.name)
                .popoverTitle()
            if let amount = viewModel.amount {
                CaptionValueCell(
                    caption: "Amount/Volume",
                    value: amount
                )
            }
            TextField("", text: $viewModel.price)
                .keyboardType(.decimalPad)
                .inputStyle(caption: "Price")
            Spacer()
            ControlButtonsView(viewModel: viewModel)
                .padding(.bottom, 12)
        }
        .padding(.horizontal)
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
    return ModifyBillRecordView(viewModel: vm)
}
