//
//  ManagePropertyObjectView.swift
//  UtilityBills
//
//  Created by Sergey on 09.09.2024.
//

import SwiftUI

struct ManagePropertyObjectView: View {
    @StateObject
    var viewModel: ManagePropertyObjectViewModel
    let presenter: ManagePropertyObjectPresenter
    
    var body: some View {
        VStack(spacing: 24) {
            Text(presenter.header)
                .popoverTitle()
                
            Spacer()
            TextField("", text: $viewModel.name)
                .inputStyle(caption: presenter.objectNameInputFieldTitle)
                        
            TextField("", text: $viewModel.details)
                .inputStyle(caption: presenter.objectDetailsInputFieldTitle)
            
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

#Preview {
    let obj = _propertyObject()
    let vm = ManagePropertyObjectViewModel(
        propertyObject: obj,
        updateFlow: nil
    )
    return ManagePropertyObjectView(
        viewModel: vm,
        presenter: CreateManagePropertyObjectPresenter()
    )
}
