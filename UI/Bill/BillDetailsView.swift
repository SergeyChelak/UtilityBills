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
    
    var body: some View {
        VStack(alignment: .center, spacing: 24) {
            Text("Bill Details")
                .popoverTitle()

            HStack {
                Text("Total price: \(viewModel.totalPrice)")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal)
                
                Text(viewModel.date)
                    .padding(.horizontal)
            }
            
            if viewModel.isEmpty {
                Text("No records found")
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
    return BillDetailsView(viewModel: vm)
}
