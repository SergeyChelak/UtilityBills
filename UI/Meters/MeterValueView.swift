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
    let presenter: MeterValuePresenter
    
    var body: some View {
        VStack(alignment: .center) {
            Text(presenter.screenTitle)
                .popoverTitle()
            
            Spacer()
            DatePicker(
                presenter.datePickerTitle,
                selection: $viewModel.date,
                displayedComponents: [.date]
            )
            TextField("", text: $viewModel.value)
                #if os(iOS)
                .keyboardType(.decimalPad)
                #endif
                .inputStyle(caption: presenter.valueInputTitle)
            
            Toggle(isOn: $viewModel.isPaid, label: {
                Text(presenter.paidToggleTitle)
            })
                        
            Spacer()
            ControlButtonsView(
                viewModel: viewModel,
                presenter: presenter
            )
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
        flow: nil
    )
    let presenter = AddMeterValuePresenter()
    return MeterValueView(viewModel: vm, presenter: presenter)
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
        flow: nil
    )
    let presenter = EditMeterValuePresenter()
    return MeterValueView(viewModel: vm, presenter: presenter)
}
