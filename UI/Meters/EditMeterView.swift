//
//  EditMeterView.swift
//  UtilityBills
//
//  Created by Sergey on 27.09.2024.
//

import SwiftUI

struct EditMeterView: View {
    @StateObject
    var viewModel: EditMeterViewModel
    @State
    var isConfirmDeleteAlertVisible = false
    
    var body: some View {
        VStack(alignment: .center, spacing: 24) {
            Text("Edit meter")
                .popoverTitle()
            
            TextField("", text: $viewModel.name)
                .inputStyle(caption: "Meter name")
            
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
            
            Spacer()
            CTAButton(caption: "Update", callback: viewModel.save)
                .padding(.bottom, 10)
            
            CTAButton(
                caption: "Delete Meter",
                style: .destructive,
                callback: { isConfirmDeleteAlertVisible.toggle() }
            )
            .padding(.bottom, 12)
        }
        .padding(.horizontal)
        .errorAlert(for: $viewModel.error)
        .alert(isPresented: $isConfirmDeleteAlertVisible) {
            Alert(
                title: Text("Warning"),
                message: Text("Do you want to delete this meter (\(viewModel.name))?"),
                primaryButton: .destructive(Text("Delete"), action: viewModel.delete),
                secondaryButton: .default(Text("Cancel"))
            )
        }
    }
}

#Preview {
    let meter = Meter(
        id: UUID(),
        name: "Unknown Meter",
        capacity: nil,
        inspectionDate: nil
    )
    let vm = EditMeterViewModel(
        meter: meter,
        actionUpdateMeter: { _ in },
        actionDeleteMeter: { }
    )
    return EditMeterView(viewModel: vm)
}
