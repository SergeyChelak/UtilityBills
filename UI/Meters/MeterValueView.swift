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
            ControlButtonsView(viewModel: viewModel)
                .padding(.bottom, 12)
        }
        .padding(.horizontal)
        .errorAlert(for: $viewModel.error)
    }
}

#Preview("New") {
    let vm = MeterValueViewModel(
        meterId: MeterId(),
        date: Date(),
        value: 123,
        delegate: nil
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
        delegate: nil
    )
    return MeterValueView(viewModel: vm)
}
