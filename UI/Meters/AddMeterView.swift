//
//  AddMeterView.swift
//  UtilityBills
//
//  Created by Sergey on 10.09.2024.
//

import SwiftUI

struct AddMeterView: View {
    @ObservedObject
    var viewModel: AddMeterViewModel
    let presenter: AddMeterPresenter
        
    var body: some View {
        VStack(alignment: .center, spacing: 24) {
            Text(presenter.screenTitle)
                .popoverTitle()
            
            TextField("", text: $viewModel.name)
                .inputStyle(caption: presenter.meterNameInputFieldTitle)
            
            VStack {
                Toggle(isOn: $viewModel.isCapacityApplicable, label: {
                    Text(presenter.toggleCapacityApplicableTitle)
                })
                if viewModel.isCapacityApplicable {
                    Picker(presenter.capacityPickerTitle, selection: $viewModel.capacity) {
                        ForEach(viewModel.capacities, id: \.self) {
                            Text(presenter.capacityValue($0))
                        }
                    }
                }
            }
            VStack {
                Toggle(isOn: $viewModel.isInspectionDateApplicable, label: {
                    Text(presenter.toggleInspectionApplicableTitle)
                })
                if viewModel.isInspectionDateApplicable {
                    DatePicker(
                        presenter.inspectionDatePickerTitle,
                        selection: $viewModel.inspectionDate,
                        displayedComponents: [.date]
                    )
                }
            }
            
            TextField("", text: $viewModel.initialValue)
                #if os(iOS)
                .keyboardType(.decimalPad)
                #endif
                .inputStyle(caption: presenter.initialValueInputFieldTitle)
            Spacer()
            CTAButton(
                caption: presenter.addMeterButtonTitle,
                callback: viewModel.save
            )
            .padding(.bottom, 12)
        }
        .padding(.horizontal)
        .errorAlert(for: $viewModel.error)
    }
}

#Preview {
    let vm = AddMeterViewModel(
        propertyObjectId: PropertyObjectId(),
        flow: nil
    )
    let presenter = iOSAddMeterPresenter()
    return AddMeterView(viewModel: vm, presenter: presenter)
}
