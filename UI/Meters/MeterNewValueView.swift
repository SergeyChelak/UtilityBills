//
//  MeterNewValueView.swift
//  UtilityBills
//
//  Created by Sergey on 24.09.2024.
//

import SwiftUI

struct MeterNewValueView: View {
    @ObservedObject
    var viewModel: MeterNewValueViewModel
    
    var body: some View {
        VStack(alignment: .center) {
            Text("Add new meter value")
                .popoverTitle()
            
            Spacer()
            DatePicker(
                "Date",
                selection: $viewModel.date,
                displayedComponents: [.date]
            )
            
            TextField("", value: $viewModel.value, format: .number)
                .keyboardType(.decimalPad)
                .inputStyle(caption: "Value")
            
            Toggle(isOn: $viewModel.isPaid, label: {
                Text("Value already included in bill")
            })
                        
            Spacer()
            CTAButton(caption: "Save", callback: viewModel.save)
                .padding(.bottom, 12)
        }
        .padding(.horizontal)
        .errorAlert(for: $viewModel.error)
    }
}

#Preview {
    let vm = MeterNewValueViewModel(
        date: Date(),
        value: 123,
        actionSave: { _ in
            throw NSError(domain: "MeterNewValueViewModel", code: 1)
        }
    )
    return MeterNewValueView(viewModel: vm)
}
