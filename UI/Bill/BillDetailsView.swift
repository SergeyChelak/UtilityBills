//
//  BillDetailsView.swift
//  UtilityBills
//
//  Created by Sergey on 06.10.2024.
//

import SwiftUI

struct BillDetailsView: View {
    @StateObject
    var viewModel: BillDetailsViewModel
    let presenter: BillDetailsPresenter
    
    var body: some View {
        VStack(alignment: .center, spacing: 24) {
            Text(presenter.header)
                .popoverTitle()

            HStack {
                Text(presenter.totalPrice(viewModel.totalPrice))
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal)
                
                Text(presenter.billDate(viewModel.date))
                    .padding(.horizontal)
            }
            
            if viewModel.isEmpty {
                Text(presenter.emptyBillMessage)
            }
            List {
                ForEach(viewModel.items.indices, id: \.self) { i in
                    let item = viewModel.items[i]
                    CaptionValueCell(caption: item.name, value: item.price.formatted())
                }
            }
            Spacer()
        }
        .task {
            viewModel.load()
        }
        .errorAlert(for: $viewModel.error)
    }
}

#Preview {
    func generate() -> BillRecord {
        BillRecord(
            id: BillRecordId(),
            name: "item #" + arc4random().formatted(),
            amount: Decimal(arc4random()),
            price: Decimal(arc4random()))
    }
    
    let records = (0...100).map { _ in
        generate()
    }
    let bill = Bill(
        id: BillId(),
        date: Date(),
        records: records
    )
    let vm = BillDetailsViewModel(bill)
    return BillDetailsView(
        viewModel: vm,
        presenter: iOSBillDetailsPresenter()
    )
}
