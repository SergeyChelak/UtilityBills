//
//  MeterValueView.swift
//  UtilityBills
//
//  Created by Sergey on 24.09.2024.
//

import SwiftUI

struct MeterValueView: View {
    @ObservedObject
    var viewModel: MeterValueViewModel
    
    var body: some View {
        VStack(alignment: .center) {
            Text(viewModel.screenTitle)
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
            VStack(spacing: 24) {
                ForEach(viewModel.actions, id: \.hashValue) { action in
                    CTAButton(caption: action.name, actionKind: action.kind) {
                        viewModel.onAction(action)
                    }
                }
            }
            .padding(.bottom, 12)
        }
        .padding(.horizontal)
        .errorAlert(for: $viewModel.error)
    }
}

#Preview("New") {
    let vm = MeterValueViewModel(
        date: Date(),
        value: 123,
        actionAdd: { _ in
            throw NSError(domain: "MeterNewValueViewModel", code: 1)
        }
    )
    return MeterValueView(viewModel: vm)
}

#Preview("Edit") {
    let value = MeterValue(
        id: MeterValueId(),
        date: Date(),
        value: 1.23,
        isPaid: true
    )
    let vm = MeterValueViewModel(
        meterValue: value,
        actionUpdate: { _ in },
        actionDelete: { _ in }
    )
    return MeterValueView(viewModel: vm)
}
