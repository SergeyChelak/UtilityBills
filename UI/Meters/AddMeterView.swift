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
        
    var body: some View {
        VStack(alignment: .center, spacing: 24) {
            Text("Add new meter")
                .popoverTitle()
            
            TextField("", text: $viewModel.name)
                .inputStyle(caption: "Meter name")
            
            VStack {
                Toggle(isOn: $viewModel.isCapacityApplicable, label: {
                    Text("Capacity is applicable for this meter")
                })
                if viewModel.isCapacityApplicable {
                    Picker("Capacity", selection: $viewModel.capacity) {
                        ForEach(viewModel.capacities, id: \.self) {
                            Text(formatPicker(for: $0))
                        }
                    }
                }
            }
            VStack {
                Toggle(isOn: $viewModel.isInspectionDateApplicable, label: {
                    Text("Inspection date is applicable")
                })
                if viewModel.isInspectionDateApplicable {
                    DatePicker(
                        "Inspection Date",
                        selection: $viewModel.inspectionDate,
                        displayedComponents: [.date]
                    )
                }
            }
            
            TextField("", text: $viewModel.initialValue)
                .keyboardType(.decimalPad)
                .inputStyle(caption: "Initial value")
            
            Spacer()
            CTAButton(caption: "Add Meter", callback: viewModel.save)
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
    return AddMeterView(viewModel: vm)
}

func formatPicker(for capacity: Int) -> String {
    let val = maxValue(for: capacity).formatted()
    return String(format: "%d digits, max value: %@", capacity, val)
}
