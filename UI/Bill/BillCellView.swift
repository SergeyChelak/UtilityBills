//
//  BillCellView.swift
//  UtilityBills
//
//  Created by Sergey on 10.10.2024.
//

import SwiftUI

struct BillCellView: View {
    let item: Bill
    let presenter: BillCellPresenter
    
    var body: some View {
        CaptionValueCell(
            caption: presenter.title(item),
            value: presenter.value(item)
        )
    }
}

#Preview {
    let bill = Bill(id: BillId(), date: Date(), records: [])
    return BillCellView(
        item: bill,
        presenter: iOSBillCellPresenter()
    )
}
