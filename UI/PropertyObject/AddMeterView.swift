//
//  AddMeterView.swift
//  UtilityBills
//
//  Created by Sergey on 10.09.2024.
//

import SwiftUI

struct AddMeterView: View {
    @Environment(\.dismiss) var dismiss
    
    @State var state: NewMeterData
    
    let saveMeterCallback: (NewMeterData) throws -> Void
        
    var body: some View {
        VStack(alignment: .center, spacing: 24) {
            Text("Add new meter")
                .frame(maxWidth: .infinity)
                .padding(.top, 12)
            
            TextField("", text: $state.name)
                .inputStyle(caption: "Meter name")
            
            VStack {
                Toggle(isOn: $state.isCapacityApplicable, label: {
                    Text("Capacity is applicable for this meter")
                })
                if state.isCapacityApplicable {
                    Picker("Capacity", selection: $state.capacity) {
                        ForEach(NewMeterData.capacities, id: \.self) {
                            Text(formatPicker(for: $0))
                        }
                    }
                }
            }
            VStack {
                Toggle(isOn: $state.isInspectionDateApplicable, label: {
                    Text("Inspection date is applicable")
                })
                if state.isInspectionDateApplicable {
                    DatePicker(
                        "Inspection Date",
                        selection: $state.inspectionDate,
                        displayedComponents: [.date]
                    )
                }
            }
            
            TextField("", value: $state.initialValue, format: .number)
                .keyboardType(.decimalPad)
                .inputStyle(caption: "Initial value")
            
            Spacer()
            CTAButton(caption: "Add Meter") {
                do {
                    try saveMeterCallback(state)
                    dismiss()
                } catch {
                    fatalError(error.localizedDescription)
                }
            }
            .padding(.bottom, 12)
        }
        .padding(.horizontal)
    }
}

#Preview {
    AddMeterView(state: .newData(propertyObjectId: UUID())) { _ in }
}
