//
//  BillListView.swift
//  UtilityBills
//
//  Created by Sergey on 06.10.2024.
//

import SwiftUI

struct BillListView: View {
    @StateObject
    var viewModel: BillListViewModel
    
    var body: some View {
        VStack {
            if viewModel.isEmpty {
                Text("You have no bills yet")
            }
            List {
                ForEach(viewModel.items.indices, id: \.self) { i in
                    let item = viewModel.items[i]
                    CaptionValueCell(
                        caption: item.date.formatted(),
                        value: item.total.formatted()
                    )
                    .onTapGesture {
                        viewModel.select(index: i)
                    }
                }
            }
        }
        .navigationTitle("Your Bills")
        .task {
            viewModel.load()
        }
        .errorAlert(for: $viewModel.error)
    }
}

#Preview {
    struct Flow: BillListFlowDelegate {
        let now = Date()
        
        func generate() -> Bill {
            var date = now
            date.addTimeInterval(10)
            
            let records: [BillRecord] = [
                //
            ]
            return Bill(id: BillId(),
                 date: date,
                 records: records
            )
        }
        
        func loadBillsList() throws -> [Bill] {
            (0..<10).map { _ in
                generate()
            }
        }
        
        func openBillDetails(_ bill: Bill) {
            //
        }
    }
    let vm = BillListViewModel(flowDelegate: Flow())
    return NavigationStack {
        BillListView(viewModel: vm)
    }
}
