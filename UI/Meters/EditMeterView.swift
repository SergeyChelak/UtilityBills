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
    let presenter: EditMeterPresenter
    @State
    var isConfirmDeleteAlertVisible = false
    
    var body: some View {
        VStack(alignment: .center, spacing: 24) {
            Text(presenter.screenTitle)
                .popoverTitle()
            
            TextField("", text: $viewModel.name)
                .inputStyle(caption: presenter.meterNameInputFieldTitle)
            
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
            
            Spacer()
            CTAButton(caption: presenter.updateMeterButtonTitle, callback: viewModel.save)
                .padding(.bottom, 10)
                .errorAlert(for: $viewModel.error)
            
            CTAButton(
                caption: presenter.deleteMeterButtonTitle,
                actionKind: .destructive,
                callback: { isConfirmDeleteAlertVisible.toggle() }
            )
            .padding(.bottom, 12)
            .alert(isPresented: $isConfirmDeleteAlertVisible) {
                confirmationAlert(
                    presenter: presenter.deleteMeterAlertPresenter,
                    action: viewModel.delete
                )
            }
        }
        .padding(.horizontal)
    }
}

#Preview {
    let meter = _meter()
    let vm = EditMeterViewModel(
        meter: meter,
        flow: nil
    )
    let alertPresenter = DeleteMeterAlertPresenter()
    let presenter = iOSEditMeterPresenter(deleteMeterAlertPresenter: alertPresenter)
    return EditMeterView(viewModel: vm, presenter: presenter)
}
